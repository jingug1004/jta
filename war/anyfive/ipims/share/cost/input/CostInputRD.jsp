<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.share.common.app.ShareApp"%><% ShareApp app = new ShareApp(request, response, out); %>
<%@page import="anyfive.ipims.share.common.util.SystemTypes"%>
<%@page import="any.util.etc.NDateUtil"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>비용입력 상세</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("GRAND_NAME");
    addBind("DETAIL_NAME");
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
    addBind("OFFICE_NAME");
    addBind("CONFIRM_YN");
    <% } %>
    addBind("ABSTRACT");
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

    prx.path = top.getRoot() + "/anyfive.ipims.share.cost.input.act.RetrieveCost.do";
    prx.addParam("COST_SEQ", parent.COST_SEQ);

    prx.onSuccess = function(gr, fg)
    {
        any_abstractInfo.refId = ds_mainInfo.value(0, "REF_ID");

        cfShowObjects([btn_modify, btn_delete, btn_line], ds_mainInfo.value(0, "CONSULT_ID") == "");
    }

    prx.onFail = function(gr, fg)
    {
        this.error.show();
    }

    prx.execute();
}

//수정
function fnModify()
{
    window.location.href = "CostInputU.jsp";
}

//삭제
function fnDelete()
{
    if (!confirm("<%= app.message.get("msg.com.confirm.delete").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.share.cost.input.act.DeleteCost.do";
    prx.addParam("COST_SEQ", parent.COST_SEQ);

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

<!-- 서지사항 로딩시 -->
<SCRIPT language="JScript" for="any_abstractInfo" event="OnLoad()">
    var extShow = (this.value("MST_DIV") == "A" && this.value("INOUT_DIV") == "EXT");

    cfShowObjects(["obj_extItem"], extShow == true);
    cfShowObjects(["obj_intItem"], extShow != true);
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
        <TD>비용구분</TD>
        <TD><ANY:SPAN id="GRAND_NAME" /></TD>
        <TD>상세비용</TD>
        <TD><ANY:SPAN id="DETAIL_NAME" /></TD>
    </TR>
    <TR id="obj_extItem" style="display:none;">
        <TD>통화단위</TD>
        <TD><SPAN id="CURRENCY_UNIT"></SPAN></TD>
        <TD>환율/일자</TD>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD width="100%">
                        <INPUT type="text" id="EXCHANGE_RATIO" format="number2(6.2)" readOnly2>
                    </TD>
                    <TD width="1px">&nbsp;/&nbsp;</TD>
                    <TD>
                        <INPUT type="text" id="EXCHANGE_DATE" format="date" readOnly2>
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR id="obj_extItem" style="display:none;">
        <TD>해외관납비</TD>
        <TD>
            <INPUT type="text" id="EXT_GOVERNMENT_PAY" format="number2(-16.2)" readOnly2>
        </TD>
        <TD>해외사무소수수료</TD>
        <TD>
            <INPUT type="text" id="EXT_OFFICE_CHARGE" format="number2(-16.2)" readOnly2>
        </TD>
    </TR>
    <TR id="obj_extItem" style="display:none;">
        <TD>공통비</TD>
        <TD>
            <INPUT type="text" id="COMMON_PAY" format="number2(-16.2)" readOnly2>
        </TD>
        <TD>외화</TD>
        <TD>
            <INPUT type="text" id="PRICE" format="number2(-16.2)" readOnly2>
        </TD>
    </TR>
    <TR>
        <TD>원화(KRW)</TD>
        <TD>
            <INPUT type="text" id="WON_PRICE" format="number2(-16)" readOnly2>
        </TD>
        <TD>비용계정구분</TD>
        <TD>
            <ANY:RADIO id="COST_KIND" codeData="{APP_COST_KIND}" readOnly />
        </TD>
    </TR>
    <TR>
        <TD>비용처리</TD>
        <TD colspan="3">
            <ANY:RADIO id="COST_PROC_DIV" codeData="{COST_PROC_DIV}" readOnly />
        </TD>
    </TR>
    <% if (SystemTypes.PATENT.equals(SystemTypes.getSystemType(request))) { %>
    <TR>
        <TD>사무소</TD>
        <TD><SPAN id="OFFICE_NAME"></SPAN></TD>
        <TD>승인여부</TD>
        <TD>
            <ANY:RADIO id="CONFIRM_YN" codeData="{COST_CONFIRM_YN}" readOnly />
        </TD>
    </TR>
    <% } %>
    <TR>
        <TD>적요내용</TD>
        <TD colspan="3">
            <ANY:SPAN id="ABSTRACT" />
        </TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.modify").toHTML() %>" onClick="javascript:fnModify();" id="btn_modify" display="none"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.delete").toHTML() %>" onClick="javascript:fnDelete();" id="btn_delete" display="none"></BUTTON>
    <BUTTON auto="line" id="btn_line" display="none"></BUTTON>
    <BUTTON auto="list"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
