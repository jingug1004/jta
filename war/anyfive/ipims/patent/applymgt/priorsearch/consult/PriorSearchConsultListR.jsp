<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.share.workprocess.util.WorkProcessConst"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>선행기술조사 현황</TITLE>
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
    var ldr = gr_examConsultList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.priorsearch.consult.act.RetrievePriorSearchConsultList.do";
    ldr.addParam("SEARCH_KIND", SEARCH_KIND.value);
    ldr.addParam("SEARCH_TEXT", SEARCH_TEXT.value);
    ldr.addParam("PRSCH_NO", PRSCH_NO.value);
    ldr.addParam("PRSCH_SUBJECT", PRSCH_SUBJECT.value);
    ldr.addParam("DATE_GUBUN", DATE_GUBUN.value);
    ldr.addParam("DATE_START", DATE_START.value);
    ldr.addParam("DATE_END", DATE_END.value);
    ldr.addParam("BIZ_STATUS", BIZ_STATUS.value);
    ldr.addParam("PRSCH_DIV", PRSCH_DIV.value);

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
        win.path = "PriorSearchConsultU.jsp";
    } else {
        win.path = "PriorSearchConsultRD.jsp";
    }

    win.arg.PRSCH_ID = gr.value(row, "PRSCH_ID");

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
                    <COL class="conddata" width="25%">
                    <COL class="condhead" width="10%">
                    <COL class="conddata" width="20%">
                    <COL class="condhead" width="10%">
                    <COL class="conddata" width="20%">
                </COLGROUP>
                <TR>
                    <TD>검색어</TD>
                    <TD>
                        <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                            <TR>
                                <TD>
                                    <ANY:SELECT id="SEARCH_KIND" codeData="/applymgt/priorSearchRequestListSearchGubun" value="1" style="width:100px; margin-right:3px;" />
                                </TD>
                                <TD width="100%"><INPUT type="text" id="SEARCH_TEXT"></TD>
                            </TR>
                        </TABLE>
                    </TD>
                    <TD>의뢰번호</TD>
                    <TD><INPUT type="text" id="PRSCH_NO"></TD>
                    <TD>의뢰제목</TD>
                    <TD><INPUT type="text" id="PRSCH_SUBJECT"></TD>
                </TR>
                <TR>
                    <TD>검색일자</TD>
                    <TD noWrap>
                        <ANY:SELECT id="DATE_GUBUN" codeData="/applymgt/priorSearchRequestListDateGubun" firstName="none" style="width:100px; margin-right:3px;" />
                        <ANY:DATE id="DATE_START" disabled />&nbsp;~
                        <ANY:DATE id="DATE_END" disabled />
                    </TD>
                    <TD>진행상태</TD>
                    <TD>
                        <ANY:SELECT id="BIZ_STATUS" codeData="/common/bizStepStatus,<%= WorkProcessConst.Step.PRIOR_SEARCH_CONSULT %>||<%= WorkProcessConst.Step.PRIOR_SEARCH_PROGRESS %>" firstName="all" />
                    </TD>
                    <TD>조사구분</TD>
                    <TD>
                        <ANY:SELECT id="PRSCH_DIV" codeData="{PRSCH_DIV}" firstName="all" />
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
            <ANY:GRID id="gr_examConsultList" pagingType="1"><COMMENT>
                addColumn({ width:110, align:"left"  , type:"string" , sort:true , id:"PRSCH_NO"         , name:"의뢰번호" });
                addColumn({ width:75 , align:"center", type:"string" , sort:true , id:"REQ_USER_NAME"    , name:"의뢰인" });
                addColumn({ width:110, align:"left"  , type:"string" , sort:true , id:"PRSCH_DIV_NAME"   , name:"조사구분" });
                addColumn({ width:200, align:"left"  , type:"string" , sort:true , id:"PRSCH_SUBJECT"    , name:"의뢰제목" });
                addColumn({ width:75 , align:"center", type:"date"   , sort:true , id:"CRE_DATE"         , name:"작성일" });
                addColumn({ width:75 , align:"center", type:"date"   , sort:true , id:"REQ_DATE"         , name:"특허팀의뢰일" });
                addColumn({ width:75 , align:"center", type:"date"   , sort:true , id:"OFFICE_RCPT_DATE" , name:"사무소접수일" });
                addColumn({ width:75 , align:"center", type:"date"   , sort:true , id:"INFORM_DATE"      , name:"조사결과통보일" , hide:true });
                addColumn({ width:110, align:"left"  , type:"string" , sort:true , id:"BIZ_STATUS_NAME"  , name:"진행상태" });
                addColumn({ width:75 , align:"center", type:"string" , sort:true , id:"JOB_MAN_NAME"     , name:"담당자" });
                useConfig = true;
                messageSpan = "spn_gridMessage";
                setFixedColumn(null, "PRSCH_SUBJECT");
                addSorting("PRSCH_NO", "DESC");
                addAction("PRSCH_SUBJECT", fnDetail);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
