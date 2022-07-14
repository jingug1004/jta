<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.framework.app.FrameworkApp"%><% FrameworkApp app = new FrameworkApp(request, response, out); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>Image Viewer</TITLE>
<% app.writeHTMLHeader(); %>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    img1.src = parent.imgSrc;
    img1.alt = parent.imgName;
}

//드래그 방지
document.ondragstart = function()
{
    return false;
}

//윈도우 사이즈 조정
function fnResizeWindow()
{
    window.blur();
    top.window.blur();

    var div = document.getElementById("__BODY_MAIN_DIV__");

    top.window.resizeTo(0, 0);
    top.window.moveTo(0, 0);

    div.prevWidth = div.offsetWidth;
    div.prevHeight = div.offsetHeight;
    div.prevOverflow = div.style.overflow;

    div.style.overflow = "";

    top.window.resizeBy(div.offsetWidth - div.prevWidth, div.offsetHeight - div.prevHeight);
    top.window.moveTo((screen.availWidth - div.offsetWidth) / 2, (screen.availHeight - div.offsetHeight) / 2);

    div.style.overflow = div.prevOverflow;

    top.window.focus();
    window.focus();
}

//이미지 저장
function fnSave()
{
    cfFileDownload(parent.downloadKey);
}
</SCRIPT>

<!-- 이미지 로딩시 -->
<SCRIPT language="JScript" for="img1" event="onload()">
    fnResizeWindow();
</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
    <TR>
        <TD align="center"><IMG id="img1"></TD>
    </TR>
    <TR>
        <TD height="10px"></TD>
    </TR>
    <TR>
        <TD height="1px" align="right">
            <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="jsvascript:fnSave();"></BUTTON>
            <BUTTON auto="close"></BUTTON>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
