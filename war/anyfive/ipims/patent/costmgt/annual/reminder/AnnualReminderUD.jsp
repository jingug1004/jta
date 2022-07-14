<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<%@page import="any.util.etc.NDateUtil"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>Reminder 수정</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("REF_ID");
    addBind("PAY_YEARDEG");
    addBind("PAY_LIMIT");
    addBind("NEXT_PAY_YEARDEG");
    addBind("NEXT_PAY_LIMIT");
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.costmgt.annual.reminder.act.RetrieveAnnualReminder.do";
    prx.addParam("REF_ID", parent.REF_ID);
    prx.addParam("PAY_YEARDEG", parent.PAY_YEARDEG);

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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.costmgt.annual.reminder.act.UpdateAnnualReminder.do";
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.costmgt.annual.reminder.act.DeleteAnnualReminder.do";
    prx.addParam("REF_ID", parent.REF_ID);
    prx.addParam("PAY_YEARDEG", parent.PAY_YEARDEG);

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

<TABLE border="0" cellspacing="1" cellpadding="2" class="main" style="margin-top:5px;">
    <COLGROUP>
        <COL class="conthead" width="15%">
        <COL class="contdata" width="35%">
        <COL class="conthead" width="15%">
        <COL class="contdata" width="35%">
    </COLGROUP>
    <TR>
        <TD req="REF_ID">REF-NO</TD>
        <TD colspan="3">
            <ANY:SEARCH id="REF_ID" mode="U"><COMMENT>
                win.path = top.getRoot() + "/anyfive/ipims/patent/common/popup/search/RefNoSearchListR.jsp";
                win.arg.ABD_YN = '0';
                win.opt.width = 600;
                codeColumn = "REF_ID";
                nameExpr = "[{#REF_NO}] {#KO_APP_TITLE}";
            </COMMENT></ANY:SEARCH>
        </TD>
    </TR>
    <TR>
        <TD req="PAY_YEARDEG">납부년차</TD>
        <TD>
            <INPUT type="text" id="PAY_YEARDEG" format="number(2.1)" style="text-align:center;">
        </TD>
        <TD req="PAY_LIMIT">납부기한</TD>
        <TD>
            <ANY:DATE id="PAY_LIMIT" />
        </TD>
    </TR>
    <TR>
        <TD>차기납부년차</TD>
        <TD>
            <INPUT type="text" id="NEXT_PAY_YEARDEG" format="number(2.1)" style="text-align:center;">
        </TD>
        <TD>차기납부기한</TD>
        <TD>
            <ANY:DATE id="NEXT_PAY_LIMIT" />
        </TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.delete").toHTML() %>" onClick="javascript:fnDelete();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="close"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
