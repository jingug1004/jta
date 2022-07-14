<%@page pageEncoding="UTF-8"%><% response.setContentType("text/x-component; charset=utf-8"); %>
<%@page import="anyfive.ipims.share.common.app.ShareApp"%><% ShareApp app = new ShareApp(request, response, out, true, true); %>
<PUBLIC:COMPONENT tagName="WORKPROC" lightWeight="false">
    <PUBLIC:DEFAULTS tabStop="true" viewInheritStyle="true" viewLinkContent="true" viewMasterTab="false" />
    <PUBLIC:ATTACH event="ondocumentready" onevent="document_onready();" />
    <PUBLIC:PROPERTY name="isReady" value="false" />
    <PUBLIC:PROPERTY name="status" get="getStatus" />
    <PUBLIC:PROPERTY name="avail" get="getAvail" />
    <PUBLIC:METHOD name="reset" />
    <PUBLIC:EVENT name="OnLoad" id="OnLoadEvent" />
</PUBLIC:COMPONENT>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML XMLNS:ANY>
<HEAD>
<META http-equiv="Content-Type" content="text/x-component; charset=utf-8">
<SCRIPT language="JScript" src="<%= request.getContextPath() %>/anyfive/framework/js/anyworks.js" charset="utf-8"></SCRIPT>
<% app.writeHTCImport("/anyfive/framework/htc/anyworks/ds.htc"); %>
<ANY:DS id="ds_bizComMst" />
<ANY:DS id="ds_bizMgtProc" />
<SCRIPT language="JScript">
var gRefId;
var gStatus;

function document_onready()
{
    for (var i = 0, elements = element.getElementsByTagName("*"); i < elements.length; i++) {
        if (elements[i].tagName == "SCRIPT" || elements[i].tagName == "COMMENT") eval(elements[i].text);
    }

    element.isReady = true;
}

function reset(refId)
{
    gRefId = refId;
    gStatus = null;

    var viewPath = window.location.pathname.replace(top.getRoot(), "");

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.share.workprocess.act.RetrieveWorkProcessForView.do";
    prx.addParam("REF_ID", gRefId);
    prx.addParam("BIZ_VIEW_PATH", viewPath.substr(0, viewPath.lastIndexOf("/")));

    prx.onSuccess = function()
    {
        gStatus = ds_bizComMst.value(0, "STATUS");

        OnLoadEvent.fire(element.document.createEventObject());
    }

    prx.onFail = function()
    {
        this.error.show();

        OnLoadEvent.fire(element.document.createEventObject());
    }

    prx.execute(false);
}

function getStatus()
{
    return gStatus;
}

function getAvail(bizActs, actOwner)
{
    for (var i = 0; i < bizActs.length; i++) {
        if (check(bizActs[i]) == true) return true;
    }

    return false;

    function check(bizAct)
    {
        if (actOwner == null) {
            if (ds_bizMgtProc.valueRow(["CURR_STATUS", gStatus], ["BIZ_ACT", bizAct]) != -1) return true;
        } else {
            if (ds_bizMgtProc.valueRow(["CURR_STATUS", gStatus], ["BIZ_ACT", bizAct], ["ACT_OWNER", actOwner]) != -1) return true;
        }
    }
}
</SCRIPT>
