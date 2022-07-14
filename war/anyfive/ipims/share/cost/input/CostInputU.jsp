<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.share.common.app.ShareApp"%><% ShareApp app = new ShareApp(request, response, out); %>
<%@page import="anyfive.ipims.share.common.util.SystemTypes"%>
<%@page import="any.util.etc.NDateUtil"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>비용입력 수정</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("GRAND_CODE");
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

    fnRetrieve();
}

//조회
function fnRetrieve()
{
    var prx = new any.proxy();

    prx.path = top.getRoot() + "/anyfive.ipims.share.cost.input.act.RetrieveCost.do";
    prx.addParam("COST_SEQ", parent.COST_SEQ);

    prx.onSuccess = function(gr, fg)
    {
        any_abstractInfo.refId = ds_mainInfo.value(0, "REF_ID");

        GRAND_CODE.codeData = "/costmgt/costGrandCodeByRef," + ds_mainInfo.value(0, "REF_ID");
        DETAIL_CODE.value = ds_mainInfo.value(0, "DETAIL_CODE");
        ds_mainInfo.addBind("DETAIL_CODE");
    }

    prx.onFail = function(gr, fg)
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
    prx.path = top.getRoot() + "/anyfive.ipims.share.cost.input.act.UpdateCost.do";
    prx.addParam("COST_SEQ", parent.COST_SEQ);
    prx.addParam("REF_ID", parent.REF_ID);
    prx.addData("ds_mainInfo");

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        fnDetail();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();

}

//상세
function fnDetail()
{
    window.location.replace("CostInputRD.jsp");
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

    WON_PRICE.value2 = exchangeRatio * price;
}
</SCRIPT>

<!-- 서지사항 로딩시 -->
<SCRIPT language="JScript" for="any_abstractInfo" event="OnLoad()">
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

</SCRIPT>



<!-- 공통비 변경시 -->
<SCRIPT language="JScript" for="COMMON_PAY" event="OnChangeValue()">
    setPrice();
</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
    <TR>
        <TD height="5"></TD>
    </TR>
    <TR>
        <TD height="1">
            <ANY:ABSTRACT id="any_abstractInfo"<% if (SystemTypes.PATENT.equals(SystemTypes.getSystemType(request))) { %> masterLink="true"<% } %> />
        </TD>
    </TR>
    <TR>
        <TD height="5"></TD>
    </TR>
</TABLE>

<TABLE border="0" cellspacing="1" cellpadding="2" class="main">
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
            <ANY:SELECT id="DETAIL_CODE" firstName="sel" />
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
        <TD id="td_extOfficeCharge">해외사무소수수료</TD>
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
        <TD >원화(KRW)</TD>
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
            <ANY:RADIO id="COST_PROC_DIV"  codeData="{COST_PROC_DIV}"  />
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
            <ANY:RADIO id="CONFIRM_YN" codeData="{COST_CONFIRM_YN}" />
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
    <BUTTON text="<%= app.message.get("btn.com.cancel").toHTML() %>" onClick="javascript:fnDetail();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="list"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
