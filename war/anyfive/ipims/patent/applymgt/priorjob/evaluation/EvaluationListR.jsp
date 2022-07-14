<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>특허평가현황</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
}

//목록 조회
function fnRetrieve()
{
    var ldr = gr_evaluationList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.priorjob.evaluation.act.RetrieveEvaluationList.do";
    ldr.addParam("NUM_KIND", NUM_KIND.value);
    ldr.addParam("NUM_TEXT", NUM_TEXT.value);
    ldr.addParam("NUM_ONLY", NUM_ONLY.value);
    ldr.addParam("INOUT_DIV", INOUT_DIV.value);
    ldr.addParam("EVAL_CODE", EVAL_CODE.value);
    ldr.addParam("JOB_MAN", JOB_MAN.value);
    ldr.addParam("DATE_KIND", DATE_KIND.value);
    ldr.addParam("DATE_START", DATE_START.value);
    ldr.addParam("DATE_END", DATE_END.value);

    ldr.onSuccess = function(gr, fg)
    {
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

//상세
function fnDetail(gr, fg, row, colId)
{
    var win = new any.window();
    win.path = top.getRoot() + gr.value(row, "EVAL_VIEW_PATH");
    win.arg.REF_ID = gr.value(row, "REF_ID");
    win.arg.LIST_SEQ = gr.value(row, "PAPER_LIST_SEQ");
    win.opt.resizable = "yes";

    win.onReload = function()
    {
        gr.loader.reload();
    }

    win.show();
}
</SCRIPT>

<!-- 검색일자 구분 변경시 -->
<SCRIPT language="JScript" for="DATE_KIND" event="OnChange()">
    DATE_START.disabled = (this.value == "");
    DATE_END.disabled = (this.value == "");
</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
    <TR>
        <TD>
            <TABLE border="0" cellspacing="1" cellpadding="2" class="main" onEnter="javascript:fnRetrieve();">
                <COLGROUP>
                    <COL class="condhead" width="15%">
                    <COL class="conddata" width="35%">
                    <COL class="condhead" width="15%">
                    <COL class="conddata" width="35%">
                </COLGROUP>
                <TR>
                    <TD>검색번호</TD>
                    <TD>
                        <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                            <TR>
                                <TD>
                                    <ANY:SELECT id="NUM_KIND" codeData="/applymgt/priorJobEvalListNumKind" style="width:80px; margin-right:3px;" />
                                </TD>
                                <TD width="100%">
                                    <INPUT type="text" id="NUM_TEXT" style="text-transform:uppercase;">
                                </TD>
                                <TD noWrap>
                                    <ANY:CHECK id="NUM_ONLY" text="번호만 검색" />
                                </TD>
                            </TR>
                        </TABLE>
                    </TD>
                    <TD>국내외구분</TD>
                    <TD>
                        <ANY:SELECT id="INOUT_DIV" codeData="{INOUT_DIV}" firstName="all" />
                    </TD>
                </TR>
                <TR>
                    <TD>평가종류</TD>
                    <TD>
                        <ANY:SELECT id="EVAL_CODE" codeData="/applymgt/evalCode" firstName="all" />
                    </TD>
                    <TD>건담당자</TD>
                    <TD>
                        <ANY:SELECT id="JOB_MAN" codeData="/common/jobManAll" firstName="all" />
                    </TD>
                </TR>
                <TR>
                    <TD>검색일자</TD>
                    <TD colspan="3">
                        <ANY:SELECT id="DATE_KIND" codeData="/applymgt/priorJobEvalListDateKind" firstName="none" style="width:150px; margin-right:3px;" />
                        <ANY:DATE id="DATE_START" disabled />&nbsp;~
                        <ANY:DATE id="DATE_END" disabled />
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD height="5"></TD>
    </TR>
    <TR>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD><SPAN id="spn_gridMessage"></SPAN></TD>
                    <TD align="right">
                        <BUTTON auto="retrieve" onClick="javascript:fnRetrieve();"></BUTTON>
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD height="5"></TD>
    </TR>
    <TR>
        <TD height="100%">
            <ANY:GRID id="gr_evaluationList" pagingType="1"><COMMENT>
                addColumn({ width:120, align:"left"  , type:"string", sort:true, id:"REF_NO"                    , name:"REF-NO" });
                addColumn({ width:200, align:"left"  , type:"string", sort:true, id:"KO_APP_TITLE"              , name:"발명의 명칭" });
                addColumn({ width:120, align:"left"  , type:"string", sort:true, id:"EVAL_TITLE"                , name:"평가명칭" });
                addColumn({ width:70 , align:"center", type:"string", sort:true, id:"JOB_MAN_NAME"              , name:"건담당자" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true, id:"INVDEPT_EVAL_USER_NAME"    , name:"발명부서 평가자" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true, id:"INVDEPT_EVAL_DATE"         , name:"발명부서 평가일" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true, id:"PATDEPT_EVAL_USER_NAME"    , name:"특허부서 평가자" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true, id:"PATDEPT_EVAL_DATE"         , name:"특허부서 평가일" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true, id:"STATUS_NAME"               , name:"진행상태" });
                useConfig = true;
                messageSpan = "spn_gridMessage";
                setFixedColumn(null, "EVAL_TITLE");
                addSorting("INVDEPT_EVAL_DATE", "DESC");
                addSorting("PATDEPT_EVAL_DATE", "DESC");
                addAction("EVAL_TITLE", fnDetail);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
