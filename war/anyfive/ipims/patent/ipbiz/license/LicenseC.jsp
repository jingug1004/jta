<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<%@page import="any.util.etc.NDateUtil"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>라이센스 작성</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("UTILIZE_TITLE");
    addBind("LICENSE_DIV");
    addBind("UTILIZE_DIV");
    addBind("TARGET_ENT");
    addBind("TARGET_ENT_CHARGE");
    addBind("ETC_CLS_CODE");
    addBind("OWN_TEL");
    addBind("MAIL_ADDR");
    addBind("CONTRACT_START_DATE");
    addBind("CONTRACT_END_DATE");
    addBind("LR_FIX_USE_PRICE");
    addBind("LR_CURRENCY_UNIT");
    addBind("LR_UNIT_YN");
    addBind("RR_FIX_USE_PRICE");
    addBind("RR_CURRENCY_UNIT");
    addBind("RR_UNIT_YN");
    addBind("ADD_COND");
    addBind("CONTRACT_STATUS");
    addBind("REASON");
    addBind("REMARK");
    addBind("ATTACH_FILE", "any_attachFile");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
}

//저장
function fnSave(isFileUploaded)
{
    if (!cfCheckAllReqValid()) return;

    if (isFileUploaded != true) {
        if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;
        cfFileUpload("fnSave(true);");
        return;
    }

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.ipbiz.license.act.CreateLicense.do";
    prx.addParam("CRE_USER","<%= app.userInfo.getUserId() %>");
    prx.addData("ds_mainInfo");
    prx.addData("ds_countryList");
    prx.addData("ds_attachFile");

    prx.onSuccess = function()
    {
        parent.LICENSE_ID = this.result;
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        window.location.replace("LicenseRD.jsp");
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
        <COL class="conthead" width="15%">
        <COL class="contdata" width="35%">
        <COL class="conthead" width="15%">
        <COL class="contdata" width="35%">
    </COLGROUP>
    <TR>
        <TD>관리번호</TD>
        <TD disabled>(<%= app.message.get("msg.com.autocreate") %>)</TD>
        <TD>작성자(작성일)</TD>
        <TD><%= app.userInfo.getEmpHname() %>(<%= NDateUtil.getFormatDate("yyyy/MM/dd") %>)</TD>
    </TR>
    <TR>
        <TD req="UTILIZE_TITLE">실시권의 명칭</TD>
        <TD colspan="3">
            <INPUT type="text" id="UTILIZE_TITLE" maxByte="1000" />
        </TD>
    </TR>
    <TR>
        <TD>관련자료 첨부</TD>
        <TD colspan="3">
            <ANY:FILE id="any_attachFile" mode="C" policy="ipbiz_license" />
        </TD>
    </TR>
    <TR>
        <TD req="LICENSE_DIV">라이센스 구분</TD>
        <TD>
            <ANY:RADIO id="LICENSE_DIV" codeData="{LICENSE_DIV}" />
        </TD>
        <TD req="UTILIZE_DIV">실시권 구분</TD>
        <TD>
            <ANY:RADIO id="UTILIZE_DIV" codeData="{UTILIZE_DIV}" />
        </TD>
    </TR>
    <TR>
        <TD req="TARGET_ENT">대상업체</TD>
        <TD>
            <INPUT type="text" id="TARGET_ENT" maxByte="100" />
        </TD>
        <TD req="TARGET_ENT">대상업체담당자</TD>
        <TD>
            <INPUT type="text" id="TARGET_ENT_CHARGE" maxByte="100"/>
        </TD>
    </TR>
    <TR>
        <TD>적용국가현황</TD>
        <TD colspan="3">
            <ANY:MSEARCH id="any_countryList" mode="C"><COMMENT>
                win.path = top.getRoot() + "/anyfive/ipims/patent/common/popup/search/CountrySearchListR.jsp";
                codeColumn = "COUNTRY_CODE";
                nameExpr = "[{#COUNTRY_CODE}] {#COUNTRY_NAME}";
                size = 4;
            </COMMENT></ANY:MSEARCH>
        </TD>
    </TR>
    <TR>
        <TD>통신방식코드</TD>
        <TD colspan="3">
            <INPUT type="text" id="ETC_CLS_CODE" maxByte="1000" />
        </TD>
    </TR>
    <TR>
        <TD req="OWN_TEL">대표전화</TD>
        <TD>
            <INPUT type="text" id="OWN_TEL" maxByte="20" />
        </TD>
        <TD req="MAIL_ADDR">E-mail</TD>
        <TD>
            <INPUT type="text" id="MAIL_ADDR" maxByte="50" format="email" />
        </TD>
    </TR>
    <TR>
        <TD>계약기간</TD>
        <TD>
            <ANY:DATE id="CONTRACT_START_DATE" />&nbsp;~
            <ANY:DATE id="CONTRACT_END_DATE" />
        </TD>
        <TD>실시료 L/R</TD>
        <TD>
            <TABLE border="0" width="100%" cellspacing="0" cellpadding="0">
                <TR>
                    <TD width="100%"><INPUT type="text" id="LR_FIX_USE_PRICE" format="number2(18.2)" /></TD>
                    <TD width="1px" style="padding-left:3px;"><ANY:SELECT id="LR_CURRENCY_UNIT" codeData="/ipbiz/currencyDiv" style="width:50px;" /></TD>
                    <TD noWrap><ANY:CHECK id="LR_UNIT_YN" text="UNIT당 여부" /></TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD>추가조건</TD>
        <TD>
            <INPUT type="text" id="ADD_COND" maxByte="1000" />
        </TD>
        <TD>실시료 R/R</TD>
        <TD>
            <TABLE border="0" width="100%" cellspacing="0" cellpadding="0">
                <TR>
                    <TD width="100%"><INPUT type="text" id="RR_FIX_USE_PRICE" format="number2(18.2)" /></TD>
                    <TD width="1px" style="padding-left:3px;"><ANY:SELECT id="RR_CURRENCY_UNIT" codeData="/ipbiz/currencyDiv" style="width:50px;" /></TD>
                    <TD noWrap><ANY:CHECK id="RR_UNIT_YN" text="UNIT당 여부" /></TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD req="CONTRACT_STATUS">계약상태</TD>
        <TD colspan="3">
            <TABLE border="0" width="100%" cellspacing="0" cellpadding="0">
                <TR>
                    <TD width="1%"><ANY:RADIO id="CONTRACT_STATUS" codeData="{CONTRACT_STATUS}"/></TD>
                    <TD width="1%" style="padding-left:5px;" noWrap><ANY:SPAN style="vertical-align:-20%;">사유:</ANY:SPAN></TD>
                    <TD width="100%" style="padding-left:2px;"><INPUT type="text" id="REASON" maxByte="200" /></TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD>비고</TD>
        <TD colspan="3">
            <TEXTAREA id="REMARK" rows="3" maxByte="4000"></TEXTAREA>
        </TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="list" list="LicenseListR.jsp"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
