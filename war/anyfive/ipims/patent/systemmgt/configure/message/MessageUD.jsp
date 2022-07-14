<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE><%= app.message.get("tit.systemmgt.basecode.message.modify") %></TITLE>
<% app.writeHTMLHeader(); %>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    MSG_ID.value = parent.MSG_ID;

    any_messageList.focus();

    fnRetrieve();
}

//조회
function fnRetrieve()
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.configure.message.act.RetrieveMessage.do";
    prx.addParam("MSG_ID", parent.MSG_ID);
    prx.checkData = ds_messageList;

    prx.onSuccess = function()
    {
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.configure.message.act.UpdateMessage.do";
    prx.addParam("DEL_MSG_ID", parent.MSG_ID);
    prx.addParam("MSG_ID", MSG_ID.value.trim());
    prx.addData("ds_messageList");

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        top.window.close();
    }

    prx.onFail = function()
    {
        this.error.show();

        if (this.error.number == 1) {
            MSG_ID_NEW.focus();
            MSG_ID_NEW.select();
        }
    }

    prx.execute();
}

//삭제
function fnDelete()
{
    if (!confirm("<%= app.message.get("msg.com.confirm.delete").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.configure.message.act.DeleteMessage.do";
    prx.addParam("DEL_MSG_ID", parent.MSG_ID);

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
        <TD req="MSG_ID">Message ID</TD>
        <TD>
            <INPUT type="text" id="MSG_ID" maxByte="50">
        </TD>
    </TR>
    <TBODY id="any_messageList" class="LangCodeList" colId="MSG_TEXT" rows="2" maxByte="500">
    </TBODY>
</TABLE>
<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.delete").toHTML() %>" onClick="javascript:fnDelete();"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.cancel").toHTML() %>" onClick="javascript:top.window.close();"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
