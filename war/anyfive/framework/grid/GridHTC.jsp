<%--<%@page pageEncoding="UTF-8"%><% response.setContentType("text/x-component; charset=utf-8"); %>--%>
<%--<%@page import="anyfive.framework.app.FrameworkApp"%><% FrameworkApp app = new FrameworkApp(request, response, out, true, true); %>--%>
<%--<PUBLIC:COMPONENT tagName="GRID" lightWeight="false">--%>
<%--    <PUBLIC:DEFAULTS tabStop="true" viewInheritStyle="true" viewLinkContent="true" viewMasterTab="false" />--%>
<%--    <PUBLIC:ATTACH event="ondocumentready" onevent="document_onready();" />--%>
<%--    <PUBLIC:PROPERTY name="isReady" value="false" />--%>
<%--    <PUBLIC:PROPERTY name="fg" />--%>
<%--    <PUBLIC:PROPERTY name="title" />--%>
<%--    <PUBLIC:PROPERTY name="loader" get="getLoader" />--%>
<%--    <PUBLIC:PROPERTY name="pagingType" value="0" />--%>
<%--    <PUBLIC:PROPERTY name="rowNumDir" value="ASC" />--%>
<%--    <PUBLIC:PROPERTY name="viewType" value="grid" />--%>
<%--    <PUBLIC:PROPERTY name="useConfig" get="getUseConfig" put="setUseConfig" />--%>
<%--    <PUBLIC:PROPERTY name="messageSpan" get="getMessageSpan" put="setMessageSpan" />--%>
<%--    <PUBLIC:PROPERTY name="headerName" get="getHeaderName" put="setHeaderName" />--%>
<%--    <PUBLIC:PROPERTY name="columnInfo" get="getColumnInfo" />--%>
<%--    <PUBLIC:PROPERTY name="value" get="getValue" put="setValue" />--%>
<%--    <PUBLIC:PROPERTY name="checked" get="getChecked" put="setChecked" />--%>
<%--    <PUBLIC:PROPERTY name="editable" get="getEditable" put="setEditable" />--%>
<%--    <PUBLIC:PROPERTY name="minHeight" put="setMinHeight" />--%>
<%--    <PUBLIC:PROPERTY name="text" get="getText" />--%>
<%--    <PUBLIC:PROPERTY name="rowData" get="getRowData" />--%>
<%--    <PUBLIC:PROPERTY name="cell" put="setCell" />--%>
<%--    <PUBLIC:PROPERTY name="beforeSort" />--%>
<%--    <PUBLIC:PROPERTY name="beforeCheck" />--%>
<%--    <PUBLIC:PROPERTY name="useNull" />--%>
<%--    <PUBLIC:METHOD name="init" />--%>
<%--    <PUBLIC:METHOD name="addHeader" />--%>
<%--    <PUBLIC:METHOD name="addColumn" />--%>
<%--    <PUBLIC:METHOD name="setFixedColumn" />--%>
<%--    <PUBLIC:METHOD name="setExtendColumnWidth" />--%>
<%--    <PUBLIC:METHOD name="setSorting" />--%>
<%--    <PUBLIC:METHOD name="addSorting" />--%>
<%--    <PUBLIC:METHOD name="addAction" />--%>
<%--    <PUBLIC:METHOD name="delAction" />--%>
<%--    <PUBLIC:METHOD name="getAction" />--%>
<%--    <PUBLIC:METHOD name="setOutline" />--%>
<%--    <PUBLIC:METHOD name="addCheck" />--%>
<%--    <PUBLIC:METHOD name="addImage" />--%>
<%--    <PUBLIC:METHOD name="setBind" />--%>
<%--    <PUBLIC:METHOD name="moveRowPos" />--%>
<%--    <PUBLIC:METHOD name="moveRowData" />--%>
<%--    <PUBLIC:METHOD name="clearAll" />--%>
<%--    <PUBLIC:METHOD name="changeConfig" />--%>
<%--</PUBLIC:COMPONENT>--%>

<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">--%>
<%--<HTML XMLNS:ANY>--%>
<%--<HEAD>--%>
<%--<META http-equiv="Content-Type" content="text/x-component; charset=utf-8">--%>
<%--<LINK rel="StyleSheet" type="text/css" href="<%= request.getContextPath() %>/anyfive/framework/css/style.css">--%>
<%--<SCRIPT language="JScript" src="<%= request.getContextPath() %>/anyfive/framework/grid/flexgrid/FlexGrid.js"></SCRIPT>--%>
<%--<SCRIPT language="JScript" src="<%= request.getContextPath() %>/anyfive/framework/js/md5.js"></SCRIPT>--%>
<%--<SCRIPT></SCRIPT>--%>
<%--<% app.writeHTCImport("/anyfive/framework/htc/anyworks/ds.htc"); %>--%>
<%--<STYLE type="text/css">--%>
<%--INPUT.PAGING_NO {--%>
<%--    border: none;--%>
<%--    text-align: center;--%>
<%--    width: 60px;--%>
<%--    height: 17px;--%>
<%--}--%>

<%--BUTTON {--%>
<%--    width: 30px;--%>
<%--    height: 19px;--%>
<%--}--%>
<%--</STYLE>--%>
<%--<SCRIPT language="JScript">--%>
<%--var gHeaderInfo = new Array();--%>
<%--var gGridSorting = new Array();--%>
<%--var gGridSortingDefault = new Array();--%>
<%--var gGridActions = new Object();--%>
<%--var gCheckColumns = new Object();--%>
<%--var gImageColumns = new Object();--%>
<%--var gPagingParams = new Object();--%>
<%--var gMouseDown = new Object();--%>

<%--var gAutoColumn = true;--%>
<%--var gUserResized = false;--%>
<%--var gFixedColumns = {};--%>
<%--var gCheckColumnIcon = { 0:"◇", 1:"◆" };--%>
<%--var gSortTypeMarker = { ASC:"▲", DESC:"▼" };--%>
<%--var gHilightRow;--%>

<%--var gConfigUse = false;--%>
<%--var gConfigLoaded = { column:false, sorting:false };--%>
<%--var gExtendColKey;--%>
<%--var gRowConfig;--%>
<%--var gGridPath;--%>
<%--var gGridId;--%>

<%--var gPopup;--%>

<%--var gLoadingFrame;--%>
<%--var gMessageSpan;--%>
<%--var gOutlineInfo;--%>
<%--var gEditable;--%>
<%--var gMinHeight;--%>
<%--var gLoader;--%>

<%--function content_oninit()--%>
<%--{--%>
<%--    element.fg = document.getElementById("fg");--%>

<%--    if (element.style.width == "") {--%>
<%--        element.style.width = "100%";--%>
<%--    }--%>

<%--    if (element.style.height == "") {--%>
<%--        element.style.height = "100%";--%>
<%--    }--%>
<%--}--%>

<%--function document_onready()--%>
<%--{--%>
<%--    div_popupMenu.style.display = "none";--%>

<%--    fg.FontName = "Tahoma";--%>
<%--    fg.FontSize = "9";--%>

<%--    for (var i = 0, elements = element.getElementsByTagName("*"); i < elements.length; i++) {--%>
<%--        if (elements[i].tagName == "SCRIPT" || elements[i].tagName == "COMMENT") eval(elements[i].text);--%>
<%--    }--%>

<%--    gEditable = fg.Editable;--%>

<%--    fg.Editable = flexEDNone;--%>

<%--    changeConfig();--%>

<%--    if (element.pagingType != 0) {--%>
<%--        gPagingParams.size = sel_pagingSize.value = 50;--%>
<%--        gPagingParams.no = 1;--%>
<%--    }--%>

<%--    setMinHeightResize();--%>
<%--    setExtendColumnWidth();--%>

<%--    initControl();--%>
<%--    initPopup();--%>
<%--}--%>

<%--function init()--%>
<%--{--%>
<%--    gHeaderInfo = new Array();--%>
<%--    gGridSorting = new Array();--%>
<%--    gGridSortingDefault = new Array();--%>
<%--    gGridActions = new Object();--%>
<%--    gCheckColumns = new Object();--%>
<%--    gImageColumns = new Object();--%>
<%--    gMouseDown = new Object();--%>

<%--    gAutoColumn = true;--%>
<%--    gUserResized = false;--%>

<%--    gConfigLoaded = { column:false, sorting:false };--%>
<%--    gExtendColKey = null;--%>

<%--    gPagingParams.no = 1;--%>

<%--    fg.Rows = fg.Cols = 0;--%>
<%--}--%>

<%--function initControl()--%>
<%--{--%>
<%--    gLoadingFrame = document.createElement('<IFRAME src="' + top.getRoot() + '/anyfive/framework/grid/util/GridLoading.jsp?' + element.id + '" frameBorder="no" scrolling="no">');--%>
<%--    gLoadingFrame.style.position = "absolute";--%>
<%--    gLoadingFrame.style.width = "110px";--%>
<%--    gLoadingFrame.style.height = "30px";--%>
<%--    gLoadingFrame.style.display = "none";--%>
<%--    document.body.appendChild(gLoadingFrame);--%>

<%--    gLoadingFrame.setPosition = function()--%>
<%--    {--%>
<%--        this.style.left = (element.offsetWidth - parseInt(this.style.width, 10)) / 2;--%>
<%--        this.style.top = (element.offsetHeight - parseInt(this.style.height, 10)) / 2.5;--%>
<%--    }--%>

<%--    gLoadingFrame.show = function()--%>
<%--    {--%>
<%--        this.setPosition();--%>
<%--        this.style.display = "block";--%>
<%--    }--%>

<%--    gLoadingFrame.hide = function()--%>
<%--    {--%>
<%--        this.style.display = "none";--%>
<%--    }--%>

<%--    element.attachEvent("onresize", function()--%>
<%--    {--%>
<%--        gLoadingFrame.setPosition();--%>
<%--    });--%>

<%--    element.attachEvent("onkeyup", function()--%>
<%--    {--%>
<%--        if (event.keyCode < "A".charCodeAt(0)) return;--%>
<%--        if (event.keyCode > "Z".charCodeAt(0)) return;--%>

<%--        execPopupCommand(String.fromCharCode(event.keyCode));--%>
<%--    });--%>

<%--    if (gMessageSpan != null) {--%>
<%--        gMessageSpan.innerHTML = "(Ready)";--%>
<%--    }--%>
<%--}--%>

<%--function getUseConfig()--%>
<%--{--%>
<%--    return gConfigUse;--%>
<%--}--%>

<%--function setUseConfig(bUse)--%>
<%--{--%>
<%--    gConfigUse = bUse;--%>
<%--}--%>

<%--function getMessageSpan()--%>
<%--{--%>
<%--    return gMessageSpan;--%>
<%--}--%>

<%--function setMessageSpan(vSpan)--%>
<%--{--%>
<%--    if (typeof(vSpan) == "string") {--%>
<%--        gMessageSpan = element.document.getElementById(vSpan);--%>
<%--    } else {--%>
<%--        gMessageSpan = vSPan;--%>
<%--    }--%>

<%--    gMessageSpan.style.whiteSpace = "nowrap";--%>
<%--}--%>

<%--function addHeaderRow()--%>
<%--{--%>
<%--    if (fg.FixedRows > gHeaderInfo.length) return;--%>

<%--    fg.Rows++;--%>
<%--    fg.FixedRows++;--%>
<%--    fg.RowHeight(fg.FixedRows - 1) = 350;--%>
<%--    fg.MergeRow(fg.FixedRows - 1) = true;--%>
<%--}--%>

<%--function addHeader(arr)--%>
<%--{--%>
<%--    if (fg.FixedRows > gHeaderInfo.length) return;--%>

<%--    var header = new Array();--%>

<%--    for (var i = 0; i < arr.length; i++) {--%>
<%--        header.push(arr[i] == "" ? header[i - 1] : arr[i]);--%>
<%--    }--%>

<%--    gHeaderInfo.push(header);--%>

<%--    addHeaderRow();--%>
<%--}--%>

