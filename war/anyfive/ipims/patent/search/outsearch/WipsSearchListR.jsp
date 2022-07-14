<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<%@page import="any.core.config.NConfig"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>WIPS DB 검색</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<SCRIPT language="JScript">
var searchDb;
var searchAll;
var searchGroups;
var searchItems;
var dateFilter;

//윈도우 로딩시
window.onready = function()
{
    fnSetVariables();
}

//변수 셋팅
function fnSetVariables()
{
    searchDb = tab_main.button.id;

    searchAll = document.getElementById("chk_searchAll" + searchDb);
    searchGroups = document.getElementsByName("chk_searchGroup" + searchDb);
    searchItems = document.getElementsByName("chk_searchItem" + searchDb);
    dateFilter = document.getElementById("sel_dateFilter" + searchDb);
}

//전체선택/해제
function fnCheckAll()
{
    for (var i = 0; i < searchGroups.length; i++) {
        searchGroups[i].checked = searchAll.checked;
        searchGroups[i].disabled = searchAll.checked;
    }

    fnCheckGroup();
}

//그룹선택/해제
function fnCheckGroup(obj)
{
    var checked;

    for (var i = 0; i < searchItems.length; i++) {
        if (obj != null && obj.group != searchItems[i].group) continue;
        if (searchItems[i].group == null) {
            checked = searchAll.checked;
        } else {
            checked = getGroupChecked(searchItems[i].group);
        }
        searchItems[i].checked = checked;
        searchItems[i].disabled = checked;
    }

    function getGroupChecked(group)
    {
        for (var i = 0; i < searchGroups.length; i++) {
            if (searchGroups[i].group == group) return searchGroups[i].checked;
        }
        return false;
    }
}

//검색
function fnSearch()
{
    var query = txt_query.value.trim();
    var searchItemValues = new Array();

    if (query == "") {
        alert("검색식을 입력하세요.");
        txt_query.focus();
        return;
    }

    for (var i = 0; i < searchItems.length; i++) {
        if (searchItems[i].checked != true) continue;
        searchItemValues.push(searchItems[i].value);
    }

    if (searchItemValues.length == 0) {
        alert("검색대상은 1개 이상 선택되어야 합니다.");
        searchItems[0].focus();
        return;
    }

    gr_searchList.setSorting();

    var ldr = gr_searchList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.search.outsearch.act.RetrieveWipsSearchList.do";
    ldr.addParam("QUERY", query);
    ldr.addParam("CC", searchItemValues.join("|"));
    ldr.addParam("DF", dateFilter.value);
    ldr.addParam("SDATE1", txt_searchDate1.value);
    ldr.addParam("SDATE2", txt_searchDate2.value);
    ldr.addParam("SDAPPLY", chk_searchDateApply.checked == true ? "1" : "0");

    ldr.onSuccess = function(gr, fg)
    {
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();

        if (this.error.number == -999999999){
            any.replaceLoginPage();
        }
    }

    ldr.execute();
}

//상세보기
function fnGoView(gr, fg, row, colId)
{
    alert(gr.value(row, "DOC_URL"));
}

//원문 다운로드
function fnDownImage(gr, fg, row, colId)
{
//    alert(gr.value(row, "VIEW_ORG"));
}

//PM정보 입력
function fnOpenPMEdit(gr, fg, row, colId)
{
    alert(gr.value(row, "WIPS_KEY") + "\n" + gr.value(row, "DB_CODE"));
}
</SCRIPT>

<!-- 검색DB 변경시 -->
<SCRIPT language="JScript" for="tab_main" event="OnChange()">
    fnSetVariables();
</SCRIPT>

<!-- 검색식 키입력시 -->
<SCRIPT language="JScript" for="txt_query" event="onkeypress()">
    if (event.keyCode == 13) {
        event.keyCode = 0;
        fnSearch();
    }
