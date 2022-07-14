<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.framework.app.FrameworkApp"%><% FrameworkApp app = new FrameworkApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>Data Save</TITLE>
<% app.writeHTMLHeader(); %>
<SCRIPT language="JScript">
var fg = parent.gr.fg;
var gTotalCnt = 0;
var gSavedCnt = 0;

//윈도우 로딩시
window.onready = function()
{
    for (var r = fg.FixedRows; r < fg.Rows; r++) {
        if (fg.RowHidden(r) != true) gTotalCnt++;
    }

    fg.Row = fg.FixedRows;

    spn_successCnt.innerText = 0;
    spn_failureCnt.innerText = 0;
    spn_totalCnt.innerText = gTotalCnt;
    spn_executeCnt.innerText = 0;
    spn_executeRatio.innerText = 0;

    parent.saveFunc(fnResult, false);
}

//결과처리
function fnResult(isSuccess)
{
    gSavedCnt++;

    if (isSuccess == true) {
        spn_successCnt.innerText++;
    } else {
        spn_failureCnt.innerText++;
    }

    spn_executeCnt.innerText = gSavedCnt;
    spn_executeRatio.innerText = parseInt(gSavedCnt / gTotalCnt * 10000, 10) / 100;
    spn_progressBar.style.width = spn_executeRatio.innerText + "%";

    if (fg.Row >= fg.Rows - 1) return;

    try {
        parent.saveFunc(fnResult, true);
    } catch(ex) {
    }
}
</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="1" cellpadding="2" class="main" onEnter="javascript:fnRetrieve();">
    <COLGROUP>
        <COL class="conthead" width="15%">
        <COL class="contdata" width="35%">
        <COL class="conthead" width="15%">
        <COL class="contdata" width="35%">
    </COLGROUP>
    <TR>
        <TD>전체</TD>
        <TD colspan="3"><SPAN id="spn_executeCnt"></SPAN>&nbsp;/&nbsp;<SPAN id="spn_totalCnt"></SPAN>&nbsp;(<SPAN id="spn_executeRatio"></SPAN>&nbsp;%)</TD>
    </TR>
    <TR>
        <TD>성공</TD>
        <TD><SPAN id="spn_successCnt"></SPAN></TD>
        <TD>실패</TD>
        <TD><SPAN id="spn_failureCnt"></SPAN></TD>
    </TR>
    <TR>
        <TD>진행율</TD>
        <TD colspan="3">
            <SPAN style="width:100%; border:#0000FF 1px solid;">
                <SPAN id="spn_progressBar" style="height:16px; background-color:blue;"></SPAN>
            </SPAN>
        </TD>
    </TR>
</TABLE>
<DIV class="button_area">
    <BUTTON text="Close" onClick="javascript:top.window.close();"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