<%--function addColumn(obj)--%>
<%--{--%>
<%--    if (obj.id == null) return;--%>

<%--    gAutoColumn = false;--%>

<%--    addHeaderRow();--%>

<%--    fg.Cols++;--%>

<%--    var c = fg.Cols - 1;--%>
<%--    var enum_align = { left:1, center:4, right:7 };--%>
<%--    var enum_dataType = { check:11, string:8, number:3, date:7, image:-40 };--%>

<%--    fg.ColData(c) = { info:{} };--%>
<%--    fg.ColData(c).info.index = c;--%>
<%--    fg.ColData(c).info.id = obj.id;--%>
<%--    fg.ColData(c).info.id2 = (obj.id2 == null ? obj.id : obj.id2);--%>
<%--    fg.ColData(c).info.name = (obj.name == null ? obj.id : obj.name);--%>
<%--    fg.ColData(c).info.width = obj.width;--%>
<%--    fg.ColData(c).info.align = (obj.align == null ? "left" : obj.align).toLowerCase();--%>
<%--    fg.ColData(c).info.type = (obj.type == null ? "string" : obj.type).toLowerCase();--%>
<%--    fg.ColData(c).info.nouse = (obj.nouse == null ? false : obj.nouse);--%>
<%--    fg.ColData(c).info.hide = (obj.hide == null ? false : obj.hide);--%>
<%--    fg.ColData(c).info.sort = (obj.sort == null ? false : obj.sort);--%>
<%--    fg.ColData(c).info.image = obj.image;--%>
<%--    fg.ColData(c).info.format = obj.format;--%>
<%--    fg.ColData(c).info.rownum = (obj.rownum == null ? "ASC" : obj.rownum);--%>
<%--    fg.ColData(c).info.edit = obj.edit;--%>
<%--    fg.ColData(c).info.codeData = obj.codeData;--%>
<%--    fg.ColData(c).info.editMask = obj.editMask;--%>
<%--    fg.ColData(c).info.text = obj.text;--%>

<%--    switch (fg.ColData(c).info.id.toUpperCase()) {--%>
<%--    case "ROW_NUM":--%>
<%--        fg.ColData(c).info.id = "ROW_NUM";--%>
<%--        fg.ColData(c).info.sort = false;--%>
<%--        break;--%>
<%--    case "ROW_CHK":--%>
<%--        fg.ColData(c).info.id = "ROW_CHK";--%>
<%--        fg.ColData(c).info.name = gCheckColumnIcon[0];--%>
<%--        fg.ColData(c).info.sort = false;--%>
<%--        break;--%>
<%--    }--%>

<%--    if (typeof(fg.ColData(c).info.text) == "string") {--%>
<%--        fg.ColData(c).info.textString = fg.ColData(c).info.text;--%>
<%--        fg.ColData(c).info.text = function(gr, fg, row, colId, value) { return fg.ColData(c).info.textString; }--%>
<%--    }--%>

<%--    if (fg.ColData(c).info.text == null) {--%>
<%--        if (fg.ColData(c).info.id == "ROW_NUM") {--%>
<%--            if (element.pagingType == 0) {--%>
<%--                fg.ColData(c).info.text = function(gr, fg, row, colId, value) { return getRowNum(row); }--%>
<%--            } else {--%>
<%--                fg.ColData(c).info.text = function(gr, fg, row, colId, value) { return value; }--%>
<%--            }--%>
<%--        } else if (fg.ColData(c).info.type == "check") {--%>
<%--            fg.ColData(c).info.text = function(gr, fg, row, colId, value) { return (Number(value) == 1 ? 1 : 0); }--%>
<%--        } else if (fg.ColData(c).info.type == "date") {--%>
<%--            fg.ColData(c).info.text = function(gr, fg, row, colId, value) { return cfGetFormatDate(value); }--%>
<%--        } else if (fg.ColData(c).info.type == "number") {--%>
<%--            fg.ColData(c).info.text = function(gr, fg, row, colId, value) { return (isNaN(parseInt(value, 10)) ? "" : Number(value)); }--%>
<%--        } else {--%>
<%--            fg.ColData(c).info.text = function(gr, fg, row, colId, value) { return value; }--%>
<%--        }--%>
<%--    }--%>

<%--    for (var r = 0; r < gHeaderInfo.length; r++) {--%>
<%--        fg.TextMatrix(r, c) = (gHeaderInfo[r][c] == null ? fg.ColData(c).info.name : gHeaderInfo[r][c]);--%>
<%--        if (fg.TextMatrix(fg.FixedRows - 1, c) == fg.TextMatrix(fg.FixedRows - (gHeaderInfo.length - r), c)) {--%>
<%--            fg.MergeCol(c) = true;--%>
<%--        }--%>
<%--    }--%>

<%--    fg.ColKey(c) = fg.ColData(c).info.id;--%>
<%--    fg.TextMatrix(fg.FixedRows - 1, c) = fg.ColData(c).info.name;--%>
<%--    if (fg.ColData(c).info.width != null) {--%>
<%--        fg.ColWidth(c) = fg.ColData(c).info.width * 15;--%>
<%--    }--%>
<%--    fg.ColAlignment(c) = enum_align[fg.ColData(c).info.align];--%>
<%--    fg.ColDataType(c) = enum_dataType[fg.ColData(c).info.type];--%>
<%--    fg.ColHidden(c) = (fg.ColData(c).info.nouse == true || fg.ColData(c).info.hide == true);--%>
<%--    if (fg.ColData(c).info.format != null) {--%>
<%--        fg.ColFormat(c) = fg.ColData(c).info.format;--%>
<%--    }--%>

<%--    if (fg.ColData(c).info.sort == true) {--%>
<%--        for (var r = 0; r < fg.FixedRows; r++) {--%>
<%--            if (fg.TextMatrix(r, c) != fg.ColData(c).info.name) continue;--%>
<%--            fg.Cell(flexcpForeColor, r, c, r, c) = "&H800000";--%>
<%--        }--%>
<%--    }--%>

<%--    if (gExtendColKey == null) gExtendColKey = obj.id;--%>

<%--    if (fg.ColData(c).info.width >= fg.ColData(fg.ColIndex(gExtendColKey)).info.width) {--%>
<%--        gExtendColKey = obj.id;--%>
<%--    }--%>

<%--    if (fg.ColData(c).info.codeData != null) {--%>
<%--        var codeDatas = any.getCodeData(fg.ColData(c).info.codeData);--%>
<%--        var comboList = new Array();--%>
<%--        for (var i = 0; i < codeDatas.length; i++) {--%>
<%--            comboList.push("#" + codeDatas[i].data.CODE + ";" + any.getCodeName(codeDatas[i].data));--%>
<%--        }--%>
<%--        fg.ColComboList(c) = comboList.join("|");--%>
<%--    }--%>

<%--    fg.Cell(flexcpAlignment, 0, c, fg.FixedRows - 1, c) = flexAlignCenterCenter;--%>
<%--    fg.Cell(flexcpPictureAlignment, 0, c, fg.FixedRows - 1, c) = flexPicAlignCenterCenter;--%>
<%--}--%>

<%--function setFixedColumn(sFixedColId, sFrozenColId)--%>
<%--{--%>
<%--    gFixedColumns = { fixedColId:sFixedColId, frozenColId:sFrozenColId };--%>

<%--    if (sFixedColId != null && fg.ColIndex(sFixedColId) != -1) {--%>
<%--        fg.FixedCols = fg.ColIndex(sFixedColId) + 1;--%>
<%--    }--%>
<%--    if (sFrozenColId != null && fg.ColIndex(sFrozenColId) != -1) {--%>
<%--        fg.FrozenCols = fg.ColIndex(sFrozenColId) + 1 - fg.FixedCols;--%>
<%--    }--%>
<%--}--%>

<%--function setSorting(sName, sType)--%>
<%--{--%>
<%--    gGridSorting = new Array();--%>

<%--    addSorting(sName, sType, true);--%>
<%--}--%>

<%--function addSorting(sName, sType, bNotDefault)--%>
<%--{--%>
<%--    if (sName == null) return;--%>

<%--    try {--%>
<%--        if (fg.ColIndex(sName) != -1 && fg.ColData(fg.ColIndex(sName)).info.sort != true) return;--%>
<%--    } catch(ex) {--%>
<%--    }--%>

<%--    add(gGridSorting);--%>

<%--    if (bNotDefault != true) {--%>
<%--        add(gGridSortingDefault);--%>
<%--    }--%>

<%--    function add(arr)--%>
<%--    {--%>
<%--        arr.push({ name:sName.trim(), type:(sType == null || sType == "" ? "ASC" : sType.trim().toUpperCase()) });--%>
<%--    }--%>
<%--}--%>

<%--function doSort(moveToFirst)--%>
<%--{--%>
<%--    if (gGridSorting.length == 0) return;--%>

<%--    for (var i = gGridSorting.length - 1; i >= 0; i--) {--%>
<%--        vbSortGrid(fg.ColIndex(gGridSorting[i].name), gGridSorting[i].type, moveToFirst);--%>
<%--    }--%>
<%--}--%>

<%--function addAction(sColKey, oAction, iType, oCheck)--%>
<%--{--%>
<%--    var iColIdx = fg.ColIndex(sColKey);--%>

<%--    if (iColIdx > -1 && fg.ColData(iColIdx) != null && fg.ColData(iColIdx).info.type == "check") {--%>
<%--        alert('Check column "' + sColKey + '" action is not available!');--%>
<%--        return;--%>
<%--    }--%>

<%--    gGridActions[sColKey] = { type:(iType == null ? 1 : iType), action:oAction, check:oCheck };--%>

<%--    putAction(sColKey);--%>
<%--}--%>

<%--function delAction(sColKey)--%>
<%--{--%>
<%--    gGridActions[sColKey] = null;--%>

<%--    if (fg.FixedRows == fg.Rows) return;--%>

<%--    var c = fg.ColIndex(sColKey);--%>

<%--    if (c == -1) return;--%>

<%--    fg.Cell(flexcpFontUnderline, fg.FixedRows, c, fg.Rows - 1, c) = false;--%>
<%--    fg.Cell(flexcpForeColor, fg.FixedRows, c, fg.Rows - 1, c) = "&H000000";--%>
<%--}--%>

<%--function putAction(sColKey)--%>
<%--{--%>
<%--    if (fg.FixedRows == fg.Rows) return;--%>

<%--    var gridAction = gGridActions[sColKey];--%>

<%--    if (gridAction == null) return;--%>

<%--    var c = fg.ColIndex(sColKey);--%>

<%--    if (c == -1) return;--%>

<%--    if (gridAction.check == null) {--%>
<%--        setActionStyle(fg.FixedRows, fg.Rows - 1, c);--%>
<%--        return;--%>
<%--    }--%>

<%--    for (var r = fg.FixedRows; r < fg.Rows; r++) {--%>
<%--        if (gridAction.check(element, fg, r, sColKey) == false) continue;--%>
<%--        setActionStyle(r, r, c);--%>
<%--    }--%>

<%--    function setActionStyle(startRow, endRow, col)--%>
<%--    {--%>
<%--        fg.Cell(flexcpFontUnderline, startRow, col, endRow, col) = true;--%>
<%--        fg.Cell(flexcpForeColor, startRow, col, endRow, col) = "&HFF0000";--%>
<%--    }--%>
<%--}--%>

<%--function getAction(sColKey)--%>
<%--{--%>
<%--    return gGridActions[sColKey];--%>
<%--}--%>

<%--function setOutline(sRootName, sOutlineColKey, sLevelColKey, iExtendLevel)--%>
<%--{--%>
<%--    gOutlineInfo = { rootName:sRootName, outlineColKey:sOutlineColKey, levelColKey:sLevelColKey, extendLevel:iExtendLevel };--%>
<%--}--%>

<%--function addCheck(sColKey, oCheckFunc)--%>
<%--{--%>
<%--    gCheckColumns[sColKey] = oCheckFunc;--%>

<%--    putCheck(sColKey);--%>
<%--}--%>

<%--function putCheck(sColKey)--%>
<%--{--%>
<%--    var iColIdx = fg.ColIndex(sColKey);--%>

<%--    if (iColIdx == -1) return;--%>
<%--    if (gCheckColumns[sColKey] == null) return;--%>

<%--    setPictureAlignment(iColIdx);--%>

<%--    var cpChecked;--%>

<%--    for (var r = fg.FixedRows; r < fg.Rows; r++) {--%>
<%--        cpChecked = gCheckColumns[sColKey](element, fg, r, sColKey);--%>
<%--        if (cpChecked == null) cpChecked = flexNoCheckbox;--%>
<%--        if (cpChecked != flexNoCheckbox) fg.ColData(iColIdx).info.checkBoxExists = true;--%>
<%--        fg.Cell(flexcpChecked, r, iColIdx) = cpChecked;--%>
<%--    }--%>
<%--}--%>

<%--function addImage(sColKey, oImageFunc)--%>
<%--{--%>
<%--    gImageColumns[sColKey] = oImageFunc;--%>
<%--}--%>

<%--function putImage(sColKey)--%>
<%--{--%>
<%--    var iColIdx = fg.ColIndex(sColKey);--%>
<%--    var imgs = new Object;--%>
<%--    var img;--%>

<%--    function getImage(src)--%>
<%--    {--%>
<%--        if (src == null) return null;--%>

<%--        if (imgs[src] == null) {--%>
<%--            imgs[src] = new Image();--%>
<%--            imgs[src].src = src;--%>
<%--        }--%>

<%--        return imgs[src];--%>
<%--    }--%>

<%--    if (iColIdx == -1) return;--%>
<%--    if (fg.Rows == fg.FixedRows) return;--%>

<%--    setPictureAlignment(iColIdx);--%>

<%--    if (fg.ColData(iColIdx) != null && fg.ColData(iColIdx).info != null && fg.ColData(iColIdx).info.image != null) {--%>
<%--        img = getImage(fg.ColData(iColIdx).info.image);--%>
<%--        if (img == null) return;--%>
<%--        try {--%>
<%--            fg.Cell(flexcpPicture, fg.FixedRows, iColIdx, fg.Rows - 1, iColIdx) = img.src;--%>
<%--        } catch(ex) {--%>
<%--            alert("[ERROR] Invalid Image!\n\n" + img.src);--%>
<%--        }--%>
<%--    } else if (gImageColumns[sColKey] != null) {--%>
<%--        for (var r = fg.FixedRows; r < fg.Rows; r++) {--%>
<%--            img = getImage(gImageColumns[sColKey](element, fg, r, sColKey));--%>
<%--            if (img == null) continue;--%>
<%--            try {--%>
<%--                fg.Cell(flexcpPicture, r, iColIdx) = img.src;--%>
<%--            } catch(ex) {--%>
<%--            }--%>
<%--        }--%>
<%--    }--%>
<%--}--%>

