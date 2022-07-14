<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>메뉴 수정</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("MENU_CODE_PRIOR_NAME");
    addBind("MENU_PATH");
    addBind("USE_YN");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    MENU_CODE.value = parent.MENU_CODE;

    fnRetrieve();
}

//조회
function fnRetrieve()
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.menugroup.menucode.act.RetrieveMenuCode.do";
    prx.addParam("SYSTEM_TYPE", parent.SYSTEM_TYPE);
    prx.addParam("MENU_CODE", parent.MENU_CODE);
    prx.checkData = ds_mainInfo;

    prx.onSuccess = function()
    {
        any_menuNameList.focus();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//저장
function fnSave()
{
    if (!cfCheckAllReqValid()) return;

    if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.menugroup.menucode.act.UpdateMenuCode.do";
    prx.addParam("SYSTEM_TYPE", parent.SYSTEM_TYPE);
    prx.addParam("MENU_CODE", parent.MENU_CODE);
    prx.addData("ds_mainInfo");
    prx.addData("ds_menuNameList");

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

//삭제
function fnDelete()
{
    if (!confirm("<%= app.message.get("msg.com.confirm.delete").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.menugroup.menucode.act.DeleteMenuCode.do";
    prx.addParam("SYSTEM_TYPE", parent.SYSTEM_TYPE);
    prx.addParam("MENU_CODE", parent.MENU_CODE);

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.delete").toJS() %>");
        top.window.close();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//상위메뉴코드 변경
function fnChangePriorMenuCode()
{
    var win = new any.window();
    win.path = top.getRoot() + "/anyfive/ipims/patent/common/popup/search/MenuCodeSearchTreeR.jsp";
    win.arg.SYSTEM_TYPE = parent.SYSTEM_TYPE;
    win.arg.addRoot = true;
    win.opt.width = 500;
    win.opt.height = 550;
    win.show();

    if (win.rtn == null) return;

    if (Number(win.rtn.MENU_LEVEL) != Number(ds_mainInfo.value(0, "MENU_LEVEL") - 1)) {
        alert("동일레벨의 상위메뉴로만 변경이 가능합니다.");
        return;
    }

    ds_mainInfo.value(0, "MENU_CODE_PRIOR") = win.rtn.MENU_CODE;
    ds_mainInfo.value(0, "MENU_CODE_PRIOR_NAME") = win.rtn.MENU_CODE + ' [' + win.rtn.MENU_NAME + ']';
}
</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="1" cellpadding="2" class="main">
    <COLGROUP>
        <COL class="conthead" width="20%">
        <COL class="contdata" width="80%">
    </COLGROUP>
    <TR>
        <TD>메뉴 코드</TD>
        <TD>
            <INPUT type="text" id="MENU_CODE" readOnly style="border:none;">
        </TD>
    </TR>
    <TR>
        <TD>상위 메뉴</TD>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD width="100%">
                        <INPUT type="text" id="MENU_CODE_PRIOR_NAME" readOnly style="border:none;">
                    </TD>
                    <TD width="1px">
                        <BUTTON text="변경" onClick="javascript:fnChangePriorMenuCode();"></BUTTON>
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TBODY id="any_menuNameList" class="LangCodeList" colId="MENU_NAME" maxByte="50">
    </TBODY>
    <TR>
        <TD>메뉴 경로</TD>
        <TD>
            <INPUT type="text" id="MENU_PATH" maxByte="200">
        </TD>
    </TR>
    <TR>
        <TD req="USE_YN">사용 여부</TD>
        <TD>
            <ANY:RADIO id="USE_YN" codeData="{USE_YN}" />
        </TD>
    </TR>
</TABLE>
<DIV class="button_area">
    <BUTTON text="저장" onClick="javascript:fnSave();"></BUTTON>
    <BUTTON text="삭제" onClick="javascript:fnDelete();"></BUTTON>
    <BUTTON text="취소" onClick="javascript:top.window.close();"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
