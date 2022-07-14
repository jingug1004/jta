<%@page pageEncoding="UTF-8"%><% response.setContentType("text/x-component; charset=utf-8"); %>
<%@page import="anyfive.ipims.share.common.app.ShareApp"%><% ShareApp app = new ShareApp(request, response, out, true, true); %>
<PUBLIC:COMPONENT tagName="MENULEFT" lightWeight="false">
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
BODY {
    background-color: transparent;
}

BODY, TD, SPAN, LABEL {
    font-family:"Tahoma";
    font-size: 12px;
}

BODY {
    scrollbar-face-color: #FFF;
    scrollbar-shadow-color: #CECECE;
    scrollbar-highlight-color: #CECECE;
    scrollbar-3dlight-color: #FFF;
    scrollbar-darkshadow-color: #FFF;
    scrollbar-track-color: #F3F3F3;
    scrollbar-arrow-color: #CECECE;
}

TABLE.left_menu {
    background:url(image/menu_left_bg.gif) repeat-y;
}

TD.menu_left_title {
    margin:0px 3px 0px 10px;
    background:url(image/menu_left_title.gif) no-repeat;
    height:69px;
    font-family:"돋움";
    font-size:14px;
    font-weight:bold;
    color:#28417b;
    padding:0px 0px 4px 10px;
}

LABEL {
    padding-left:3px;
}

LABEL.menu_left1 {
    font-weight:bold;
}

LABEL.menu_left2 {
    color:#255D97;
}
</STYLE>
<SCRIPT language="JScript">
var gData;
var gIndex;

var gTopDivs = new Array();
var gWidth = element.style.width;

element.style.height = "100%";

function reset(data, show)
{
    if (data == null) return;

    gData = data;

    var priorDiv, div, spn, img, lbl;
    var marginLeft;

    for (var r = 0; r < gData.ds.rowCount; r++) {
        if (gData.ds.value(r, "MENU_CODE_PRIOR") != "") break;

        div = document.createElement('<DIV>');
        div.id = "div_menuList_" + gData.ds.value(r, "MENU_CODE");
        div.idx = r;
        if (show != true) div.style.display = "none";
        div_menuArea.appendChild(div);

        gTopDivs.push(div);
    }

    if (show == true) {
        div_title.innerText = gData.ds.value(gTopDivs[0].idx, "MENU_NAME");
    }

    for (var r = 0; r < gData.ds.rowCount; r++) {
        priorDiv = document.getElementById("div_menuList_" + gData.ds.value(r, "MENU_CODE_PRIOR"));

        if (priorDiv == null) continue;

        marginLeft = (priorDiv.parentElement == div_menuArea ? 10 : 15);

        spn = document.createElement('<SPAN style="cursor:hand; width:100%; padding:2 0 2 0;">');
        spn.id = "spn_menuName";
        spn.idx = r;
        spn.style.marginLeft = marginLeft;
        priorDiv.appendChild(spn);

        img = document.createElement('<IMG align="absmiddle">');
        img.src = top.getRoot() + '/anyfive/ipims/share/menu/image/menu_left_bullet' + gData.ds.value(r, "MENU_LEVEL") + '.gif';
        spn.appendChild(img);

        lbl = document.createElement('<LABEL onSelectStart="javascript:return false;">');
        lbl.innerText = gData.ds.value(r, "MENU_NAME");
        lbl.className = "menu_left" + gData.ds.value(r, "MENU_LEVEL");
        spn.appendChild(lbl);
        spn.nameLabel = lbl;

        div = document.createElement('<DIV>');
        div.id = "div_menuList_" + gData.ds.value(r, "MENU_CODE");
        div.style.marginLeft = marginLeft;
        div.style.display = "none";
        priorDiv.appendChild(div);
    }
}