<%--function setRowConfig(iRowIdx)--%>
<%--{--%>
<%--    if (gRowConfig != null) gRowConfig(element, fg, iRowIdx);--%>
<%--}--%>

<%--function setBind(vData)--%>
<%--{--%>
<%--    var ds = (typeof(vData) == "object" ? vData : element.document.getElementById(vData));--%>
<%--    var row;--%>

<%--    ds.init();--%>

<%--    for (var c = 0; c < fg.Cols; c++) {--%>
<%--        ds.addCol(fg.ColKey(c));--%>
<%--    }--%>

<%--    for (var r = fg.FixedRows; r < fg.Rows; r++) {--%>
<%--        row = ds.addRow();--%>
<%--        for (var c = 0; c < fg.Cols; c++) {--%>
<%--            ds.value(row, c) = getValue(r, fg.ColKey(c));--%>
<%--        }--%>
<%--        if (fg.RowData(r) == null || fg.RowData(r).data == null) continue;--%>
<%--        for (var item in fg.RowData(r).data) {--%>
<%--            if (fg.ColIndex(item) == -1) ds.value(row, item) = getValue(r, item);--%>
<%--        }--%>
<%--    }--%>
<%--}--%>

<%--function setPictureAlignment(iColIdx)--%>
<%--{--%>
<%--    if (fg.Rows == fg.FixedRows) return;--%>

<%--    fg.Cell(flexcpPictureAlignment, fg.FixedRows, iColIdx, fg.Rows - 1, iColIdx) = fg.ColAlignment(iColIdx);--%>
<%--}--%>

<%--function doAction(iType)--%>
<%--{--%>
<%--    var row = fg.MouseRow;--%>
<%--    var col = fg.MouseCol;--%>

<%--    if (row == -1) return;--%>
<%--    if (col == -1) return;--%>

<%--    for (var item in gGridActions) {--%>
<%--        if (gGridActions[item] == null) continue;--%>
<%--        if (gGridActions[item].type != iType) continue;--%>
<%--        if (fg.ColKey(col) == item && (gGridActions[item].check == null || gGridActions[item].check(element, fg, row, fg.ColKey(col)) == true)) {--%>
<%--            gGridActions[item].action(element, fg, row, fg.ColKey(col));--%>
<%--            break;--%>
<%--        }--%>
<%--    }--%>
<%--}--%>

<%--function toggleCheckBox(allCheck)--%>
<%--{--%>
<%--    var row = fg.MouseRow;--%>
<%--    var col = fg.MouseCol;--%>

<%--    if (row == -1) return;--%>
<%--    if (col == -1) return;--%>

<%--    if (fg.ColData(col) == null) return;--%>
<%--    if (fg.ColData(col).info == null) return;--%>

<%--    if (fg.ColData(col).info.id == "ROW_CHK") {--%>
<%--        if (allCheck == true) {--%>
<%--            fg.ReDraw = 0;--%>
<%--            if (fg.ColData(col).info.type == "check") {--%>
<%--                var value = (fg.TextMatrix(fg.FixedRows - 1, col) == gCheckColumnIcon[0] ? 1 : 0);--%>
<%--                for (var r = fg.FixedRows; r < fg.Rows; r++) {--%>
<%--                    fg.TextMatrix(r, col) = value;--%>
<%--                }--%>
<%--            } else {--%>
<%--                var check = (fg.TextMatrix(fg.FixedRows - 1, col) == gCheckColumnIcon[0] ? flexChecked : flexUnchecked);--%>
<%--                for (var r = fg.FixedRows; r < fg.Rows; r++) {--%>
<%--                    if (fg.Cell(flexcpChecked, r, col) == flexNoCheckbox) continue;--%>
<%--                    fg.Cell(flexcpChecked, r, col) = check;--%>
<%--                }--%>
<%--            }--%>
<%--            fg.ReDraw = 2;--%>
<%--        } else {--%>
<%--            setChecked(row, fg.ColKey(col), (getChecked(row, fg.ColKey(col)) == false));--%>
<%--        }--%>
<%--        setCheckHeader(col);--%>
<%--    } else if (fg.Cell(flexcpChecked, row, col) != 0) {--%>
<%--        setChecked(row, fg.ColKey(col), (getChecked(row, fg.ColKey(col)) == false));--%>
<%--    }--%>
<%--}--%>

<%--function getHeaderName(sColKey)--%>
<%--{--%>
<%--    return fg.ColData(fg.ColIndex(sColKey)).info.name;--%>
<%--}--%>

<%--function setHeaderName(sColKey, sValue)--%>
<%--{--%>
<%--    fg.TextMatrix(fg.FixedRows - 1, fg.ColIndex(sColKey)) = sValue;--%>
<%--    fg.ColData(fg.ColIndex(sColKey)).info.name = sValue;--%>
<%--}--%>

<%--function getColumnInfo(sColKey)--%>
<%--{--%>
<%--    var c = fg.ColIndex(sColKey);--%>

<%--    if (c != -1) return fg.ColData(c).info;--%>
<%--}--%>

<%--function getLoader()--%>
<%--{--%>
<%--    if (gLoader == null) gLoader = new dataLoader();--%>

<%--    return gLoader;--%>
<%--}--%>

<%--function dataLoader()--%>
<%--{--%>
<%--    var xhr;--%>
<%--    var params;--%>
<%--    var reloadObj;--%>

<%--    this.loading = false;--%>
<%--    this.executed = false;--%>

<%--    this.path;--%>
<%--    this.result;--%>
<%--    this.onStart;--%>
<%--    this.onSuccess;--%>
<%--    this.onFail;--%>

<%--    this.error = new Object();--%>

<%--    this.error.show = function()--%>
<%--    {--%>
<%--        xhr.error.show();--%>
<%--    }--%>

<%--    this.init = function()--%>
<%--    {--%>
<%--        if (this.loading == true) return;--%>

<%--        xhr = null;--%>
<%--        params = new Array();--%>
<%--        reloadObj = null;--%>

<%--        this.path = null;--%>
<%--        this.result = null;--%>
<%--        this.onStart = null;--%>
<%--        this.onSuccess = null;--%>
<%--        this.onFail = null;--%>

<%--        for (var item in this.error) {--%>
<%--            if (item == "show") continue;--%>
<%--            this.error[item] = null;--%>
<%--        }--%>

<%--        try {--%>
<%--            new any.viewer().initialize();--%>
<%--        } catch(ex) {--%>
<%--        }--%>
<%--    }--%>

<%--    this.isReloading = function()--%>
<%--    {--%>
<%--        return (reloadObj != null);--%>
<%--    }--%>

<%--    this.addParam = function(sName, sValue)--%>
<%--    {--%>
<%--        if (this.loading == true) return;--%>

<%--        params.push({ name:sName, value:sValue });--%>
<%--    }--%>

<%--    this.setParam = function(sName, sValue)--%>
<%--    {--%>
<%--        if (this.loading == true) return;--%>

<%--        for (var i = 0; i < params.length; i++) {--%>
<%--            if (params[i].name != sName) continue;--%>
<%--            params[i].value = sValue;--%>
<%--            return;--%>
<%--        }--%>

<%--        this.addParam(sName, sValue);--%>
<%--    }--%>

<%--    this.getParam = function(sName)--%>
<%--    {--%>
<%--        if (params == null) return null;--%>

<%--        for (var i = 0; i < params.length; i++) {--%>
<%--            if (params[i].name == sName) return params[i].value;--%>
<%--        }--%>
<%--    }--%>

<%--    this.getParams = function(sName)--%>
<%--    {--%>
<%--        if (params == null) return null;--%>

<%--        var values = new Array();--%>
<%--        for (var i = 0; i < params.length; i++) {--%>
<%--            if (params[i].name == sName) values.push(params[i].value);--%>
<%--        }--%>
<%--        return values;--%>
<%--    }--%>

<%--    this.execute = function(keepPagingNo)--%>
<%--    {--%>
<%--        if (this.loading == true) return;--%>
<%--        if (this.path == null) return;--%>

<%--        for (var item in this.error) {--%>
<%--            if (item == "show") continue;--%>
<%--            this.error[item] = null;--%>
<%--        }--%>

<%--        this.loading = true;--%>

<%--        this.result = null;--%>

<%--        setMessage();--%>
<%--        setCheckHeader(fg.ColIndex("ROW_CHK"));--%>

<%--        if (gLoader.onStart != null) {--%>
<%--            gLoader.onStart(element, fg);--%>
<%--        }--%>

<%--        xhr = new any.xmlHttp();--%>

<%--        xhr.path = this.path;--%>

<%--        if (element.pagingType != 0) {--%>
<%--            if (keepPagingNo != true) gPagingParams.no = 1;--%>

<%--            var pagingSort = new Array();--%>

<%--            for (var i = 0; i < gGridSorting.length; i++) {--%>
<%--                pagingSort.push(gGridSorting[i].name + ":" + gGridSorting[i].type);--%>
<%--            }--%>

<%--            xhr.addParam("_PAGING_TYPE_", element.pagingType);--%>
<%--            xhr.addParam("_PAGING_SIZE_", gPagingParams.size);--%>
<%--            xhr.addParam("_PAGING_NO_", gPagingParams.no);--%>
<%--            xhr.addParam("_PAGING_SORT_", pagingSort.join(","));--%>
<%--        }--%>

<%--        for (var i = 0; i < params.length; i++) {--%>
<%--            xhr.addParam(params[i].name, params[i].value);--%>
<%--        }--%>

<%--        xhr.send();--%>

<%--        xhr.req.onreadystatechange = function()--%>
<%--        {--%>
<%--            if (xhr == null) return;--%>
<%--            if (xhr.req == null) return;--%>
<%--            if (xhr.req.readyState != 4) return;--%>

<%--            if (xhr.error() == true) {--%>
<%--                for (var item in xhr.error) {--%>
<%--                    if (typeof(xhr.error[item]) != "function") gLoader.error[item] = xhr.error[item];--%>
<%--                }--%>
<%--                if (gLoader.onFail != null) {--%>
<%--                    gLoader.onFail(element, fg);--%>
<%--                }--%>
<%--                setGrid();--%>
<%--                return;--%>
<%--            }--%>

<%--            var resText = xhr.req.responseText;--%>

<%--            xhr.req = null;--%>
<%--            xhr = null;--%>

<%--            if (resText == "") {--%>
<%--                setGrid();--%>
<%--                return;--%>
<%--            }--%>

<%--            try {--%>

<%--                var resData = eval("(" + resText + ")");--%>

<%--                try {--%>
<%--                    gLoader.result = resData.info;--%>
<%--                } catch(ex) {--%>
<%--                }--%>

<%--                fg.ReDraw = 0;--%>

<%--                if (gAutoColumn == true) {--%>
<%--                    gExtendColKey = null;--%>
<%--                    setAutoColumn(resData.data.header);--%>
<%--                    gAutoColumn = true;--%>
<%--                }--%>

<%--                fg.Rows = fg.FixedRows + resData.data.data.length;--%>

<%--                for (var r = 0; r < resData.data.data.length; r++) {--%>
<%--                    fg.RowData(r + fg.FixedRows) = { data:resData.data.data[r].data };--%>
<%--                }--%>

<%--                if (gOutlineInfo != null && gOutlineInfo.rootName != null) {--%>
<%--                    fg.Rows++;--%>
<%--                    fg.RowPosition(fg.Rows - 1) = fg.FixedRows;--%>
<%--                    fg.RowData(fg.FixedRows) = { data:createRowData([{ id:gOutlineInfo.outlineColKey, value:gOutlineInfo.rootName }, { id:gOutlineInfo.levelColKey, value:0 }]) };--%>
<%--                    fg.Row = fg.FixedRows;--%>
<%--                }--%>

<%--                vbBindGrid();--%>

<%--                if (gOutlineInfo != null) {--%>
<%--                    fg.MergeCells = flexMergeOutline;--%>
<%--                    fg.OutlineBar = flexOutlineBarSimpleLeaf;--%>
<%--                    fg.OutlineCol = fg.ColIndex(gOutlineInfo.outlineColKey);--%>
<%--                    for (var r = fg.FixedRows; r < fg.Rows; r++) {--%>
<%--                        fg.RowOutlineLevel(r) = getValue(r, gOutlineInfo.levelColKey);--%>
<%--                        fg.IsSubtotal(r) = true;--%>
<%--                        fg.IsCollapsed(r) = flexOutlineCollapsed;--%>
<%--                    }--%>
<%--                    fg.Outline(gOutlineInfo.extendLevel);--%>
<%--                }--%>

<%--                if (gAutoColumn == true) {--%>
<%--                    for (var c = 0; c < fg.Cols; c++) {--%>
<%--                        setAutoColSize(c);--%>
<%--                    }--%>
<%--                }--%>

<%--                if (element.pagingType == 0) {--%>
<%--                    doSort();--%>
<%--                }--%>

<%--                setGrid();--%>

<%--                if (gLoader.onSuccess != null) {--%>
<%--                    gLoader.onSuccess(element, fg);--%>
<%--                }--%>

<%--            } catch(ex) {--%>
<%--                setGrid();--%>
<%--                throw(ex);--%>
<%--            } finally {--%>
<%--                fg.ReDraw = 2;--%>
<%--            }--%>
<%--        }--%>
<%--    }--%>

<%--    this.reload = function()--%>
<%--    {--%>
<%--        if (this.loading == true) return;--%>

<%--        reloadObj = new Object();--%>
<%--        reloadObj.row = fg.Row;--%>
<%--        reloadObj.topRow = fg.TopRow;--%>
<%--        reloadObj.col = fg.Col;--%>
<%--        reloadObj.leftCol = fg.LeftCol;--%>

<%--        this.execute(true);--%>
<%--    }--%>

<%--    this.download = function()--%>
<%--    {--%>
<%--        if (this.loading == true) return;--%>

<%--        var win = new any.window();--%>
<%--        win.path = top.getRoot() + "/anyfive/framework/grid/excel/ExcelDownload.jsp";--%>
<%--        win.arg.gr = element;--%>
<%--        win.arg.pagingType = element.pagingType;--%>
<%--        win.arg.pagingParams = gPagingParams;--%>
<%--        win.arg.gridSorting = gGridSorting;--%>
<%--        win.arg.params = params;--%>
<%--        win.arg.rowNumDir = element.rowNumDir;--%>
<%--        win.opt.width = 300;--%>
<%--        win.opt.height = 115;--%>
<%--        win.opt.edge = "raised";--%>
<%--        win.show(false);--%>
<%--    }--%>

<%--    this.cancel = function()--%>
<%--    {--%>
<%--        try {--%>
<%--            xhr.req.abort();--%>
<%--        } catch(ex) {--%>
<%--        }--%>

<%--        setGrid();--%>
<%--    }--%>

<%--    function setGrid()--%>
<%--    {--%>
<%--        gLoader.loading = false;--%>

<%--        if (gLoader.result == null) {--%>
<%--            gLoader.result = new Object();--%>
<%--        }--%>

<%--        setMessage(parseInt(gLoader.result.totalCount, 10));--%>

<%--        if (fg.Rows > fg.FixedRows) {--%>
<%--            for (var c = 0; c < fg.Cols; c++) {--%>
<%--                putAction(fg.ColKey(c));--%>
<%--                putCheck(fg.ColKey(c));--%>
<%--                putImage(fg.ColKey(c));--%>
<%--            }--%>
<%--        }--%>

<%--        setCheckHeader(fg.ColIndex("ROW_CHK"));--%>
<%--        setPagingHeader();--%>

<%--        if (reloadObj != null) {--%>
<%--            fg.Row = Math.min(reloadObj.row, fg.Rows - 1);--%>
<%--            fg.TopRow = reloadObj.topRow;--%>
<%--            fg.Col = Math.min(reloadObj.col, fg.Cols - 1);--%>
<%--            fg.LeftCol = reloadObj.leftCol;--%>
<%--            reloadObj = null;--%>
<%--        } else {--%>
<%--            fg.Row = Math.min(0, fg.Rows - 1);--%>
<%--            fg.TopRow = 0;--%>
<%--        }--%>

<%--        gLoader.executed = true;--%>
<%--    }--%>
<%--}--%>

