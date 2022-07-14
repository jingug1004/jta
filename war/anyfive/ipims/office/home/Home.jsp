<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.office.common.app.OfficeApp"%><% OfficeApp app = new OfficeApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>Home</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_boardConfig" />
<ANY:DS id="ds_boardList" />
<ANY:DS id="ds_recentList_NEW_PAPER" />
<ANY:DS id="ds_recentList_INT_RECEIPT" />
<ANY:DS id="ds_recentList_EXT_RECEIPT" />
<LINK rel="StyleSheet" type="text/css" href="style.css">
<style type="text/css">
.table_header_line {
    background-color: #AAAAAA;
    height: 1px;
}

.table_middle_line {
    background-color: #DDDDDD;
    height: 1px;
}

.tab_titleon {
    font-family: "Tahoma";
    font-size: 11px;
    font-weight: bold;
    color: #216B84;
}

.table_padding {
    background-color: #FFF;
    padding: 1px 2px 1px 2px;
    height: 22px;
}

a:link {
    text-decoration: none;
    color: #353535;
}

a:visited {
    text-decoration: none;
    color: #777;
}

a:active {
    text-decoration: none;
    color: #0000CC;
}

a:hover {
    text-decoration: none;
    color: #155F9E;
}
</style>
<SCRIPT language="JScript">
var gBoardConfig;

//윈도우 로딩시
window.onready = function()
{
    fnRetrieveRecentList(tbd_recentList1, "NEW_PAPER");
    fnRetrieveRecentList(tbd_recentList2, "INT_RECEIPT");
    fnRetrieveRecentList(tbd_recentList3, "EXT_RECEIPT");
}

