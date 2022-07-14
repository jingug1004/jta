<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.framework.app.FrameworkApp"%><% FrameworkApp app = new FrameworkApp(request, response, out, true, true); %>
<%@page import="anyfive.framework.session.SessionUtil"%>
<%@page import="any.core.config.NConfig"%>
<% SessionUtil.setDebugMode(request, NConfig.getString("/security/admin-key").equals(request.getParameter("key"))); %>
<% app.writeHTMLDocType(); %>
<HTML>
<HEAD>
<TITLE><%= NConfig.getString(NConfig.DEFAULT_CONFIG + "/system-title") %> - Debug Setting</TITLE>
</HEAD>

<BODY>

Debug Mode : <%= SessionUtil.isDebugMode(request) %>

</BODY>
</HTML>