<%--function createRowData(datas)--%>
<%--{--%>
<%--    var rowData  = {};--%>

<%--    for (var i = 0; i < datas.length; i++) {--%>
<%--        rowData[datas[i].id] = datas[i].value;--%>
<%--    }--%>

<%--    return rowData;--%>
<%--}--%>

<%--function resetPagingSize(pagingSize)--%>
<%--{--%>
<%--    gPagingParams.size = pagingSize;--%>
<%--    gPagingParams.no = 1;--%>

<%--    if (gLoader != null) gLoader.execute(true);--%>
<%--}--%>

<%--function resetPagingNo(mode)--%>
<%--{--%>
<%--    switch(mode) {--%>
<%--    case "first":--%>
<%--        txt_pagingNo.value = 1;--%>
<%--        break;--%>
<%--    case "prev":--%>
<%--        txt_pagingNo.value--;--%>
<%--        break;--%>
<%--    case "next":--%>
<%--        txt_pagingNo.value++;--%>
<%--        break;--%>
<%--    case "last":--%>
<%--        txt_pagingNo.value = txt_pagingNo.totPageCnt;--%>
<%--        break;--%>
<%--    }--%>

<%--    var err;--%>

<%--    if (isNaN(txt_pagingNo.value)) {--%>
<%--        err = "Page Number is not a number!";--%>
<%--    }--%>

<%--    if (txt_pagingNo.value < 1 || txt_pagingNo.value > txt_pagingNo.totPageCnt) {--%>
<%--        err = "Page number is out of range!";--%>
<%--    }--%>

<%--    if (err == null) {--%>
<%--        gPagingParams.no = txt_pagingNo.value;--%>
<%--        if (gLoader != null) gLoader.execute(true);--%>
<%--    } else {--%>
<%--        alert(err);--%>
<%--        txt_pagingNo.value = gPagingParams.no;--%>
<%--        txt_pagingNo.focus();--%>
<%--        txt_pagingNo.select();--%>
<%--    }--%>
<%--}--%>

<%--function setAutoColumn(oCols)--%>
<%--{--%>
<%--    var colId;--%>
<%--    var colId2;--%>
<%--    var colAlign;--%>
<%--    var colType;--%>
<%--    var colFormat;--%>

<%--    fg.Cols = 0;--%>
<%--    fg.FixedRows = 0;--%>
<%--    fg.ColWidthMax = 500 * 15;--%>

<%--    function getFormat(scale)--%>
<%--    {--%>
<%--        var format = "#,##0";--%>

<%--        if (scale == null || scale == "0" || scale == "255") return format;--%>

<%--        format += ".";--%>

<%--        for (var i = 0; i < scale; i++) {--%>
<%--            format += "#";--%>
<%--        }--%>

<%--        return format;--%>
<%--    }--%>

<%--    var dataTypeEnum = {--%>
<%--          adEmpty : 0--%>
<%--        , adTinyInt : 16--%>
<%--        , adSmallInt : 2--%>
<%--        , adInteger : 3--%>
<%--        , adBigInt : 20--%>
<%--        , adUnsignedTinyInt : 17--%>
<%--        , adUnsignedSmallInt : 18--%>
<%--        , adUnsignedInt : 19--%>
<%--        , adUnsignedBigInt : 21--%>
<%--        , adSingle : 4--%>
<%--        , adDouble : 5--%>
<%--        , adCurrency : 6--%>
<%--        , adDecimal : 14--%>
<%--        , adNumeric : 131--%>
<%--        , adBoolean : 11--%>
<%--        , adError : 10--%>
<%--        , adUserDefined : 132--%>
<%--        , adVariant : 12--%>
<%--        , adIDispatch : 9--%>
<%--        , adIUnknown : 13--%>
<%--        , adGUID : 72--%>
<%--        , adDate : 7--%>
<%--        , adDBDate : 133--%>
<%--        , adDBTime : 134--%>
<%--        , adDBTimeStamp : 135--%>
<%--        , adBSTR : 8--%>
<%--        , adChar : 129--%>
<%--        , adVarChar : 200--%>
<%--        , adLongVarChar : 201--%>
<%--        , adWChar : 130--%>
<%--        , adVarWChar : 202--%>
<%--        , adLongVarWChar : 203--%>
<%--        , adBinary : 128--%>
<%--        , adVarBinary : 204--%>
<%--        , adLongVarBinary : 205--%>
<%--        , adChapter : 136--%>
<%--        , adFileTime : 64--%>
<%--        , adPropVariant : 138--%>
<%--        , adVarNumeric : 139--%>
<%--    };--%>

<%--    for (var c = 0; c < oCols.length; c++) {--%>
<%--        colId = oCols[c].id;--%>
<%--        colId2 = oCols[c].id;--%>

<%--        if (colId == null) colId = colId2;--%>

<%--        if (colId == "ROW_NUM") continue;--%>

<%--        switch (Number(oCols[c].type)) {--%>
<%--        case dataTypeEnum.adTinyInt:--%>
<%--        case dataTypeEnum.adSmallInt:--%>
<%--        case dataTypeEnum.adInteger:--%>
<%--        case dataTypeEnum.adBigInt:--%>
<%--        case dataTypeEnum.adUnsignedTinyInt:--%>
<%--        case dataTypeEnum.adUnsignedSmallInt:--%>
<%--        case dataTypeEnum.adUnsignedInt:--%>
<%--        case dataTypeEnum.adUnsignedBigInt:--%>
<%--        case dataTypeEnum.adSingle:--%>
<%--        case dataTypeEnum.adDouble:--%>
<%--        case dataTypeEnum.adCurrency:--%>
<%--        case dataTypeEnum.adDecimal:--%>
<%--        case dataTypeEnum.adNumeric:--%>
<%--        case dataTypeEnum.adNumeric:--%>
<%--        case dataTypeEnum.adVarNumeric:--%>
<%--            colAlign = "right";--%>
<%--            colType = "number";--%>
<%--            colFormat = getFormat(oCols[c].numericScale);--%>
<%--            break;--%>
<%--        default:--%>
<%--            colAlign = "left";--%>
<%--            colType = "string";--%>
<%--            colFormat = null;--%>
<%--            break;--%>
<%--        }--%>

<%--        addColumn({ id:colId, id2:colId2, align:colAlign, type:colType, sort:true, format:colFormat });--%>
<%--    }--%>
<%--}--%>

<%--function setMessage(iTotCnt)--%>
<%--{--%>
<%--    var html;--%>
<%--    var totPageCnt;--%>

<%--    if (iTotCnt == null) {--%>
<%--        gLoadingFrame.show();--%>
<%--        if (gMessageSpan != null) gMessageSpan.innerHTML = "Loading...";--%>
<%--        fg.Rows = fg.FixedRows;--%>
<%--    } else {--%>
<%--        gLoadingFrame.hide();--%>
<%--        totPageCnt = parseInt((iTotCnt - 1) / gPagingParams.size + 1, 10);--%>
<%--        if (totPageCnt == 0) totPageCnt = 1;--%>
<%--        if (gMessageSpan != null) {--%>
<%--            if (iTotCnt >= 0) {--%>
<%--                if (element.pagingType == 0) {--%>
<%--                    gMessageSpan.innerHTML = "Total : " + cfGetFormatNumber(fg.Rows - fg.FixedRows);--%>
<%--                } else {--%>
<%--                    gMessageSpan.innerHTML = "Total : " + cfGetFormatNumber(iTotCnt) + " (" + cfGetFormatNumber(gPagingParams.no) + " Page of " + cfGetFormatNumber(totPageCnt) + " Pages)";--%>
<%--                }--%>
<%--            } else {--%>
<%--                gMessageSpan.innerHTML = "(Error)";--%>
<%--            }--%>
<%--        }--%>
<%--    }--%>

<%--    if (element.pagingType == 0) return;--%>

<%--    var pagingNo = parseInt(gPagingParams.no, 10);--%>
<%--    var pagingEnable = (!isNaN(iTotCnt) && !isNaN(totPageCnt) && !isNaN(pagingNo));--%>

<%--    btn_resetPagingNoFirst.disabled = !(pagingEnable && pagingNo != 1);--%>
<%--    btn_resetPagingNoPrev.disabled = !(pagingEnable && pagingNo != 1);--%>
<%--    btn_resetPagingNoText.disabled = !pagingEnable;--%>
<%--    btn_resetPagingNoNext.disabled = !(pagingEnable && pagingNo != totPageCnt);--%>
<%--    btn_resetPagingNoLast.disabled = !(pagingEnable && pagingNo != totPageCnt);--%>

<%--    spn_pagingNo.disabled = !pagingEnable;--%>
<%--    sel_pagingSize.disabled = !pagingEnable;--%>
<%--    txt_pagingNo.disabled = !pagingEnable;--%>
<%--    txt_totPageCnt.disabled = !pagingEnable;--%>

<%--    sel_pagingSize.value = "";--%>
<%--    txt_pagingNo.value = "";--%>
<%--    txt_pagingNo.totPageCnt = "";--%>
<%--    txt_pagingNo.maxLength = "";--%>
<%--    txt_totPageCnt.value = "";--%>

<%--    if (pagingEnable != true) return;--%>

<%--    sel_pagingSize.value = gPagingParams.size;--%>
<%--    txt_pagingNo.value = gPagingParams.no;--%>
<%--    txt_pagingNo.totPageCnt = totPageCnt;--%>
<%--    txt_pagingNo.maxLength = String(totPageCnt).length;--%>
<%--    txt_totPageCnt.value = totPageCnt;--%>
<%--}--%>

