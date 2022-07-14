<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="any.core.session.NAbstractSessionUtil"%>
<%
response.setDateHeader("Expires", 0);
response.setHeader("Pragma", "no-cache");
response.setHeader("Cache-Control", "no-cache");
out.clear();
%>
<HTML>
<HEAD>
<TITLE>Error</TITLE>
<STYLE type="text/css">
HTML, BODY {
    height:100%;
}

BODY {
    font-family: Arial;
    font-size: 12px;
    text-decoration: none;
}

.A01 {
    width:572px;
    height:212px;
    background:url(<%= request.getContextPath() %>/anyfive/framework/error/image/error.jpg) no-repeat;
    position:absolute;
    top:40%;
    left:50%;
    margin: -106px 0px 0px -286px;
    padding:22px 0px 0px 232px;
}

.B01 {
    font-size:13px;
    font-family:Trebuchet MS;
    color:#FF0000;
    font-weight:bold;
    height:26px;
    width:320px;
    padding:4px;
}

.B02 {
    color:#334966;
    margin-bottom:20px;
    width:320px;
    padding:4px;
    height:70px;

}

.B03 {
    border-top:1px solid #334966;
    padding:10px 4px 4px 4px;
    color:#555;
    width:320px;
}
</STYLE>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onload = function()
{
    try {
        parent.bfHideBodyMessage();
    } catch(ex) {
    }
}
</SCRIPT>
</HEAD>

<BODY style="margin:0px;" scroll="no">

<%
String code = null, message = null, type = null, uri = null;
Object codeObj, messageObj, typeObj;
Throwable throwable;

codeObj = request.getAttribute("javax.servlet.error.status_code");
messageObj = request.getAttribute("javax.servlet.error.message");
typeObj = request.getAttribute("javax.servlet.error.exception_type");
throwable = (Throwable)request.getAttribute("javax.servlet.error.exception");
uri = (String)request.getAttribute("javax.servlet.error.request_uri");

if (uri == null) uri = request.getRequestURI();

if (codeObj != null) code = codeObj.toString();
if (messageObj != null) message = messageObj.toString();
if (typeObj != null) type = typeObj.toString();

String reason = (code != null ? code : type);
%>

<DIV class="A01">
    <DIV>
        <% if (code.equals(Integer.toString(HttpServletResponse.SC_NOT_FOUND))) { %>
        <DIV class="B01">Page Not Found!</DIV>
        <DIV class="B02"><%= "[" + reason + "] " + message %></DIV>
        <% } else { %>
        <DIV class="B01">Page Error!</DIV>
        <DIV class="B02"><%= "[" + reason + "] " + type %></DIV>
        <% } %>
        <DIV class="B03">
            <B>Contact Information or Troubleshooting Tips </B><BR>
            <B>E-mail :</B> csr@anyfive.com<BR>
            <B>Call us :</B> 080-2-2082-2690,080-2-2082-2691<BR>
        </DIV>
    </DIV>
</DIV>

<% if (NAbstractSessionUtil.isDebugMode(request)) { %>
<DIV style="display:none;">
<%= message %>
</DIV>
<% } %>

</BODY>
</HTML>
