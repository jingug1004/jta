<%@page pageEncoding="UTF-8"%><% response.setContentType("text/x-component; charset=utf-8"); %>
<%@page import="anyfive.framework.app.FrameworkApp"%><% FrameworkApp app = new FrameworkApp(request, response, out, true, true); %>
<PUBLIC:COMPONENT tagName="TREE" lightWeight="false">
    <PUBLIC:DEFAULTS tabStop="true" viewInheritStyle="true" viewLinkContent="true" viewMasterTab="false" />
    <PUBLIC:ATTACH event="ondocumentready" onevent="document_onready();" />
    <PUBLIC:PROPERTY name="isReady" value="false" />
    <PUBLIC:PROPERTY name="fg" />
    <PUBLIC:PROPERTY name="loader" get="getLoader" />
    <PUBLIC:PROPERTY name="parentColumn" />
    <PUBLIC:PROPERTY name="codeColumn" />
    <PUBLIC:PROPERTY name="nameColumn" />
    <PUBLIC:PROPERTY name="expandLevel" />
    <PUBLIC:PROPERTY name="showCheck" />
    <PUBLIC:PROPERTY name="lastCheck" />
    <PUBLIC:PROPERTY name="autoCheck" />
    <PUBLIC:PROPERTY name="value" get="getValue" put="setValue" />
    <PUBLIC:PROPERTY name="checked" get="getChecked" put="setChecked" />
    <PUBLIC:PROPERTY name="rowData" get="getRowData" />
    <PUBLIC:PROPERTY name="useNull" />
    <PUBLIC:METHOD name="addRoot" />
    <PUBLIC:METHOD name="addNode" />
    <PUBLIC:METHOD name="getNode" />
</PUBLIC:COMPONENT>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
<HEAD>
<META http-equiv="Content-Type" content="text/x-component; charset=utf-8">
<SCRIPT language="JScript" src="<%= request.getContextPath() %>/anyfive/framework/grid/flexgrid/FlexGrid.js"></SCRIPT>
<SCRIPT language="JScript">
var gNodeWhichs = new Object();
var gColumnIndex = new Object();
var gMouseDown = new Object();

var gCurrExpandNodeCodes;
var gCurrSelectedNodeObj;

var gRootNodes;
var gTreeNodes;

var gLoadingFrame;
var gLoader;

function content_oninit()
{
    gNodeWhichs["Root"] = 0;
    gNodeWhichs["Parent"] = 1;
    gNodeWhichs["FirstChild"] = 2;
    gNodeWhichs["LastChild"] = 3;
    gNodeWhichs["FirstSibling"] = 4;
    gNodeWhichs["LastSibling"] = 5;
    gNodeWhichs["NextSibling"] = 6;
    gNodeWhichs["PreviousSibling"] = 7;

    element.fg = document.getElementById("fg");

    if (element.style.width == "") {
        element.style.width = "100%";
    }

    if (element.style.height == "") {
        element.style.height = "100%";
    }
}

function document_onready()
{
    fg.FontName = "Tahoma";
    fg.FontSize = "9";

    for (var i = 0, elements = element.getElementsByTagName("*"); i < elements.length; i++) {
        if (elements[i].tagName == "SCRIPT" || elements[i].tagName == "COMMENT") eval(elements[i].text);
    }

    initControl();

    element.isReady = true;
}

function initControl()
{
    element.showCheck = (String(element.showCheck) == "true");

    if (element.showCheck == true) {
        fg.Cols = 2;
        fg.ColKey(0) = "ROW_CHK";
        fg.ColWidth(0) = 25 * 15;
        fg.ColDataType(0) = 11;
    } else {
        fg.Cols = 1;
    }

    fg.OutlineBar = 5;
    fg.OutlineCol = fg.Cols - 1;
    fg.ColKey(fg.OutlineCol) = element.nameColumn;
    fg.ColAlignment(fg.OutlineCol) = flexAlignLeftCenter;

    gLoadingFrame = document.createElement('<IFRAME src="' + top.getRoot() + '/anyfive/framework/grid/util/GridLoading.jsp?' + element.id + '" frameBorder="no" scrolling="no">');
    gLoadingFrame.style.position = "absolute";
    gLoadingFrame.style.width = "110px";
    gLoadingFrame.style.height = "30px";
    gLoadingFrame.style.display = "none";
    document.body.appendChild(gLoadingFrame);

    gLoadingFrame.setPosition = function()
    {
        this.style.left = (element.offsetWidth - parseInt(this.style.width, 10)) / 2;
        this.style.top = (element.offsetHeight - parseInt(this.style.height, 10)) / 2.5;
    }

    gLoadingFrame.show = function()
    {
        this.setPosition();
        this.style.display = "block";
    }

    gLoadingFrame.hide = function()
    {
        this.style.display = "none";
    }

    element.attachEvent("onresize", function()
    {
        gLoadingFrame.setPosition();
    });
}

