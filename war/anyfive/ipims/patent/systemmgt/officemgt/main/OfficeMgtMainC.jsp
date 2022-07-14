<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>사무소 등록</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("COUNTRY_CODE");
    addBind("FIRM_HNAME");
    addBind("FIRM_ENAME");
    addBind("PRESIDENT_NAME");
    addBind("BUSINESS_NO");
    addBind("TELNO");
    addBind("FAXNO");
    addBind("ADDRESS");
    addBind("MAILID");
    addBind("DISP_ORD");
    addBind("USE_YN");
    addBind("SAP_CODE");
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.officemgt.main.act.CreateOfficeMgtMain.do";
    prx.addData("ds_mainInfo");

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        parent.OFFICE_CODE = this.result;
        window.location.replace("OfficeMgtMainUD.jsp");
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}
</SCRIPT>

<!-- 국가 변경시 -->
<SCRIPT language="JScript" for="COUNTRY_CODE" event="OnChange()">
    td_businessNo.reqEnable = (this.value == "KR");
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
        <TD>회사코드</TD>
        <TD disabled>(<%= app.message.get("msg.com.autocreate") %>)</TD>
        <TD req="COUNTRY_CODE">국가</TD>
        <TD>
            <ANY:SELECT id="COUNTRY_CODE" codeData="/common/countryCode" firstName="sel" />
        </TD>
    </TR>
    <TR>
        <TD req="FIRM_HNAME">회사명(한)</TD>
        <TD>
            <INPUT type="text" id="FIRM_HNAME" maxByte="50">
        </TD>
        <TD>회사명(영)</TD>
        <TD>
            <INPUT type="text" id="FIRM_ENAME" maxByte="50">
        </TD>
    </TR>
    <TR>
        <TD req="PRESIDENT_NAME">대표자성명</TD>
        <TD>
            <INPUT type="text" id="PRESIDENT_NAME" maxByte="30">
        </TD>
        <TD id="td_businessNo" req="BUSINESS_NO">사업자번호</TD>
        <TD>
            <INPUT type="text" id="BUSINESS_NO" maxByte="15">
        </TD>
    </TR>
    <TR>
        <TD req="TELNO">전화번호</TD>
        <TD>
            <INPUT type="text" id="TELNO" maxByte="30">
        </TD>
        <TD>팩스번호</TD>
        <TD>
            <INPUT type="text" id="FAXNO" maxByte="30">
        </TD>
    </TR>
    <TR>
        <TD>사무실주소</TD>
        <TD colspan="3">
            <INPUT type="text" id="ADDRESS" maxByte="300">
        </TD>
    </TR>
    <TR>
        <TD>대표메일</TD>
        <TD >
            <INPUT type="text" id="MAILID" maxByte="30" format="email">
        </TD>
        <TD>SAP_CODE</TD>
        <TD>
            <INPUT type="text" id="SAP_CODE" maxByte="10" >*회계처리 시스템(SAP)에 요청하여 부여받은 SAP_CODE 를 넣어주세요.
        </TD>
    </TR>
    <TR>
        <TD req="DISP_ORD">표시순서</TD>
        <TD>
            <INPUT type="text" id="DISP_ORD" maxByte="3" format="number" style="text-align:left;">
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
