<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<%@page import="any.util.etc.NTextUtil"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>특허팀 일괄평가</TITLE>
<% app.writeHTMLHeader(); %>
<SCRIPT language="JScript">

//윈도우 로딩시
window.onready = function()
{
}

//저장
function fnSave()
{
    if (!cfCheckAllReqValid()) return;

    if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;

    var gr = top.opener.document.getElementById("gr_annualValuationList");
    var ds = top.opener.document.getElementById("ds_annualValuationList");

    ds.init();

    for (var r = gr.fg.FixedRows; r < gr.fg.Rows; r++) {
        if (gr.checked(r, "ROW_CHK") != true) continue;

        ds.addRow();
        ds.value(ds.rowCount - 1, "REF_ID") = gr.value(r, "REF_ID");
        ds.value(ds.rowCount - 1, "PAY_YEARDEG") = gr.value(r, "PAY_YEARDEG");
    }

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.costmgt.annual.valuation.act.UpdateAnnualValuationList.do";
    prx.addParam("KEEP_YN", KEEP_YN.value);
    prx.addData(ds);

    prx.onSuccess = function()
    {
        gr.loader.reload();
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

<TABLE border="0" cellspacing="1" cellpadding="2" class="main" style="margin-top:2px;">
    <COLGROUP>
        <COL class="conthead" width="30%" style="text-align:left;">
        <COL class="contdata" width="70%">
    </COLGROUP>
    <TR>
        <TD req="KEEP_YN">유지여부</TD>
        <TD><ANY:RADIO id="KEEP_YN" codeData="{KEEP_YN}" /></TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="close"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
