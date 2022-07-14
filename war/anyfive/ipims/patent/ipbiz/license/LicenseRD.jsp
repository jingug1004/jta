<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<%@page import="any.util.etc.NDateUtil"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>라이센스 상세</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<% app.writeHTCImport(app.HTC_IPBHIST); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("MGT_NO");
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
    addBind("CRE_USER_NAME");
    addBind("CRE_DATE");
    addBind("ATTACH_FILE", "any_attachFile");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();
}

//목록 조회
function fnRetrieve()
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.ipbiz.license.act.RetrieveLicense.do";
    prx.addParam("LICENSE_ID", parent.LICENSE_ID);
    prx.checkData = ds_mainInfo;

    prx.onSuccess = function()
    {
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//수정
function fnModify()
{
    window.location.href = "LicenseU.jsp";
}

//삭제
function fnDelete()
{
    if (!confirm("<%= app.message.get("msg.com.confirm.delete").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.ipbiz.license.act.DeleteLicense.do";
    prx.addParam("LICENSE_ID", parent.LICENSE_ID);

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
        <TD><SPAN id="MGT_NO"></SPAN></TD>
        <TD>작성자(작성일)</TD>
        <TD><SPAN id="CRE_USER_NAME"></SPAN>(<ANY:SPAN id="CRE_DATE" format="date" />)</TD>
    </TR>
    <TR>
        <TD>관련자료 첨부</TD>
        <TD colspan="3">
            <ANY:FILE id="any_attachFile" mode="R" />
        </TD>
    </TR>
    <TR>
        <TD>실시권의 명칭</TD>
        <TD colspan="3"><SPAN id="UTILIZE_TITLE"></SPAN></TD>
    </TR>
    <TR>
        <TD>라이센스 구분</TD>
        <TD>
            <ANY:RADIO id="LICENSE_DIV" codeData="{LICENSE_DIV}" readOnly />
        </TD>
        <TD>실시권 구분</TD>
        <TD>
            <ANY:RADIO id="UTILIZE_DIV" codeData="{UTILIZE_DIV}" readOnly />
        </TD>
    </TR>
    <TR>
        <TD>대상업체</TD>
        <TD><SPAN id="TARGET_ENT"></SPAN></TD>
        <TD>대상업체담당자</TD>
        <TD><SPAN id="TARGET_ENT_CHARGE"></SPAN></TD>
    </TR>
    <TR>
        <TD>적용국가현황</TD>
        <TD colspan="3">
            <ANY:MSEARCH id="any_countryList" mode="R"><COMMENT>
                win.path = top.getRoot() + "/anyfive/ipims/patent/common/popup/search/CountrySearchListR.jsp";
                codeColumn = "COUNTRY_CODE";
                nameExpr = "[{#COUNTRY_CODE}] {#COUNTRY_NAME}";
                size = 4;
            </COMMENT></ANY:MSEARCH>
        </TD>
    </TR>
    <TR>
        <TD>통신방식코드</TD>
        <TD colspan="3"><SPAN id="ETC_CLS_CODE"></SPAN></TD>
    </TR>
    <TR>
        <TD>대표전화</TD>
        <TD><SPAN id="OWN_TEL"></SPAN></TD>
        <TD>E-mail</TD>
        <TD><SPAN id="MAIL_ADDR"></SPAN></TD>
    </TR>
    <TR>
        <TD>계약기간</TD>
        <TD>
            <ANY:SPAN id="CONTRACT_START_DATE" format="date" />&nbsp;~
            <ANY:SPAN id="CONTRACT_END_DATE" format="date" />
        </TD>
        <TD>실시료 L/R</TD>
        <TD>
            <TABLE border="0" width="100%" cellspacing="0" cellpadding="0">
                <TR>
                    <TD width="100%"><ANY:SPAN id="LR_FIX_USE_PRICE" format="number2" />&nbsp;(<SPAN id="LR_CURRENCY_UNIT"></SPAN>)</TD>
                    <TD noWrap><ANY:CHECK id="LR_UNIT_YN" text="UNIT당 여부" readOnly /></TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD>추가조건</TD>
        <TD><SPAN id="ADD_COND"></SPAN></TD>
        <TD>실시료 R/R</TD>
        <TD>
            <TABLE border="0" width="100%" cellspacing="0" cellpadding="0">
                <TR>
                    <TD width="100%"><ANY:SPAN id="RR_FIX_USE_PRICE" format="number2" />&nbsp;(<SPAN id="RR_CURRENCY_UNIT"></SPAN>)</TD>
                    <TD noWrap><ANY:CHECK id="RR_UNIT_YN" text="UNIT당 여부" readOnly /></TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD>계약상태</TD>
        <TD colspan="3">
            <TABLE border="0" width="100%" cellspacing="0" cellpadding="0">
                <TR>
                    <TD width="1%" noWrap><ANY:RADIO id="CONTRACT_STATUS" codeData="{CONTRACT_STATUS}" readOnly/></TD>
                    <TD width="1%" style="padding-left:5px;" noWrap><SPAN style="vertical-align:-20%;">사유:</SPAN></TD>
                    <TD width="100%" style="padding-left:2px;"><SPAN id="REASON"></SPAN></TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD>비고</TD>
        <TD colspan="3"><SPAN id="REMARK"></SPAN></TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.modify").toHTML() %>" onClick="javascript:fnModify();"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.delete").toHTML() %>" onClick="javascript:fnDelete();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="list" list="LicenseListR.jsp"></BUTTON>
</DIV>

<ANY:IPBHIST id="any_ipbHistory" style="height:250px;"><COMMENT>
    refId = parent.LICENSE_ID;
</COMMENT></ANY:IPBHIST>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
