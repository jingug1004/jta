<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.framework.session.SessionUtil"%>
<%@page import="anyfive.ipims.share.common.util.SystemTypes"%>
<%
response.setDateHeader("Expires", 0);
response.setHeader("Pragma", "no-cache");
response.setHeader("Cache-Control", "no-cache");

String path = null;

if (SessionUtil.getUserInfo(request).isLogin() == true) {
    if (SystemTypes.PATENT.equals(SessionUtil.getUserInfo(request).getSystemType())) {
        path = "/anyfive/ipims/patent/default.jsp";
    } else {
        path = "/anyfive/ipims/office/default.jsp";
    }
} else {
    path = "/anyfive/ipims/share/login/SessionOut.jsp";
}

request.getRequestDispatcher(path).forward(request, response);
%>
