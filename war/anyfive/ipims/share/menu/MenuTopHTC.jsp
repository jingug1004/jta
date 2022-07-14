<%@page pageEncoding="UTF-8"%><% response.setContentType("text/x-component; charset=utf-8"); %>
<%@page import="anyfive.ipims.share.common.app.ShareApp"%><% ShareApp app = new ShareApp(request, response, out, true, true); %>
<PUBLIC:COMPONENT tagName="MENUTOP" lightWeight="false">
    <PUBLIC:DEFAULTS tabStop="true" viewInheritStyle="true" viewLinkContent="true" viewMasterTab="false" />
    <PUBLIC:PROPERTY name="selectedMenu" get="getSelectedMenu" />
    <PUBLIC:METHOD name="reset" />
    <PUBLIC:METHOD name="show" />
    <PUBLIC:METHOD name="go" />
    <PUBLIC:EVENT name="OnChange" id="OnChangeEvent" />
</PUBLIC:COMPONENT>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML XMLNS:ANY>
<HEAD>
<META http-equiv="Content-Type" content="text/x-component; charset=utf-8">
<STYLE type="text/css">
TABLE.menu_top {
    background:url(<%= request.getContextPath() %>/anyfive/ipims/share/menu/image/ipims_topmenu_bg.gif) repeat-x;
    height:42px;
}

TD.menu_top_off {
    font-family:"돋움";
    font-size: 14px;
    color: #FFF;
    line-height:14px;
    font-weight:bold;
    text-align:center;
    padding:0px 15px 0px 15px;
    height:42px;
}

TD.menu_top_on {
    background:url(<%= request.getContextPath() %>/anyfive/ipims/share/menu/image/ipims_topmenu_on.gif) no-repeat center;
    font-family:"돋움";
    font-size: 14px;
    color: #FFF4AC;
    line-height:14px;
    font-weight:bold;
    text-align:center;
    padding:0px 15px 0px 15px;
    height:42px;
}
</STYLE>
<SCRIPT language="JScript">
var gData;
var gIndex;

function reset(data)
{
    if (data == null) return;

    gData = data;

    var td, spn;

    for (var r = 0; r < gData.ds.rowCount; r++) {
        if (gData.ds.value(r, "MENU_CODE_PRIOR") != "") break;

        td = document.createElement('<TD>');
        td.className = "menu_top_off";
        td.noWrap = true;
        tr_menu.appendChild(td);

        spn = document.createElement('<SPAN>');
        spn.id = "spn_menuName";
        spn.idx = r;
        spn.innerText = gData.ds.value(r, "MENU_NAME");
        spn.style.cursor = "hand";
        td.appendChild(spn);
    }

    div_loading.style.display = "none";
    tbl_menu.style.display = "block";
}

function show(menuCode)
{
    var gIndex = gData.getTopIndex(menuCode);

    if (gIndex == -1) return;

    var spans = document.getElementsByName("spn_menuName");

    for (var i = 0; i < spans.length; i++) {
        spans[i].parentElement.className = (spans[i].idx == gIndex ? "menu_top_on" : "menu_top_off");
        spans[i].style.color = "";
    }
}

function go(val)
{
    gIndex = (val == null ? gIndex : gData.getIndex(val));

    if (gIndex == -1) return;

    show(gData.ds.value(gIndex, "MENU_CODE"));

    OnChangeEvent.fire(element.document.createEventObject());
}

function getSelectedMenu()
{
    return gData.getMenuData(gIndex);
}
</SCRIPT>

<SCRIPT language="JScript" for="spn_menuName" event="onmouseover()">
    this.style.color = "#FFF4AC";

</SCRIPT>
<SCRIPT language="JScript" for="spn_menuName" event="onmouseout()">
    this.style.color = "";
</SCRIPT>
<SCRIPT language="JScript" for="spn_menuName" event="onclick()">
    go(this.idx);
</SCRIPT>
</HEAD>

<BODY>

<DIV style="width:100%; padding:0px 10px 0px 10px;">
<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" class="menu_top">
    <TR>
        <TD><IMG src="<%= request.getContextPath() %>/anyfive/ipims/share/menu/image/ipims_topmenu_left.gif" width="26" height="42"></TD>
        <TD width="100%">
            <DIV id="div_loading" style="color:#DDDDDD;">Loading Menus...</DIV>
            <TABLE border="0" cellspacing="0" cellpadding="0" id="tbl_menu" style="display:none;">
                <TR id="tr_menu"></TR>
            </TABLE>
        </TD>
        <TD><IMG src="<%= request.getContextPath() %>/anyfive/ipims/share/menu/image/ipims_topmenu_right.gif" width="27" height="42"></TD>
    </TR>
</TABLE>
</DIV>

</BODY>
</HTML>
