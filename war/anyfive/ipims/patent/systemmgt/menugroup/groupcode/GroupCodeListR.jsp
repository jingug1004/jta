<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>그룹 관리</TITLE>
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
    var ldr = gr_groupCodeList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.menugroup.groupcode.act.RetrieveGroupCodeList.do";
    ldr.addParam("SYSTEM_TYPE", SYSTEM_TYPE.value);
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

//작성 팝업
function fnOpenCreate()
{
    var win = new any.window();
    win.path = "GroupCodeC.jsp";
    win.arg.SYSTEM_TYPE = SYSTEM_TYPE.value;
    win.opt.width = 600;
    win.opt.height = 190;

    win.onReload = function()
    {
        gr_groupCodeList.loader.reload();
    }

    win.show();
}

//상세 팝업
function fnOpenView(gr, fg, row, colId)
{
    var win = new any.window();
    win.path = "GroupCodeUD.jsp";
    win.arg.SYSTEM_TYPE = gr.value(row, "SYSTEM_TYPE");
    win.arg.GROUP_CODE = gr.value(row, "GROUP_CODE");
    win.opt.width = 600;
    win.opt.height = 190;

    win.onReload = function()
    {
        gr.loader.reload();
    }

    win.show();
}

//그룹별 메뉴 팝업
function fnOpenGroupMenu(gr, fg, row, colId)
{
    var win = new any.window();
    win.path = top.getRoot() + "/anyfive/ipims/patent/systemmgt/menugroup/groupmenu/GroupMenuListUD.jsp";
    win.arg.SYSTEM_TYPE = gr.value(row, "SYSTEM_TYPE");
    win.arg.GROUP_CODE = gr.value(row, "GROUP_CODE");
    win.arg.GROUP_NAME = gr.value(row, "GROUP_NAME");
    win.arg.SYSTEM_TYPE_NAME = gr.value(row, "SYSTEM_TYPE_NAME");
    win.opt.width = 500;
    win.opt.height = 550;

    win.onReload = function()
    {
        gr.loader.reload();
    }

    win.show();
}

//그룹별 사용자 팝업
function fnOpenGroupUser(gr, fg, row, colId)
{
    var win = new any.window();
    win.path = top.getRoot() + "/anyfive/ipims/patent/systemmgt/menugroup/groupuser/GroupUserListUD.jsp";
    win.arg.SYSTEM_TYPE = gr.value(row, "SYSTEM_TYPE");
    win.arg.GROUP_CODE = gr.value(row, "GROUP_CODE");
    win.arg.GROUP_NAME = gr.value(row, "GROUP_NAME");
    win.arg.SYSTEM_TYPE_NAME = gr.value(row, "SYSTEM_TYPE_NAME");
    win.opt.width = 650;
    win.opt.height = 500;

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
                    <TD>구분</TD>
                    <TD>
                        <ANY:SELECT id="SYSTEM_TYPE" codeData="{SYSTEM_TYPE}" />
                    </TD>
                    <TD>검색어</TD>
                    <TD>
                        <INPUT type="text" id="SEARCH_TEXT">
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
                        <BUTTON auto="line"></BUTTON>
                        <BUTTON text="작성" onClick="javascript:fnOpenCreate();"></BUTTON>
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
            <ANY:GRID id="gr_groupCodeList" pagingType="1"><COMMENT>
                addColumn({ width:50 , align:"center", type:"number" , sort:false, id:"ROW_NUM"          , name:"No" });
                addColumn({ width:100, align:"center", type:"string" , sort:true , id:"SYSTEM_TYPE_NAME" , name:"구분" });
                addColumn({ width:100, align:"center", type:"string" , sort:true , id:"GROUP_CODE"       , name:"그룹코드" });
                addColumn({ width:250, align:"left"  , type:"string" , sort:true , id:"GROUP_NAME"       , name:"그룹명" });
                addColumn({ width:100, align:"right" , type:"number" , sort:true , id:"GROUP_MENU_CNT"   , name:"그룹별 메뉴" , format:"####" });
                addColumn({ width:100, align:"right" , type:"number" , sort:true , id:"GROUP_USER_CNT"   , name:"그룹별 사용자" , format:"####" });
                addColumn({ width:100, align:"center", type:"string" , sort:true , id:"USE_YN_NAME"      , name:"사용여부" });
                messageSpan = "spn_gridMessage";
                addSorting("GROUP_NAME", "ASC");
                addAction("GROUP_NAME", fnOpenView);
                addAction("GROUP_MENU_CNT", fnOpenGroupMenu);
                addAction("GROUP_USER_CNT", fnOpenGroupUser, null, function(gr, fg, row, colId)
                {
                    return (gr.value(row, "GROUP_CODE") != "COM");
                });
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
