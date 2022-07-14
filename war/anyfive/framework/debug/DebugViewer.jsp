<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%
response.setDateHeader("Expires", 0);
response.setHeader("Pragma", "no-cache");
response.setHeader("Cache-Control", "no-cache");
%>
<HTML>
<HEAD>
<TITLE>Debug Viewer</TITLE>
<SCRIPT language="JScript" src="<%= request.getContextPath() %>/anyfive/framework/js/prototype.js"></SCRIPT>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onload = function()
{
}

//디버그 제거
function $clear()
{
    txt1.value = "";
}

//디버그 기록
function $write(val)
{
    txt1.value += (typeof(val) == "object" ? Object.toJSON(val) : val) + "\n";
    top.window.focus();
    fnScroll();
}

//디버그 버퍼 기록
function $writeBuffer(buffer)
{
    for (var i = 0; i < buffer.length; i++) {
        $write(buffer[i]);
    }
}

//스크롤
function fnScroll()
{
    txt1.scrollTop = txt1.offsetHeight + txt1.scrollHeight;
}
</SCRIPT>

<!-- 사이즈 변경시 -->
<SCRIPT language="JScript" for="txt1" event="onresize()">
    fnScroll();
</SCRIPT>
</HEAD>

<BODY style="margin:0px;" scroll="no">

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
    <TR>
        <TD height="100%" style="padding-bottom:5px;">
            <TEXTAREA id="txt1" style="border:none; width:100%; height:100%; overflow:auto;" wrap="off" readOnly></TEXTAREA>
        </TD>
    </TR>
    <TR>
        <TD height="1px" align="right">
            <BUTTON onClick="javascript:$clear();">Clear</BUTTON>
            <BUTTON onClick="javascript:top.window.close();">Close</BUTTON>
        </TD>
    </TR>
</TABLE>

</BODY>
</HTML>
