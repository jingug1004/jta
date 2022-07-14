<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>사무소 수정</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("OFFICE_CODE");
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
    fnRetrieve();
}

//조회
function fnRetrieve()
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.officemgt.main.act.RetrieveOfficeMgtMain.do";
    prx.addParam("OFFICE_CODE", parent.OFFICE_CODE);
    prx.checkData = ds_mainInfo;

    prx.onSuccess = function()
    {
        FIRM_HNAME.focus();
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.officemgt.main.act.UpdateOfficeMgtMain.do";
    prx.addParam("OFFICE_CODE", parent.OFFICE_CODE);
    prx.addData("ds_mainInfo");

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.officemgt.main.act.DeleteOfficeMgtMain.do";
    prx.addParam("OFFICE_CODE", parent.OFFICE_CODE);

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.delete").toJS() %>");
        parent.goList();
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
        <TD><SPAN id="OFFICE_CODE"></SPAN></TD>
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
        <TD >
            <INPUT type="text" id="SAP_CODE" maxByte="30" >
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
    <BUTTON text="<%= app.message.get("btn.com.delete").toHTML() %>" onClick="javascript:fnDelete();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="list"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
