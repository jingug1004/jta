<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>공통코드 수정</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("CODE_VALUE_ID");
    addBind("CODE_DESC");
    addBind("USE_YN");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    cfSetPageTitle(document.title + " - " + parent.CODE_GRP_NAME);

    fnRetrieve();
}

//조회
function fnRetrieve()
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.configure.codevalue.act.RetrieveCodeValue.do";
    prx.addParam("CODE_GRP", parent.CODE_GRP);
    prx.addParam("CODE_VALUE", parent.CODE_VALUE);
    prx.checkData = ds_mainInfo;

    prx.onSuccess = function()
    {
        any_codeNameList.focus();
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.configure.codevalue.act.UpdateCodeValue.do";
    prx.addParam("CODE_GRP", parent.CODE_GRP);
    prx.addParam("CODE_VALUE", parent.CODE_VALUE);
    prx.addData("ds_mainInfo");
    prx.addData("ds_codeNameList");

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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.configure.codevalue.act.DeleteCodeValue.do";
    prx.addParam("CODE_GRP", parent.CODE_GRP);
    prx.addParam("CODE_VALUE", parent.CODE_VALUE);

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
        <TD req="CODE_VALUE_ID">코드 값</TD>
        <TD>
            <INPUT type="text" id="CODE_VALUE_ID" maxByte="50">
        </TD>
    </TR>
    <TBODY id="any_codeNameList" class="LangCodeList" colId="CODE_NAME" maxByte="1000">
    </TBODY>
    <TR>
        <TD>코드 설명</TD>
        <TD>
            <INPUT type="text" id="CODE_DESC" maxByte="4000">
        </TD>
    </TR>
    <TR>
        <TD req="USE_YN"><%= app.message.get("lbl.com.useyn") %></TD>
        <TD>
            <ANY:RADIO id="USE_YN" codeData="{USE_YN}" />
        </TD>
    </TR>
</TABLE>
<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.delete").toHTML() %>" onClick="javascript:fnDelete();"></BUTTON>
    <BUTTON auto="close"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
