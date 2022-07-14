<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.share.common.app.ShareApp"%><% ShareApp app = new ShareApp(request, response, out); %>
<%@page import="anyfive.ipims.share.common.util.SystemTypes"%>
<%@page import="any.util.etc.NDateUtil"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>비용입력</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("GRAND_CODE");
    addBind("DETAIL_CODE");
    addBind("CURRENCY_UNIT");
    addBind("EXCHANGE_RATIO");
    addBind("EXCHANGE_DATE");
    addBind("EXT_GOVERNMENT_PAY");
    addBind("EXT_OFFICE_CHARGE");
    addBind("COMMON_PAY");
    addBind("PRICE");
    addBind("WON_PRICE");
    addBind("COST_KIND");
    addBind("COST_PROC_DIV");
    <% if (SystemTypes.PATENT.equals(SystemTypes.getSystemType(request))) { %>
    addBind("OFFICE_CODE");
    addBind("CONFIRM_YN");
    <% } %>
    addBind("ABSTRACT");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    <% if (SystemTypes.OFFICE.equals(SystemTypes.getSystemType(request))) { %>
    ds_mainInfo.value(0, "OFFICE_CODE") = "<%= app.userInfo.getOfficeCode() %>";
    <% } %>

    if (parent.REF_ID == null) {
        any_costSearch.style.display = "block";
    } else {
        any_costSearch.style.display = "none";
        any_abstractInfo.refId = parent.REF_ID;
    }
}

