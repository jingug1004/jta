<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%
response.setDateHeader("Expires", 0);
response.setHeader("Pragma", "no-cache");
response.setHeader("Cache-Control", "no-cache");
out.clear();
%>
<SCRIPT language="JScript">
alert("정상적인 접근경로가 아닙니다.\n\n시스템 홈페이지로 이동합니다.");
top.location.replace("<%= request.getContextPath() %>/");
</SCRIPT>
