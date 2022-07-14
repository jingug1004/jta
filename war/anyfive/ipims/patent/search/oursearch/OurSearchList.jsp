<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<%@page import="any.core.config.NConfig"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>자사특허검색</TITLE>
<% app.writeHTMLHeader(); %>
<STYLE type="text/css">
A:link {text-decoration: none; color: #336699; }
A:visited {text-decoration: none; color: #336699; }
A:active {text-decoration: none; color: #336699; }
A:hover {text-decoration: none; color: #336699; }
</STYLE>
<ANY:DS id="ds_main" />
<SCRIPT language="JScript">
var gPageInfo;
var gResult;

//윈도우 로딩시
window.onready = function()
{
    document.getElementById("__BODY_MAIN_DIV__").style.overflowY = "scroll";

    SEARCH_RANGE.value = parent.state;

    fnSearch(parent.keywordArray);
}

//검색
function fnSearch()
{
    gPageInfo = {};

    gPageInfo.pageSize = parseInt(PAGE_SIZE.value, 10);
    gPageInfo.pageNo = parseInt(PAGE_NO.value, 10);

    var searchText = [];

    if (parent.andKeyword != null && parent.andKeyword != "") {
        if (parent.SEARCH_TEXT != null && parent.SEARCH_TEXT != "") {
            searchText.push("(" + "ALL="+parent.SEARCH_TEXT + ").AND");
        } else {
            searchText.push("(" + parent.andKeyword + ").AND");
        }
    }
    if (parent.orKeyword != null && parent.orKeyword != "") {
        searchText.push("(" + parent.orKeyword + ").OR");
    }
    for (var item in parent.etcKeywords) {
        searchText.push("(" + parent.etcKeywords[item] + ")." + item);
    }

    if (searchText.length == 0) {
        parent.andKeyword = "ALL=" + SEARCH_KEYWORD.value.trim();
        searchText.push("(" + parent.andKeyword + ").AND");
    }

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.search.oursearch.act.RetrieveOurSearchList.do";
    prx.addParam("STATE", parent.state);
    if (parent.SEARCH_TEXT != null && parent.SEARCH_TEXT != "") {
        prx.addParam("AND_KEYWORD", 'ALL='+parent.SEARCH_TEXT);
    } else {
        prx.addParam("AND_KEYWORD", parent.andKeyword);
    }
    prx.addParam("OR_KEYWORD", parent.orKeyword);
    for (var item in parent.etcKeywords) {
        prx.addParam(item, parent.etcKeywords[item]);
    }
    prx.addParam("PAGE_SIZE", gPageInfo.pageSize);
    prx.addParam("PAGE_NO", gPageInfo.pageNo);
    prx.addParam("TEXT_SEARCH", parent.TEXT_SEARCH);
    prx.addParam("MAX_SIZE", parent.MAX_SIZE);

    prx.hideMessage = true;

    prx.onStart = function()
    {
        a_searchKeyword.innerText = searchText.join("+");

        if (SEARCH_ITEM.value == "") {
            SEARCH_KEYWORD.value = a_searchKeyword.innerText;
        }

        fnCreateMessage('<IMG src="' + top.getRoot() + '/anyfive/framework/body/BodyMessage.gif" style="filter:gray();">');
    }

    prx.onSuccess = function()
    {
        gResult = eval("(" + prx.result + ")");

        gPageInfo.totalCount = parseInt(gResult.info.TOTAL_SIZE, 10);
        gPageInfo.totalPage = parseInt((gPageInfo.totalCount - 1) / gPageInfo.pageSize, 10) + 1;

        spn_totalCount.innerText = cfGetFormatNumber(gPageInfo.totalCount);
        spn_totalPage.innerText = gPageInfo.totalPage;

        ds_main.load(gResult.data);

        if (ds_main.rowCount == 0) {
            fnCreateMessage('(검색결과가 존재하지 않습니다)');
        } else {
            fnCreateList();
        }

        SEARCH_KEYWORD.focus();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//키워드 검색
function fnSearchByKeyword()
{
    if (SEARCH_KEYWORD.value.trim() == "") {
        alert("검색어를 입력하세요.");
        SEARCH_KEYWORD.focus();
        return;
    }

    parent.state = SEARCH_RANGE.value;
    parent.andKeyword = null;
    parent.orKeyword = null;
    parent.etcKeywords = {};

    if (SEARCH_ITEM.value == "") {
        var searchKeywords = SEARCH_KEYWORD.value.split("+");
        var searchKeyword;
        for (var i = 0; i < searchKeywords.length; i++) {
            searchKeyword = searchKeywords[i].trim();
            if (searchKeyword.indexOf("(") == -1 || searchKeyword.indexOf(").") == -1) continue;
            switch (searchKeyword.substr(searchKeyword.lastIndexOf(".") + 1).toUpperCase()) {
            case "AND":
                parent.andKeyword = searchKeyword.substr(searchKeyword.indexOf("(") + 1, searchKeyword.toUpperCase().lastIndexOf(").AND") - 1);
                break;
            case "OR":
                parent.orKeyword = searchKeyword.substr(searchKeyword.indexOf("(") + 1, searchKeyword.toUpperCase().lastIndexOf(").OR") - 1);
                break;
            default:
                parent.etcKeywords[searchKeyword.substr(searchKeyword.lastIndexOf(").") + 2)] = searchKeyword.substr(searchKeyword.indexOf("(") + 1, searchKeyword.lastIndexOf(").") - 1);
                break;
            }
        }
    } else {
        if (SEARCH_ITEM.value(null, "TYPE") == "DATE") {
            parent.etcKeywords[SEARCH_ITEM.value] = SEARCH_KEYWORD.value.trim();
        } else {
            parent.andKeyword = SEARCH_ITEM.value + "=" + SEARCH_KEYWORD.value.trim();
        }
    }

    PAGE_NO.value = 1;

    fnSearch();
}

//메세지 생성
function fnCreateMessage(msg)
{
    var tbd = document.getElementById(tab_main.button.src).firstChild;

    for (var i = tbd.rows.length - 1; i >= 0; i--) {
        tbd.deleteRow(i);
    }

    var tr, td;

    tr = tbd.insertRow();

    td = tr.insertCell();
    td.align = "center";
    td.vAlign = "bottom";
    td.height = 100;
    td.innerHTML = msg;
}

//목록 생성
function fnCreateList()
{
    if (gResult == null) return;

    var tbd = document.getElementById(tab_main.button.src).firstChild;

    for (var i = tbd.rows.length - 1; i >= 0; i--) {
        tbd.deleteRow(i);
    }

    switch(tab_main.button.id) {
    case "simple":
        fnCreateSimpleList(tbd);
        break;
    case "abstract":
        fnCreateAbstractList(tbd);
        break;
    case "image":
        fnCreateImageList(tbd);
        break;
    }
}

//라인 생성
function fnDrawLine(box)
{
    tr = box.appendChild(document.createElement('<TR>'));
    td = tr.appendChild(document.createElement('<TD>'));
    td.style.backgroundColor = "#BCCADF";
    td.height = "1px";

    switch (tab_main.button.id) {
    case "simple":
        td.colSpan = "9";
        break;
    case "abstract":
        break;
    case "image":
        td.align = "left";
        td.style.width = "100%";
        break;
    }
}

//이미지 팝업창 생성
function fnPopupResize(img)
{
    if (img.fileId == "" || img.fileId == null) {
        alert("대표도면이 없습니다");
        return;
    }

    var win = new any.window(2);
    win.path = top.getRoot() + "/anyfive/framework/file/ImageViewerR.jsp";
    win.arg.fileId = img.fileId;
    win.arg.fileSeq = img.fileSeq;
    win.arg.imgName = img.fileNameOrg;
    win.arg.imgSrc = img.src;
    win.opt.resizable = "yes";
    win.show();
}

//목록 생성 - 간략정보
function fnCreateSimpleList(box)
{
    var tr, td, div, img, a, cnt=0;

    fnDrawLine(box);

    tr = box.appendChild(document.createElement('<TR>'));
    td = tr.appendChild(document.createElement('<TD>'));
    td.style.width = "4%";
    td.align = "center";
    td.innerText = "번호";
    td = tr.appendChild(document.createElement('<TD>'));
    /*
    td.style.width = "15%";
    td.innerText = "        대표도면";
    td = tr.appendChild(document.createElement('<TD>'));*/
    td.style.width = "12%";
    td.align = "center";
    td.innerText = "출원번호";
    td = tr.appendChild(document.createElement('<TD>'));
    td.style.width = "10%";
    td.align = "center";
    td.innerText = "출원일";
    td = tr.appendChild(document.createElement('<TD>'));
    td.style.width = "10%";
    td.align = "center";
    td.innerText = "상태";
    td = tr.appendChild(document.createElement('<TD>'));
    td.style.width = "20%";
    td.align = "center";
    td.innerText = "발명의 명칭";
    td = tr.appendChild(document.createElement('<TD>'));
    td.style.width = "8%";
    td.align = "center";
    td.innerText = "IPC";
    td = tr.appendChild(document.createElement('<TD>'));
    td.style.width = "13%";
    td.align = "center";
    td.innerText = "발명자";
    td = tr.appendChild(document.createElement('<TD>'));
    td.style.width = "10%";
    td.align = "center";
    td.innerText = "등록일";
    td = tr.appendChild(document.createElement('<TD>'));
    td.style.width = "13%";
    td.align = "center";
    td.innerText = "등록번호";

    for (var i = 0; i < ds_main.rowCount; i++) {

        fnDrawLine(box);

        tr = box.appendChild(document.createElement('<TR>'));
        td = tr.appendChild(document.createElement('<TD align="center">'));
        td.innerText = (gPageInfo.pageSize * (gPageInfo.pageNo - 1) + i + 1);

        /*td = tr.appendChild(document.createElement('<TD>'));
        div = td.appendChild(document.createElement('<DIV>'));
        img = div.appendChild(document.createElement('<IMG width="120px", height="120px", align="center", border="0", alt="크게보기" onClick="javascript:fnPopupResize(this);">'));
        img.style.cursor = "hand";
        img.fileId = ds_main.value(i, "FILE_ID");
        img.fileSeq = ds_main.value(i, "FILE_SEQ");
        img.fileNameOrg = ds_main.value(i, "FILE_NAME_ORG");

        if (ds_main.value(i, "FILE_ID") == "") {
            img.src = top.getRoot() + "/anyfive.framework.file.act.DownloadFile.do?TEMPLATE_PATH=/image/noimage.gif";
        } else {
            img.src = top.getRoot() + "/anyfive.framework.file.act.DownloadFile.do?FILE_ID=" + ds_main.value(i, "FILE_ID") + "&FILE_SEQ=" + ds_main.value(i, "FILE_SEQ");
        }*/

        td = tr.appendChild(document.createElement('<TD>'));
        td.align = "center";
        a = td.appendChild(document.createElement('<A href="javascript:fnKipris(\'' + ds_main.value(i, "PAT_APP_NO") + '\');">'));
        a.innerText = ds_main.value(i, "APP_NO");

        td = tr.appendChild(document.createElement('<TD align="center">'));
        td.innerText = ds_main.value(i, "APP_DATE");

        td = tr.appendChild(document.createElement('<TD align="center">'));
        td.innerText = ds_main.value(i, "STATUS_NAME");

        td = tr.appendChild(document.createElement('<TD align="left">'));
        a = td.appendChild(document.createElement('<A href="javascript:fnMaster(\'' + ds_main.value(i, "REF_ID") + '\');">'));
        a.innerText = ds_main.value(i, "KO_APP_TITLE");

        td = tr.appendChild(document.createElement('<TD align="center">'));
        td.innerText = ds_main.value(i, "IPC_CLS_CODE");

        td = tr.appendChild(document.createElement('<TD align="center">'));
        td.innerText = ds_main.value(i, "INV_NAMES");

        td = tr.appendChild(document.createElement('<TD align="center">'));
        td.innerText = ds_main.value(i, "REG_DATE");

        td = tr.appendChild(document.createElement('<TD align="center">'));
        td.innerText = ds_main.value(i, "REG_NO");

        cnt++;
    }
    fnDrawLine(box);
}

//목록 생성 - 초록정보
function fnCreateAbstractList(box)
{
    var tbl, tbd, grp, col, tr, td, a, src;

    for (var i = 0; i < ds_main.rowCount; i++) {
        fnDrawLine(box);

        //발명의 명칭 - 링크
        tr = box.appendChild(document.createElement('<TR>'));
        td = tr.appendChild(document.createElement('<TD>'));
        a = td.appendChild(document.createElement('<A href="javascript:fnMaster(\'' + ds_main.value(i, "REF_ID") + '\');">'));
        a.innerText = (gPageInfo.pageSize * (gPageInfo.pageNo - 1) + i + 1) + ". " + ds_main.value(i, "KO_APP_TITLE");
        a.style.fontWeight = "bold";

        fnDrawLine(box);

        tr = box.appendChild(document.createElement('<TR>'));
        td = tr.appendChild(document.createElement('<TD>'));

        tbl = td.appendChild(document.createElement('<TABLE border="0" cellspacing="0" cellpadding="2">'));
        grp = tbl.appendChild(document.createElement('<COLGROUP>'));
        col = grp.appendChild(document.createElement('<COL valign="top" style="white-space:nowrap; font-weight:bold;">'));
        col = grp.appendChild(document.createElement('<COL valign="top" style="white-space:nowrap; font-weight:bold;">'));
        col = grp.appendChild(document.createElement('<COL valign="top" style="padding-left:5px;">'));
        tbd = tbl.appendChild(document.createElement('<TBODY>'));

        tr = tbd.appendChild(document.createElement('<TR>'));
        td = tr.appendChild(document.createElement('<TD rowSpan="6">'));
        /*div = td.appendChild(document.createElement('<DIV>'));
        img = div.appendChild(document.createElement('<IMG width="120px", height="120px", align="center", border="0", alt="크게보기", onClick="javascript:fnPopupResize(this);">'));
        img.style.cursor = "hand";
        img.fileId = ds_main.value(i, "FILE_ID");
        img.fileSeq = ds_main.value(i, "FILE_SEQ");
        img.fileNameOrg = ds_main.value(i, "FILE_NAME_ORG");

        if (ds_main.value(i, "FILE_ID") == "") {
            img.src = top.getRoot() + "/anyfive.framework.file.act.DownloadFile.do?TEMPLATE_PATH=/image/noimage.gif";
        } else {
            img.src = top.getRoot() + "/anyfive.framework.file.act.DownloadFile.do?FILE_ID=" + ds_main.value(i, "FILE_ID") + "&FILE_SEQ=" + ds_main.value(i, "FILE_SEQ");
        }*/

        tr = tbd.appendChild(document.createElement('<TR>'));
        td = tr.appendChild(document.createElement('<TD>'));
        td.innerText = "출원번호";
        td = tr.appendChild(document.createElement('<TD>'));
        a = td.appendChild(document.createElement('<A href="javascript:fnKipris(\'' + ds_main.value(i, "PAT_APP_NO") + '\');">'));
        a.innerText = ds_main.value(i, "APP_NO");

        tr = tbd.appendChild(document.createElement('<TR>'));
        td = tr.appendChild(document.createElement('<TD>'));
        td.innerText = "IPC";
        td = tr.appendChild(document.createElement('<TD>'));
        td.innerText = ds_main.value(i, "IPC_CLS_CODE");

        tr = tbd.appendChild(document.createElement('<TR>'));
        td = tr.appendChild(document.createElement('<TD>'));
        td.innerText = "발명자";
        td = tr.appendChild(document.createElement('<TD>'));
        td.innerText = ds_main.value(i, "INV_NAMES");

        tr = tbd.appendChild(document.createElement('<TR>'));
        td = tr.appendChild(document.createElement('<TD>'));
        td.innerText = "등록번호";
        td = tr.appendChild(document.createElement('<TD>'));
        td.innerText = ds_main.value(i, "REG_NO");

        tr = tbd.appendChild(document.createElement('<TR>'));
        td = tr.appendChild(document.createElement('<TD>'));
        td.innerText = "초록";
        td = tr.appendChild(document.createElement('<TD style="text-align:justify;">'));
        td.innerText = ds_main.value(i, "ABSTRACT");

        fnDrawLine(box);
    }
}

//목록 생성 - 대표도면
/*function fnCreateImageList(box)
{
    var totCnt, tbl, tbd, grp, col, tr, td, a, cnt=0;

    if (ds_main.rowCount > 5 && ds_main.rowCount%5 != 0) {
        totCnt = ds_main.rowCount/5 + 1;
    } else {
        totCnt = ds_main.rowCount/5;
    }

    for (var i = 0; i < totCnt; i++) {
        fnDrawLine(box);

        tr = box.appendChild(document.createElement('<TR>'));
        td = tr.appendChild(document.createElement('<TD>'));
        tbl = td.appendChild(document.createElement('<TABLE border="0" cellspacing="0" cellpadding="2">'));
        tbd = tbl.appendChild(document.createElement('<TBODY>'));
        tr_main = tbd.appendChild(document.createElement('<TR>'));

        for (var j = 0; j < 5; j++) {

            if (ds_main.rowCount == cnt) break;

            td_cnt = "td_" + cnt;
            td_main = tr_main.appendChild(document.createElement('<TD id='+td_cnt+'>'));
            tbl = td_main.appendChild(document.createElement('<TABLE border="0" cellspacing="0" cellpadding="0">'));
            tbd = tbl.appendChild(document.createElement('<TBODY>'));

            tr = tbd.appendChild(document.createElement('<TR>'));
            td = tr.appendChild(document.createElement('<TD width="30" align="right" valign="top" rowSpan="3">'));
            td.innerText = (gPageInfo.pageSize * (gPageInfo.pageNo - 1) + cnt + 1)+".  ";
            td = tr.appendChild(document.createElement('<TD width="130" align="center" rowSpan="3">'));
            tbl = td.appendChild(document.createElement('<TABLE border="0" cellspacing="0" cellpadding="0">'));
            tbd = tbl.appendChild(document.createElement('<TBODY>'));
            tr = tbd.appendChild(document.createElement('<TR>'));
            td = tr.appendChild(document.createElement('<TD>'));
            a = td.appendChild(document.createElement('<A href="javascript:fnKipris(\'' + ds_main.value(cnt, "APP_NO") + '\');">'));

            if (ds_main.value(cnt, "APP_NO") == "") {
                a.innerText = " ";
            } else {
                a.innerText = ds_main.value(cnt, "APP_NO");
            }

            tr = tbd.appendChild(document.createElement('<TR>'));
            td = tr.appendChild(document.createElement('<TD>'));
            td.innerText = ds_main.value(cnt, "IPC_CLS_CODE") + "(" + ds_main.value(cnt, "STATUS_NAME") + ")";

            tr = tbd.appendChild(document.createElement('<TR>'));
            td = tr.appendChild(document.createElement('<TD>'));
            div = td.appendChild(document.createElement('<DIV>'));
            img = div.appendChild(document.createElement('<IMG width="130px", height="130px", align="center", border="0", alt="크게보기", onClick="javascript:fnPopupResize(this);">'));
            img.style.cursor = "hand";
            img.fileId = ds_main.value(i, "FILE_ID");
            img.fileSeq = ds_main.value(i, "FILE_SEQ");
            img.fileNameOrg = ds_main.value(cnt, "FILE_NAME_ORG");

            if (ds_main.value(i, "FILE_ID") == "") {
                img.src = top.getRoot() + "/anyfive.framework.file.act.DownloadFile.do?TEMPLATE_PATH=/image/noimage.gif";
            } else {
                img.src = top.getRoot() + "/anyfive.framework.file.act.DownloadFile.do?FILE_ID=" + ds_main.value(cnt, "FILE_ID") + "&FILE_SEQ=" + ds_main.value(cnt, "FILE_SEQ");
            }

            cnt++;
        }
    }
    fnDrawLine(box);
}*/

//마스터 상세
function fnMaster(refId)
{
    window.open(top.getRoot() + "/anyfive/ipims/patent/applymgt/common/MasterView.jsp?ID=" + refId, "_blank", "width=1000,height=800,resizable=yes");
}

//KIPRIS 상세
function fnKipris(appNo)
{
    window.open("<%= NConfig.getString("/config/kipris/fulldoc-url") %>?APPLNO=" + appNo, "_blank", "width=1000,height=800,resizable=yes");
}

//검색식 입력
function fnInputSearchKeyword()
{
    SEARCH_ITEM.value = "";
    SEARCH_KEYWORD.value = a_searchKeyword.innerText;
}

//검색식 저장
function fnSaveKeyword()
{
    var win = new any.window();
    win.path = top.getRoot() + "/anyfive/ipims/patent/search/keyword/SearchKeywordCU.jsp";
    win.arg.isCreate = true;
    win.arg.SEARCH_KIND = "OUR";
    win.arg.KEYWORD = a_searchKeyword.innerText;
    win.opt.width = 500;
    win.opt.height = 250;

    win.show();
}

//검색식 보기
function fnViewKeyword()
{
    var win = new any.window();
    win.path = top.getRoot() + "/anyfive/ipims/patent/search/keyword/SearchKeywordListR.jsp";
    win.arg.SEARCH_KIND = "OUR";
    win.opt.width = 800;
    win.opt.height = 500;
    win.show();

    if (win.rtn == null) return;

    SEARCH_ITEM.value = "";
    SEARCH_KEYWORD.value = win.rtn;
    SEARCH_KEYWORD.focus();
}

//페이지 번호 이동
function fnMovePageNo(num)
{
    if (num != null) {
        if (parseInt(PAGE_NO.value, 10) + num < 1) return;
        if (parseInt(PAGE_NO.value, 10) + num > gPageInfo.totalPage) return;
        PAGE_NO.value = parseInt(PAGE_NO.value, 10) + num;
    }

    if (parseInt(PAGE_NO.value, 10) > gPageInfo.totalPage) {
        alert("페이지 번호는 " + spn_totalPage.innerText + " 이하입니다.");
        PAGE_NO.value = gPageInfo.pageNo;
        PAGE_NO.focus();
        return;
    }

    fnSearch();
}
</SCRIPT>

<!-- 탭 변경시 -->
<SCRIPT language="JScript" for="tab_main" event="OnChange()">
    fnCreateList();
</SCRIPT>

<!-- 검색항목 변경시 -->
<SCRIPT language="JScript" for="SEARCH_ITEM" event="OnChange()">
    SEARCH_KEYWORD.value = "";
    SEARCH_KEYWORD.focus();
</SCRIPT>

<!-- 검색어 입력시 -->
<SCRIPT language="JScript" for="SEARCH_KEYWORD" event="onkeypress()">
    if (event.keyCode != 13) return;
    event.keyCode = 0;
    fnSearchByKeyword();
</SCRIPT>

<!-- 페이지 크기 변경시 -->
<SCRIPT language="JScript" for="PAGE_SIZE" event="OnChange()">
    PAGE_NO.value = 1;
    fnSearch();
</SCRIPT>

<!-- 페이지 번호 입력시 -->
<SCRIPT language="JScript" for="PAGE_NO" event="onkeypress()">
    if (event.keyCode != 13) return;
    event.keyCode = 0;
    fnMovePageNo();
</SCRIPT>
<!-- 페이지 번호 변경시 -->
<SCRIPT language="JScript" for="PAGE_NO" event="onblur()">
    if (parseInt(PAGE_NO.value, 10) == gPageInfo.pageNo) return;
    fnMovePageNo();
</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="0" cellpadding="10" width="100%" style="border:#DEDEDE 1px solid; background-color:#F3F3F3; margin-bottom:10px;">
    <TR>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%" style="margin-bottom:5px;">
                <TR>
                    <TD>
                        <TABLE border="0" cellspacing="0" cellpadding="0" style="margin-bottom:5px;">
                            <TR>
                                <TD>출원/등록상태 :&nbsp;</TD>
                                <TD><ANY:SELECT id="SEARCH_RANGE" codeData="{SEARCH_RANGE}" style="width:65px;" firstName="all" /></TD>
                            </TR>
                        </TABLE>
                    </TD>
                </TR>
            </TABLE>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD width="1"><ANY:SELECT id="SEARCH_ITEM" codeData="/search/searchItem" style="width:240px;" firstName="자유검색식" /></TD>
                    <TD><INPUT type="text" id="SEARCH_KEYWORD" style="margin-left:2px;"></TD>
                    <TD width="1"><BUTTON auto="search" onClick="javascript:fnSearchByKeyword();"></BUTTON></TD>
                </TR>
            </TABLE>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%" style="margin-top:5px;">
                <TR>
                    <TD>
                        <A id="a_searchKeyword" href="javascript:fnInputSearchKeyword();"></A>
                    </TD>
                </TR>
            </TABLE>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%" style="margin-top:5px;">
                <TR>
                    <TD>
                        <IMG src="img/btn_keyword_save.gif" style="cursor:hand;" onClick="javascript:fnSaveKeyword();" />
                        <IMG src="img/btn_keyword_view.gif" style="cursor:hand;" onClick="javascript:fnViewKeyword();" />
                    </TD>
                    <TD align="right">
                        <ANY:SELECT id="PAGE_SIZE" codeData="/search/searchPageSize" style="width:115px;" />
                        &nbsp;
                        <A href="javascript:fnMovePageNo(-1);" style="font-size:20px;">◀</A
                        ><INPUT type="text" id="PAGE_NO" value="1"
                            style="width:50px; text-align:center;"
                            onFocus="this.select();"
                        ><A href="javascript:fnMovePageNo(+1);" style="font-size:20px;">▶</A
                        > Page of&nbsp;<SPAN id="spn_totalPage"></SPAN>&nbsp;Pages
                        &nbsp;
                        [ Total : <SPAN id="spn_totalCount"></SPAN>&nbsp;]
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
</TABLE>

<ANY:TAB id="tab_main"><COMMENT>
    addButton({ name:"간략정보", id:"simple"   , src:"tbl_simple" });
    addButton({ name:"초록정보", id:"abstract" , src:"tbl_abstract" });

    goTab("abstract");
</COMMENT></ANY:TAB>

<TABLE border="0" cellspacing="0" cellpadding="5" width="100%" style="display:none;" id="tbl_simple">
    <TBODY></TBODY>
</TABLE>

<TABLE border="0" cellspacing="0" cellpadding="5" width="100%" style="display:none;" id="tbl_abstract">
    <TBODY></TBODY>
</TABLE>

<!-- <TABLE border="0" cellspacing="0" cellpadding="5" width="90%" style="display:none;" id="tbl_image">
    <TBODY></TBODY>
</TABLE> -->

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
