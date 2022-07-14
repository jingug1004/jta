<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>그룹별 메뉴</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_TREE); %>
<ANY:DS id="ds_groupMenuList" />
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    cfSetPageTitle("그룹별 메뉴 - " + parent.GROUP_NAME + "(" + parent.SYSTEM_TYPE_NAME + ")");

    fnRetrieve();
}

//조회
function fnRetrieve()
{
    var ldr = gr_groupMenuTree.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.menugroup.groupmenu.act.RetrieveGroupMenuList.do";
    ldr.addParam("SYSTEM_TYPE", parent.SYSTEM_TYPE);
    ldr.addParam("GROUP_CODE", parent.GROUP_CODE);

    ldr.onSuccess = function(gr, fg)
    {
        fg.ReDraw = 0;
        for (var r = fg.FixedRows; r < fg.Rows; r++) {
            gr.checked(r) = (gr.value(r, "CHECK_YN") == "1");
        }
        fg.ReDraw = 2;
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

//저장
function fnSave()
{
    if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;

    var gr = document.getElementById("gr_groupMenuTree");
    var ds = document.getElementById("ds_groupMenuList");

    ds.init();

    function addData(jobType, menuCode)
    {
        var row = ds.addRow();
        ds.value(row, "JOB_TYPE") = jobType;
        ds.value(row, "MENU_CODE") = menuCode;
    }

    for (var r = gr.fg.FixedRows; r < gr.fg.Rows; r++) {
        if (gr.checked(r) == true && gr.value(r, "CHECK_YN") != "1") {
            addData("C", gr.value(r, "MENU_CODE"));
        }
        if (gr.checked(r) != true && gr.value(r, "CHECK_YN") == "1") {
            addData("D", gr.value(r, "MENU_CODE"));
        }
    }

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.menugroup.groupmenu.act.UpdateGroupMenuList.do";
    prx.addParam("SYSTEM_TYPE", parent.SYSTEM_TYPE);
    prx.addParam("GROUP_CODE", parent.GROUP_CODE);
    prx.addData(ds);

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        top.window.close();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//하위메뉴 전체선택/해제
function fnCheclAllSub(bool)
{
    var gr = document.getElementById("gr_groupMenuTree");
    var level = gr.fg.RowOutlineLevel(gr.fg.Row);

    gr.checked(gr.fg.Row) = bool;

    try {
        gr.fg.ReDraw = 0;
        for (var r = gr.fg.Row + 1; r < gr.fg.Rows; r++) {
            if (gr.fg.RowOutlineLevel(r) <= level) break;
            gr.checked(r) = bool;
        }
    } catch(ex) {
    } finally {
        gr.fg.ReDraw = 2;
    }
}
</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
    <TR>
        <TD height="100%">
            <ANY:TREE id="gr_groupMenuTree"><COMMENT>
                parentColumn = "MENU_CODE_PRIOR";
                codeColumn   = "MENU_CODE";
                nameColumn   = "MENU_NAME";
                expandLevel  = -1;
                showCheck    = true;
                autoCheck    = true;
            </COMMENT></ANY:TREE>
        </TD>
    </TR>
    <TR>
        <TD height="5px"></TD>
    </TR>
    <TR>
        <TD height="1px" align="right">
            <BUTTON text="하위메뉴 전체선택" onClick="javascript:fnCheclAllSub(true);"></BUTTON>
            <BUTTON text="하위메뉴 전체해제" onClick="javascript:fnCheclAllSub(false);"></BUTTON>
            <BUTTON auto="line"></BUTTON>
            <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>
            <BUTTON auto="close"></BUTTON>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
