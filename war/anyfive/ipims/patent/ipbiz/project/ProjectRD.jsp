<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<%@page import="any.util.etc.NDateUtil"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>프로젝트 추가정보</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    ds_mainInfo.value(0, "PJT_CODE")= parent.PJT_CODE;
    ds_mainInfo.value(0, "PJT_NAME") = parent.PJT_NAME;
    ds_mainInfo.value(0, "PJT_LAB") = parent.PJT_LAB;
    ds_mainInfo.value(0, "PJT_NO") = parent.PJT_NO;
    ds_mainInfo.value(0, "PJT_MGT") = parent.PJT_MGT;
    ds_mainInfo.value(0, "PJT_DEPT") = parent.PJT_DEPT;
    ds_mainInfo.value(0, "PJT_OWNER") = parent.PJT_OWNER;
    ds_mainInfo.value(0, "PJT_DATE")= parent.PJT_DATE;
}

</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>
<TABLE border="0" cellspacing="1" cellpadding="2" class="main">
    <COLGROUP>
        <COL class="conthead" width="15%">
        <COL class="contdata" width="35%">
        <COL class="conthead" width="15%">
        <COL class="contdata" width="35%">
    </COLGROUP>
    <TR>
        <TD>프로젝트 코드</TD>
        <TD colspan="3"><SPAN ID="PJT_CODE"  bind="ds_mainInfo"></SPAN></TD>
    </TR>
    <TR>
        <TD>프로젝트명</TD>
        <TD colspan="3"><SPAN ID="PJT_NAME" bind="ds_mainInfo"></SPAN></TD>
    </TR>
    <TR>
        <TD>연구과제명</TD>
        <TD><SPAN ID="PJT_LAB"  bind="ds_mainInfo"></SPAN></TD>
        <TD>연구관리기관</TD>
        <TD><SPAN ID="PJT_MGT"  bind="ds_mainInfo"></SPAN></TD>
    </TR>
    <TR>
        <TD>주관기관</TD>
        <TD><SPAN ID="PJT_OWNER"  bind="ds_mainInfo"></SPAN></TD>
        <TD>수행기간</TD>
        <TD><SPAN ID="PJT_DATE"  bind="ds_mainInfo"></SPAN></TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON auto="close"></BUTTON>
</DIV>
<% app.writeBodyFooter(); %>

</BODY>
</HTML>