<%--function setCheckHeader(col)--%>
<%--{--%>
<%--    if (col == -1) return;--%>

<%--    var icon = 1;--%>

<%--    if (fg.ColData(col).info.type == "check") {--%>
<%--        if (fg.Rows == fg.FixedRows || fg.FindRow(0, fg.FixedRows, col, true, true) > -1) {--%>
<%--            icon = 0;--%>
<%--        } else {--%>
<%--            for (var r = fg.FixedRows; r < fg.Rows; r++) {--%>
<%--                if (fg.TextMatrix(r, col) != "") continue;--%>
<%--                icon = 0;--%>
<%--                break;--%>
<%--            }--%>
<%--        }--%>
<%--    } else {--%>
<%--        if (fg.Rows == fg.FixedRows || fg.ColData(col).info.checkBoxExists != true) {--%>
<%--            icon = 0;--%>
<%--        } else {--%>
<%--            fg.ColData(col).info.checkBoxExists = false;--%>
<%--            for (var r = fg.FixedRows; r < fg.Rows; r++) {--%>
<%--                if (fg.Cell(flexcpChecked, r, col) != flexNoCheckbox) fg.ColData(col).info.checkBoxExists = true;--%>
<%--                if (fg.Cell(flexcpChecked, r, col) != flexUnchecked) continue;--%>
<%--                icon = 0;--%>
<%--                break;--%>
<%--            }--%>
<%--            if (fg.ColData(col).info.checkBoxExists != true) {--%>
<%--                icon = 0;--%>
<%--            }--%>
<%--        }--%>
<%--    }--%>

<%--    for (var r = 0; r < fg.FixedRows; r++) {--%>
<%--        if (fg.TextMatrix(r, col) != fg.TextMatrix(fg.FixedRows - 1, col)) continue;--%>
<%--        fg.TextMatrix(r, col) = gCheckColumnIcon[icon];--%>
<%--    }--%>
<%--}--%>

<%--function setPagingHeader()--%>
<%--{--%>
<%--    for (var c = 0; c < fg.Cols; c++) {--%>
<%--        if (fg.ColData(c) == null || fg.ColData(c).info == null || fg.ColData(c).info.id == "ROW_CHK") continue;--%>
<%--        for (var r = 0; r < fg.FixedRows; r++) {--%>
<%--            if (fg.TextMatrix(r, c) != fg.TextMatrix(fg.FixedRows - 1, c)) continue;--%>
<%--            if (gGridSorting.length > 0 && fg.ColKey(c) == gGridSorting[0].name && fg.ColData(c).info.sort == true) {--%>
<%--                fg.TextMatrix(r, c) = gSortTypeMarker[gGridSorting[0].type.toUpperCase()] + " " + fg.ColData(c).info.name;--%>
<%--            } else {--%>
<%--                fg.TextMatrix(r, c) = fg.ColData(c).info.name;--%>
<%--            }--%>
<%--        }--%>
<%--        setAutoColSize(c);--%>
<%--    }--%>
<%--}--%>

<%--function getValue(iRowIdx, sColKey)--%>
<%--{--%>
<%--    if (iRowIdx < fg.FixedRows) return null;--%>
<%--    if (iRowIdx > fg.Rows - 1) return null;--%>

<%--    if (sColKey.toUpperCase() == "ROW_NUM" && element.pagingType == 0) {--%>
<%--        return getRowNum(iRowIdx);--%>
<%--    }--%>

<%--    var sValue;--%>

<%--    if (fg.RowData(iRowIdx) == null || fg.RowData(iRowIdx).data == null) {--%>
<%--        sValue = fg.TextMatrix(iRowIdx, fg.ColIndex(sColKey));--%>
<%--        if (fg.ColData(fg.ColIndex(sColKey)).info.type == "date") {--%>
<%--            sValue = cfGetUnformatDate(sValue);--%>
<%--        }--%>
<%--    } else {--%>
<%--        sValue = fg.RowData(iRowIdx).data[sColKey];--%>
<%--    }--%>

<%--    if (sValue == null && element.useNull != true) return "";--%>

<%--    return sValue;--%>
<%--}--%>

<%--function setValue(iRowIdx, sColKey, sValue)--%>
<%--{--%>
<%--    if (iRowIdx < fg.FixedRows) return;--%>
<%--    if (iRowIdx > fg.Rows - 1) return;--%>

<%--    if (sColKey.toUpperCase() == "ROW_NUM") {--%>
<%--        fg.TextMatrix(iRowIdx, iColIdx) = getRowNum(iRowIdx);--%>
<%--        return;--%>
<%--    }--%>

<%--    if (fg.RowData(iRowIdx) == null) {--%>
<%--        fg.RowData(iRowIdx) = {};--%>
<%--    }--%>

<%--    if (fg.RowData(iRowIdx).data == null) {--%>
<%--        fg.RowData(iRowIdx).data = {};--%>
<%--    }--%>

<%--    fg.RowData(iRowIdx).data[sColKey] = sValue;--%>

<%--    var iColIdx = fg.ColIndex(sColKey);--%>

<%--    if (iColIdx != -1) {--%>
<%--        fg.TextMatrix(iRowIdx, iColIdx) = fg.ColData(iColIdx).info.text(element, fg, iRowIdx, sColKey, (sValue == null ? "" : sValue));--%>
<%--    }--%>
<%--}--%>

<%--function getChecked(iRowIdx, sColKey)--%>
<%--{--%>
<%--    if (iRowIdx < 0) return null;--%>
<%--    if (iRowIdx >= fg.Rows) return null;--%>

<%--    var iColIdx = fg.ColIndex(sColKey);--%>

<%--    if (iColIdx == -1) return null;--%>

<%--    if (fg.ColData(iColIdx).info.type == "check") {--%>
<%--        return (fg.TextMatrix(iRowIdx, iColIdx) == 1);--%>
<%--    } else {--%>
<%--        var cpChecked = fg.Cell(flexcpChecked, iRowIdx, iColIdx);--%>
<%--        if (cpChecked != 0) return (cpChecked == 1);--%>
<%--    }--%>

<%--    return null;--%>
<%--}--%>

<%--function setChecked(iRowIdx, sColKey, bValue)--%>
<%--{--%>
<%--    if (element.beforeCheck != null) {--%>
<%--        if (eval(element.beforeCheck)(iRowIdx, sColKey) != true) return;--%>
<%--    }--%>

<%--    if (iRowIdx < 0) return;--%>
<%--    if (iRowIdx >= fg.Rows) return;--%>

<%--    var iColIdx = fg.ColIndex(sColKey);--%>

<%--    if (iColIdx == -1) return;--%>

<%--    if (fg.ColData(iColIdx).info.type == "check") {--%>
<%--        fg.TextMatrix(iRowIdx, iColIdx) = (bValue == true ? 1 : 0);--%>
<%--        if (fg.RowData(iRowIdx) != null && fg.RowData(iRowIdx).data != null) {--%>
<%--            fg.RowData(iRowIdx).data[sColKey] = (bValue == true ? 1 : 0);--%>
<%--        }--%>
<%--    } else {--%>
<%--        var cpChecked = fg.Cell(flexcpChecked, iRowIdx, iColIdx);--%>
<%--        if (cpChecked != 0) fg.Cell(flexcpChecked, iRowIdx, iColIdx) = (bValue == true ? 1 : 2);--%>
<%--    }--%>
<%--}--%>

<%--function getEditable()--%>
<%--{--%>
<%--    return gEditable;--%>
<%--}--%>

<%--function setEditable(iEditable)--%>
<%--{--%>
<%--    gEditable = iEditable;--%>
<%--}--%>

<%--function setMinHeight(val)--%>
<%--{--%>
<%--    if (element.style.height == "100%") {--%>
<%--        gMinHeight = parseInt(val, 10);--%>
<%--    }--%>

<%--    element.attachEvent("onresize", function()--%>
<%--    {--%>
<%--        setMinHeightResize();--%>
<%--    });--%>

<%--    window.attachEvent("onresize", function()--%>
<%--    {--%>
<%--        if (gMinHeight == null) return;--%>

<%--        element.style.height = "100%";--%>

<%--        setMinHeightResize();--%>
<%--    });--%>
<%--}--%>

<%--function setMinHeightResize()--%>
<%--{--%>
<%--    if (gMinHeight == null) return;--%>

<%--    if (element.offsetHeight < gMinHeight) {--%>
<%--        element.style.height = gMinHeight;--%>
<%--    }--%>
<%--}--%>

<%--function getText(iRowIdx, sColKey)--%>
<%--{--%>
<%--    if (iRowIdx < 0) return null;--%>
<%--    if (iRowIdx >= fg.Rows) return null;--%>

<%--    var iColIdx = fg.ColIndex(sColKey);--%>

<%--    if (iColIdx == -1) return null;--%>

<%--    return fg.Cell(flexcpTextDisplay, iRowIdx, iColIdx);--%>
<%--}--%>

<%--function getRowData(iRowIdx)--%>
<%--{--%>
<%--    if (fg.RowData(iRowIdx) == null) return {};--%>
<%--    if (fg.RowData(iRowIdx).data == null) return {};--%>

<%--    return fg.RowData(iRowIdx).data;--%>
<%--}--%>

<%--function setCell()--%>
<%--{--%>
<%--    switch (arguments.length) {--%>
<%--    case 3:--%>
<%--        do1(arguments[0], arguments[1], arguments[2]);--%>
<%--        break;--%>
<%--    case 4:--%>
<%--        do2(arguments[0], arguments[1], arguments[2], arguments[3]);--%>
<%--        break;--%>
<%--    }--%>

<%--    function do1(iProp, iRowIdx, sValue)--%>
<%--    {--%>
<%--        fg.Cell(iProp, iRowIdx, 0, iRowIdx, fg.Cols - 1) = sValue;--%>
<%--    }--%>

<%--    function do2(iProp, iRowIdx, sColId, sValue)--%>
<%--    {--%>
<%--        fg.Cell(iProp, iRowIdx, fg.ColIndex(sColId)) = sValue;--%>
<%--    }--%>
<%--}--%>

<%--function moveRowPos(dir, colId)--%>
<%--{--%>
<%--    if (fg.Row + dir < fg.FixedRows) {--%>
<%--        fg.Row = Math.min(fg.FixedRows, fg.Rows - 1);--%>
<%--    } else if (fg.Row + dir > fg.Rows - 1) {--%>
<%--        fg.Row = fg.Rows - 1;--%>
<%--    } else {--%>
<%--        fg.Row = fg.Row + dir;--%>
<%--    }--%>

<%--    if (colId != null) {--%>
<%--        fg.Select(fg.Row, fg.ColIndex(colId));--%>
<%--    }--%>

<%--    fg.ShowCell(fg.Row, fg.Col);--%>
<%--}--%>

<%--function moveRowData(dir)--%>
<%--{--%>
<%--    if (fg.SelectedRow(0) < fg.FixedRows) return;--%>
<%--    if (dir == -1 && fg.SelectedRow(0) == fg.FixedRows) return;--%>
<%--    if (dir == 1 && fg.SelectedRow(fg.SelectedRows - 1) == fg.Rows - 1) return;--%>

<%--    try {--%>

<%--        fg.ReDraw = 0;--%>

<%--        if (dir == -1) {--%>
<%--            for (var r = 0; r < fg.SelectedRows; r++) {--%>
<%--                fg.RowPosition(fg.SelectedRow(r)) = fg.SelectedRow(r) + dir;--%>
<%--            }--%>
<%--        } else {--%>
<%--            for (var r = fg.SelectedRows - 1; r >= 0; r--) {--%>
<%--                fg.RowPosition(fg.SelectedRow(r)) = fg.SelectedRow(r) + dir;--%>
<%--            }--%>
<%--        }--%>

<%--    } catch(ex) {--%>
<%--    } finally {--%>
<%--        fg.ReDraw = 2;--%>
<%--    }--%>
<%--}--%>

