<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>평가요소 수정</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("ELEM_NAME");
    addBind("ELEM_VALUE");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();
}

//조회
function fnRetrieve()
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.evalsheet.evalelem.act.RetrieveEvalElemMgt.do";
    prx.addParam("EVAL_SHEET_ID", parent.EVAL_SHEET_ID);
    prx.addParam("ITEM_SEQ", parent.ITEM_SEQ);
    prx.addParam("ELEM_SEQ", parent.ELEM_SEQ);

    prx.onSuccess = function()
    {
        ELEM_NAME.focus();
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.evalsheet.evalelem.act.UpdateEvalElemMgt.do";
    prx.addParam("EVAL_SHEET_ID", parent.EVAL_SHEET_ID);
    prx.addParam("ITEM_SEQ", parent.ITEM_SEQ);
    prx.addParam("ELEM_SEQ", parent.ELEM_SEQ);
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.evalsheet.evalelem.act.DeleteEvalElemMgt.do";
    prx.addParam("EVAL_SHEET_ID", parent.EVAL_SHEET_ID);
    prx.addParam("ITEM_SEQ", parent.ITEM_SEQ);
    prx.addParam("ELEM_SEQ", parent.ELEM_SEQ);

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
        <TD req="ELEM_NAME">요소 이름</TD>
        <TD>
            <INPUT type="text" id="ELEM_NAME" maxByte="1000">
        </TD>
    </TR>
    <TR>
        <TD req="ELEM_VALUE">요소 값</TD>
        <TD>
            <INPUT type="text" id="ELEM_VALUE" maxByte="3">
        </TD>
    </TR>
</TABLE>
<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.delete").toHTML() %>" onClick="javascript:fnDelete();"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.cancel").toHTML() %>" onClick="javascript:top.window.close();"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
