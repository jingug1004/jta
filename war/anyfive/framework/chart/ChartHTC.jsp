<%@page pageEncoding="UTF-8"%><% response.setContentType("text/x-component; charset=utf-8"); %>
<%@page import="anyfive.framework.app.FrameworkApp"%><% FrameworkApp app = new FrameworkApp(request, response, out, true, true); %>
<PUBLIC:COMPONENT tagName="CHART" lightWeight="false">
    <PUBLIC:DEFAULTS tabStop="true" viewInheritStyle="true" viewLinkContent="true" viewMasterTab="false" />
    <PUBLIC:ATTACH event="ondocumentready" onevent="document_onready();" />
    <PUBLIC:PROPERTY name="isReady" value="false" />
    <PUBLIC:PROPERTY name="fc" get="getFC" />
    <PUBLIC:PROPERTY name="color" get="getColor" />
    <PUBLIC:PROPERTY name="option" get="getOption" />
    <PUBLIC:PROPERTY name="size" get="getSize" />
    <PUBLIC:PROPERTY name="attributeValue" get="getAttributeValue" />
    <PUBLIC:PROPERTY name="maxValue" get="getMaxValue" put="setMaxValue" />
    <PUBLIC:PROPERTY name="defaultSingleChart" value="Column 3D Chart" />
    <PUBLIC:PROPERTY name="defaultMultiChart" value="Multi-Series Column 3D Chart" />
    <PUBLIC:METHOD name="init" />
    <PUBLIC:METHOD name="addXML" />
    <PUBLIC:METHOD name="getXML" />
    <PUBLIC:METHOD name="create" />
    <PUBLIC:METHOD name="autoCreate" />
    <PUBLIC:EVENT name="OnClickSeries" id="OnClickSeriesEvent" />
</PUBLIC:COMPONENT>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
<HEAD>
<META http-equiv="Content-Type" content="text/x-component; charset=utf-8">
<STYLE type="text/css">
BODY, TD, DIV, BUTTON, SELECT {
    font-family: 돋움;
    font-size: 12px;
    color: #575757;
}

BUTTON {
    background-color: #F6F6E8;
    border: #CAC8C0 1px solid;
    margin-left: 2px;
    width: 40px;
}
</STYLE>
<SCRIPT language="JScript" src="<%= request.getContextPath() %>/anyfive/framework/chart/fusioncharts/FusionCharts.js"></SCRIPT>
<SCRIPT language="JScript">
var gChartColors;
var gChartTypes;
var gChartType;
var gChartSize;
var gChartOptions;
var gChartXML;

var gMaxValue;

if (element.style.width == "") {
    element.style.width = "100%";
}

if (element.style.height == "") {
    element.style.height = "100%";
}

if (element.style.border == "") {
    element.style.border = "#CAC8C0 1px solid";
}

function document_onready()
{
    initChartColors();
    initChartTypes();

    gChartType = {};
    gChartSize = {};

    element.isReady = true;
}

function initChartColors()
{
    gChartColors = new Array();

    gChartColors.push("AFD8F8");
    gChartColors.push("F6BD0F");
    gChartColors.push("8BBA00");
    gChartColors.push("FF8E46");
    gChartColors.push("008E8E");
    gChartColors.push("D64646");
    gChartColors.push("8E468E");
    gChartColors.push("588526");
    gChartColors.push("B3AA00");
    gChartColors.push("008ED6");
    gChartColors.push("9D080D");
    gChartColors.push("A186BE");
}

function initChartTypes()
{
    gChartTypes = new Array();

    gChartTypes.push({ series:"single", name:"Column 2D Chart", swf:"FCF_Column2D" });
    gChartTypes.push({ series:"single", name:"Column 3D Chart", swf:"FCF_Column3D" });
    gChartTypes.push({ series:"single", name:"Pie 2D Chart", swf:"FCF_Pie2D" });
    gChartTypes.push({ series:"single", name:"Pie 3D Chart", swf:"FCF_Pie3D" });
    gChartTypes.push({ series:"single", name:"Line 2D Chart", swf:"FCF_Line" });
    gChartTypes.push({ series:"single", name:"Bar 2D Chart", swf:"FCF_Bar2D" });
    gChartTypes.push({ series:"single", name:"Area 2D Chart", swf:"FCF_Area2D" });

    gChartTypes.push({ series:"multi", name:"Multi-Series Column 2D Chart", swf:"FCF_MSColumn2D" });
    gChartTypes.push({ series:"multi", name:"Multi-Series Column 3D Chart", swf:"FCF_MSColumn3D" });
    gChartTypes.push({ series:"multi", name:"Multi-Series Line 2D Chart", swf:"FCF_MSLine" });
    gChartTypes.push({ series:"multi", name:"Multi-Series Area 2D Chart", swf:"FCF_MSArea2D" });
    gChartTypes.push({ series:"multi", name:"Multi-Series Bar 2D Sheet", swf:"FCF_MSBar2D" });
    gChartTypes.push({ series:"multi", name:"Stacked Column 2D Chart", swf:"FCF_StackedColumn2D" });
    gChartTypes.push({ series:"multi", name:"Stacked Column 3D Chart", swf:"FCF_StackedColumn3D" });
    gChartTypes.push({ series:"multi", name:"Stacked Area 2D Chart", swf:"FCF_StackedArea2D" });
    gChartTypes.push({ series:"multi", name:"Stacked Bar 2D Chart", swf:"FCF_StackedBar2D" });
}

