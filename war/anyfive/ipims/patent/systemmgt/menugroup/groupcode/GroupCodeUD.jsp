<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>그룹 수정</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("SYSTEM_TYPE_NAME");
    addBind("GROUP_CODE");
    addBind("GROUP_NAME");
    addBind("USE_YN");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    btn_delete.disabled = (parent.GROUP_CODE == "COM");
    USE_YN.readOnly = (parent.GROUP_CODE == "COM");

    fnRetrieve();
}

//조회
function fnRetrieve()
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.menugroup.groupcode.act.RetrieveGroupCode.do";
    prx.addParam("SYSTEM_TYPE", parent.SYSTEM_TYPE);
    prx.addParam("GROUP_CODE", parent.GROUP_CODE);
    prx.checkData = ds_mainInfo;

    prx.onSuccess = function()
    {
        GROUP_NAME.focus();
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.menugroup.groupcode.act.UpdateGroupCode.do";
    prx.addParam("SYSTEM_TYPE", parent.SYSTEM_TYPE);
    prx.addParam("GROUP_CODE", parent.GROUP_CODE);
    prx.addData("ds_mainInfo");

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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.menugroup.groupcode.act.DeleteGroupCode.do";
    prx.addParam("SYSTEM_TYPE", parent.SYSTEM_TYPE);
    prx.addParam("GROUP_CODE", parent.GROUP_CODE);

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
        <TD>구분</TD>
        <TD><SPAN id="SYSTEM_TYPE_NAME"></SPAN></TD>
    </TR>
    <TR>
        <TD>그룹코드</TD>
        <TD>
            <INPUT type="text" id="GROUP_CODE" readOnly style="border:none;">
        </TD>
    </TR>
    <TR>
        <TD req="GROUP_NAME">그룹명</TD>
        <TD>
            <INPUT type="text" id="GROUP_NAME" maxByte="100">
        </TD>
    </TR>
    <TR>
        <TD req="USE_YN">사용여부</TD>
        <TD>
            <ANY:RADIO id="USE_YN" codeData="{USE_YN}" readOnly />
        </TD>
    </TR>
</TABLE>
<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.delete").toHTML() %>" onClick="javascript:fnDelete();" id="btn_delete" disabled></BUTTON>
    <BUTTON auto="close"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