//저장
function fnSave()
{
    if (any_abstractInfo.refId == null || any_abstractInfo.refId == "") {
        alert("비용을 입력할 건을 선택하세요.");
        return;
    }

    if (!cfCheckAllReqValid()) return;

    if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.share.cost.input.act.CreateCost.do";
    prx.addParam("REF_ID", any_abstractInfo.refId);
    prx.addParam("REQ_ID", parent.REQ_ID);
    prx.addParam("LETTER_SEQ", parent.LETTER_SEQ);
    prx.addData("ds_mainInfo");

    prx.onSuccess = function()
    {
        parent.gr.loader.reload();
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        EXT_GOVERNMENT_PAY.value = "";
        EXT_OFFICE_CHARGE.value = "";
        COMMON_PAY.value = "";
        WON_PRICE.value = "";
        PRICE.innerText = "";
        ABSTRACT.value = "";
        WON_PRICE.focus();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//금액 적용
function setPrice()
{
    extGovernmentPay = parseFloat(EXT_GOVERNMENT_PAY.value2, 10);
    extOfficeCharge = parseFloat(EXT_OFFICE_CHARGE.value2, 10);
    commonPay = parseFloat(COMMON_PAY.value2, 10);

    if (isNaN(extGovernmentPay)) extGovernmentPay = 0;
    if (isNaN(extOfficeCharge)) extOfficeCharge = 0;
    if (isNaN(commonPay)) commonPay = 0;

    PRICE.value2 = extGovernmentPay + extOfficeCharge + commonPay;

    setWonPrice();
}

//원화금액 적용
function setWonPrice()
{
    var exchangeRatio = parseFloat(EXCHANGE_RATIO.value2, 10);
    var price = parseFloat(PRICE.value2, 10);

   // WON_PRICE.value2 = exchangeRatio * price;
}
</SCRIPT>

<!-- 비용마스터 검색시 -->
<SCRIPT language="JScript" for="any_costSearch" event="OnSearch()">
    any_abstractInfo.refId = this.refId;
</SCRIPT>

<!-- 서지사항 로딩시 -->
<SCRIPT language="JScript" for="any_abstractInfo" event="OnLoad()">
    div_message.style.display = "none";
    div_content.style.display = "";

    <% if (SystemTypes.PATENT.equals(SystemTypes.getSystemType(request))) { %>
    OFFICE_CODE.value = this.value("OFFICE_CODE");
    <% } %>

    COST_KIND.value = (this.value("MST_DIV") == "A" ? "4" : "3");
    GRAND_CODE.codeData = "/costmgt/costGrandCodeByRef," + this.refId;

    var extShow = (this.value("MST_DIV") == "A" && this.value("INOUT_DIV") == "EXT");

    cfShowObjects(["obj_extItem"], extShow == true);
    cfShowObjects(["obj_intItem"], extShow != true);
</SCRIPT>

<!-- 대분류코드 변경시 -->
<SCRIPT language="JScript" for="GRAND_CODE" event="OnChange()">
    DETAIL_CODE.disabled = (this.value == "");
    if (this.value == ""){
        DETAIL_CODE.clearAll();
    } else {
        DETAIL_CODE.codeData = "/costmgt/costDetailCode," + this.value;
        DETAIL_CODE.index = 0;
    }
</SCRIPT>

<!-- 통화단위 변경시 -->
<SCRIPT language="JScript" for="CURRENCY_UNIT" event="OnChange()">
    td_extOfficeCharge.reqEnable = (this.value != "KRW");
</SCRIPT>

<!-- 환율 변경시 -->
<SCRIPT language="JScript" for="EXCHANGE_RATIO" event="OnChangeValue()">
    setWonPrice();
</SCRIPT>

<!-- 해외관납비 변경시 -->
<SCRIPT language="JScript" for="EXT_GOVERNMENT_PAY" event="OnChangeValue()">
    setPrice();
</SCRIPT>

<!-- 해외사무소수수료 변경시 -->
<SCRIPT language="JScript" for="EXT_OFFICE_CHARGE" event="OnChangeValue()">
    setPrice();
</SCRIPT>

<!-- 공통비 변경시 -->
<SCRIPT language="JScript" for="COMMON_PAY" event="OnChangeValue()">
    setPrice();
</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<% if (SystemTypes.OFFICE.equals(SystemTypes.getSystemType(request))) { %>
    <ANY:COSTSEARCH id="any_costSearch" inoutDiv="INT" exAssetYNConfirm="1" style="display:none; margin-bottom:5px;" />
<% } else {%>
    <ANY:COSTSEARCH id="any_costSearch" inoutDiv="INT" style="display:none; margin-bottom:5px;" />
<% } %>

<DIV id="div_message" style="width:100%; margin-top:50px; text-align:center; color:gray;">
(비용을 입력할 건을 선택하세요)
</DIV>

<DIV id="div_content" style="display:none;">
<ANY:ABSTRACT id="any_abstractInfo"<% if (SystemTypes.PATENT.equals(SystemTypes.getSystemType(request))) { %> masterLink="true"<% } %> />

<TABLE border="0" cellspacing="1" cellpadding="2" class="main" style="margin-top:5px;">
    <COLGROUP>
        <COL class="conthead" width="15%">
        <COL class="contdata" width="35%">
        <COL class="conthead" width="15%">
        <COL class="contdata" width="35%">
    </COLGROUP>
    <TR>
        <TD colspan="4" class="title_table">[비용 내역]</TD>
    </TR>
    <TR>
        <TD req="GRAND_CODE">비용구분</TD>
        <TD>
            <ANY:SELECT id="GRAND_CODE" firstName="sel" />
        </TD>
        <TD req="DETAIL_CODE">상세비용</TD>
        <TD>
            <ANY:SELECT id="DETAIL_CODE" firstName="sel" disabled />
        </TD>
    </TR>
    <TR id="obj_extItem" style="display:none;">
        <TD>통화단위</TD>
        <TD>
            <ANY:SELECT id="CURRENCY_UNIT" codeData="/common/currencyCode" value="KRW" />
        </TD>
        <TD>환율/일자</TD>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD width="100%">
                        <INPUT type="text" id="EXCHANGE_RATIO" format="number2(6.2)">
                    </TD>
                    <TD noWrap style="padding-left:3px;">
                        <ANY:DATE id="EXCHANGE_DATE" />
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR id="obj_extItem" style="display:none;">
        <TD>해외관납비</TD>
        <TD>
            <INPUT type="text" id="EXT_GOVERNMENT_PAY" format="number2(-16.2)">
        </TD>
        <TD req="EXT_OFFICE_CHARGE" id="td_extOfficeCharge">해외사무소수수료</TD>
        <TD>
            <INPUT type="text" id="EXT_OFFICE_CHARGE" format="number2(-16.2)">
        </TD>
    </TR>
    <TR id="obj_extItem" style="display:none;">
        <TD>공통비</TD>
        <TD>
            <INPUT type="text" id="COMMON_PAY" format="number2(-16.2)">
        </TD>
        <TD>외화</TD>
        <TD>
            <INPUT type="text" id="PRICE" format="number2(-16.2)" readOnly2>
        </TD>
    </TR>
    <TR>
        <TD>원화(KRW)</TD>
        <TD>
            <INPUT type="text" id="WON_PRICE" format="number2(-16)">
        </TD>
        <TD req="COST_KIND">비용계정구분</TD>
        <TD>
            <ANY:RADIO id="COST_KIND" codeData="{APP_COST_KIND}" />
        </TD>
    </TR>
    <TR>
        <TD>비용처리</TD>
        <TD colspan="3">
            <ANY:RADIO id="COST_PROC_DIV"  codeData="{COST_PROC_DIV}"  value="1" />
        </TD>
    </TR>
    <% if (SystemTypes.PATENT.equals(SystemTypes.getSystemType(request))) { %>
    <TR>
        <TD>사무소</TD>
        <TD>
            <ANY:SELECT id="OFFICE_CODE" codeData="/common/intOfficeCode" firstName="sel" />
        </TD>
        <TD>승인여부</TD>
        <TD>
            <ANY:RADIO id="CONFIRM_YN" codeData="{COST_CONFIRM_YN}" value="1" />
        </TD>
    </TR>
    <% } %>
    <TR>
        <TD>적요내용</TD>
        <TD colspan="3">
            <TEXTAREA id="ABSTRACT" rows="6" maxByte="4000"></TEXTAREA>
        </TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="list"></BUTTON>
</DIV>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
