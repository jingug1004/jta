<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.framework.app.FrameworkApp"%><% FrameworkApp app = new FrameworkApp(request, response, out, true, true); %>
<%@page import="any.core.config.NConfigRefresher"%>
<%@page import="any.core.config.NConfig"%>
<%@page import="any.core.message.NMessageMap"%>
<%@page import="any.util.dao.NQueryMap"%>
<%@page import="any.util.file.NFilePolicyMap"%>
<%@page import="any.util.mail.NMailTemplateMap"%>
<%
    NConfigRefresher.refresh();

    out.clear();

    if (NConfig.getString("/security/admin-key").equals(request.getParameter("key"))) {
        out.println("<HTML>");
        out.println("<BODY>");
        out.println("<XMP>");

        out.println("NConfig ======================================================================================");
        out.println(NConfig.getMapString());

        out.println("NMessageMap ==================================================================================");
        out.println(NMessageMap.getMapString());

        out.println("NQueryMap ====================================================================================");
        out.println(NQueryMap.getMapString());

        out.println("NFilePolicyMap ===============================================================================");
        out.println(NFilePolicyMap.getMapString());

        out.println("NMailTemplateMap =============================================================================");
        out.println(NMailTemplateMap.getMapString());

        out.println("</XMP>");
        out.println("</BODY>");
        out.println("</HTML>");
    }

    out.println("OK");
%>
