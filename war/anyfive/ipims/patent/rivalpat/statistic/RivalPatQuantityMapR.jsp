<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>정량맵</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<% app.writeHTCImport(app.HTC_TREE); %>
<% app.writeHTCImport(app.HTC_CHART); %>
<ANY:DS id="ds_result" />
<SCRIPT language="JScript">
var gChartTitle;
var gPriorCode;

//윈도우 로딩시
window.onready = function()
{
}

//조회
function fnRetrieve()
{
    var prx = new any.proxy();

    prx.path = top.getRoot() + "/anyfive.ipims.patent.rivalpat.statistic.act.RetrieveRivalPatQuantityMap.do";
    prx.addParam("LIST_TYPE", LIST_TYPE.value);
    prx.addParam("TECH_CODE", gPriorCode);
    prx.addParam("COUNTRY_CODE", COUNTRY_CODE.value);
    prx.addParam("OWN_APP_MAN", OWN_APP_MAN.value);
    prx.addParam("SEARCH_YEAR", SEARCH_YEAR.value);
    prx.addParam("SEARCH_RANK", SEARCH_RANK.value);

    prx.onSuccess = function()
    {
        chart1.init();
        chart1.autoCreate(ds_result, "COL1", "COL2", "CNT");
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//엑셀다운
function fnExcelDownload()
{
    var ldr = gr_statisticQuantity.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.rivalpat.statistic.act.QuantityExcelDownload.do";
    ldr.addParam("LIST_TYPE", LIST_TYPE.value);
    ldr.addParam("TECH_CODE", gPriorCode);
    ldr.addParam("COUNTRY_CODE", COUNTRY_CODE.value);
    ldr.addParam("OWN_APP_MAN", OWN_APP_MAN.value);
    ldr.addParam("SEARCH_YEAR", SEARCH_YEAR.value);
    ldr.addParam("SEARCH_RANK", SEARCH_RANK.value);

    ldr.onSuccess = function(gr, fg)
    {
        gr_statisticQuantity.title = "정량맵 - " + gChartTitle;
        gr_statisticQuantity.loader.download();
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

//기술분류 트리 조회
function fnRetrieveTechTree()
{
    var ldr = gr_techCodeTree.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.common.popup.search.act.RetrieveTechCodeSearchTree.do";

    ldr.onSuccess = function(gr, fg)
    {
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}
</SCRIPT>

<!-- 맵유형 변경시 -->
<SCRIPT language="JScript" for="LIST_TYPE" event="OnChange()">
    gChartTitle = this.text;
    gPriorCode = null;

    COUNTRY_CODE.disabled = (this.value(null, "COUNTRY_CODE") != "1");
    OWN_APP_MAN.disabled = (this.value(null, "OWN_APP_MAN") != "1");

    cfShowObjects([tr_yearArea], this.value(null, "YEAR_AREA") == "1");
    cfShowObjects([tr_rankArea], this.value(null, "RANK_AREA") == "1");
    cfShowObjects([tr_techCodeArea], this.value(null, "TECH_AREA") == "1");

    if (tr_techCodeArea.style.display != "none") {
        fnRetrieveTechTree();
    }
</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
    <TR>
        <TD valign="top">
            <TABLE border="0" cellspacing="0" cellpadding="0" width="230px" height="100%">
                <TR>
                    <TD valign="top">
                        <TABLE border="0" cellspacing="1" cellpadding="2" class="main" width="100%">
                            <TR>
                                <TD class="condhead" align="left">국가구분</TD>
                            </TR>
                            <TR>
                                <TD class="conddata"><ANY:SELECT id="COUNTRY_CODE" codeData="/rivalpat/countryCode" firstName="all" disabled /></TD>
                            </TR>
                            <TR>
                                <TD class="condhead">대표출원인</TD>
                            </TR>
                            <TR>
                                <TD class="conddata"><ANY:SELECT id="OWN_APP_MAN" codeData="/rivalpat/ownAppMan" firstName="all" disabled /></TD>
                            </TR>
                            <TR>
                                <TD class="condhead">맵유형별</TD>
                            </TR>
                            <TR>
                                <TD class="conddata"><ANY:SELECT id="LIST_TYPE" codeData="/rivalpat/quantityMapType" /></TD>
                            </TR>
                            <TR id="tr_yearArea" style="display:none;">
                                <TD class="condhead">기간</TD>
                            </TR>
                            <TR id="tr_yearArea" style="display:none;">
                                <TD class="conddata"><ANY:SELECT id="SEARCH_YEAR" codeData="/rivalpat/searchYear" firstName="all" /></TD>
                            </TR>
                            <TR id="tr_rankArea" style="display:none;">
                                <TD class="condhead">순위</TD>
                            </TR>
                            <TR id="tr_rankArea" style="display:none;">
                                <TD class="conddata"><ANY:SELECT id="SEARCH_RANK" codeData="/rivalpat/searchRank" firstName="all" /></TD>
                            </TR>
                        </TABLE>
                    </TD>
                </TR>
                <TR id="tr_techCodeArea" height="100%" style="display:none;">
                    <TD width="230px">
                        <ANY:TREE id="gr_techCodeTree"><COMMENT>
                            parentColumn = "PRIOR_TECH_CODE";
                            codeColumn   = "TECH_CODE";
                            nameColumn   = "TECH_HNAME";
                            expandLevel  = 1;

                            addRoot(null, "ROOT", "iPIMS");

                            fg.attachEvent("AfterRowColChange", function(iOldRow, iOldCol, iNewRow, iNewCol)
                            {
                                if (element.loader.loading == true) return;

                                gPriorCode = element.value(iNewRow, "TECH_CODE");
                            });
                        </COMMENT></ANY:TREE>
                    </TD>
                </TR>
            </TABLE>
        </TD>
        <TD width="100%" style="padding-left:5px;">
            <TABLE border="0" cellspacing="0" cellpadding="0" height="100%" width="100%">
                <TR>
                    <TD align="left">
                        <BUTTON text="Chart View" onClick="javascript:fnRetrieve();" space="none"></BUTTON>
                        <BUTTON text="Save Excel" onClick="javascript:fnExcelDownload();"></BUTTON>
                    </TD>
                </TR>
                <TR>
                    <TD height="5"></TD>
                </TR>
                <TR>
                    <TD height="100%">
                        <ANY:GRID id="gr_statisticQuantity" style="display:none;" />
                        <ANY:CHART id="chart1" />
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
