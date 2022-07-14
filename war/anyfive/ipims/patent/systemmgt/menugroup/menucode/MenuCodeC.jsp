<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>메뉴 작성</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("MENU_PATH");
    addBind("USE_YN");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    ds_mainInfo.value(0, "MENU_CODE_PRIOR") = parent.MENU_CODE_PRIOR;

    MENU_CODE_PRIOR_NAME.value = parent.MENU_CODE_PRIOR_NAME;

    any_menuNameList.focus();
}

//저장
function fnSave()
{
    if (!cfCheckAllReqValid()) return;

    if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.menugroup.menucode.act.CreateMenuCode.do";
    prx.addParam("SYSTEM_TYPE", parent.SYSTEM_TYPE);
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
        <TD>상위 메뉴</TD>
        <TD>
            <INPUT type="text" id="MENU_CODE_PRIOR_NAME" readOnly style="border:none;">
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
            <ANY:RADIO id="USE_YN" codeData="{USE_YN}" value="1" />
        </TD>
    </TR>
</TABLE>
<DIV class="button_area">
    <BUTTON text="저장" onClick="javascript:fnSave();"></BUTTON>
    <BUTTON text="취소" onClick="javascript:top.window.close();"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
