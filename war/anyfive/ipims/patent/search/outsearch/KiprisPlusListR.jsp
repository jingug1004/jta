<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML>
<HEAD>
<TITLE>JIPOS 검색시스템</TITLE>
<% app.writeHTMLHeader(); %>
</HEAD>
<BODY>
<% app.writeBodyHeader(); %>
<IFRAME src="http://192.168.1.17:8081" width="100%" height="100%" frameborder="0"></IFRAME>
</BODY>
</HTML>
