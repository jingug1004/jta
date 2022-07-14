<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<%@page import="any.util.etc.NTextUtil"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>해외출원마스터</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_tabInfo" />
<SCRIPT language="JScript">
var REF_ID = parent.REF_ID;
var GRP_ID;

//윈도우 로딩시
window.onready = function()
{
    cfShowObjects([btn_movePrev, btn_moveNext, btn_moveLine], parent.gr != null && parent.fg != null);

    fnSetMoveButtonDisabled();
    fnRetrieveTabInfo();
}

//탭 정보 조회
function fnRetrieveTabInfo()
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.common.act.RetrieveExtMasterTabInfo.do";
    prx.addParam("REF_ID", REF_ID);

    prx.onSuccess = function()
    {
        GRP_ID = parent.GRP_ID = ds_tabInfo.value(0, "GRP_ID");

        if (document.isPageInit != true) {
            document.isPageInit = true;
            fnInitRefNoSearch();
            fnInitTabMain();
        }

        tab_main.enableButton("group") = (ds_tabInfo.value(0, "GROUP_EXIST") == "1");

        tab_main.resetAll();

        if (tab_main.index == -1 || tab_main.enableButton(tab_main.index) != true) {
            var reqTabId = "<%= NTextUtil.nvl(request.getParameter("TAB"), "") %>";
            var reqTabIdx = tab_main.index(reqTabId);
            tab_main.goTab(reqTabIdx == -1 ? 0 : reqTabIdx);
        } else {
            tab_main.goTab();
        }
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute(false);
}

//검색박스 초기화
function fnInitRefNoSearch()
{
    REF_NO_SEARCH.win.path = top.getRoot() + "/anyfive/ipims/patent/common/popup/search/RefNoSearchListR.jsp";
    REF_NO_SEARCH.win.opt.width = 700;
    REF_NO_SEARCH.win.opt.height = 500;

    switch (ds_tabInfo.value(0, "RIGHT_DIV")) {
    case "10":
    case "20":
        REF_NO_SEARCH.win.arg.RIGHT_DIV = "10,20";
        break;
    default:
        REF_NO_SEARCH.win.arg.RIGHT_DIV = ds_tabInfo.value(0, "RIGHT_DIV");
        break;
    }

    REF_NO_SEARCH.win.arg.INOUT_DIV = "EXT";
    REF_NO_SEARCH.codeColumn = "REF_ID";
    REF_NO_SEARCH.nameExpr = "{#REF_NO}";

    REF_NO_SEARCH.value = { REF_ID:REF_ID, REF_NO:ds_tabInfo.value(0, "REF_NO") };
}

//탭 초기화
function fnInitTabMain()
{
    switch (ds_tabInfo.value(0, "RIGHT_DIV")) {
    case "10":
    case "20":
        cfSetPageTitle("해외출원마스터");
        tab_main.addButton({ name:"해외출원마스터", src:top.getRoot() + "/anyfive/ipims/patent/applymgt/extpatent/master/ExtPatentMasterRD.jsp", reload:true });
        <% if (app.userInfo.isPatentTeam()) { %>
        tab_main.addButton({ name:"해외출원품의서", src:top.getRoot() + "/anyfive/ipims/patent/applymgt/extpatent/group/ExtPatentGroupRD.jsp", reload:true, id:"group" });
        <% } %>
        break;
    case "30":
        cfSetPageTitle("디자인해외출원마스터");
        tab_main.addButton({ name:"디자인해외출원마스터", src:top.getRoot() + "/anyfive/ipims/patent/applymgt/design/extmaster/DesignExtMasterRD.jsp", reload:true });
        <% if (app.userInfo.isPatentTeam()) { %>
        tab_main.addButton({ name:"디자인해외출원품의서", src:top.getRoot() + "/anyfive/ipims/patent/applymgt/design/extgroup/DesignExtGroupRD.jsp", reload:true, id:"group" });
        <% } %>
        break;
    case "40":
        cfSetPageTitle("상표해외출원마스터");
        tab_main.addButton({ name:"상표해외출원마스터", src:top.getRoot() + "/anyfive/ipims/patent/applymgt/tmark/extmaster/TMarkExtMasterRD.jsp", reload:true });
        <% if (app.userInfo.isPatentTeam()) { %>
        tab_main.addButton({ name:"상표해외출원품의서", src:top.getRoot() + "/anyfive/ipims/patent/applymgt/tmark/extgroup/TMarkExtGroupRD.jsp", reload:true, id:"group" });
        <% } %>
        break;
    }

    tab_main.addButton({ name:"진행서류", src:top.getRoot() + "/anyfive/ipims/share/docpaper/docpaper/DocPaperM.jsp", reload:true, id:"paper" });
    <% if (app.userInfo.isPatentTeam()) { %>
    tab_main.addButton({ name:"비용내역", src:top.getRoot() + "/anyfive/ipims/patent/costmgt/cost/costview/CostViewRD.jsp?MASTER=1", reload:true });
    <% } %>
}

