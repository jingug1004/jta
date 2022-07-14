<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>자사특허검색</TITLE>
<% app.writeHTMLHeader(); %>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    document.getElementById("__BODY_MAIN_DIV__").style.overflowY = "scroll";

    fnMakeSearchItem();

    SEARCH_ITEM_CHECK.value = any.getCookie("SEARCH_ITEM_CHECK");

    if (SEARCH_ITEM_CHECK.value == "") {
        SEARCH_ITEM_CHECK.checkAll(true);
    }
}

//검색항목 생성
function fnMakeSearchItem()
{
    var tr, td, ctrl1, ctrl2;
    var codeDataObjects = [];

    var searchItems = any.getCodeData("/search/searchItem");

    for (var i = 0; i < searchItems.length; i++) {
        tr = tbd_searchItem.insertRow();
        tr.id = "tr_searchItem";
        tr.cond = searchItems[i].data.CODE;
        tr.style.display = "none";

        td = tr.insertCell();
        td.innerText = searchItems[i].data.NAME;

        td = tr.insertCell();
        if (searchItems[i].data.TYPE == "TEXTAREA") {
            ctrl1 = td.appendChild(document.createElement('<TEXTAREA id="KEYWORD" cond="' + searchItems[i].data.CODE + '" class="text">'));
        }
        if (searchItems[i].data.TYPE == "TEXT" || searchItems[i].data.TYPE == "DATE") {
            ctrl1 = td.appendChild(document.createElement('<INPUT type="text" id="KEYWORD" cond="' + searchItems[i].data.CODE + '" class="text">'));
        }

        td = tr.insertCell();
        if (searchItems[i].data.TYPE != "DATE") {
            ctrl2 = td.appendChild(document.createElement('<ANY:SELECT id="OPERATOR" cond="' + searchItems[i].data.CODE + '" codeData2="{SEARCH_OPERATOR}" style="width:50px;" />'));
            codeDataObjects.push(ctrl2);
        }

        td = tr.insertCell();
        switch (searchItems[i].data.CODE) {
        case "ALL":
            td.innerHTML = 'ex) 모든 조건 검색 가능 : "RFID"'; break;
        case "KW":
            td.innerHTML = 'ex) 구문으로 검색을 할 경우 : "휴대폰 케이스"<BR>(구문검색 범위 : 발명의명칭, 초록, 청구범위)'; break;
        case "TL":
            td.innerHTML = 'ex) 휴대폰 케이스, 전자*화폐<BR>"휴대폰 케이스"'; break;
        case "AB":
            td.innerHTML = 'ex) 자동차 + 클러치,<BR>"데이터 신호"'; break;
        case "CL":
            td.innerHTML = 'ex) 자동차 + 클러치,<BR>"디스크 표면"'; break;
        case "IPC":
            td.innerHTML = 'ex) G06Q + H04Q'; break;
        case "AN":
            td.innerHTML = 'ex) 10-2002-12345'; break;
        case "OPN":
            td.innerHTML = 'ex) 10-2002-12345'; break;
        case "GN":
            td.innerHTML = 'ex) 10-12345'; break;
        case "RN":
            td.innerHTML = 'ex) KR2020090030648'; break;
        case "AD":
            td.innerHTML = 'ex) 20090101~20090131'; break;
        case "OPD":
            td.innerHTML = 'ex) 20090101~20090131'; break;
        case "GD":
            td.innerHTML = 'ex) 20090101~20090131'; break;
        case "RD":
            td.innerHTML = 'ex) 20090131, 정확한 일자만 검색가능'; break;
        case "IN":
            td.innerHTML = 'ex) 연구소'; break;
        case "AG":
            td.innerHTML = 'ex) 김철수'; break;
        case "FILES":
            td.innerHTML = 'ex) 특허'; break;
        }
    }

    any.setCodeDataObjects(codeDataObjects);
}

