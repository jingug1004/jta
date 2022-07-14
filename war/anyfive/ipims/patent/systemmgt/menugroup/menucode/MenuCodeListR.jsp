<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>메뉴 관리</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<% app.writeHTCImport(app.HTC_TREE); %>
<ANY:DS id="ds_menuCodeList" />
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieveMenuTree();
}

//메뉴 트리 조회
function fnRetrieveMenuTree()
{
    var ldr = gr_menuCodeTree.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.menugroup.menucode.act.RetrieveMenuCodeTree.do";
    ldr.addParam("SYSTEM_TYPE", SYSTEM_TYPE.value);
    ldr.addParam("LANG_CODE", LANG_CODE.value);

    ldr.onSuccess = function(gr, fg)
    {
        if (gr_menuCodeList.loader.executed == true) {
            gr_menuCodeList.loader.reload();
        } else {
            fnRetrieveMenuList(gr.value(fg.Row, "MENU_CODE"));
        }
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

//메뉴 목록 조회
function fnRetrieveMenuList(priorCode)
{
    var ldr = gr_menuCodeList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.menugroup.menucode.act.RetrieveMenuCodeList.do";
    ldr.addParam("SYSTEM_TYPE", SYSTEM_TYPE.value);
    ldr.addParam("LANG_CODE", LANG_CODE.value);
    ldr.addParam("MENU_CODE_PRIOR", priorCode);

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
    win.path = "MenuCodeC.jsp";
    win.arg.SYSTEM_TYPE = SYSTEM_TYPE.value;
    win.arg.MENU_CODE_PRIOR = gr_menuCodeTree.value(gr_menuCodeTree.fg.Row, "MENU_CODE");
    win.arg.MENU_CODE_PRIOR_NAME = gr_menuCodeTree.value(gr_menuCodeTree.fg.Row, "MENU_NAME");
    win.opt.width = 600;
    win.opt.height = 400;

    win.onReload = function()
    {
        gr_menuCodeTree.loader.reload();
    }

    win.show();
}

//상세 팝업
function fnOpenView(gr, fg, row, colId)
{
    var win = new any.window();
    win.path = "MenuCodeUD.jsp";
    win.arg.SYSTEM_TYPE = gr.value(row, "SYSTEM_TYPE");
    win.arg.MENU_CODE = gr.value(row, "MENU_CODE");
    win.opt.width = 600;
    win.opt.height = 400;

    win.onReload = function()
    {
        gr_menuCodeTree.loader.reload();
    }

    win.show();
}

//위/아래 이동
function fnMoveRowData(dir)
{
    gr_menuCodeList.moveRowData(dir);
}

//저장
function fnSave()
{
    var gr = gr_menuCodeList;
    var ds = ds_menuCodeList;

    for (var r = gr.fg.FixedRows; r < gr.fg.Rows; r++) {
        gr.value(r, "MENU_ORD") = r - gr.fg.FixedRows + 1;
    }

    if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;

    ds.init();

    for (var r = gr.fg.FixedRows; r < gr.fg.Rows; r++) {
        ds.addRow();
        ds.value(r - gr.fg.FixedRows, "SYSTEM_TYPE") = gr.value(r, "SYSTEM_TYPE");
        ds.value(r - gr.fg.FixedRows, "MENU_CODE") = gr.value(r, "MENU_CODE");
        ds.value(r - gr.fg.FixedRows, "MENU_ORD") = gr.value(r, "MENU_ORD");
    }

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.menugroup.menucode.act.UpdateMenuOrdList.do";
    prx.addData(ds);

    prx.onSuccess = function()
    {
        gr_menuCodeTree.loader.reload();
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}
</SCRIPT>

<!-- 시스템형태 변경시 -->
<SCRIPT language="JScript" for="SYSTEM_TYPE" event="OnChange()">
    gr_menuCodeList.loader.executed = false;
    fnRetrieveMenuTree();
</SCRIPT>

<!-- 언어코드 변경시 -->
<SCRIPT language="JScript" for="LANG_CODE" event="OnChange()">
    gr_menuCodeList.loader.executed = false;
    fnRetrieveMenuTree();
</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
    <COLGROUP>
        <COL width="30%">
        <COL style="padding-left:10px;">
    </COLGROUP>
    <TR height="1">
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD width="50%">
                        <ANY:SELECT id="SYSTEM_TYPE" codeData="{SYSTEM_TYPE}" />
                    </TD>
                    <TD width="1px"><IMG src="<%= request.getContextPath() %>/anyfive/framework/img/blank.gif" width="3px" height="1px"></TD>
                    <TD width="50%">
                        <ANY:SELECT id="LANG_CODE" codeData="{LANG_CODE}" />
                    </TD>
                </TR>
            </TABLE>
        </TD>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD><SPAN id="spn_gridMessage"></SPAN></TD>
                    <TD align="right">
                        <BUTTON text="작성" onClick="javascript:fnOpenCreate();"></BUTTON>
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD height="5" colspan="2"></TD>
    </TR>
    <TR>
        <TD>
            <ANY:TREE id="gr_menuCodeTree"><COMMENT>
                parentColumn = "MENU_CODE_PRIOR";
                codeColumn   = "MENU_CODE";
                nameColumn   = "MENU_NAME";
                expandLevel  = 1;

                addRoot(null, "ROOT", "iPIMS");

                fg.attachEvent("AfterRowColChange", function(iOldRow, iOldCol, iNewRow, iNewCol)
                {
                    if (element.loader.loading == true) return;

                    fnRetrieveMenuList(element.value(iNewRow, "MENU_CODE"));
                });
            </COMMENT></ANY:TREE>
        </TD>
        <TD>
            <ANY:GRID id="gr_menuCodeList" pagingType="0"><COMMENT>
                fg.SelectionMode = 3;
                addColumn({ width:50 , align:"center", type:"number" , sort:false, id:"MENU_ORD"    , name:"순서" });
                addColumn({ width:150, align:"left"  , type:"string" , sort:false, id:"MENU_NAME"   , name:"메뉴명" });
                addColumn({ width:200, align:"left"  , type:"string" , sort:false, id:"MENU_PATH"   , name:"메뉴 경로" });
                addColumn({ width:50 , align:"center", type:"string" , sort:false, id:"USE_YN_NAME" , name:"사용" });
                messageSpan = "spn_gridMessage";
                addAction("MENU_NAME", fnOpenView);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
    <TR>
        <TD height="5" colspan="2"></TD>
    </TR>
    <TR>
        <TD height="1" align="right" colspan="2">
            <BUTTON text="위로" onClick="javascript:fnMoveRowData(-1);"></BUTTON>
            <BUTTON text="아래로" onClick="javascript:fnMoveRowData(1);"></BUTTON>
            <BUTTON text="저장" onClick="javascript:fnSave();"></BUTTON>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
