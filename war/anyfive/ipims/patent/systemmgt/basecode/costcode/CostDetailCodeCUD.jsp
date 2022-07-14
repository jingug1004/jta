<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>상세분류 작성</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("DETAIL_NAME");
    addBind("TAX_YN");
    addBind("DISP_ORD");
    addBind("USE_YN");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    DETAIL_NAME.focus();

    fnRetrieve();
}

//조회
function fnRetrieve()
{
    if (parent.DETAIL_CODE == null) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.basecode.costcode.act.RetrieveCostDetailCode.do";
    prx.addParam("GRAND_CODE", parent.GRAND_CODE);
    prx.addParam("DETAIL_CODE", parent.DETAIL_CODE);

    prx.onSuccess = function()
    {
        DETAIL_NAME.focus();
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
    if (parent.DETAIL_CODE == null) {
        prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.basecode.costcode.act.CreateCostDetailCode.do";
    } else {
        prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.basecode.costcode.act.UpdateCostDetailCode.do";
        prx.addParam("DETAIL_CODE", parent.DETAIL_CODE);
    }
    prx.addParam("GRAND_CODE", parent.GRAND_CODE);
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.basecode.costcode.act.DeleteCostDetailCode.do";
    prx.addParam("DETAIL_CODE", parent.DETAIL_CODE);
    prx.addParam("GRAND_CODE", parent.GRAND_CODE);

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
        <TD req="DETAIL_NAME">상세분류명</TD>
        <TD>
            <INPUT type="text" id="DETAIL_NAME" maxByte="300">
        </TD>
    </TR>
    <TR>
        <TD req="TAX_YN">과세여부</TD>
        <TD>
            <ANY:RADIO id="TAX_YN" codeData="{YES_NO}" value="1" />
        </TD>
    </TR>
    <TR>
        <TD req="DISP_ORD">표시순서</TD>
        <TD>
            <INPUT type="text" id="DISP_ORD" maxByte="3">
        </TD>
    </TR>
    <TR>
        <TD req="USE_YN">사용여부</TD>
        <TD>
            <ANY:RADIO id="USE_YN" codeData="{USE_YN}" value="1" />
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
