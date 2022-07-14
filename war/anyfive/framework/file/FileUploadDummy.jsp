<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.framework.app.FrameworkApp"%><% FrameworkApp app = new FrameworkApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML>
<HEAD>
<SCRIPT language="JScript">
window.frameElement.uploadSuccess();
</SCRIPT>
</HEAD>

<BODY>
</BODY>
</HTML>