function show(menuCode)
{
    var topMenuCode = gData.ds.value(gData.getTopIndex(menuCode), "MENU_CODE");
    var topDiv;

    for (var i = 0; i < gTopDivs.length; i++) {
        if (gData.ds.value(gTopDivs[i].idx, "MENU_CODE") == topMenuCode) {
            div_title.innerText = gData.ds.value(gTopDivs[i].idx, "MENU_NAME");
            gTopDivs[i].style.display = "block";
            topDiv = gTopDivs[i];
        } else {
            gTopDivs[i].style.display = "none";
        }
    }

    var divs = topDiv.getElementsByTagName("DIV");

    for (var i = 0; i < divs.length; i++) {
        divs[i].style.display = "none";
    }

    var div = document.getElementById("div_menuList_" + menuCode);

    while (div != topDiv) {
        div.style.display = "block";
        div = div.parentElement;
    }

    if (menuCode != topMenuCode || topDiv == null) return;

    var lbls = topDiv.getElementsByTagName("SPAN");

    for (var i = 0; i < lbls.length; i++) {
        if (gData.ds.value(lbls[i].idx, "MENU_PATH") == "") continue;
        go(lbls[i].idx);
        break;
    }
}

function go(val)
{
    gIndex = (val == null ? gIndex : gData.getIndex(val));

    if (gIndex == -1) return;

    var div = document.getElementById("div_menuList_" + gData.ds.value(gIndex, "MENU_CODE"));
    var dis;

    dis = div.style.display;

    show(gData.ds.value(gIndex, "MENU_CODE"));
    showHideMenu(true);

    if (gData.ds.value(gIndex, "MENU_PATH") == "") {
        div.style.display = (dis == "none" ? "block" : "none");
    } else {
        OnChangeEvent.fire(element.document.createEventObject());
    }
}

function showHideMenu(bool)
{
    if (bool == true || td_menuList.style.display == "none") {
        td_menuList.style.display = "block";
        img_menuShow.style.display = "none";
        img_menuHide.style.display = "block";
        document.body.style.padding = 10;
        document.body.style.paddingRight = 0;
        element.style.width = gWidth;
    } else {
        td_menuList.style.display = "none";
        img_menuHide.style.display = "none";
        img_menuShow.style.display = "block";
        document.body.style.padding = 0;
        element.style.width = td_menuBar.offsetWidth;
    }
}

function getSelectedMenu()
{
    return gData.getMenuData(gIndex);
}
</SCRIPT>

<SCRIPT language="JScript" for="spn_menuName" event="onmouseover()">
    this.nameLabel.style.textDecoration = "underline";
</SCRIPT>
<SCRIPT language="JScript" for="spn_menuName" event="onmouseout()">
    this.nameLabel.style.textDecoration = "";
</SCRIPT>
<SCRIPT language="JScript" for="spn_menuName" event="onclick()">
    go(this.idx);
</SCRIPT>
</HEAD>

<BODY>

<TABLE border="0" cellspacing="0" cellpadding="0" height="100%">
    <TR>
        <TD id="td_menuList" valign="top">
            <TABLE border="0" cellspacing="0" cellpadding="0" width="1" height="100%" class="left_menu">
                <TR>
                    <TD class="menu_left_title"><DIV id="div_title">Loading Menus...</DIV></TD>
                </TR>
                <TR>
                    <TD height="100%" valign="top" style="padding:0px 10px 5px 10px;">
                        <DIV id="div_menuArea" style="width:100%; height:100%; overflow-x:hidden; overflow-y:auto;"></DIV>
                    </TD>
                </TR>
                <TR>
                    <TD><IMG src="<%= request.getContextPath() %>/anyfive/ipims/share/menu/image/menu_left_bottom.gif" width="188" height="5"></TD>
                </TR>
            </TABLE>
        </TD>
        <TD id="td_menuBar" width="6px">
            <IMG src="<%= request.getContextPath() %>/anyfive/ipims/share/menu/image/menu_left_hide.gif" width="6px" height="40px"
                id="img_menuHide"
                onClick="javascript:showHideMenu();"
                style="cursor:hand;"
            >
            <IMG src="<%= request.getContextPath() %>/anyfive/ipims/share/menu/image/menu_left_show.gif" width="6px" height="40px"
                id="img_menuShow"
                onClick="javascript:showHideMenu();"
                style="cursor:hand; display:none;"
            >
        </TD>
    </TR>
</TABLE>

<SCRIPT language="JScript">showHideMenu(true);</SCRIPT>

</BODY>
</HTML>