function getLoader()
{
    if (gLoader == null) gLoader = new dataLoader();

    return gLoader;
}

function dataLoader()
{
    var xhr;
    var params;

    this.path;
    this.loading;
    this.onStart;
    this.onSuccess;
    this.onFail;

    this.error = new Object();

    this.error.show = function()
    {
        xhr.error.show();
    }

    this.init = function()
    {
        xhr = null;
        params = new Array();

        this.path = null;
        this.loading = false;
        this.onStart = null;
        this.onSuccess = null;
        this.onFail = null;

        this.error.type = null;
        this.error.number = null;
        this.error.description = null;
    }

    this.addParam = function(sName, sValue)
    {
        params.push({ name:sName, value:sValue });
    }

    this.execute = function()
    {
        if (this.path == null) return;
        if (this.loading == true) return;

        gLoadingFrame.show();

        this.loading = true;

        fg.Rows = 0;
        fg.FixedRows = 0;
        gTreeNodes = new Object();

        if (gLoader.onStart != null) {
            gLoader.onStart(element, fg);
        }

        xhr = new any.xmlHttp();

        xhr.path = this.path;

        for (var i = 0; i < params.length; i++) {
            xhr.addParam(params[i].name, params[i].value);
        }

        xhr.send();

        xhr.req.onreadystatechange = function()
        {
            if (xhr == null) return;
            if (xhr.req == null) return;
            if (xhr.req.readyState != 4) return;

            if (xhr.error() == true) {
                gLoadingFrame.hide();
                for (var item in xhr.error) {
                    if (typeof(xhr.error[item]) != "function") gLoader.error[item] = xhr.error[item];
                }
                if (gLoader.onFail != null) {
                    gLoader.onFail(element, fg);
                }
                return;
            }

            var resText = xhr.req.responseText;

            xhr.req = null;
            xhr = null;

            if (resText == "") return;

            try {

                var resData = eval("(" + resText + ")");

                fg.Redraw = 0;

                if (gRootNodes != null) {
                    addNode(gRootNodes.prior, gRootNodes.code, gRootNodes.text);
                }

                for (var r = 0; r < resData.data.data.length; r++) {
                    addNode(resData.data.data[r]);
                }

                if (fg.ColKey(0) == "ROW_CHK") {
                    fg.Cell(6, 0, 0, fg.Rows - 1, 0) = "&HE5E5E5";
                    if (String(element.lastCheck) == "true") {
                        for (var r = 0; r < fg.Rows; r++) {
                            if (fg.GetNode(r).Children != 0) {
                                fg.TextMatrix(r, 0) = "";
                            }
                        }
                    }
                }

                if (gCurrExpandNodeCodes != null) {
                    var nd;
                    for (var i = gCurrExpandNodeCodes.length - 1; i >= 0; i--) {
                        nd = getNode(gCurrExpandNodeCodes[i]);
                        nd.Expanded = true;
                        nd = nd.GetNode(gNodeWhichs["Parent"]);
                        if (nd != null) nd.Expanded = false;
                    }
                    gCurrExpandNodeCodes = null;
                }

                if (gCurrSelectedNodeObj != null) {
                    fg.Row = Math.min(getNode(gCurrSelectedNodeObj.rowCode).Row, fg.Rows - 1);
                    fg.TopRow = gCurrSelectedNodeObj.topRow;
                    gCurrSelectedNodeObj = null;
                } else {
                    fg.Row = Math.min(0, fg.Rows - 1);
                    fg.TopRow = 0;
                }

            } catch(ex) {
                alert(ex.description);
            } finally {
                fg.Redraw = 2;
            }

            setGrid();

            if (gLoader.onSuccess != null) {
                gLoader.onSuccess(element, fg);
            }
        }
    }

    this.reload = function()
    {
        gCurrExpandNodeCodes = new Array();
        for (var r = 0; r < fg.Rows; r++) {
            if (fg.GetNode(r).Children == 0) continue;
            if (fg.GetNode(r).Expanded != true) continue;
            gCurrExpandNodeCodes.push(getValue(r, element.codeColumn));
        }

        gCurrSelectedNodeObj = new Object();
        gCurrSelectedNodeObj.rowCode = getValue(fg.Row, element.codeColumn);
        gCurrSelectedNodeObj.topRow = fg.TopRow;

        this.execute();
    }

    this.cancel = function()
    {
        try {
            xhr.req.abort();
        } catch(ex) {
        }

        setGrid();
    }

    function setGrid()
    {
        gLoader.loading = false;

        gLoadingFrame.hide();

        fg.focus();
    }
}