function getFC()
{
    return document.getElementById("fc");
}

function getColor(index)
{
    return gChartColors[index % gChartColors.length];
}

function getOption()
{
    return gChartOptions;
}

function getSize()
{
    return gChartSize;
}

function getAttributeValue(value)
{
    return value.replaceAll('"', '&#34;');
}

function getMaxValue()
{
    return gMaxValue;
}

function setMaxValue(value)
{
    if (!isNaN(value)) gMaxValue = Math.max(gMaxValue, value);
}

function init()
{
    gChartOptions = new Object();
    gChartXML = new Array();
    gMaxValue = -1;

    gChartOptions.baseFont = "Tahoma";
    gChartOptions.baseFontSize = "12";
    gChartOptions.yAxisMinValue = "0";
    gChartOptions.formatNumberScale = "0";
    gChartOptions.decimalSeparator = ".";
    gChartOptions.thousandSeparator = ",";
    gChartOptions.divLineColor = "C5C5C5";
    gChartOptions.divLineAlpha = "60";
    gChartOptions.showAreaBorder = "1";
    gChartOptions.areaBorderColor = "000000";
    gChartOptions.showNames = "1";
    gChartOptions.decimalPrecision = "0";
    gChartOptions.rotateNames = "0";

    td_chartArea.innerHTML = '';
}

function addXML(xmlString)
{
    gChartXML.push(xmlString);
}

function getXML()
{
    var options = new Array();

    gChartOptions.animation = (chk_animation.checked ? "1" : "0");

    for (var item in gChartOptions) {
        options.push(item + '="' + gChartOptions[item] + '"');
    }

    return '<graph ' + options.join(" ") + '>\n' + gChartXML.join("\n") + '\n</graph>';
}

function create()
{
    if (gChartSize.width == null) gChartSize.width = td_chart.offsetWidth;
    if (gChartSize.height == null) gChartSize.height = td_chart.offsetHeight;

    setDivLines();

    sel_chartType.series = (gChartXML.join("").indexOf("<categories") == -1 ? "single" : "multi");
    sel_chartType.options.length = 0;

    for (var i = 0; i < gChartTypes.length; i++) {
        if (gChartTypes[i].series != sel_chartType.series) continue;
        sel_chartType.add(new Option(gChartTypes[i].name, gChartTypes[i].swf));
        if (gChartTypes[i].name == element.defaultSingleChart || gChartTypes[i].name == element.defaultMultiChart) {
            sel_chartType.defaultChart = gChartTypes[i].swf;
        }
    }

    sel_chartType.value = gChartType[sel_chartType.series];

    if (sel_chartType.options.selectedIndex == -1) {
        gChartType[sel_chartType.series] = sel_chartType.value = sel_chartType.defaultChart;
    }

    if (sel_chartType.options.selectedIndex == -1) {
        sel_chartType.options.selectedIndex = 0;
        gChartType[sel_chartType.series] = sel_chartType.value;
    }

    var chart = new FusionCharts(top.getRoot() + "/anyfive/framework/chart/fusioncharts/" + gChartType[sel_chartType.series] + ".swf", "fc", gChartSize.width, gChartSize.height);
    chart.setDataXML(getXML());
    chart.render("td_chartArea");
}