<%--function clearAll()--%>
<%--{--%>
<%--    fg.Rows = fg.FixedRows;--%>

<%--    if (gMessageSpan != null) {--%>
<%--        gMessageSpan.innerHTML = "(Ready)";--%>
<%--    }--%>

<%--    btn_resetPagingNoFirst.disabled = true;--%>
<%--    btn_resetPagingNoPrev.disabled = true;--%>
<%--    btn_resetPagingNoText.disabled = true;--%>
<%--    btn_resetPagingNoNext.disabled = true;--%>
<%--    btn_resetPagingNoLast.disabled = true;--%>

<%--    spn_pagingNo.disabled = true;--%>
<%--    sel_pagingSize.disabled = true;--%>
<%--    txt_pagingNo.disabled = true;--%>
<%--    txt_totPageCnt.disabled = true;--%>

<%--    txt_pagingNo.value = "1";--%>
<%--    txt_pagingNo.totPageCnt = "";--%>
<%--    txt_pagingNo.maxLength = "";--%>
<%--    txt_totPageCnt.value = "1";--%>
<%--}--%>

<%--function initPopup()--%>
<%--{--%>
<%--    tr_separator_1.style.display = (gConfigUse == true ? "block" : "none");--%>
<%--    tr_command_L.style.display = tr_separator_1.style.display;--%>
<%--    tr_command_T.style.display = tr_separator_1.style.display;--%>

<%--    gPopup = window.createPopup();--%>
<%--    gPopup.document.createStyleSheet(top.getRoot() + "/anyfive/framework/css/style.css");--%>
<%--    gPopup.document.body.onselectstart = function() { return false; }--%>
<%--    gPopup.document.body.ondragstart   = function() { return false; }--%>
<%--    gPopup.document.body.oncontextmenu = function() { return false; }--%>
<%--    gPopup.document.body.innerHTML = div_popupMenu.innerHTML;--%>

<%--    var tds = gPopup.document.getElementById("tbl_popupMenu").getElementsByTagName("TD");--%>

<%--    for (var i = 0; i < tds.length; i++) {--%>
<%--        if (tds[i].command == null) {--%>
<%--            tds[i].height = "8px";--%>
<%--            continue;--%>
<%--        }--%>

<%--        tds[i].noWrap = true;--%>
<%--        tds[i].style.cursor = "default";--%>
<%--        tds[i].style.padding = "1px 4px 2px 4px";--%>

<%--        tds[i].onmouseover = function()--%>
<%--        {--%>
<%--            hilightTd(this, true);--%>
<%--        }--%>

<%--        tds[i].onmouseout = function()--%>
<%--        {--%>
<%--            hilightTd(this, false);--%>
<%--        }--%>

<%--        tds[i].onclick = function()--%>
<%--        {--%>
<%--            hilightTd(this, false);--%>

<%--            execPopupCommand(this.command);--%>
<%--        }--%>
<%--    }--%>

<%--    function hilightTd(td, bool)--%>
<%--    {--%>
<%--        if (td.command == null) return;--%>
<%--        if (td.parentElement.style.display == "none") return;--%>
<%--        if (td.parentElement.disabled == true) return;--%>

<%--        td.style.backgroundColor = (bool == true ? "#316AC5" : "");--%>
<%--        td.style.color = (bool == true ? "white" : "");--%>
<%--    }--%>
<%--}--%>

<%--function showPopup(iX, iY)--%>
<%--{--%>
<%--    if (gLoader != null && gLoader.loading == true) return;--%>

<%--    element.focus();--%>
<%--    fg.focus();--%>

<%--    var tbl = gPopup.document.getElementsByTagName("TABLE")[0];--%>
<%--    var tds = gPopup.document.getElementById("tbl_popupMenu").getElementsByTagName("TD");--%>

<%--    for (var i = 0; i < tds.length; i++) {--%>
<%--        tds[i].style.backgroundColor = "";--%>
<%--        tds[i].style.color = "";--%>
<%--    }--%>

<%--    var row;--%>
<%--    var col;--%>

<%--    if (gMouseDown == null) {--%>
<%--        row = fg.MouseRow;--%>
<%--        col = fg.MouseCol;--%>
<%--    } else {--%>
<%--        row = gMouseDown.mouseRow;--%>
<%--        col = gMouseDown.mouseCol;--%>
<%--    }--%>

<%--    gPopup.document.mouseRow = row;--%>
<%--    gPopup.document.mouseCol = col;--%>

<%--    if (row == -1 || col == -1) {--%>
<%--        gPopup.document.getElementById("spn_copyCellText").innerText = "";--%>
<%--    } else {--%>
<%--        gPopup.document.getElementById("spn_copyCellText").innerText = replaceCrLf(fg.Cell(0, gPopup.document.mouseRow, gPopup.document.mouseCol));--%>
<%--    }--%>

<%--    if (row == -1) {--%>
<%--        gPopup.document.getElementById("spn_copyRowText").innerText = "";--%>
<%--    } else {--%>
<%--        gPopup.document.getElementById("spn_copyRowText").innerText = replaceCrLf(fg.Cell(0, gPopup.document.mouseRow, 0, gPopup.document.mouseRow, fg.Cols - 1));--%>
<%--    }--%>

<%--    if (col == -1) {--%>
<%--        gPopup.document.getElementById("spn_copyColText").innerText = "";--%>
<%--    } else {--%>
<%--        gPopup.document.getElementById("spn_copyColText").innerText = function()--%>
<%--        {--%>
<%--            if (fg.ColData(col) == null || fg.ColData(col).info == null) {--%>
<%--                if (fg.FixedRows > 0) return replaceCrLf(fg.TextMatrix(fg.FixedRows - 1, col)) + "...";--%>
<%--            } else {--%>
<%--                return replaceCrLf(fg.ColData(col).info.name) + "...";--%>
<%--            }--%>
<%--            return "";--%>
<%--        }();--%>
<%--    }--%>

<%--    gPopup.document.getElementById("tr_command_R").disabled = (gLoader == null);--%>
<%--    gPopup.document.getElementById("tr_command_X").disabled = (gLoader == null);--%>

<%--    gPopup.document.getElementById("tr_command_T").disabled = function()--%>
<%--    {--%>
<%--        for (var c = 0; c < fg.Cols; c++) {--%>
<%--            if (fg.ColData(c) == null) return false;--%>
<%--            if (fg.ColData(c).info == null) return false;--%>
<%--            if (fg.ColData(c).info.sort == true) return false;--%>
<%--        }--%>
<%--        return true;--%>
<%--    }();--%>

<%--    gPopup.show(0, 0, 0, 0, document.body);--%>
<%--    gPopup.show(iX / 15, iY / 15, tbl.offsetWidth, tbl.offsetHeight, document.body);--%>

<%--    function replaceCrLf(val)--%>
<%--    {--%>
<%--        return val.replaceAll("\r\n", " ").replaceAll("\r", " ").replaceAll("\n", " ");--%>
<%--    }--%>
<%--}--%>

<%--function execPopupCommand(cmd)--%>
<%--{--%>
<%--    if (gPopup == null) return;--%>
<%--    if (gPopup.isOpen != true) return;--%>

<%--    var td = gPopup.document.getElementById("tr_command_" + cmd);--%>

<%--    if (td != null && td.style.display == "none") return;--%>
<%--    if (td != null && td.disabled == true) return;--%>

<%--    var clipText;--%>

<%--    gPopup.hide();--%>

<%--    switch (cmd) {--%>
<%--    case "C":--%>
<%--        if (gPopup.document.mouseRow == -1 || gPopup.document.mouseCol == -1) {--%>
<%--            clipText = "";--%>
<%--        } else {--%>
<%--            clipText = fg.Cell(0, gPopup.document.mouseRow, gPopup.document.mouseCol);--%>
<%--        }--%>
<%--        break;--%>
<%--    case "W":--%>
<%--        if (gPopup.document.mouseRow == -1) {--%>
<%--            clipText = "";--%>
<%--        } else {--%>
<%--            clipText = fg.Cell(0, gPopup.document.mouseRow, 0, gPopup.document.mouseRow, fg.Cols - 1);--%>
<%--        }--%>
<%--        break;--%>
<%--    case "O":--%>
<%--        if (gPopup.document.mouseCol == -1) {--%>
<%--            clipText = "";--%>
<%--        } else {--%>
<%--            clipText = fg.Cell(0, 0, gPopup.document.mouseCol, fg.Rows - 1, gPopup.document.mouseCol);--%>
<%--        }--%>
<%--        break;--%>
<%--    case "S":--%>
<%--        clipText = fg.Clip;--%>
<%--        break;--%>
<%--    case "A":--%>
<%--        if (fg.Rows == 0 || fg.Cols == 0) {--%>
<%--            clipText = "";--%>
<%--        } else {--%>
<%--            clipText = fg.Cell(0, 0, 0, fg.Rows - 1, fg.Cols - 1);--%>
<%--        }--%>
<%--        break;--%>
<%--    case "R":--%>
<%--        if (gLoader != null) gLoader.reload();--%>
<%--        break;--%>
<%--    case "F":--%>
<%--        var win = new any.window(1);--%>
<%--        win.path = top.getRoot() + "/anyfive/framework/grid/util/GridFinder.jsp";--%>
<%--        win.arg.gr = element;--%>
<%--        win.opt.width = 380;--%>
<%--        win.opt.height = 125;--%>
<%--        win.opt.left = 100;--%>
<%--        win.opt.top = 80;--%>
<%--        win.opt.edge = "raised";--%>
<%--        win.show(false);--%>
<%--        break;--%>
<%--    case "X":--%>
<%--        gLoader.download();--%>
<%--        break;--%>
<%--    case "P":--%>
<%--        fg.PrintGrid(true, 2, 500, 500);--%>
<%--        break;--%>
<%--    case "L":--%>
<%--        var win = new any.window();--%>
<%--        win.path = top.getRoot() + "/anyfive/framework/grid/config/GridColumn.jsp";--%>
<%--        win.arg.gr = element;--%>
<%--        win.arg.gridId = gGridId;--%>
<%--        win.arg.gridPath = gGridPath;--%>
<%--        win.arg.fixedColumns = gFixedColumns;--%>
<%--        win.opt.width = 450;--%>
<%--        win.opt.height = 450;--%>
<%--        if (win.show() == "OK") {--%>
<%--            setGridColumn();--%>
<%--        }--%>
<%--        break;--%>
<%--    case "T":--%>
<%--        var win = new any.window();--%>
<%--        win.path = top.getRoot() + "/anyfive/framework/grid/config/GridSorting.jsp";--%>
<%--        win.arg.gr = element;--%>
<%--        win.arg.gridId = gGridId;--%>
<%--        win.arg.gridPath = gGridPath;--%>
<%--        win.arg.gridSorting = gGridSorting;--%>
<%--        win.arg.gridSortingDefault = gGridSortingDefault;--%>
<%--        win.opt.width = 450;--%>
<%--        win.opt.height = 300;--%>
<%--        if (win.show() == "OK") {--%>
<%--            setGridSorting();--%>
<%--        }--%>
<%--        break;--%>
<%--    default:--%>
<%--        return;--%>
<%--    }--%>

<%--    if (clipText != null) {--%>
<%--        window.clipboardData.setData("Text", clipText);--%>
<%--    }--%>
<%--}--%>

<%--function getGridPath(addonPath)--%>
<%--{--%>
<%--    return element.document.location.pathname + "/" + element.id + (addonPath == null ? "" : "/" + addonPath);--%>
<%--}--%>

<%--function changeConfig(addonPath)--%>
<%--{--%>
<%--    if (gConfigUse != true) {--%>
<%--        setIsReady("column");--%>
<%--        setIsReady("sorting");--%>
<%--        return;--%>
<%--    }--%>

<%--    gGridPath = getGridPath(addonPath);--%>
<%--    gGridId = MD5(gGridPath);--%>

<%--    var configInfoDsId = "ds_configInfo_" + gGridId;--%>

<%--    element.configInfoDs = element.document.getElementById(configInfoDsId);--%>

<%--    if (element.configInfoDs == null) {--%>
<%--        element.configInfoDs = document.createElement('<ANY:DS id="' + configInfoDsId + '" />');--%>
<%--        element.document.body.appendChild(element.configInfoDs);--%>
<%--    }--%>

<%--    setGridColumn();--%>
<%--    setGridSorting();--%>
<%--}--%>