function addRoot(sPrior, sCode, sText)
{
    gRootNodes = { prior:sPrior, code:sCode, text:sText };
}

function addNode()
{
    var oData;
    var sPrior;
    var sCode;
    var sText;

    switch (arguments.length) {
    case 3:
        oData  = {};
        oData[element.parentColumn] = arguments[0];
        oData[element.codeColumn] = arguments[1];
        oData[element.nameColumn] = arguments[2];
        break;
    case 1:
        oData  = arguments[0].data;
        break;
    default:
        return;
    }

    sPrior = oData[element.parentColumn];
    sCode  = oData[element.codeColumn];
    sText  = oData[element.nameColumn];

    var priorRow;
    var priorLevel;
    var priorNode;
    var nodeLevel;
    var nodeRow;

    if (gTreeNodes[sPrior] == null) {
        nodeLevel = 1;
        nodeRow = fg.Rows;
        fg.AddItem("");
    } else {
        priorRow = gTreeNodes[sPrior].Row;
        priorLevel = fg.RowOutlineLevel(priorRow);
        priorNode = fg.GetNode(priorRow);
        nodeLevel = priorLevel + 1;
        nodeRow = priorNode.AddNode(flexNTLastChild, "").Row;
        if (element.expandLevel != -1 && priorLevel > element.expandLevel) {
            priorNode.Expanded = false;
        }
    }

    fg.IsSubtotal(nodeRow) = true;
    fg.RowOutlineLevel(nodeRow) = nodeLevel;
    fg.RowData(nodeRow) = { data:oData };

    if (element.showCheck == true && (gRootNodes == null || nodeRow > 0)) {
        fg.TextMatrix(nodeRow, 0) = 0;
    }

    fg.TextMatrix(nodeRow, fg.OutlineCol) = sText;

    gTreeNodes[sCode] = fg.GetNode(nodeRow);

    return nodeRow;
}

function getValue(iRowIdx, sColKey)
{
    if (sColKey == "ROW_CHK") {
        return fg.TextMatrix(iRowIdx, fg.ColIndex(sColKey));
    }

    if (fg.RowData(iRowIdx) == null) {
        return (element.useNull == true ? null : "");
    }

    var sValue = fg.RowData(iRowIdx).data[sColKey];

    if (sValue == null && element.useNull != true) return "";

    return sValue;
}

function setValue(iRowIdx, sColKey, sValue)
{
    fg.RowData(iRowIdx).data[sColKey] = sValue;
}

function getChecked(iRowIdx)
{
    var col = fg.ColIndex("ROW_CHK");
    var row = (iRowIdx == null || iRowIdx == -1 ? fg.Row : iRowIdx);

    if (col == -1) return null;
    if (row < 0) return null;
    if (row >= fg.Rows) return null;
    if (fg.TextMatrix(row, col) == "") return null;

    return (fg.TextMatrix(row, col) == "1");
}

function setChecked(iRowIdx, bValue)
{
    var col = fg.ColIndex("ROW_CHK");
    var row = (iRowIdx == null || iRowIdx == -1 ? fg.Row : iRowIdx);

    if (col == -1) return;
    if (row < 0) return;
    if (row >= fg.Rows) return;
    if (fg.TextMatrix(row, col) == "") return;

    fg.TextMatrix(row, col) = (bValue == true ? "1" : "0");

    if (String(element.autoCheck) == "true") {
        doAutoCheck();
    }

    function doAutoCheck()
    {
        try {

            fg.ReDraw = 0;

            if (getChecked(-1) == true) {
                var parentNode = getNode(-1, "Parent");
                while (parentNode != null) {
                    if (fg.TextMatrix(parentNode.Row, col) != "") {
                        fg.TextMatrix(parentNode.Row, col) = "1";
                    }
                    parentNode = getNode(parentNode.Row, "Parent");
                }
            } else {
                var currLevel = fg.RowOutlineLevel(fg.Row);
                for (var r = fg.Row + 1; r < fg.Rows; r++) {
                    if (fg.RowOutlineLevel(r) <= currLevel) break;
                    fg.TextMatrix(r, col) = "0";
                }
            }

        } catch(ex) {
            fg.ReDraw = 2;
            throw(ex);
        } finally {
            fg.ReDraw = 2;
        }
    }
}

