<%@page pageEncoding="UTF-8"%><% response.setContentType("text/x-component; charset=utf-8"); %>
<%@page import="anyfive.ipims.share.common.app.ShareApp"%><% ShareApp app = new ShareApp(request, response, out, true, true); %>
<PUBLIC:COMPONENT tagName="MENUDATA" lightWeight="false">
    <PUBLIC:DEFAULTS tabStop="true" viewInheritStyle="true" viewLinkContent="true" viewMasterTab="false" />
    <PUBLIC:ATTACH event="ondocumentready" onevent="document_onready();" />
    <PUBLIC:PROPERTY name="ds" get="getDs" />
    <PUBLIC:PROPERTY name="menuTop" get="getMenuTop" put="setMenuTop" />
    <PUBLIC:PROPERTY name="menuLeft" get="getMenuLeft" put="setMenuLeft" />
    <PUBLIC:METHOD name="getIndex" />
    <PUBLIC:METHOD name="getTopIndex" />
    <PUBLIC:METHOD name="getMenuData" />
    <PUBLIC:EVENT name="OnLoad" id="OnLoadEvent" />
</PUBLIC:COMPONENT>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML XMLNS:ANY>
<HEAD>
<META http-equiv="Content-Type" content="text/x-component; charset=utf-8">
<link href="newstyle.css" rel="stylesheet" type="text/css">
<SCRIPT language="JScript" src="<%= request.getContextPath() %>/anyfive/framework/js/anyworks.js" charset="utf-8"></SCRIPT>
<%= "<?IMPORT namespace=\"ANY\" implementation=\"" + request.getContextPath() + "/anyfive/framework/htc/anyworks/ds.htc\">" %>
<ANY:DS id="ds_menuList" />
<SCRIPT language="JScript">
var gMenuTopId;
var gMenuLeftId;

var gMenuTop;
var gMenuLeft;

function document_onready()
{
    if (gMenuTopId != null) gMenuTop = element.document.getElementById(gMenuTopId);
    if (gMenuLeftId != null) gMenuLeft = element.document.getElementById(gMenuLeftId);

    load();
}

function load()
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.share.menu.act.RetrieveMenuList.do";

    prx.onSuccess = function()
    {
        if (gMenuTop != null) gMenuTop.reset(element);
        if (gMenuLeft != null) gMenuLeft.reset(element, gMenuTop == null);

        OnLoadEvent.fire(element.document.createEventObject());
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

function getDs()
{
    return ds_menuList;
}

function getMenuTop()
{
    return gMenuTop;
}

function setMenuTop(val)
{
    if (typeof(val) == "object") {
        gMenuTopId = val.id;
        gMenuTop = val;
    } else {
        gMenuTopId = val;
        gMenuTop = element.document.getElementById(gMenuTopId);
    }
}

function getMenuLeft()
{
    return gMenuLeft;
}

function setMenuLeft(val)
{
    if (typeof(val) == "object") {
        gMenuLeftId = val.id;
        gMenuLeft = val;
    } else {
        gMenuLeftId = val;
        gMenuLeft = element.document.getElementById(gMenuLeftId);
    }
}

function getIndex(val)
{
    if (typeof(val) == "number") return val;

    if (ds_menuList.valueRow(["MENU_CODE", val]) != -1) return ds_menuList.valueRow(["MENU_CODE", val]);
    if (ds_menuList.valueRow(["MENU_PATH", val]) != -1) return ds_menuList.valueRow(["MENU_PATH", val]);

    return -1;
}

function getTopIndex(menuCode)
{
    var menuIndex = ds_menuList.valueRow(["MENU_CODE", menuCode]);
    var menuCodePrior = ds_menuList.value(menuIndex, "MENU_CODE_PRIOR");

    while (menuCodePrior != "") {
        menuCode = menuCodePrior;
        menuIndex = ds_menuList.valueRow(["MENU_CODE", menuCode]);
        menuCodePrior = ds_menuList.value(menuIndex, "MENU_CODE_PRIOR");
    }

    return menuIndex;
}

function getMenuData(idx)
{
    var data = {};

    if (idx == null || idx == -1) return data;

    data.code = ds_menuList.value(idx, "MENU_CODE");
    data.name = ds_menuList.value(idx, "MENU_NAME");
    data.path = ds_menuList.value(idx, "MENU_PATH").replaceAll("{#MENU_CODE}", data.code);

    return data;
}
</SCRIPT>
</HEAD>
</HTML>
