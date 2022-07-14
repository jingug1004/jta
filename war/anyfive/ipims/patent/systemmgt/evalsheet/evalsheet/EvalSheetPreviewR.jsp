<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>평가서 미리보기</TITLE>
<% app.writeHTMLHeader(); %>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    any_evalItemList.reset(parent.EVAL_SHEET_ID);
}
</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<ANY:EVAL id="any_evalItemList" mode="C" />

<DIV class="button_area">
    <BUTTON auto="close"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
