<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.share.common.app.ShareApp"%><% ShareApp app = new ShareApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>&nbsp;</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<ANY:DS id="ds_boardConfig" />
<SCRIPT language="JScript">
var brdConfig;

//윈도우 로딩시
window.onready = function()
{
    fnRetrieveConfig();
}

//설정 조회
function fnRetrieveConfig()
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.share.board.act.RetrieveBoardConfig.do";
    if ("<%= request.getParameter("MC") %>" != "null"){
        prx.addParam("MENU_CODE", "<%= request.getParameter("MC") %>");
    }
    prx.addParam("BRD_ID",parent.brdId);


    prx.onSuccess = function()
    {
        fnSetConfig();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//목록 조회
function fnRetrieve()
{
    var ldr = gr_boardList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.share.board.act.RetrieveBoardList.do";
    ldr.addParam("BRD_ID", brdConfig.BRD_ID);
    ldr.addParam("SEARCH_KIND", SEARCH_KIND.value);
    ldr.addParam("SEARCH_TEXT", SEARCH_TEXT.value);

    ldr.onSuccess = function(gr, fg)
    {
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

//설정
function fnSetConfig()
{
    brdConfig = new Object();

    if (ds_boardConfig.rowCount == 0) {
        cfSetPageTitle("게시판 - 목록");
        alert("게시판 설정을 확인할 수 없습니다.");
        return;
    }

    for (var c = 0; c < ds_boardConfig.colCount; c++) {
        brdConfig[ds_boardConfig.colId(c)] = ds_boardConfig.value(0, c);
    }

    cfSetPageTitle(brdConfig.MENU_NAME + " - 목록");

    btn_write.display = btn_line.display = (brdConfig.WRITE_AVAIL == "1" ? "inline" : "none");

    gr_boardList.fg.ColHidden(gr_boardList.fg.ColIndex("FILE_ICON")) = (brdConfig.FILE_POLICY == "");
    gr_boardList.fg.ColHidden(gr_boardList.fg.ColIndex("READ_CNT")) = (brdConfig.READ_CNT_DISP != "1");

    fnRetrieve();
}

//작성
function fnWrite()
{
    var win = new any.viewer();
    win.path = "BoardC.jsp";
    win.arg.brdConfig = brdConfig;
    win.arg.BRD_NO = null;
    win.arg.RE_PARENT = null;
    win.arg.gr = gr_boardList;
    win.arg.fg = gr_boardList.fg;

    win.onReload = function()
    {
        gr_boardList.loader.reload();
    }

    win.show();
}

//상세
function fnGoView(gr, fg, row, colId)
{
    var win = new any.viewer();
    win.path = "BoardRD.jsp";
    win.arg.brdConfig = brdConfig;
    win.arg.readCntAdd = 1;
    win.arg.BRD_NO = gr.value(row, "BRD_NO");
    win.arg.gr = gr;
    win.arg.fg = fg;

    win.onReload = function()
    {
        gr.loader.reload();
    }

    win.show();
}
</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
    <TR>
        <TD>
            <TABLE border="0" cellspacing="1" cellpadding="2" class="main" onEnter="javascript:fnRetrieve();">
                <COLGROUP>
                    <COL class="condhead" width="15%">
                    <COL class="conddata" width="85%">
                </COLGROUP>
                <TR>
                    <TD>검색어</TD>
                    <TD>
                        <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                            <TR>
                                <TD width="20%">
                                    <ANY:SELECT id="SEARCH_KIND" codeData="/board/boardListSearchKind" value="SUBJECT" />
                                </TD>
                                <TD style="padding-left:2px;">
                                    <INPUT type="text" id="SEARCH_TEXT">
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
                        <BUTTON auto="retrieve" onClick="javascript:fnRetrieve();"></BUTTON>
                        <BUTTON auto="line" id="btn_line" display="none"></BUTTON>
                        <BUTTON text="<%= app.message.get("btn.com.write").toHTML() %>" onClick="javascript:fnWrite();" id="btn_write" display="none"></BUTTON>
                        <BUTTON auto="list"></BUTTON>
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
            <ANY:GRID id="gr_boardList" pagingType="1"><COMMENT>
                addColumn({ width:50 , align:"center", type:"number", sort:false, id:"ROW_NUM"          , name:"No" });
                addColumn({ width:300, align:"left"  , type:"string", sort:false, id:"SUBJECT"          , name:"제목" });
                addColumn({ width:70 , align:"center", type:"string", sort:false, id:"CRE_USER_NAME"    , name:"작성자" });
                addColumn({ width:130, align:"center", type:"string", sort:false, id:"CRE_DATE_TIME"    , name:"작성일" });
                addColumn({ width:50 , align:"center", type:"string", sort:false, id:"FILE_ICON"        , name:"파일" , hide:true, text:"" });
                addColumn({ width:60 , align:"center", type:"number", sort:false, id:"READ_CNT"         , name:"조회수" , hide:true, format:"#,###" });
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_NUM", "SUBJECT");
                addSorting("RE_PARENT", "DESC");
                addSorting("RE_ORDER", "ASC");

                columnInfo("SUBJECT").text = function(gr, fg, row, colId, value)
                {
                    var reLevel = Number(gr.value(row, "RE_LEVEL"));

                    if (reLevel == 0) return value;

                    value = "┗ " + value;

                    for (var i = 0; i < reLevel * 3; i++) {
                        value = " " + value;
                    }

                    return value;
                }

                addImage("FILE_ICON", function(gr, fg, row, colId)
                {
                    if (gr.value(row, "FILE_ICON") == "1") {
                        return top.getRoot() + "/anyfive/ipims/share/image/icon_file.gif";
                    }
                });

                addAction("SUBJECT", fnGoView, null, function(gr, fg, row, colId)
                {
                    return (gr.value(row, "DEL_YN") == "0");
                });
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
