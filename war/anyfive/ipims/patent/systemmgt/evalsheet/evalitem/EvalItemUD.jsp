<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>평가항목 수정</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("ITEM_NAME");
    addBind("ROW_ELEM_CNT");
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.evalsheet.evalitem.act.RetrieveEvalItemMgt.do";
    prx.addParam("EVAL_SHEET_ID", parent.EVAL_SHEET_ID);
    prx.addParam("ITEM_SEQ", parent.ITEM_SEQ);

    prx.onSuccess = function()
    {
        ITEM_NAME.focus();
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.evalsheet.evalitem.act.UpdateEvalItemMgt.do";
    prx.addParam("EVAL_SHEET_ID", parent.EVAL_SHEET_ID);
    prx.addParam("ITEM_SEQ", parent.ITEM_SEQ);
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.evalsheet.evalitem.act.DeleteEvalItemMgt.do";
    prx.addParam("EVAL_SHEET_ID", parent.EVAL_SHEET_ID);
    prx.addParam("ITEM_SEQ", parent.ITEM_SEQ);

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
        <TD req="ITEM_NAME">항목 이름</TD>
        <TD>
            <INPUT type="text" id="ITEM_NAME" maxByte="1000">
        </TD>
    </TR>
    <TR>
        <TD>줄당 요소 갯수</TD>
        <TD>
            <INPUT type="text" id="ROW_ELEM_CNT" maxByte="2" format="number" style="text-align:left;">
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
