<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.share.common.app.ShareApp"%><% ShareApp app = new ShareApp(request, response, out, true, true); %>
<%@page import="any.core.config.NConfig"%>
<% app.writeHTMLDocType(); %>
<HTML>
<HEAD>
<SCRIPT language="JScript">
top.window.location.replace("<%= NConfig.getString("/config/logout-path", request.getContextPath() + "/anyfive/ipims/share/login/Login.jsp") %>");
</SCRIPT>
</HEAD>

<BODY>

</BODY>
</HTML>
