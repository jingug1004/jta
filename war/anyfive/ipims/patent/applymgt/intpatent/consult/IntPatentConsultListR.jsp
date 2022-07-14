<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.share.workprocess.util.WorkProcessConst"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>국내출원품의</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();
}

//목록 조회
function fnRetrieve()
{
    var ldr = gr_intPatentConsultList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.intpatent.consult.act.RetrieveIntPatentConsultList.do";
    ldr.addParam("NO_GUBUN", NO_GUBUN.value);
    ldr.addParam("SR_NO", SR_NO.value);
    ldr.addParam("SR_NO_ONLY", SR_NO_ONLY.value);
    ldr.addParam("KO_APP_TITLE", KO_APP_TITLE.value);
    ldr.addParam("EMP_GUBUN", EMP_GUBUN.value);
    ldr.addParam("SR_INV", SR_INV.value);
    ldr.addParam("SR_STATUS", SR_STATUS.value);
    ldr.addParam("DATE_GUBUN", DATE_GUBUN.value);
    ldr.addParam("DATE_START", DATE_START.value);
    ldr.addParam("DATE_END", DATE_END.value);
    ldr.addParam("FIRM_CODE", FIRM_CODE.value);
    ldr.addParam("JOB_MAN", JOB_MAN.value);

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
    var win = new any.viewer();

    //건담당자이고, 검토결과가 입력되어 있지 않는 경우 수정화면으로 이동
    if (gr.value(row, "JOB_MAN") == "<%= app.userInfo.getUserId() %>" && gr.value(row, "EXAM_RESULT") == "") {
        win.path = "IntPatentConsultU.jsp";
    } else {
        win.path = "IntPatentConsultRD.jsp";
    }

    win.arg.REF_ID = gr.value(row, "REF_ID");

    win.onReload = function()
    {
        gr.loader.reload();
    }

    win.show();
}
</SCRIPT>

<!-- 검색일자 구분 변경시 -->
<SCRIPT language="JScript" for="DATE_GUBUN" event="OnChange()">
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
                    <COL class="condhead" width="10%">
                    <COL class="conddata" width="23%">
                    <COL class="condhead" width="10%">
                    <COL class="conddata" width="23%">
                    <COL class="condhead" width="10%">
                    <COL class="conddata" width="23%">
                </COLGROUP>
                <TR>
                    <TD>번호검색</TD>
                    <TD colspan="3">
                        <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                            <TR>
                                <TD>
                                    <ANY:SELECT id="NO_GUBUN" codeData="/applymgt/inNewConsultNoGubun" style="width:105px; margin-right:3px;" />
                                </TD>
                                <TD width="100%">
                                    <INPUT type="text" id="SR_NO" style="text-transform:uppercase;">
                                </TD>
                                <TD noWrap>
                                    <ANY:CHECK id="SR_NO_ONLY" text="번호만 검색" />
                                </TD>
                            </TR>
                        </TABLE>
                    </TD>
                    <TD>발명의명칭</TD>
                    <TD><INPUT type="text" id="KO_APP_TITLE"></TD>
                </TR>
                <TR>
                    <TD>발명자</TD>
                    <TD colspan="3">
                        <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                            <TR>
                                <TD>
                                    <ANY:SELECT id="EMP_GUBUN" codeData="/common/userSearchGubun" style="width:105px; margin-right:3px;" />
                                </TD>
                                <TD width="100%">
                                    <INPUT type="text" id="SR_INV" style="width:100%;">
                                </TD>
                            </TR>
                        </TABLE>
                    </TD>
                    <TD>진행상태</TD>
                    <TD>
                        <ANY:SELECT id="SR_STATUS" codeData="/common/bizStepStatus,<%= WorkProcessConst.Step.INT_PATENT_CONSULT %>" firstName="all" />
                    </TD>
                </TR>
                <TR>
                    <TD>검색일자</TD>
                    <TD noWrap>
                        <ANY:SELECT id="DATE_GUBUN" codeData="/applymgt/intPatentConsultDateGubun" firstName="none" style="width:105px; margin-right:3px;"/>
                        <ANY:DATE id="DATE_START" disabled />&nbsp;~
                        <ANY:DATE id="DATE_END" disabled />
                    </TD>
                    <TD>사무소</TD>
                    <TD>
                        <ANY:SELECT id="FIRM_CODE" codeData="/common/intOfficeCode" firstName="all" />
                    </TD>
                     <TD>건담당자</TD>
                    <TD>
                        <ANY:SELECT id="JOB_MAN" codeData="/common/jobMan,PAT" value="<%= app.userInfo.getUserId() %>" firstName="all" />
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
            <ANY:GRID id="gr_intPatentConsultList" pagingType="1"><COMMENT>
                addColumn({ width:110, align:"left"  , type:"string", sort:true , id:"REF_NO"               , name:"REF-NO" });
                addColumn({ width:200, align:"left"  , type:"string", sort:true , id:"KO_APP_TITLE"         , name:"발명의 명칭" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"PATTEAM_RCPT_DATE"    , name:"접수일"  });
                addColumn({ width:110, align:"left"  , type:"string", sort:true , id:"OFFICE_NAME"          , name:"사무소" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"OFFICE_SEND_DATE"     , name:"사무소위임일" });
                addColumn({ width:110, align:"left"  , type:"string", sort:true , id:"INVENTOR_NAMES"       , name:"발명자" });
                addColumn({ width:60 , align:"center", type:"string", sort:true , id:"JOB_MAN_NAME"         , name:"담당자" });
                addColumn({ width:110, align:"left"  , type:"string", sort:true , id:"STATUS_NAME"          , name:"진행상태" });
                addColumn({ width:70 , align:"center", type:"string", sort:true , id:"EXAM_RESULT_NAME"     , name:"검토결과" });
                useConfig = true;
                messageSpan = "spn_gridMessage";
                setFixedColumn(null, "KO_APP_TITLE");
                addSorting("PATTEAM_RCPT_DATE", "DESC");
                addSorting("REF_NO", "DESC");
                addAction("KO_APP_TITLE", fnDetail);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
