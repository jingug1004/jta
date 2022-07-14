<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.framework.app.FrameworkApp"%><% FrameworkApp app = new FrameworkApp(request, response, out, true, false); %>
<%@page import="any.core.config.NConfig"%>
<%@page import="any.util.etc.NTextUtil"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE><%= NConfig.getString(NConfig.DEFAULT_CONFIG + "/system-title") %></TITLE>
<SCRIPT language="JScript" src="<%= request.getContextPath() %>/anyfive/framework/js/anyworks.js"></SCRIPT>
<% app.writePageInitialize(app.PAGE_TYPE_POPUP); %>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onload = function()
{
    window.focus();

    try {
        $go();
    } catch(ex) {
        alert(ex.description);
    }
}

//윈도우 종료시
window.onunload = function()
{
    if (window["_RELOAD_LIST_"] == true) {
        window["_RELOAD_LIST_"] = null;
        doReloadList();
    }
}

//문서 키입력시
document.onkeypress = function()
{
    if (event.keyCode == 27 && window["_PAGE_TYPE_"] == "popup") {
        top.window.close();
    }
}

//페이지 이동
function $go(arg)
{
    window.focus();

    if (arg == null) {
        arg = window.dialogArguments;
    }

    if (arg == null) {
        if (top == window) {
            arg = window.opener["_WINDOW_ARGUMENTS_"][window.name];
        } else {
            var viewerDiv = parent.document.getElementById(window.name).parentElement;
            viewerDiv.style.display = "block";
            arg = viewerDiv.arg;
            window["_PAGE_TYPE_"] = "viewer";
            document.body.style.margin = "0px";
        }
    } else {
        window.opener = arg.opener;
    }

    if (top.any == null) {
        top.any = { messageData : arg.messageData };
    } else {
        top.any.messageData = arg.messageData;
    }

    window["_WINDOW_ARGUMENTS_"] = arg;

    for (var item in arg.arg) {
        if (item == "_WINDOW_INFO_") continue;
        window[item] = arg.arg[item];
    }

    document.getElementsByTagName("DIV")[0].innerHTML = '<IFRAME name="ifr_popupFrame" frameBorder="no" scrolling="no" width="100%" height="100%" pageType="' + window["_PAGE_TYPE_"] + '"></IFRAME>';

    var frm = document.forms[0];

    if (arg.windowInfo.path.indexOf("?") == -1) {
        frm.action = arg.windowInfo.path;
    } else {
        frm.action = arg.windowInfo.path.substr(0, arg.windowInfo.path.indexOf("?"));
        var params = arg.windowInfo.path.substr(arg.windowInfo.path.indexOf("?") + 1).split("&");
        for (var i = 0; i < params.length; i++) {
            addHidden(params[i].split("=")[0], params[i].split("=")[1]);
        }
    }

    if (arg.windowInfo.params != null) {
        for (var i = 0; i < arg.windowInfo.params.length; i++) {
            addHidden(arg.windowInfo.params[i].name, arg.windowInfo.params[i].value);
        }
    }

    frm.method = "get";
    frm.target = "ifr_popupFrame";
    frm.submit();

    function addHidden(name, value)
    {
        var hdn = document.createElement('<INPUT type="hidden">');
        hdn.name  = name;
        hdn.value = value;
        frm.appendChild(hdn);
    }
}

//목록 조회 예약
function reloadList()
{
    if (window["_PAGE_TYPE_"] == "viewer") {
        try {
            parent.document.getElementById(window.name).parentElement.reloadList = true;
        } catch(ex) {
        }
        return;
    }

    if (window["_WINDOW_ARGUMENTS_"].windowInfo.type == 0) {
        window["_RELOAD_LIST_"] = true;
    } else {
        doReloadList();
    }
}

//목록 조회
function doReloadList()
{
    if (window.opener.any.docPageType == "popup") {
        window.opener.parent.reloadList();
    }

    if (window["_WINDOW_ARGUMENTS_"] == null) return;
    if (window["_WINDOW_ARGUMENTS_"].onReload == null) return;

    window["_WINDOW_ARGUMENTS_"].onReload();
}

//목록
function goList()
{
    if (window["_PAGE_TYPE_"] == "viewer") {
        new parent.any.viewer().initialize();
    } else {
        top.window.close();
    }
}
</SCRIPT>

<!-- 팝업 프레임 로딩시 -->
<SCRIPT language="JScript" for="ifr_popupFrame" event="onload()">
    if (this.contentWindow.document.title != "") {
        document.title = "<%= NTextUtil.toJS(NConfig.getString(NConfig.DEFAULT_CONFIG + "/system-title")) %> - " + this.contentWindow.document.title;
    }
</SCRIPT>
</HEAD>

<BODY style="margin:0px;" scroll="no">

<FORM style="display:none;"></FORM>
<DIV style="width:100%; height:100%;"></DIV>

</BODY>
</HTML>
