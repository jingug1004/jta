var FlexGrid = function(id, type, doc)
{
    if (id == null) id = "fg";
    if (type == null) type = "grid";
    if (doc == null) doc = document;

    FlexGrid.writeLPK(doc);

    doc.writeln('<OBJECT id="' + id + '" classid="CLSID:74233DB3-F72F-44EA-94DC-258A624037E6"');
    doc.writeln('    codeBase="' + top.getRoot() + '/anyfive/framework/grid/flexgrid/vsflex8n.cab#version=8,0,20044,210" width="100%" height="100%">');
    doc.writeln('    <PARAM name="Cols" value="0">');
    doc.writeln('    <PARAM name="Rows" value="0">');
    doc.writeln('    <PARAM name="ExplorerBar" value="0">');
    doc.writeln('    <PARAM name="FixedCols" value="0">');
    doc.writeln('    <PARAM name="FixedRows" value="0">');
    doc.writeln('    <PARAM name="FrozenCols" value="0">');
    doc.writeln('    <PARAM name="FrozenRows" value="0">');
    doc.writeln('    <PARAM name="AllowUserResizing" value="1">');
    doc.writeln('    <PARAM name="AllowUserFreezing" value="0">');
    doc.writeln('    <PARAM name="BorderStyle" value="0">');
    doc.writeln('    <PARAM name="ScrollBars" value="3">');
    doc.writeln('    <PARAM name="ScrollTrack" value="True">');
    doc.writeln('    <PARAM name="HighLight" value="1">');
    doc.writeln('    <PARAM name="BackColorFixed" value="&HEEEEEE">');
    doc.writeln('    <PARAM name="BackColorFrozen" value="&HF6F6F6">');
    doc.writeln('    <PARAM name="BackColor" value="&HFFFFFF">');
    doc.writeln('    <PARAM name="BackColorAlternate" value="&HFFFFFF">');
    doc.writeln('    <PARAM name="ForeColor" value="&H000000">');
    doc.writeln('    <PARAM name="BackColorSel" value="&HF2E9DF">');
    doc.writeln('    <PARAM name="ForeColorSel" value="&H000000">');
    doc.writeln('    <PARAM name="BackColorBkg" value="&HFFFFFF">');
    doc.writeln('    <PARAM name="GridColor" value="&HDDDDDD">');
    doc.writeln('    <PARAM name="GridColorFixed" value="&HCCCCCC">');
    doc.writeln('    <PARAM name="Ellipsis" value="1">');
    doc.writeln('    <PARAM name="Editable" value="False">');
    doc.writeln('    <PARAM name="RowHeightMin" value="280">');
    doc.writeln('    <PARAM name="WordWrap" value="False">');
    doc.writeln('    <PARAM name="AutoSizeMode" value="1">');
    doc.writeln('    <PARAM name="AllowBigSelection" value="True">');
    doc.writeln('    <PARAM name="GridLinesFixed" value="2">');
    FlexGrid.writeOptions[type](doc);
    doc.writeln('</OBJECT>');
}

FlexGrid.writeLPK = function(doc)
{
    if (doc == null) doc = document;

    doc.writeln('<OBJECT classid="CLSID:5220CB21-C88D-11CF-B347-00AA00A28331">');
    doc.writeln('    <PARAM name="LPKPath" value="' + top.getRoot() + '/anyfive/framework/grid/flexgrid/vsflex8.lpk">');
    doc.writeln('</OBJECT>');
}

FlexGrid.writeOptions = new Object();

FlexGrid.writeOptions.grid = function(doc)
{
    if (doc == null) doc = document;

    doc.writeln('    <PARAM name="SheetBorder" value="&HDDDDDD">');
    doc.writeln('    <PARAM name="AllowSelection" value="True">');
    doc.writeln('    <PARAM name="MergeCells" value="5">');
    doc.writeln('    <PARAM name="ExtendLastCol" value="False">');
    doc.writeln('    <PARAM name="FocusRect" value="2">');
    doc.writeln('    <PARAM name="SelectionMode" value="0">');
    doc.writeln('    <PARAM name="GridLines" value="1">');
}

FlexGrid.writeOptions.tree = function(doc)
{
    if (doc == null) doc = document;

    doc.writeln('    <PARAM name="SheetBorder" value="&HFFFFFF">');
    doc.writeln('    <PARAM name="AllowSelection" value="False">');
    doc.writeln('    <PARAM name="MergeCells" value="7">');
    doc.writeln('    <PARAM name="ExtendLastCol" value="True">');
    doc.writeln('    <PARAM name="FocusRect" value="0">');
    doc.writeln('    <PARAM name="SelectionMode" value="1">');
    doc.writeln('    <PARAM name="GridLines" value="0">');
}