//검색
function fnSearch()
{
    var keywords = document.getElementsByName("KEYWORD");

    var andKeywords = [];
    var orKeywords = [];
    var etcKeywords = {};

    for (var i = 0; i < keywords.length; i++) {
        if (keywords[i].parentElement.parentElement.style.display == "none") continue;
        if (keywords[i].value.trim() == "") continue;

        switch (getOperator(keywords[i].cond)) {
        case "AND":
            andKeywords.push(keywords[i].cond + "=" + keywords[i].value.trim());
            break;
        case "OR":
            orKeywords.push(keywords[i].cond + "=" + keywords[i].value.trim());
            break;
        default:
            etcKeywords[keywords[i].cond] = keywords[i].value.trim();
            break;
        }
    }

    function getOperator(cond)
    {
        var operators = document.getElementsByName("OPERATOR");

        for (var i = 0; i < operators.length; i++) {
            if (operators[i].cond == cond) return operators[i].value;
        }
    }

    if (andKeywords.length == 0 && orKeywords.length == 0) {
        alert("검색어를 입력하세요.");
        for (var i = 0; i < keywords.length; i++) {
            if (keywords[i].parentElement.parentElement.style.display == "none") continue;
            keywords[i].focus();
            break;
        }
        return;
    }

    var win = new any.viewer();
    win.path = "OurSearchList.jsp";
    win.arg.state = SEARCH_RANGE.value;
    win.arg.andKeyword = andKeywords.join("^");
    win.arg.orKeyword = orKeywords.join("^");
    win.arg.etcKeywords = etcKeywords;
    win.show();
}

//검색항목 설정 표시/숨김
function fnShowHideSearchItem()
{
    tbl_searchItem.style.display = (tbl_searchItem.style.display == "none" ? "block" : "none");
}
</SCRIPT>

<!-- 검색항목 체크 변경시 -->
<SCRIPT language="JScript" for="SEARCH_ITEM_CHECK" event="OnChange()">
    var items = document.getElementsByName("tr_searchItem");
    for (var i = 0; i < items.length; i++) {
        items[i].style.display = (this.checked(items[i].cond) == true ? "block" : "none");
    }
    any.setCookie("SEARCH_ITEM_CHECK", this.value, 999);
</SCRIPT>

<!-- 검색어 입력시 -->
<SCRIPT language="JScript" for="KEYWORD" event="onkeypress()">
    if (event.keyCode != 13) return;
    event.keyCode = 0;
    fnSearch();
</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" style="margin-bottom:5px;">
    <TR>
        <TD><IMG src="img/btn_select_open.gif" style="cursor:hand;" onClick="javascript:fnShowHideSearchItem();" /></TD>
        <TD align="right">
            <TABLE border="0" cellspacing="0" cellpadding="0">
                <TR>
                    <TD>출원/등록상태 :&nbsp;</TD>
                    <TD><ANY:SELECT id="SEARCH_RANGE" codeData="{SEARCH_RANGE}" style="width:65px;" firstName="all" /></TD>
                    <TD>
                        <BUTTON auto="line"></BUTTON>
                        <BUTTON auto="search" onClick="javascript:fnSearch();"></BUTTON>
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
</TABLE>

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" id="tbl_searchItem" style="border:#CECECE 1px solid; margin-bottom:10px; display:none;">
    <TR>
        <TD style="padding:5px;">
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD>검색항목설정 창 입니다. 아래 선택 및 해제를 하실수 있습니다.</TD>
                    <TD align="right">
                        <IMG src="img/btn_select_all.gif" style="cursor:hand;" onClick="javascript:SEARCH_ITEM_CHECK.checkAll(true);" />
                        <IMG src="img/btn_select_none.gif" style="cursor:hand;" onClick="javascript:SEARCH_ITEM_CHECK.checkAll(false);" />
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD height="1px" bgColor="#BCCADF"></TD>
    </TR>
    <TR>
        <TD height="2px" bgColor="#EAEEF2"></TD>
    </TR>
    <TR>
        <TD style="padding:5px;">
            <ANY:CHECKMULTI id="SEARCH_ITEM_CHECK" codeData="/search/searchItem" cols="4" />
        </TD>
    </TR>
</TABLE>

<TABLE border="0" cellspacing="1" cellpadding="2" class="main">
    <COLGROUP>
        <COL class="conthead" width="220px">
        <COL class="contdata" width="*">
        <COL class="contdata" width="1px">
        <COL class="contdata" width="260px">
    </COLGROUP>
    <TBODY id="tbd_searchItem"></TBODY>
</TABLE>

<DIV class="button_area">
    <BUTTON auto="search" onClick="javascript:fnSearch();"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
