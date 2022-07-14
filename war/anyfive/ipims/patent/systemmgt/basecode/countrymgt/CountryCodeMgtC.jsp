<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>국가정보 등록</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("COUNTRY_CODE");
    addBind("COUNTRY_NAME");
    addBind("CURRENCY_CODE");
    addBind("DISP_ORD");
    addBind("USE_YN");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    COUNTRY_CODE.focus();
}

//저장
function fnSave()
{
    if (!cfCheckAllReqValid()) return;

    if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.basecode.countrymgt.act.CreateCountryCodeMgt.do";
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
        <TD req="COUNTRY_CODE">국가코드</TD>
        <TD>
            <INPUT type="text" id="COUNTRY_CODE" maxByte="2" style="text-transform:uppercase;">
        </TD>
    </TR>
    <TR>
        <TD req="COUNTRY_NAME">국가명</TD>
        <TD>
            <INPUT type="text" id="COUNTRY_NAME" maxByte="50">
        </TD>
    </TR>
    <TR>
        <TD>통용화폐</TD>
        <TD>
            <INPUT type="text" id="CURRENCY_CODE" maxByte="3">
        </TD>
    </TR>
    <TR>
        <TD req="DISP_ORD">표시순서</TD>
        <TD>
            <INPUT type="text" id="DISP_ORD" maxByte="3" format="number" style="text-align:left;">
        </TD>
    </TR>
    <TR>
        <TD>사용여부</TD>
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