<%--function setGridColumn()--%>
<%--{--%>
<%--    if (gConfigUse != true) {--%>
<%--        setIsReady("column");--%>
<%--        return;--%>
<%--    }--%>

<%--    var columnListDsId = "ds_columnList_" + gGridId;--%>

<%--    element.columnListDs = element.document.getElementById(columnListDsId);--%>

<%--    if (element.columnListDs == null) {--%>
<%--        element.columnListDs = document.createElement('<ANY:DS id="' + columnListDsId + '" />');--%>
<%--        element.document.body.appendChild(element.columnListDs);--%>
<%--    }--%>

<%--    var prx = new any.proxy();--%>
<%--    prx.path = top.getRoot() + "/anyfive.framework.grid.act.RetrieveGridColumnList.do";--%>
<%--    prx.addParam("GRID_ID", gGridId);--%>

<%--    prx.onSuccess = function()--%>
<%--    {--%>
<%--        try {--%>

<%--            if (element.configInfoDs.rowCount == 0 || element.configInfoDs.value(0, "COLUMN_YN") != "1") {--%>
<%--                element.columnListDs.init();--%>
<%--                for (var i = 0; i < fg.Cols; i++) {--%>
<%--                    element.columnListDs.addRow();--%>
<%--                    element.columnListDs.value(i, "COL_ID") = fg.ColData(i).info.id;--%>
<%--                    element.columnListDs.value(i, "COL_INDEX") = fg.ColData(i).info.index + 1;--%>
<%--                    element.columnListDs.value(i, "COL_SHOW") = (fg.ColData(i).info.nouse == true || fg.ColData(i).info.hide == true ? 0 : 1);--%>
<%--                    element.columnListDs.value(i, "COL_FROZEN") = (fg.ColData(i).info.id == gFixedColumns.frozenColId ? 1 : 0);--%>
<%--                    element.columnListDs.value(i, "COL_NAME") = fg.ColData(i).info.name;--%>
<%--                    element.columnListDs.value(i, "COL_WIDTH") = fg.ColData(i).info.width;--%>
<%--                }--%>
<%--            }--%>

<%--            fg.ReDraw = 0;--%>
<%--            fg.FrozenCols = 0;--%>

<%--            for (var i = 0; i < fg.Cols; i++) {--%>
<%--                if (fg.ColData(i).info.id == "ROW_CHK" && fg.ColData(i).info.nouse != true) continue;--%>
<%--                if (element.columnListDs.valueRow(["COL_ID", fg.ColData(i).info.id]) != -1) continue;--%>
<%--                fg.ColPosition(i) = fg.Cols - 1;--%>
<%--                fg.ColHidden(i) = true;--%>
<%--            }--%>

<%--            var col1;--%>
<%--            var col2;--%>

<%--            for (var i = 0; i < element.columnListDs.rowCount; i++) {--%>
<%--                col1 = fg.ColIndex(element.columnListDs.value(i, "COL_ID"));--%>
<%--                if (col1 == -1) continue;--%>
<%--                col2 = element.columnListDs.value(i, "COL_INDEX") - 1;--%>
<%--                if (col2 >= fg.Cols) col2 = fg.Cols - 1;--%>
<%--                fg.ColPosition(col1) = col2;--%>
<%--                fg.ColHidden(col2) = (fg.ColData(col1).info.nouse == true || fg.ColData(col1).info.hide == true || element.columnListDs.value(i, "COL_SHOW") != "1");--%>
<%--                fg.ColWidth(col2) = element.columnListDs.value(i, "COL_WIDTH") * 15;--%>
<%--            }--%>

<%--            for (var item in gGridActions) {--%>
<%--                col1 = fg.ColIndex(item);--%>
<%--                if (col1 == -1) continue;--%>
<%--                fg.ColHidden(col1) = false;--%>
<%--            }--%>

<%--            setExtendColumnWidth();--%>

<%--            for (var i = 0; i < element.columnListDs.rowCount; i++) {--%>
<%--                if (element.columnListDs.value(i, "COL_FROZEN") != "1") continue;--%>
<%--                fg.FrozenCols = fg.ColIndex(element.columnListDs.value(i, "COL_ID")) + 1 - fg.FixedCols;--%>
<%--                break;--%>
<%--            }--%>

<%--        } catch(ex) {--%>
<%--            setIsReady("column");--%>
<%--            fg.ReDraw = 2;--%>
<%--            throw(ex);--%>
<%--        } finally {--%>
<%--            setIsReady("column");--%>
<%--            fg.ReDraw = 2;--%>
<%--        }--%>
<%--    }--%>

<%--    prx.onFail = function()--%>
<%--    {--%>
<%--        element.isReady = true;--%>
<%--    }--%>

<%--    prx.execute();--%>
<%--}--%>

<%--function setGridSorting()--%>
<%--{--%>
<%--    if (gConfigUse != true) {--%>
<%--        setIsReady("sorting");--%>
<%--        return;--%>
<%--    }--%>

<%--    var sortingListDsId = "ds_sortingList_" + gGridId;--%>

<%--    element.sortingListDs = element.document.getElementById(sortingListDsId);--%>

<%--    if (element.sortingListDs == null) {--%>
<%--        element.sortingListDs = document.createElement('<ANY:DS id="' + sortingListDsId + '" />');--%>
<%--        element.document.body.appendChild(element.sortingListDs);--%>
<%--    }--%>

<%--    var prx = new any.proxy();--%>
<%--    prx.path = top.getRoot() + "/anyfive.framework.grid.act.RetrieveGridSortingList.do";--%>
<%--    prx.addParam("GRID_ID", gGridId);--%>

<%--    prx.onSuccess = function()--%>
<%--    {--%>
<%--        if (element.configInfoDs.rowCount == 0 || element.configInfoDs.value(0, "SORTING_YN") != "1") {--%>
<%--            element.sortingListDs.init();--%>
<%--            for (var i = 0; i < gGridSortingDefault.length; i++) {--%>
<%--                element.sortingListDs.addRow();--%>
<%--                element.sortingListDs.value(i, "COL_ID") = gGridSortingDefault[i].name;--%>
<%--                element.sortingListDs.value(i, "SORT_INDEX") = i + 1;--%>
<%--                element.sortingListDs.value(i, "SORT_TYPE") = gGridSortingDefault[i].type;--%>
<%--            }--%>
<%--        }--%>

<%--        var col1;--%>
<%--        var col2;--%>

<%--        gGridSorting = new Array();--%>

<%--        for (var i = 0; i < element.sortingListDs.rowCount; i++) {--%>
<%--            addSorting(element.sortingListDs.value(i, "COL_ID"), element.sortingListDs.value(i, "SORT_TYPE"), true);--%>
<%--        }--%>

<%--        setPagingHeader();--%>

<%--        if (element.pagingType == 0) {--%>
<%--            doSort(true);--%>
<%--        } else if (gLoader != null) {--%>
<%--            gLoader.reload();--%>
<%--        }--%>

<%--        setIsReady("sorting");--%>
<%--    }--%>

<%--    prx.onFail = function()--%>
<%--    {--%>
<%--        element.isReady = true;--%>
<%--    }--%>

<%--    prx.execute();--%>
<%--}--%>

<%--function setExtendColumnWidth()--%>
<%--{--%>
<%--    if (gUserResized == true) return;--%>
<%--    if (gExtendColKey == null) return;--%>

<%--    var extendColIdx = fg.ColIndex(gExtendColKey);--%>

<%--    if (extendColIdx == -1) return;--%>

<%--    var totWidth = 0;--%>

<%--    for (var c = 0; c < fg.Cols; c++) {--%>
<%--        if (fg.ColKey(c) == gExtendColKey) continue;--%>
<%--        if (fg.ColHidden(c) == true) continue;--%>
<%--        totWidth += fg.ColWidth(c);--%>
<%--    }--%>

<%--    for (var i = 0; i < 2; i++) {--%>
<%--        try {--%>
<%--            fg.ColWidth(extendColIdx) = Math.max(fg.ColData(extendColIdx).info.width * 15, (fg.offsetWidth - any.scrollBarWidth) * 15 - totWidth);--%>
<%--        } catch(ex) {--%>
<%--        }--%>
<%--    }--%>
<%--}--%>

<%--function setIsReady(name)--%>
<%--{--%>
<%--    gConfigLoaded[name] = true;--%>

<%--    for (var item in gConfigLoaded) {--%>
<%--        if (gConfigLoaded[item] != true) return;--%>
<%--    }--%>

<%--    element.isReady = true;--%>
<%--}--%>

<%--function setAutoColSize(col)--%>
<%--{--%>
<%--    if (fg.ColData(col).info.width != null) return;--%>

<%--    fg.AutoSizeMode = 0;--%>
<%--    fg.AutoSize(col);--%>
<%--    fg.ColWidth(col) = Math.min(5000, fg.ColWidth(col));--%>
<%--}--%>

<%--function resetEditable(col)--%>
<%--{--%>
<%--    if (gEditable == null) return;--%>
<%--    if (gAutoColumn == true) return;--%>
<%--    if (col == -1) return;--%>

<%--    try {--%>
<%--        fg.ReDraw = 0;--%>
<%--        if (fg.ColData(col).info.edit == true) {--%>
<%--            fg.Editable = gEditable;--%>
<%--        } else {--%>
<%--            fg.Editable = flexEDNone;--%>
<%--        }--%>
<%--    } catch(ex) {--%>
<%--        fg.ReDraw = 2;--%>
<%--        throw(ex);--%>
<%--    } finally {--%>
<%--        fg.ReDraw = 2;--%>
<%--    }--%>
<%--}--%>

<%--function getCellText(row, colId)--%>
<%--{--%>
<%--    var cellText = fg.RowData(row).data[colId];--%>

<%--    return (cellText == null ? "" : cellText);--%>
<%--}--%>

<%--function getRowNum(iRowIdx)--%>
<%--{--%>
<%--    if (element.rowNumDir.toUpperCase() == "ASC") return iRowIdx - fg.FixedRows + 1;--%>

<%--    return fg.Rows - iRowIdx;--%>
<%--}--%>
<%--</SCRIPT>--%>

<%--<SCRIPT language="VBScript">--%>
<%--Option Explicit--%>

<%--Public Sub vbBindGrid()--%>
<%--    On Error Resume Next--%>

<%--    Dim r, c--%>

<%--    fg.ReDraw = 0--%>

<%--    For r = fg.FixedRows To fg.Rows - 1--%>
<%--        For c = 0 To fg.Cols - 1--%>
<%--            fg.TextMatrix(r, c) = fg.ColData(c).info.text(element, fg, r, fg.ColKey(c), getCellText(r, fg.ColData(c).info.id2))--%>
<%--        Next--%>
<%--        setRowConfig(r)--%>
<%--    Next--%>

<%--    fg.ReDraw = 2--%>
<%--End Sub--%>

<%--Public Sub vbSortGrid(ByVal iColIdx, ByVal sSortDir, ByVal aMoveToFirst)--%>
<%--    On Error Resume Next--%>

<%--    If iColIdx = -1 Then Exit Sub--%>

<%--    fg.ReDraw = 0--%>

<%--    fg.Col = iColIdx--%>

<%--    If sSortDir = "DESC" Then--%>
<%--        fg.Sort = flexSortGenericDescending--%>
<%--    Else--%>
<%--        fg.Sort = flexSortGenericAscending--%>
<%--    End If--%>

<%--    Dim r--%>
<%--    Dim c: c = fg.ColIndex("ROW_NUM")--%>

<%--    If c > -1 Then--%>
<%--        For r = fg.FixedRows To fg.Rows - 1--%>
<%--            fg.TextMatrix(r, c) = getRowNum(r)--%>
<%--        Next--%>
<%--    End If--%>

<%--    If aMoveToFirst = True Then--%>
<%--        fg.TopRow = fg.FixedRows--%>
<%--        fg.Row = fg.FixedRows--%>
<%--    End If--%>

<%--    fg.ReDraw = 2--%>
<%--End Sub--%>
<%--</SCRIPT>--%>

<%--<SCRIPT language="VBScript" for="fg" event="BeforeRowColChange(ByVal iOldRow, ByVal iOldCol, ByVal iNewRow, ByVal iNewCol, ByRef bCancel)">--%>
<%--    resetEditable iNewCol--%>
<%--</SCRIPT>--%>

<%--<SCRIPT language="VBScript" for="fg" event="BeforeEdit(ByVal iRow, ByVal iCol, ByRef bCancel)">--%>
<%--    If gAutoColumn <> True Then fg.EditMask = fg.ColData(iCol).info.editMask--%>
<%--</SCRIPT>--%>

<%--<SCRIPT language="VBScript" for="fg" event="AfterEdit(ByVal iRow, ByVal iCol)">--%>
<%--    fg.TextMatrix(iRow, iCol) = Trim(fg.TextMatrix(iRow, iCol))--%>
<%--    If gAutoColumn <> True Then fg.Editable = flexEDNone--%>
<%--</SCRIPT>--%>

<%--<SCRIPT language="JScript" for="fg" event="onresize()">--%>
<%--    setExtendColumnWidth();--%>
<%--</SCRIPT>--%>

<%--<SCRIPT language="JScript" for="fg" event="AfterUserResize(iRow, iCol)">--%>
<%--    gUserResized = true;--%>
<%--</SCRIPT>--%>

<%--<SCRIPT language="JScript" for="fg" event="MouseMove(iButton, iShift, iX, iY)">--%>
<%--    var row = fg.MouseRow;--%>
<%--    var col = fg.MouseCol;--%>

<%--    if (gHilightRow != row && fg.Rows > fg.FixedRows && row >= fg.FixedRows && row < fg.Rows && fg.IsSubtotal(row) != true) {--%>
<%--        fg.ReDraw = 0;--%>
<%--        if (gHilightRow != null && gHilightRow >= fg.FixedRows && gHilightRow < fg.Rows) {--%>
<%--            fg.Cell(flexcpBackColor, gHilightRow, fg.FixedCols, gHilightRow, fg.Cols - 1) = "";--%>
<%--        }--%>
<%--        fg.Cell(flexcpBackColor, row, fg.FixedCols, row, fg.Cols - 1) = "&HBBFFFF";--%>
<%--        gHilightRow = row;--%>
<%--        fg.ReDraw = 2;--%>
<%--    }--%>

