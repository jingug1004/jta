<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.framework.app.FrameworkApp"%><% FrameworkApp app = new FrameworkApp(request, response, out, true, true); %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
<HEAD>
<TITLE>Grid Loading</TITLE>
<META http-equiv="Content-Type" content="text/html; charset=utf-8">
<META http-equiv="Cache-Control" content="no-cache; no-store; no-save">
<META http-equiv="Expires" content="0">
<META http-equiv="Pragma" content="no-cache">
<STYLE type="text/css">
BODY {
    margin: 0px;
    text-align: center;
}

BUTTON {
    font-family: Tahoma;
    font-size: 12px;
    background-color: transparent;
    border: #CCCCCC 1px solid;
    width: 100%;
    height: 100%;
}
</STYLE>
<SCRIPT language="JScript">
var gr = parent.document.getElementById(window.location.search.substr(1));

//윈도우 로딩시
window.onload = function()
{
}

//취소
function fnCancel()
{
    gr.loader.cancel();
}
</SCRIPT>
</HEAD>

<BODY>

<BUTTON onClick="javascript:fnCancel();">
<IMG src="GridLoading.gif" width="16px" height="16px" align="absmiddle">
<SPAN style="margin-left:5px;">Cancel</SPAN>
</BUTTON>

</BODY>
</HTML>
