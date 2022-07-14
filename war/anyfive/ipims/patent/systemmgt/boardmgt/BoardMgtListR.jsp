<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>게시판 관리 목록</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();
}

//목록 조회
function fnRetrieve()
{
    var ldr = gr_boardMgtList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.boardmgt.act.RetrieveBoardMgtList.do";
    ldr.addParam("SYSTEM_TYPE", SYSTEM_TYPE.value);
    ldr.addParam("BRD_ID", BRD_ID.value);

    ldr.onSuccess = function(gr, fg)
    {
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

//작성 팝업
function fnOpenWrite()
{
    var win = new any.window();
    win.path = "BoardMgtC.jsp";
    win.opt.width = 520;
    win.opt.height = 270;

    win.onReload = function()
    {
        gr_boardMgtList.loader.reload();
    }

    win.show();
}

//상세 팝업
function fnOpenView(gr, fg, row, colId)
{
    var win = new any.window();
    win.path = "BoardMgtUD.jsp";
    win.arg.BRD_CODE = gr.value(row, "BRD_CODE");
    win.opt.width = 520;
    win.opt.height = 270;

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
                    <COL class="conddata" width="35%">
                    <COL class="condhead" width="15%">
                    <COL class="conddata" width="35%">
                </COLGROUP>
                <TR>
                    <TD>메뉴구분</TD>
                    <TD>
                        <ANY:SELECT id="SYSTEM_TYPE" codeData="{SYSTEM_TYPE}" firstName="all" />
                    </TD>
                    <TD>게시판 ID</TD>
                    <TD>
                        <INPUT type="text" id="BRD_ID">
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
                        <BUTTON text="작성" onClick="javascript:fnOpenWrite();"></BUTTON>
                        <BUTTON auto="line"></BUTTON>
                        <BUTTON auto="retrieve" onClick="javascript:fnRetrieve();"></BUTTON>
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
            <ANY:GRID id="gr_boardMgtList" pagingType="0"><COMMENT>
                addColumn({ width:50 , align:"center", type:"number", sort:false, id:"ROW_NUM"          , name:"No" });
                addColumn({ width:80 , align:"center", type:"string", sort:true , id:"SYSTEM_TYPE_NAME" , name:"메뉴구분" });
                addColumn({ width:200, align:"left"  , type:"string", sort:true , id:"MENU_NAME"        , name:"게시판 메뉴" });
                addColumn({ width:90 , align:"left"  , type:"string", sort:true , id:"BRD_ID"           , name:"게시판 ID" });
                addColumn({ width:50 , align:"center", type:"string", sort:true , id:"WRITE_AVAIL"      , name:"작성 가능여부" });
                addColumn({ width:50 , align:"center", type:"string", sort:true , id:"ANS_AVAIL"        , name:"답변 가능여부" });
                addColumn({ width:50 , align:"center", type:"string", sort:true , id:"READ_CNT_DISP"    , name:"조회수 표시여부" });
                addColumn({ width:50 , align:"center", type:"string", sort:true , id:"NOTICE_PERIOD"    , name:"공지기간 관리여부" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"FILE_POLICY"      , name:"첨부파일 정책" });
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_NUM", "MENU_NAME");
                addSorting("SYSTEM_TYPE_NAME", "DESC");
                addAction("MENU_NAME", fnOpenView);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
