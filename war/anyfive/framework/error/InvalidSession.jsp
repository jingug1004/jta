<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%
response.setDateHeader("Expires", 0);
response.setHeader("Pragma", "no-cache");
response.setHeader("Cache-Control", "no-cache");
out.clear();
%>
<SCRIPT language="JScript" src="<%= request.getContextPath() %>/anyfive/framework/js/anyworks.js"></SCRIPT>
<SCRIPT language="JScript">
function getRoot() { return "<%= request.getContextPath() %>"; }
any.replaceLoginPage();
</SCRIPT>
