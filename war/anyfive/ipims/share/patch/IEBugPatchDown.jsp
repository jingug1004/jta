<%@page import="any.core.config.NConfig"%><%@page import="any.util.file.NFileDownload"%><%
new NFileDownload(request, response).download(NConfig.HOME + "/../war/anyfive/ipims/share/patch/IEBugPatch.reg");
if (true) return;
%>