function autoCreate(ds, categoryColId, datasetColId, valueColId)
{
    chk_animation.checked = (gChartOptions.animation == "1");

    if (categoryColId == null || ds.colIndex(categoryColId) == -1) {
        for (var i = 0; i < ds.rowCount; i++) {
            addXML('<set name="' + getAttributeValue(ds.value(i, datasetColId)) + '" value="' + ds.value(i, valueColId) + '" color="' + getColor(i) + '" link="' + getLink(i) + '" />');
            setMaxValue(parseInt(ds.value(i, valueColId), 10));
        }
    } else {
        var categoryNames = new Array();
        var datasetNames = new Array();

        for (var i = 0; i < ds.rowCount; i++) {
            addUniqueValue(categoryNames, ds.value(i, categoryColId));
        }

        for (var i = 0; i < ds.rowCount; i++) {
            addUniqueValue(datasetNames, ds.value(i, datasetColId));
        }

        addXML('<categories>');
        for (var i = 0; i < categoryNames.length; i++) {
            addXML('    <category name="' + getAttributeValue(categoryNames[i]) + '" color="' + getColor(i) + '" />');
        }
        addXML('</categories>');

        var valueRows = {};
        var row;

        for (var i = 0; i < ds.rowCount; i++) {
            valueRows[ds.value(i, categoryColId) + "|::|" + ds.value(i, datasetColId)] = i;
        }

        for (var j = 0; j < datasetNames.length; j++) {
            addXML('<dataset seriesname="' + getAttributeValue(datasetNames[j]) + '" color="' + getColor(j) + '">');
            for (var i = 0; i < categoryNames.length; i++) {
                row = valueRows[categoryNames[i] + "|::|" + datasetNames[j]];
                addXML('    <set value="' + (row == null ? 0 : ds.value(row, valueColId)) + '" link="' + getLink(row) + '" />');
                setMaxValue(parseInt(ds.value(row, valueColId), 10));
            }
            addXML('</dataset>');
        }

        function addUniqueValue(array, name)
        {
            for (var i = 0; i < array.length; i++) {
                if (array[i] == name) return;
            }
            array.push(name);
        }
    }

    function getLink(row)
    {
        var link = [];

        link.push('javascript:document.getElementById(\'' + element.id + '\').clickSeries(');
        link.push(categoryColId == null ? 'null' : '\'' + getJSParam(ds.value(row, categoryColId)) + '\'');
        link.push(', \'' + getJSParam(ds.value(row, datasetColId)) + '\');');

        return link.join("");

        function getJSParam(value)
        {
            if (value == null) return "";

            value = value.replace(new RegExp("\\\\", "g"), "\\\\");
            value = value.replace(new RegExp('"', "g"), '&#34;');
            value = value.replace(new RegExp("'", "g"), "\\'");

            return value;
        }
    }

    element.clickSeries = function(categoryName, datasetName)
    {
        var obj = element.document.createEventObject();
        obj.categoryName = categoryName;
        obj.datasetName = datasetName;
        OnClickSeriesEvent.fire(obj);
    }

    create();
}

function resize(value)
{
    if (gChartSize == null) return;
    if (fc == null) return;

    var resizePower = 1.1;

    switch (value) {
    case 1:
        gChartSize.width = fc.offsetWidth * resizePower;
        gChartSize.height = fc.offsetHeight * resizePower;
        create();
        break;
    case -1:
        gChartSize.width = fc.offsetWidth / resizePower;
        gChartSize.height = fc.offsetHeight / resizePower;
        create();
        break;
    case 0:
        gChartSize = {};
        create();
        break;
    }
}

function setDivLines()
{
    var divValue = getDivValue();

    if (gMaxValue == 0) {
        gChartOptions.yAxisMaxValue = 1;
        gChartOptions.numDivLines = 0;
    } else if (divValue != null) {
        gChartOptions.yAxisMaxValue = gMaxValue + (divValue - gMaxValue % divValue);
        gChartOptions.numDivLines = gChartOptions.yAxisMaxValue / divValue - 1;
    }
}

function getDivValue()
{
    var divArray = new Array();

    divArray.push({ max:10, div:1 });
    divArray.push({ max:20, div:2 });
    divArray.push({ max:50, div:5 });
    divArray.push({ max:100, div:10 });

    for (var i = 0; i < divArray.length; i++) {
        if (gMaxValue <= divArray[i].max) return divArray[i].div;
    }
}
</SCRIPT>

<SCRIPT language="JScript" for="sel_chartType" event="onchange()">
    gChartType[this.series] = this.value;
    create();
</SCRIPT>

<SCRIPT language="JScript" for="chk_animation" event="onclick()">
    create();
</SCRIPT>
</HEAD>

<BODY scroll="no">

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
    <TR>
        <TD bgColor="#F6F6E8" height="1px" style="border-bottom:#CAC8C0 1px solid;">
            <TABLE border="0" cellspacing="0" cellpadding="2" width="100%" height="100%">
                <TR>
                    <TD noWrap>
                        <SELECT id="sel_chartType">
                            <OPTION style="color:#999999;">(NO CHART DATA)
                        </SELECT>
                        <LABEL for="chk_animation" style="cursor:hand;">
                            <INPUT type="checkbox" id="chk_animation" style="width:17px; height:17px;" onFocus="this.blur();">Animation
                        </LABEL>
                    </TD>
                    <TD noWrap align="right">
                        <BUTTON onClick="javascript:resize(1);">확대</BUTTON>
                        <BUTTON onClick="javascript:resize(-1);">축소</BUTTON>
                        <BUTTON onClick="javascript:resize(0);">100%</BUTTON>
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD id="td_chart">
            <DIV style="width:100%; height:100%; overflow:auto;">
                <TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
                    <TR>
                        <TD id="td_chartArea" align="center"></TD>
                    </TR>
                </TABLE>
            </DIV>
        </TD>
    </TR>
</TABLE>

</BODY>
</HTML>
