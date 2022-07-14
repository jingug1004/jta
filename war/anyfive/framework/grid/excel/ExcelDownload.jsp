<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.framework.app.FrameworkApp"%><% FrameworkApp app = new FrameworkApp(request, response, out, true, true); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>Grid Download</TITLE>
<META http-equiv="Content-Type" content="text/html; charset=utf-8">
<META http-equiv="Cache-Control" content="no-cache; no-store; no-save">
<META http-equiv="Expires" content="0">
<META http-equiv="Pragma" content="no-cache">
<STYLE type="text/css">
BODY, TD, BUTTON {
    font-family: "Tahoma";
    font-size: 12px;
}

BUTTON {
    width: 80px;
    height: 26px;
}
</STYLE>
<ANY:DS id="ds_headerText" style="behavior:url('<%= request.getContextPath() %>/anyfive/framework/htc/anyworks/ds.htc');" />
<ANY:DS id="ds_columnList" style="behavior:url('<%= request.getContextPath() %>/anyfive/framework/htc/anyworks/ds.htc');" />
<SCRIPT language="JScript">
var arg = top.window.dialogArguments.arg;
var gr = arg.gr;

//윈도우 로딩시
window.onload = function()
{
    fld_page.disabled = (gr.pagingType != 1);

    rdo_page_0.parentElement.style.cursor = (fld_page.disabled ? "default" : "cursor");
    rdo_page_1.parentElement.style.cursor = (fld_page.disabled ? "default" : "cursor");
}

//문서 키입력시
document.onkeypress = function()
{
    if (event.keyCode == 27) {
        top.window.close();
    }
}

//Download
function fnDownload()
{
    var pagingType = arg.pagingType;
    var pagingParams = arg.pagingParams;
    var gridSorting = arg.gridSorting;
    var params = arg.params;
    var downloadMode = (rdo_page_0.checked == true ? 2 : 1);

    var frm = document.createElement('<FORM>');
    document.appendChild(frm);

    function addHidden(name, value)
    {
        var hdn = document.createElement('<INPUT type="hidden" name="' + name + '">');
        frm.appendChild(hdn);
        hdn.value = value;
    }

    function getLoaderPath()
    {
        var ldrPath = gr.loader.path;
        var docPath = gr.document.location.pathname;

        if (ldrPath.substr(0, 1) == "/") {
            return ldrPath;
        } else {
            return docPath.substr(0, docPath.lastIndexOf("/")) + "/" + ldrPath;
        }
    }

    frm.action = getLoaderPath();
    frm.method = "post";
    frm.target = (event && event.shiftKey && event.ctrlKey && event.altKey == true ? "_blank" : "ifr_download");

    var headerTextRow;
    var columnListRow;

    ds_headerText.init();
    ds_columnList.init();

    for (var r = 0; r < gr.fg.FixedRows; r++) {
        headerTextRow = ds_headerText.addRow();
        for (var c = 0; c < gr.fg.Cols; c++) {
            if (gr.fg.ColData(c).info.nouse == true) continue;
            if (r < gr.fg.FixedRows - 1) {
                ds_headerText.value(headerTextRow, gr.fg.ColKey(c)) = gr.fg.Cell(0, r, c);
            } else {
                ds_headerText.value(headerTextRow, gr.fg.ColKey(c)) = gr.headerName(gr.fg.ColKey(c));
            }
        }
    }

    for (var c = 0; c < gr.fg.Cols; c++) {
        if (gr.fg.ColData(c).info.nouse == true) continue;
        row = ds_columnList.addRow();
        ds_columnList.value(row, "ID") = gr.fg.ColKey(c);
        ds_columnList.value(row, "ALIGN") = gr.fg.ColData(c).info.align;
        ds_columnList.value(row, "TYPE") = gr.fg.ColData(c).info.type;
        if (gr.fg.ColData(c).info.format != null && gr.fg.ColData(c).info.format.indexOf(",") != -1) {
            ds_columnList.value(row, "COMMA") = 1;
        } else {
            ds_columnList.value(row, "COMMA") = 0;
        }
        if (gr.fg.ColData(c).info.format != null && gr.fg.ColData(c).info.format.indexOf(".") != -1) {
            ds_columnList.value(row, "DIGITS") = gr.fg.ColData(c).info.format.substr(gr.fg.ColData(c).info.format.indexOf(".") + 1).length;
        } else {
            ds_columnList.value(row, "DIGITS") = -1;
        }
        ds_columnList.value(row, "WIDTH") = parseInt(gr.fg.ColWidth(c) * 1.3, 10) * 2;
        ds_columnList.value(row, "HIDE") = (gr.fg.ColHidden(c) == true ? 1 : 0);
    }

    var dataSetXML = new Array();

    dataSetXML.push(ds_headerText.getXML(false, false, ds_headerText.id));
    dataSetXML.push(ds_columnList.getXML(false, false, ds_columnList.id));

    addHidden("_DATA_SET_XML_", '<?xml version="1.0" encoding="utf-8"?><root>' + dataSetXML.join("") + '</root>');

    var pagingSort = new Array();

    for (var i = 0; i < gridSorting.length; i++) {
        if (gr.defaultColumnListDs != null && gr.defaultColumnListDs.valueRow(["COL_ID", gridSorting[i].name]) == -1) continue;
        pagingSort.push(gridSorting[i].name + ":" + gridSorting[i].type);
    }

    addHidden("_PAGING_TYPE_", pagingType);
    addHidden("_PAGING_NO_", pagingParams.no);
    addHidden("_PAGING_SIZE_", pagingParams.size);
    addHidden("_PAGING_SORT_", pagingSort.join(","));

    for (var i = 0; i < params.length; i++) {
        if (params[i].value != null) addHidden(params[i].name, params[i].value);
    }

    if (gr.pagingType == 1 && downloadMode == 2) {
        frm.elements["_PAGING_SIZE_"].value = -1;
    }

    addHidden("_DOWNLOAD_MODE_", downloadMode);
    addHidden("_DOWNLOAD_TITLE_", gr.title == null || gr.title == "" ? gr.document.title : gr.title);
    addHidden("_ROW_NUM_DIR_", arg.rowNumDir);

    frm.submit();

    document.removeChild(frm);
}
</SCRIPT>
</HEAD>

<BODY bgColor="#ECE9D8" style="margin:15px; text-align:center;">

<FIELDSET id="fld_page" disabled>
    <LEGEND style="margin-bottom:5px;">Page Select</LEGEND>
    <DIV style="width:100%; height:100%; padding:0 10 0 10;">
    <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
        <TR>
            <TD noWrap>
                <LABEL for="rdo_page_0" style="cursor:hand;">
                    <INPUT type="radio" name="rdo_page" id="rdo_page_0" onFocus="this.blur();">All Page
                </LABEL>
            </TD>
            <TD noWrap align="right">
                <LABEL for="rdo_page_1" style="cursor:hand;">
                    <INPUT type="radio" name="rdo_page" id="rdo_page_1" onFocus="this.blur();" checked>Only Current Page
                </LABEL>
            </TD>
        </TR>
    </TABLE>
    </DIV>
</FIELDSET>

<BR>

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
    <TR>
        <TD align="right">
            <BUTTON onClick="javascript:fnDownload();">Download</BUTTON>
            <BUTTON onClick="javascript:top.window.close();">Close</BUTTON>
        </TD>
    </TR>
</TABLE>

<IFRAME name="ifr_download" style="display:none;"></IFRAME>

</BODY>
</HTML>