<%--    try {--%>

<%--        var cursor = 0;--%>

<%--        if (row != -1 && col != -1 && row >= fg.FixedRows) {--%>
<%--            for (var item in gGridActions) {--%>
<%--                if (gGridActions[item] == null) continue;--%>
<%--                if (fg.ColKey(col) == item && gGridActions[item].type != 2 && (gGridActions[item].check == null || gGridActions[item].check(element, fg, row, fg.ColKey(col)) == true)) {--%>
<%--                    cursor = 54;--%>
<%--                    break;--%>
<%--                }--%>
<%--            }--%>
<%--        }--%>

<%--        fg.MousePointer = cursor;--%>

<%--    } catch(ex) {--%>
<%--    }--%>
<%--</SCRIPT>--%>

<%--<SCRIPT language="JScript" for="fg" event="MouseDown(iButton, iShift, iX, iY)">--%>
<%--    gMouseDown.button = iButton;--%>
<%--    gMouseDown.shift = iShift;--%>
<%--    gMouseDown.x = iX;--%>
<%--    gMouseDown.y = iY;--%>
<%--    gMouseDown.mouseRow = fg.MouseRow;--%>
<%--    gMouseDown.mouseCol = fg.MouseCol;--%>
<%--    resetEditable(fg.Col);--%>
<%--    doAction(0);--%>
<%--</SCRIPT>--%>

<%--<SCRIPT language="JScript" for="fg" event="MouseUp(iButton, iShift, iX, iY)">--%>
<%--    if (iButton == 2) showPopup(iX, iY);--%>
<%--</SCRIPT>--%>

<%--<SCRIPT language="JScript" for="fg" event="Click()">--%>
<%--    var row = fg.MouseRow;--%>
<%--    var col = fg.MouseCol;--%>

<%--    if (gMouseDown.button != 1) return;--%>
<%--    if (gMouseDown.mouseRow != row) return;--%>
<%--    if (gMouseDown.mouseCol != col) return;--%>
<%--    if (row == -1) return;--%>
<%--    if (col == -1) return;--%>
<%--    if (fg.ColData(col) == null) return;--%>
<%--    if (fg.ColData(col).info == null) return;--%>

<%--    if (row >= fg.FixedRows) {--%>
<%--        doAction(1);--%>
<%--        toggleCheckBox(false);--%>
<%--    } else if (row == fg.FixedRows - 1 || fg.TextMatrix(row, col) == fg.TextMatrix(fg.FixedRows - 1, col)) {--%>
<%--        if (fg.ColData(col).info.sort == true && gLoader != null && gLoader.executed == true && gLoader.loading != true) {--%>
<%--            if (element.beforeSort == null || eval(element.beforeSort)() == true) {--%>
<%--                if (gGridSorting.length > 0 && fg.ColKey(col).toUpperCase() == gGridSorting[0].name.toUpperCase()) {--%>
<%--                    switch (gGridSorting[0].type.toUpperCase()) {--%>
<%--                    case "ASC":--%>
<%--                        setSorting(gGridSorting[0].name, "DESC");--%>
<%--                        break;--%>
<%--                    case "DESC":--%>
<%--                        setSorting();--%>
<%--                        break;--%>
<%--                    }--%>
<%--                } else {--%>
<%--                    setSorting(fg.ColKey(col));--%>
<%--                }--%>
<%--                gPagingParams.no = 1;--%>
<%--                setPagingHeader();--%>
<%--                if (element.pagingType == 0) {--%>
<%--                    doSort(true);--%>
<%--                } else {--%>
<%--                    if (gLoader != null) gLoader.execute(true);--%>
<%--                }--%>
<%--            }--%>
<%--        }--%>
<%--        toggleCheckBox(true);--%>
<%--    }--%>
<%--</SCRIPT>--%>

<%--<SCRIPT language="JScript" for="fg" event="DblClick()">--%>
<%--    var row = fg.MouseRow;--%>
<%--    var col = fg.MouseCol;--%>

<%--    if (gMouseDown.button != 1) return;--%>
<%--    if (gMouseDown.mouseRow != row) return;--%>
<%--    if (gMouseDown.mouseCol != col) return;--%>
<%--    if (row == -1) return;--%>
<%--    if (col == -1) return;--%>

<%--    if (row >= fg.FixedRows) {--%>
<%--        doAction(2);--%>
<%--    }--%>
<%--</SCRIPT>--%>

<%--<SCRIPT language="JScript" for="txt_pagingNo" event="onkeypress()">--%>
<%--    if (event.keyCode == 13) {--%>
<%--        event.keyCode = 0;--%>
<%--        this.blur();--%>
<%--        resetPagingNo('text');--%>
<%--    } else if (event.keyCode < 48 || event.keyCode > 57) {--%>
<%--        event.keyCode = 0;--%>
<%--    }--%>
<%--</SCRIPT>--%>
<%--</HEAD>--%>

<%--<BODY>--%>

<%--<TABLE border="0" cellspacing="1" cellpadding="0" bgColor="#BBBBBB" width="100%" height="100%">--%>
<%--    <TR>--%>
<%--        <TD height="100%">--%>
<%--            <SCRIPT language="JScript">new FlexGrid("fg", element.viewType, document);</SCRIPT>--%>
<%--        </TD>--%>
<%--    </TR>--%>
<%--    <TR id="tr_pagingArea" style="display:none;">--%>
<%--        <TD bgColor="#EEEEEE" align="center" style="padding:3px;">--%>
<%--            <TABLE border="0" cellspacing="0" cellpadding="0">--%>
<%--                <TR>--%>
<%--                    <TD noWrap style="padding-right:10px;" id="td_pagingSize">--%>
<%--                        <SELECT id="sel_pagingSize" style="font-family:courier; width:140px;" onChange="javascript:resetPagingSize(this.value);"></SELECT>--%>
<%--                        <SCRIPT language="JScript">--%>
<%--                        eval(function()--%>
<%--                        {--%>
<%--                            var optArr;--%>
<%--                            var padLen;--%>

<%--                            switch (String(element.pagingType)) {--%>
<%--                            case "1":--%>
<%--                                optArr = [20, 50, 100, 200, 500, 1000];--%>
<%--                                break;--%>
<%--                            case "2":--%>
<%--                                optArr = [10, 20, 50, 100, 200];--%>
<%--                                break;--%>
<%--                            }--%>

<%--                            if (optArr == null) return;--%>

<%--                            padLen = String(optArr[optArr.length - 1]).length;--%>

<%--                            for (var i = 0; i < optArr.length; i++) {--%>
<%--                                sel_pagingSize.options.add(new Option(any.lpad(optArr[i], padLen, " ") + " Rows/Page", optArr[i]));--%>
<%--                            }--%>
<%--                        })();--%>
<%--                        </SCRIPT>--%>
<%--                    </TD>--%>
<%--                    <TD noWrap>--%>
<%--                        <BUTTON id="btn_resetPagingNoFirst" onClick="javascript:resetPagingNo('first');" disabled title="Go To First Page"><SPAN>&lt;&lt;</SPAN></BUTTON>--%>
<%--                        <BUTTON id="btn_resetPagingNoPrev" onClick="javascript:resetPagingNo('prev');" disabled title="Go To Previous Page" style="margin-left:1px;"><SPAN>&lt;</SPAN></BUTTON>--%>
<%--                    </TD>--%>
<%--                    <TD noWrap style="padding-left:1px; padding-right:1px;">--%>
<%--                        <SPAN id="spn_pagingNo" style="background-color:#FFFFFF; border:#BFBFBF 1px solid;" disabled>--%>
<%--                        <INPUT type="text" id="txt_pagingNo" value="1" class="PAGING_NO" disabled onFocus="this.select();" onClick="this.select();">/<INPUT type="text" id="txt_totPageCnt" value="1" class="PAGING_NO" disabled readOnly onFocus="txt_pagingNo.select();">--%>
<%--                        </SPAN>--%>
<%--                    </TD>--%>
<%--                    <TD noWrap>--%>
<%--                        <BUTTON id="btn_resetPagingNoText" onClick="javascript:resetPagingNo('text');" disabled title="Go"><SPAN>Go</SPAN></BUTTON>--%>
<%--                        <BUTTON id="btn_resetPagingNoNext" onClick="javascript:resetPagingNo('next');" disabled title="Go To Next Page" style="margin-left:1px;"><SPAN>&gt;</SPAN></BUTTON>--%>
<%--                        <BUTTON id="btn_resetPagingNoLast" onClick="javascript:resetPagingNo('last');" disabled title="Go To Last Page" style="margin-left:1px;"><SPAN>&gt;&gt;</SPAN></BUTTON>--%>
<%--                    </TD>--%>
<%--                </TR>--%>
<%--            </TABLE>--%>
<%--        </TD>--%>
<%--    </TR>--%>
<%--</TABLE>--%>
<%--<SCRIPT language="JScript">--%>
<%--if (element.pagingType == "0") {--%>
<%--    tr_pagingArea.style.display = "none";--%>
<%--} else {--%>
<%--    td_pagingSize.style.display = "block";--%>
<%--    tr_pagingArea.style.display = "block";--%>
<%--}--%>
<%--</SCRIPT>--%>

<%--<DIV id="div_popupMenu" style="position:absolute; left:0px; top:0px; visibility:hidden;">--%>
<%--<TABLE border="1" cellspacing="0" cellpadding="0" bgColor="#FFFFFF">--%>
<%--    <TR>--%>
<%--        <TD style="padding:2px;">--%>
<%--            <TABLE id="tbl_popupMenu" border="0" cellspacing="0" cellpadding="0">--%>
<%--                <TR>--%>
<%--                    <TD command="C"><SPAN style="overflow:hidden; text-overflow:ellipsis; width:386px;">Copy <U>C</U>ell : <SPAN id="spn_copyCellText"></SPAN></SPAN></TD>--%>
<%--                </TR>--%>
<%--                <TR>--%>
<%--                    <TD command="W"><SPAN style="overflow:hidden; text-overflow:ellipsis; width:386px;">Copy Ro<U>w</U> : <SPAN id="spn_copyRowText"></SPAN></SPAN></TD>--%>
<%--                </TR>--%>
<%--                <TR>--%>
<%--                    <TD command="O"><SPAN style="overflow:hidden; text-overflow:ellipsis; width:386px;">Copy C<U>o</U>lumn : <SPAN id="spn_copyColText"></SPAN></SPAN></TD>--%>
<%--                </TR>--%>
<%--                <TR>--%>
<%--                    <TD command="S">Copy <U>S</U>elected Region</TD>--%>
<%--                </TR>--%>
<%--                <TR>--%>
<%--                    <TD command="A">Copy <U>A</U>ll</TD>--%>
<%--                </TR>--%>
<%--                <TR>--%>
<%--                    <TD><DIV style="border-top:#ACA899 1px solid; border-bottom:#ECE9D8 1px solid;"></DIV></TD>--%>
<%--                </TR>--%>
<%--                <TR id="tr_command_R">--%>
<%--                    <TD command="R"><U>R</U>eload</TD>--%>
<%--                </TR>--%>
<%--                <TR>--%>
<%--                    <TD command="F"><U>F</U>ind</TD>--%>
<%--                </TR>--%>
<%--                <TR>--%>
<%--                    <TD><DIV style="border-top:#ACA899 1px solid; border-bottom:#ECE9D8 1px solid;"></DIV></TD>--%>
<%--                </TR>--%>
<%--                <TR id="tr_command_X">--%>
<%--                    <TD command="X">E<U>x</U>cel Download</TD>--%>
<%--                </TR>--%>
<%--                <TR>--%>
<%--                    <TD command="P"><U>P</U>rint</TD>--%>
<%--                </TR>--%>
<%--                <TR id="tr_separator_1" style="display:none;">--%>
<%--                    <TD><DIV style="border-top:#ACA899 1px solid; border-bottom:#ECE9D8 1px solid;"></DIV></TD>--%>
<%--                </TR>--%>
<%--                <TR id="tr_command_L" style="display:none;">--%>
<%--                    <TD command="L">Co<U>l</U>umn Setting</TD>--%>
<%--                </TR>--%>
<%--                <TR id="tr_command_T" style="display:none;">--%>
<%--                    <TD command="T">Sor<U>t</U>ing</TD>--%>
<%--                </TR>--%>
<%--            </TABLE>--%>
<%--        </TD>--%>
<%--    </TR>--%>
<%--</TABLE>--%>
<%--</DIV>--%>

<%--<SCRIPT language="JScript">content_oninit();</SCRIPT>--%>

<%--</BODY>--%>
<%--</HTML>--%>
