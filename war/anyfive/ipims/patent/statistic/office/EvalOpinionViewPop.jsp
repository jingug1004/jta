<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<%
String evalId = request.getParameter("EVALID");
String refId = request.getParameter("REFID");
%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>종합평가의견</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo" />
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();
}

function fnRetrieve()
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.statistic.office.act.EvalOpinionView.do";
    prx.addParam("EVAL_ID", "<%=evalId%>");
    prx.addParam("REF_ID", "<%=refId%>");
    prx.checkData = ds_mainInfo;

    prx.onSuccess = function()
    {
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

</SCRIPT>

</HEAD>

<BODY style="background:;">

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="1" cellpadding="2" class="main">
    <COLGROUP>
        <COL class="contdata" width="30%">
    </COLGROUP>
    <tr>
        <td><TEXTAREA id="EVAL_OPINION" bind="ds_mainInfo" readonly2></TEXTAREA></td>
    </tr>
</TABLE><br>
<DIV class="buttons_bottom" align="right">
    <BUTTON auto="close"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
