<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>통계정보 조회</TITLE>
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
    if (LIST_TYPE.value == "") {
        alert("통계구분을 선택하세요.");
        LIST_TYPE.focus();
        return;
    }

    var ldr = gr_messageList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.statistic.statistic.act.RetrieveStatisticList.do";
    ldr.addParam("LIST_TYPE", LIST_TYPE.value);

    if (td_date.disabled != true) {
        ldr.addParam("DATE_START", DATE_START.value);
        ldr.addParam("DATE_END", DATE_END.value);
    }

    ldr.onSuccess = function(gr, fg)
    {
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}
</SCRIPT>

<!-- 통계구분 변경시  -->
<SCRIPT language="JScript" for="LIST_TYPE" event="OnChange()">
    td_date.disabled = DATE_START.disabled = DATE_END.disabled = (this.value(null, "DATE") != "1");
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
                    <COL class="conddata" width="45%">
                    <COL class="condhead" width="15%">
                    <COL class="conddata" width="25%">
                </COLGROUP>
                <TR>
                    <TD>통계구분</TD>
                    <TD>
                        <ANY:SELECT id="LIST_TYPE" codeData="/applymgt/statisticListType" firstName="select" />
                    </TD>
                    <TD id="td_date" disabled>검색일</TD>
                    <TD noWrap>
                        <ANY:DATE id="DATE_START" disabled/>&nbsp;~
                        <ANY:DATE id="DATE_END" disabled/>
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
                        <BUTTON text="조회" color="1" onClick="javascript:fnRetrieve();"></BUTTON>
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
            <ANY:GRID id="gr_messageList" pagingType="0"><COMMENT>
                messageSpan = "spn_gridMessage";
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