//이전/다음
function fnMoveList(dir)
{
    if (parent.gr == null) return;
    if (parent.fg == null) return;

    parent.gr.moveRowPos(dir, "REF_NO");

    fnSetMoveButtonDisabled();

    REF_ID = parent.REF_ID = parent.gr.value(parent.fg.Row, "REF_ID");

    fnRetrieveTabInfo();
}

//이전/다음 버튼 활성/비활성
function fnSetMoveButtonDisabled()
{
    if (parent.gr == null) return;
    if (parent.fg == null) return;

    btn_movePrev.disabled = (parent.fg.Row <= parent.fg.FixedRows);
    btn_moveNext.disabled = (parent.fg.Row >= parent.fg.Rows - 1);
}

//해외출원현황
function fnExtApplyList()
{
    var win = new any.window();
    win.path = top.getRoot() + "/anyfive/ipims/patent/common/popup/viewer/ExtApplyByExtListR.jsp";
    win.arg.REF_ID = REF_ID;
    win.opt.width = 700;
    win.opt.height = 400;
    win.show();
}

//발명자정보
function fnInventorList()
{
    var win = new any.window();
    win.path = top.getRoot() + "/anyfive/ipims/patent/common/popup/viewer/InventorListR.jsp";
    win.arg.GRP_ID = GRP_ID;
    win.opt.width = 800;
    win.opt.height = 400;
    return win.show();
}

//관련화일목록
function fnRelateFileList()
{
    var win = new any.window();
    win.path = top.getRoot() + "/anyfive/ipims/patent/common/popup/viewer/RefFileListR.jsp";
    win.arg.REF_ID = REF_ID;
    win.opt.width = 700;
    win.opt.height = 400;
    win.show();
}

//패밀리구조도
function fnFamilyDiagram()
{
    var win = new any.window(2);
    win.path = top.getRoot() + "/anyfive/ipims/patent/applymgt/family/FamilyDiagramR.jsp";
    win.arg.REF_ID = REF_ID;
    win.opt.width = 1000;
    win.opt.height = 700;
    win.opt.resizable = "yes";
    win.show();
}
</SCRIPT>

<!-- REF-NO 검색시 -->
<SCRIPT language="JScript" for="REF_NO_SEARCH" event="OnChange()">
    if (this.value == null || this.value == "") return;
    if (parent.IPIMS_MASTER_VIEWER == true) {
        parent.fnChangeMaster(this.value);
    } else {
        REF_ID = this.value;
        fnRetrieveTabInfo();
    }
</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
    <TR>
        <TD height="1px">
            <ANY:TAB id="tab_main"><COMMENT>
                fullSize = true;
                frameDiv = div_tabFrame;
            </COMMENT></ANY:TAB>
        </TD>
    </TR>
    <TR>
        <TD height="1px">
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD width="150px">
                        <ANY:SEARCH id="REF_NO_SEARCH" mode="U" />
                    </TD>
                    <TD align="right">
                        <BUTTON text="해외출원현황" onClick="javascript:fnExtApplyList();"></BUTTON>
                        <BUTTON text="발명자정보" onClick="javascript:fnInventorList();"></BUTTON>
                        <BUTTON text="관련화일목록" onClick="javascript:fnRelateFileList();"></BUTTON>
                        <BUTTON text="패밀리구조도" onClick="javascript:fnFamilyDiagram();"></BUTTON>
                        <BUTTON auto="line"></BUTTON>
                        <BUTTON text="이전" id="btn_movePrev" display="none" onClick="javascript:fnMoveList(-1);"></BUTTON>
                        <BUTTON text="다음" id="btn_moveNext" display="none" onClick="javascript:fnMoveList(1);"></BUTTON>
                        <BUTTON auto="line" id="btn_moveLine" display="none"></BUTTON>
                        <BUTTON auto="list"></BUTTON>
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD height="5px"></TD>
    </TR>
    <TR>
        <TD>
            <DIV id="div_tabFrame"></DIV>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