//게시판 설정 조회
function fnRetrieveBoardConfig()
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.share.board.act.RetrieveBoardConfig.do";
    prx.addParam("BRD_ID", tab_board.button.brdId);
    prx.hideMessage = true;

    prx.onStart = function()
    {
        fnClearTbodyRows(tbd_boardList, true);
    }

    prx.onSuccess = function()
    {
        gBoardConfig = new Object();
        for (var c = 0; c < ds_boardConfig.colCount; c++) {
            gBoardConfig[ds_boardConfig.colId(c)] = ds_boardConfig.value(0, c);
        }
        fnRetrieveBoardList();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//게시판 목록 조회
function fnRetrieveBoardList()
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.office.home.act.RetrieveHomeBoardList.do";
    prx.addParam("BRD_ID", tab_board.button.brdId);
    prx.hideMessage = true;

    prx.onStart = function()
    {
        fnClearTbodyRows(tbd_boardList, true);
    }

    prx.onSuccess = function()
    {
        fnClearTbodyRows(tbd_boardList);
        fnCreateBoardList();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//게시판 목록 생성
function fnCreateBoardList()
{
    var ds = ds_boardList;
    var tr, td;
    var a;

    for (var r = 0; r < ds.rowCount; r++) {
        tr = tbd_boardList.insertRow();
        tr.style.paddingTop = "5px";

        td = tr.insertCell();
        td.width = "1px";
        td.vAlign = "center";
        td.innerHTML = '<IMG src="image/main_bullet.gif">';

        td = tr.insertCell();
        td.width = "75px";
        td.align = "center";
        td.vAlign = "top";
        td.noWrap = true;
        td.innerText = cfGetFormatDate(ds.value(r, "CRE_DATE"));

        td = tr.insertCell();
        td.vAlign = "top";
        a = document.createElement('<A href="javascript:fnOpenBoard(' + r + ');">');
        a.innerText = (ds.value(r, "RE_LEVEL") == "0" ? "" : "[RE] ") + ds.value(r, "SUBJECT");
        td.appendChild(a);
    }
}

//게시판 상세
function fnOpenBoard(row)
{
    var win = new any.window(2);
    win.path = top.getRoot() + "/anyfive/ipims/share/board/BoardRD.jsp";
    win.arg.brdConfig = gBoardConfig;
    win.arg.readCntAdd = 1;
    win.arg.BRD_NO = ds_boardList.value(row, "BRD_NO");
    win.opt.resizable = "yes";

    win.onReload = function()
    {
        fnRetrieveBoardList();
    }

    win.show();
}

//신규 목록 조회
function fnRetrieveRecentList(tbd, recentId)
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.office.home.act.RetrieveHomeRecentList.do";
    prx.addParam("RECENT_ID", recentId);
    prx.hideMessage = true;

    prx.onStart = function()
    {
        fnClearTbodyRows(tbd, true);
    }

    prx.onSuccess = function()
    {
        fnClearTbodyRows(tbd);
        fnCreateRecentList(tbd, recentId);
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//신규 목록 생성
function fnCreateRecentList(tbd, recentId)
{
    var ds = document.getElementById("ds_recentList_" + recentId);
    var tr, td;
    var a;

    for (var r = 0; r < ds.rowCount; r++) {
        tr = tbd.insertRow();
        tr.style.paddingTop = "5px";

        td = tr.insertCell();
        td.width = "1px";
        td.vAlign = "center";
        td.innerHTML = '<IMG src="image/main_bullet.gif">';

        td = tr.insertCell();
        td.width = "75px";
        td.align = "center";
        td.vAlign = "top";
        td.noWrap = true;
        td.innerText = cfGetFormatDate(ds.value(r, "LIST_DATE"));

        if (ds.colIndex("LIST_STATUS") != -1) {
            td = tr.insertCell();
            td.width = "55px";
            td.align = "left";
            td.vAlign = "top";
            td.noWrap = true;
            td.innerText = "[" + ds.value(r, "LIST_STATUS") + "]";
        }

        td = tr.insertCell();
        td.vAlign = "top";

        a = document.createElement('<A href="javascript:fnOpenRecent(' + r + ', \'' + recentId + '\');">');
        a.innerText = ds.value(r, "LIST_TITLE");
        td.appendChild(a);
    }
}

//신규 상세
function fnOpenRecent(row, recentId)
{

    var ds = document.getElementById("ds_recentList_" + recentId);

    var refId = ds.value(row, "REF_ID");
    var listSeq = ds.value(row, "LIST_SEQ");
    var olId = ds.value(row, "OL_ID");
    var grpId = ds.value(row, "GRP_ID");

    var win = new any.window(2);

    switch (recentId) {
    case "NEW_PAPER":
        win.path = top.getRoot() + "/anyfive/ipims/share/docpaper/docpaper/DocPaperM.jsp";
        win.arg.REF_ID = refId;
        win.arg.LIST_SEQ = listSeq;
        break;
    case "INT_RECEIPT":
        win.path = top.getRoot() + "/anyfive/ipims/office/reqreceipt/intapply/IntApplyReceiptU.jsp";
        win.arg.REF_ID = refId;
        break;
    case "EXT_RECEIPT":
        win.path = top.getRoot() + "/anyfive/ipims/office/reqreceipt/extapply/ExtApplyReceiptU.jsp";
        win.arg.OL_ID  = olId;
        win.arg.GRP_ID = grpId;
        break;
    }

    win.opt.resizable = "yes";

    win.onReload = function()
    {
        fnRetrieveRecentList(tbd_recentList1, recentId );
        fnRetrieveRecentList(tbd_recentList2, recentId );
        fnRetrieveRecentList(tbd_recentList3, recentId );
    }

    win.show();
}

//TBODY Row 삭제
function fnClearTbodyRows(tbd, isLoading)
{
    if (tbd == null) return;

    for (var r = tbd.rows.length - 1; r >= 0; r--) {
        tbd.deleteRow(r);
    }

    if (isLoading != true) return;

    var tr, td;

    tr = tbd.insertRow();

    td = tr.insertCell();
    td.style.padding = "5px";
    td.innerText = "Loading...";
}
</SCRIPT>

<!-- 공지사항 탭 변경시 -->
<SCRIPT language="JScript" for="tab_board" event="OnChange()">
    fnRetrieveBoardConfig();
</SCRIPT>
</HEAD>

<BODY style="padding:15px">

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
    <TR>
        <TD width="172" height="370" valign="top"><IMG src="image/office.gif" width="172" height="370"></TD>
        <TD width="20"></TD>
        <TD valign="top" height="370">
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD valign="top" width="50%" height="185">
                        <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                            <TR>
                                <TD>
                                    <ANY:TAB id="tab_board"><COMMENT>
                                        addButton({ name:"공지사항", brdId:"OFF_NOTICE" });
                                        addButton({ name:"Q&A", brdId:"OFF_QNA" });
                                        addButton({ name:"자료실", brdId:"OFF_DATA" });
                                        goTab(0);
                                    </COMMENT></ANY:TAB>
                                </TD>
                                <TD width="1" background="<%= request.getContextPath() %>/anyfive/framework/htc/anyworks/image/tab_blank.gif" style="padding-left:5px;">
                                    <A href="javascript:parent.any_menuLeft.go(gBoardConfig.MENU_CODE);"><IMG src="image/icon_more.gif" border="0"></A>
                                </TD>
                            </TR>
                        </TABLE>
                        <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                            <TBODY id="tbd_boardList"></TBODY>
                        </TABLE>
                    </TD>
                    <TD width="20"><IMG src="<%= request.getContextPath() %>/anyfive/framework/img/blank.gif" style="width:20px; height:1px;"></TD>
                    <TD valign="top" width="50%" height="185">
                        <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                            <TR>
                                <TD>
                                    <TABLE border="0" cellpadding="0" cellspacing="0" width="100%">
                                        <TR>
                                            <TD class="tab_titleon" width="1"><IMG src="image/icon_bar.gif" width="15" height="15"></IMG></TD>
                                            <TD class="tab_titleon">&nbsp;신규요청<BR></TD>
                                            <TD width="1" background="<%= request.getContextPath() %>/anyfive/framework/htc/anyworks/image/tab_blank.gif" style="padding-left:5px;">
                                                <A href="javascript:parent.any_menuLeft.go('/anyfive/ipims/office/applymgt/docpaperlist/RecentDocPaperListR.jsp');"><IMG src="image/icon_more.gif" border="0"></A>
                                            </TD>
                                        </TR>
                                        <TR class="table_header_line">
                                            <TD colspan="3"></TD>
                                        </TR>
                                        <TR class="table_middle_line">
                                            <TD colspan="3"></TD>
                                        </TR>
                                        <TR>
                                            <TD colspan="3" height="2"></TD>
                                        </TR>
                                        <TR class="table_padding">
                                            <TD colspan="3" height="5"></TD>
                                        </TR>
                                    </TABLE>
                                </TD>
                            </TR>
                        </TABLE>
                        <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                            <TBODY id="tbd_recentList1"></TBODY>
                        </TABLE>
                    </TD>
                </TR>
                <TR>
                    <TD valign="top" width="50%" height="185">
                        <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                            <TR>
                                <TD height="20"></TD>
                            </TR>
                            <TR>
                                <TD>
                                    <TABLE border="0" cellpadding="0" cellspacing="0" width="100%">
                                        <TR>
                                            <TD class="tab_titleon" width="1"><IMG src="image/icon_bar.gif" width="15" height="15"></IMG></TD>
                                            <TD class="tab_titleon">&nbsp;국내접수</TD>
                                            <TD width="1" background="<%= request.getContextPath() %>/anyfive/framework/htc/anyworks/image/tab_blank.gif" style="padding-left:5px;">
                                                <A href="javascript:parent.any_menuLeft.go('/anyfive/ipims/office/reqreceipt/intapply/IntApplyReceiptListR.jsp');"><IMG src="image/icon_more.gif" border="0"></A>
                                            </TD>
                                        </TR>
                                        <TR class="table_header_line">
                                            <TD colspan="3"></TD>
                                        </TR>
                                        <TR class="table_middle_line">
                                            <TD colspan="3"></TD>
                                        </TR>
                                        <TR>
                                            <TD colspan="3" height="2"></TD>
                                        </TR>
                                        <TR class="table_padding">
                                            <TD colspan="3" height="5"></TD>
                                        </TR>
                                    </TABLE>
                                </TD>
                            </TR>
                        </TABLE>
                        <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                            <TBODY id="tbd_recentList2"></TBODY>
                        </TABLE>
                    </TD>
                    <TD width="20"><IMG src="<%= request.getContextPath() %>/anyfive/framework/img/blank.gif" style="width:20px; height:1px;"></TD>
                    <TD valign="top" width="50%" height="185">
                        <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                            <TR>
                                <TD height="20"></TD>
                            </TR>
                            <TR>
                                <TD>
                                    <TABLE border="0" cellpadding="0" cellspacing="0" width="100%">
                                        <TR>
                                            <TD class="tab_titleon" width="1"><IMG src="image/icon_bar.gif" width="15" height="15"></IMG></TD>
                                            <TD class="tab_titleon">&nbsp;해외접수<BR></TD>
                                            <TD width="1" background="<%= request.getContextPath() %>/anyfive/framework/htc/anyworks/image/tab_blank.gif" style="padding-left:5px;">
                                                <A href="javascript:parent.any_menuLeft.go('/anyfive/ipims/office/reqreceipt/extapply/ExtApplyReceiptListR.jsp');"><IMG src="image/icon_more.gif" border="0"></A>
                                            </TD>
                                        </TR>
                                        <TR class="table_header_line">
                                            <TD colspan="3"></TD>
                                        </TR>
                                        <TR class="table_middle_line">
                                            <TD colspan="3"></TD>
                                        </TR>
                                        <TR>
                                            <TD colspan="3" height="2"></TD>
                                        </TR>
                                        <TR class="table_padding">
                                            <TD colspan="3" height="5"></TD>
                                        </TR>
                                    </TABLE>
                                </TD>
                            </TR>
                        </TABLE>
                        <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                            <TBODY id="tbd_recentList3"></TBODY>
                        </TABLE>
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
</TABLE>
</BODY>
</HTML>