function getRowData(iRowIdx)
{
    if (fg.RowData(iRowIdx) == null) return {};
    if (fg.RowData(iRowIdx).data == null) return {};

    return fg.RowData(iRowIdx).data;
}

function getNode(vRowVar, vWhich)
{
    var row;
    var which;

    if (typeof(vRowVar) == "number") {
        row = vRowVar;
    } else {
        for (var r = 0; r < fg.Rows; r++) {
            if (getValue(r, element.codeColumn) != vRowVar) continue;
            row = r;
            break;
        }
    }

    if (vWhich == null) {
        which = -1;
    } else {
        if (typeof(vWhich) == "number") {
            which = vWhich;
        } else {
            which = gNodeWhichs[vWhich];
        }
        if (which == null) return null;
    }

    var nd = fg.GetNode(row == null || row == -1 ? fg.Row : row);

    if (nd == null) return null;
    if (which == -1) return nd;

    return nd.GetNode(which);
}
</SCRIPT>

<SCRIPT language="JScript" for="fg" event="AfterCollapse(lRow, iState)">
    fg.Row = lRow;
</SCRIPT>

<SCRIPT language="JScript" for="fg" event="KeyDown(iKeyCode, iShift)">
    var nd = fg.GetNode();

    switch (iKeyCode) {
    case 8: //Back Space
        nd = nd.GetNode(flexNTParent);
        break;
    case 37: //Left Arrow
        if (nd.Children > 0) {
            if (nd.Expanded == false) {
                nd = nd.GetNode(flexNTParent);
            } else {
                nd.Expanded = false;
            }
        } else {
            nd = nd.GetNode(flexNTParent);
        }
        break;
    case 39: //Right Arrow
        if (nd.Children > 0) {
            if (nd.Expanded == true) {
                nd = nd.GetNode(flexNTFirstChild);
            } else {
                nd.Expanded = true;
            }
        }
        break;
    }

    if (nd == null) return;

    nd.Select();
    nd.EnsureVisible();
</SCRIPT>

<SCRIPT language="JScript" for="fg" event="MouseDown(iButton, iShift, iX, iY)">
    gMouseDown.button = iButton;
    gMouseDown.shift = iShift;
    gMouseDown.x = iX;
    gMouseDown.y = iY;
    gMouseDown.mouseRow = fg.MouseRow;
    gMouseDown.mouseCol = fg.MouseCol;
</SCRIPT>

<SCRIPT language="JScript" for="fg" event="Click()">
    var row = fg.MouseRow;
    var col = fg.MouseCol;

    if (gMouseDown.button != 1) return;
    if (gMouseDown.mouseRow != row) return;
    if (gMouseDown.mouseCol != col) return;
    if (row == -1) return;
    if (col == -1) return;

    var row = row;
    var col = col;

    if (fg.ColKey(col) == "ROW_CHK") {
        setChecked(row, !getChecked(row));
    }
</SCRIPT>

<SCRIPT language="JScript" for="fg" event="DblClick()">
    var row = fg.MouseRow;
    var col = fg.MouseCol;

    if (gMouseDown.button != 1) return;
    if (gMouseDown.mouseRow != row) return;
    if (gMouseDown.mouseCol != col) return;
    if (row == -1) return;
    if (col == -1) return;

    var nd = fg.GetNode();

    if (nd.Children > 0) {
        nd.Expanded = (nd.Expanded == false);
    }
</SCRIPT>
</HEAD>

<BODY>

<TABLE border="0" cellspacing="1" cellpadding="0" bgColor="#999999" width="100%" height="100%">
    <TR>
        <TD height="100%" bgColor="#FFFFFF" style="padding:3px;">
            <SCRIPT language="JScript">new FlexGrid("fg", "tree", document);</SCRIPT>
        </TD>
    </TR>
</TABLE>

<SCRIPT language="JScript">content_oninit();</SCRIPT>

</BODY>
</HTML>
