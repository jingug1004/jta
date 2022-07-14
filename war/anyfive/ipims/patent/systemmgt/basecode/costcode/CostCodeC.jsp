<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>비용대분류 작성</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("MST_DIV");
    addBind("INOUT_DIV");
    addBind("GRAND_NAME");
    addBind("USE_YN");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    GRAND_NAME.focus();
}

//저장
function fnSave()
{
    if (!cfCheckAllReqValid()) return;

    if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.basecode.costcode.act.CreateCostCode.do";
    prx.addData("ds_mainInfo");

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        parent.GRAND_CODE = this.result;
        window.location.replace("CostCodeUD.jsp");
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}
</SCRIPT>

<!-- 마스터구분 변경시 -->
<SCRIPT language="JScript" for="MST_DIV" event="OnChange()">
    INOUT_DIV.codeData = "{COST_INOUT_DIV" + (this.value == "A" ? "" : "_COM") + "}";
</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="1" cellpadding="2" class="main">
    <COLGROUP>
        <COL class="conthead" width="15%">
        <COL class="contdata" width="35%">
        <COL class="conthead" width="15%">
        <COL class="contdata" width="35%">
    </COLGROUP>
    <TR>
        <TD req="MST_DIV">구분</TD>
        <TD>
            <ANY:SELECT id="MST_DIV" codeData="{COST_MST_DIV}" />
        </TD>
        <TD req="INOUT_DIV">국내외구분</TD>
        <TD>
            <ANY:SELECT id="INOUT_DIV" codeData="{COST_INOUT_DIV}" />
        </TD>
    </TR>
    <TR>
        <TD req="GRAND_NAME">대분류명</TD>
        <TD>
            <INPUT type="text" id="GRAND_NAME" maxByte="500">
        </TD>
        <TD req="USE_YN">사용여부</TD>
        <TD>
            <ANY:RADIO id="USE_YN" codeData="{USE_YN}" value="1" />
        </TD>
    </TR>
</TABLE>
<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="list"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
