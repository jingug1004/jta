<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>평가항목 작성</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("ITEM_NAME");
    addBind("ROW_ELEM_CNT");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    ITEM_NAME.focus();
}

//저장
function fnSave()
{
    if (!cfCheckAllReqValid()) return;

    if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.evalsheet.evalitem.act.CreateEvalItemMgt.do";
    prx.addParam("EVAL_SHEET_ID", parent.EVAL_SHEET_ID);
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
    <BUTTON text="<%= app.message.get("btn.com.cancel").toHTML() %>" onClick="javascript:top.window.close();"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