</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
    <TR>
        <TD>
            <ANY:TAB id="tab_main"><COMMENT>
                addButton({ id:"T", name:"한글통합검색", src:"tr_searchFormT" });
                addButton({ id:"V", name:"영문통합검색", src:"tr_searchFormV" });
                goTab(0);
            </COMMENT></ANY:TAB>
            <TABLE border="0" cellspacing="1" cellpadding="2" class="main">
                <TR id="tr_searchFormT">
                    <TD class="conddata">
                        <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                            <TR>
                                <TD vAlign="top" width="70px">
                                    <ANY:CHECK id="chk_searchAllT" text="전체" style="font-weight:bold;" onClick="javascript:fnCheckAll();" />
                                </TD>
                                <TD vAlign="top">
                                    <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                                        <TR>
                                            <TD><ANY:CHECK id="chk_searchGroupT" text="한국" group="KR" style="font-weight:bold;" onClick="javascript:fnCheckGroup(this);" /></TD>
                                            <TD><ANY:CHECK id="chk_searchItemT" text="특허공개" checkValue="K1" group="KR" checked /></TD>
                                            <TD><ANY:CHECK id="chk_searchItemT" text="실용공개" checkValue="K2" group="KR" checked /></TD>
                                            <TD><ANY:CHECK id="chk_searchItemT" text="특허공고/등록" checkValue="K3" group="KR" /></TD>
                                            <TD><ANY:CHECK id="chk_searchItemT" text="실용공고/등록" checkValue="K4" group="KR" /></TD>
                                        </TR>
                                        <TR>
                                            <TD><ANY:CHECK id="chk_searchGroupT" text="일본" group="JP" style="font-weight:bold;" onClick="javascript:fnCheckGroup(this);" /></TD>
                                            <TD><ANY:CHECK id="chk_searchItemT" text="특허공개" checkValue="J1" group="JP" checked /></TD>
                                            <TD><ANY:CHECK id="chk_searchItemT" text="실용공개" checkValue="J2" group="JP" checked /></TD>
                                            <TD colspan="2"><ANY:CHECK id="chk_searchItemT" text="등록실용(1994년이후발행)" checkValue="J5" group="JP" /></TD>
                                        </TR>
                                        <TR>
                                            <TD></TD>
                                            <TD><ANY:CHECK id="chk_searchItemT" text="특허공고/등록" checkValue="J6" group="JP" /></TD>
                                            <TD><ANY:CHECK id="chk_searchItemT" text="실용공고/등록" checkValue="J7" group="JP" /></TD>
                                            <TD><ANY:CHECK id="chk_searchItemT" text="특허공개(공표)" checkValue="J3" group="JP" /></TD>
                                            <TD><ANY:CHECK id="chk_searchItemT" text="특허공개(재공표)" checkValue="J4" group="JP" /></TD>
                                        </TR>
                                    </TABLE>
                                </TD>
                                <TD align="right" vAlign="top" style="padding:0px 10px 0px 20px;">
                                    <TABLE border="0" cellpadding="0" cellspacing="0">
                                        <TR>
                                            <TD>
                                                <ANY:RADIO id="rdo_volumeT" codeData="/ipbiz/wipsSearchVolume" value="SUM" style="width:1px;" />
                                            </TD>
                                        </TR>
                                        <TR>
                                            <TD noWrap style="padding-left:4px;">
                                                구간 지정:
                                                <ANY:SELECT id="sel_dateFilterT" codeData="/ipbiz/wipsDateFilter" firstName="all" style="width:100px;" />
                                            </TD>
                                        </TR>
                                    </TABLE>
                                </TD>
                            </TR>
                        </TABLE>
                    </TD>
                </TR>
                <TR id="tr_searchFormV" style="display:none;">
                    <TD class="conddata">
                        <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                            <TR>
                                <TD vAlign="top" width="70px">
                                    <ANY:CHECK id="chk_searchAllV" text="전체" style="font-weight:bold;" onClick="javascript:fnCheckAll();" />
                                </TD>
                                <TD vAlign="top">
                                    <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                                        <TR>
                                            <TD><ANY:CHECK id="chk_searchGroupV" text="미국" group="US" style="font-weight:bold;" onClick="javascript:fnCheckGroup(this);" /></TD>
                                            <TD><ANY:CHECK id="chk_searchItemV" text="공개" checkValue="U1" group="US" /></TD>
                                            <TD><ANY:CHECK id="chk_searchItemV" text="등록" checkValue="U2" group="US" checked /></TD>
                                        </TR>
                                        <TR>
                                            <TD><ANY:CHECK id="chk_searchGroupV" text="EP" group="EP" style="font-weight:bold;" onClick="javascript:fnCheckGroup(this);" /></TD>
                                            <TD><ANY:CHECK id="chk_searchItemV" text="EP-A" checkValue="E1" group="EP" checked /></TD>
                                            <TD><ANY:CHECK id="chk_searchItemV" text="EP-B" checkValue="E2" group="EP" /></TD>
                                        </TR>
                                        <TR>
                                            <TD><ANY:CHECK id="chk_searchItemV" text="PCT" checkValue="W1" style="font-weight:bold;" /></TD>
                                            <TD></TD>
                                            <TD></TD>
                                        </TR>
                                    </TABLE>
                                </TD>
                                <TD vAlign="top" style="padding-left:50px;">
                                    <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                                        <TR>
                                            <TD colspan="5"><ANY:CHECK id="chk_searchItemV" text="일본 PAJ<SPAN style='font-weight:normal;'>(Patent Abstract of Japan) - 영문요약</SPAN>" checkValue="P1" style="font-weight:bold;" /></TD>
                                        </TR>
                                        <TR>
                                            <TD><ANY:CHECK id="chk_searchGroupV" text="G-Pat" group="GP" style="font-weight:bold;" onClick="javascript:fnCheckGroup(this);" /></TD>
                                            <TD><ANY:CHECK id="chk_searchItemV" text="독일" checkValue="G2" group="GP" /></TD>
                                            <TD><ANY:CHECK id="chk_searchItemV" text="영국" checkValue="G4" group="GP" /></TD>
                                            <TD><ANY:CHECK id="chk_searchItemV" text="프랑스" checkValue="G3" group="GP" /></TD>
                                            <TD><ANY:CHECK id="chk_searchItemV" text="스위스" checkValue="G1" group="GP" /></TD>
                                        </TR>
                                    </TABLE>
                                </TD>
                                <TD align="right" vAlign="top" style="padding:0px 10px 0px 20px;">
                                    <TABLE border="0" cellpadding="0" cellspacing="0">
                                        <TR>
                                            <TD>
                                                <ANY:RADIO id="rdo_volumeV" codeData="/ipbiz/wipsSearchVolume" value="SUM" style="width:1px;" />
                                            </TD>
                                        </TR>
                                        <TR>
                                            <TD noWrap style="padding-left:4px;">
                                                구간 지정:
                                                <ANY:SELECT id="sel_dateFilterV" codeData="/ipbiz/wipsDateFilter" firstName="all" style="width:100px;" />
                                            </TD>
                                        </TR>
                                    </TABLE>
                                </TD>
                            </TR>
                        </TABLE>
                    </TD>
                </TR>
                <TR>
                    <TD class="conddata">
                        <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                            <TR>
                                <TD>
                                    <TEXTAREA id="txt_query" rows="3"></TEXTAREA>
                                </TD>
                                <TD width="1">
                                    <BUTTON text="검색식 조회" onClick="javascript:fnQuerySearch();" height="22px"></BUTTON>
                                    <BUTTON text="검색식 저장" onClick="javascript:fnQuerySave();" height="22px" style="margin-top:2px;"></BUTTON>
                                </TD>
                            </TR>
                        </TABLE>
                    </TD>
                </TR>
                <TR>
                    <TD class="condhead" style="text-align:center;">
                        <TABLE border="0" cellspacing="0" cellpadding="0">
                            <TR>
                                <TD>공개일자/등록일자 :</TD>
                                <TD style="padding-left:4px;">
                                    <ANY:DATE id="txt_searchDate1" />&nbsp;~
                                    <ANY:DATE id="txt_searchDate2" />
                                </TD>
                                <TD style="padding-left:10px;">
                                    <ANY:CHECK id="chk_searchDateApply" text="적용" />
                                </TD>
                                <TD style="padding-left:20px;">
                                    <BUTTON auto="search" onClick="javascript:fnSearch();"></BUTTON>
                                </TD>
                            </TR>
                        </TABLE>
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD height="5"></TD>
    </TR>
    <TR>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD><SPAN id="spn_gridMessage"></SPAN></TD>
                    <TD align="right">
                        <BUTTON text="선택특허 일괄보기" onClick="javascript:fnFilmView();"></BUTTON>
                        <BUTTON text="대표도면 일괄보기" onClick="javascript:fnRImageView();"></BUTTON>
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD height="5"></TD>
    </TR>
    <TR>
        <TD height="100%">
            <ANY:GRID id="gr_searchList" pagingType="2"><COMMENT>
                addColumn({ width:50 , align:"center", type:"number", sort:false, id:"NO"           , name:"No" });
                addColumn({ width:30 , align:"center", type:"check" , sort:false, id:"ROW_CHK" });
                addColumn({ width:110, align:"center", type:"string", sort:false, id:"AN"           , name:"출원번호" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:false, id:"AD"           , name:"출원일" });
                addColumn({ width:300, align:"left"  , type:"string", sort:false, id:"TL"           , name:"발명의 명칭" });
                messageSpan = "spn_gridMessage";
                setFixedColumn("NO", "AN");
                addAction("AN", fnGoView);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
