<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.share.common.app.ShareApp"%><% ShareApp app = new ShareApp(request, response, out); %>
<%@page import="anyfive.ipims.share.common.util.SystemTypes"%>
<%@page import="any.util.etc.NDateUtil"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>해외비용 INVOICE 작성</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("LETTER_SUBJECT");
    addBind("EXT_INVOICE_NO");
    addBind("EXT_INVOICE_FILE", "any_extInvoiceFile");
    addBind("EXT_OFFICE_CODE");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    LETTER_SUBJECT.value = "해외비용INVOICE (<%= NDateUtil.getFormatDate("yyyy/MM/dd") %>)";
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
    prx.path = top.getRoot() + "/anyfive.ipims.share.cost.extinvoice.act.CreateExtInvoice.do";
    prx.addParam("REF_ID", any_abstractInfo.refId);
    prx.addParam("REQ_ID", parent.REQ_ID);
    prx.addData("ds_mainInfo");
    prx.addData("ds_extInvoiceFile");

    prx.onSuccess = function()
    {
        parent.LETTER_SEQ = this.result;
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        window.location.replace("ExtInvoiceU.jsp");

    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
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
</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<% if (SystemTypes.OFFICE.equals(SystemTypes.getSystemType(request))) { %>
    <ANY:COSTSEARCH id="any_costSearch" inoutDiv="EXT" exAssetYNConfirm="1" style="display:block; margin-bottom:5px;" />
<% } else {%>
        <ANY:COSTSEARCH id="any_costSearch" inoutDiv="EXT" style="display:block; margin-bottom:5px;" />
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
        <TD colspan="4" class="title_table">[해외비용 INVOICE 정보]</TD>
    </TR>
    <TR>
        <TD>INVOICE 제목</TD>
        <TD colspan="3">
            <INPUT type="text" id="LETTER_SUBJECT" maxByte="2000" />
        </TD>
    </TR>
    <TR>
        <TD req="EXT_INVOICE_NO">해외 INVOICE 번호</TD>
        <TD>
            <INPUT type="text" id="EXT_INVOICE_NO" maxByte="30" />
        </TD>
        <TD req="EXT_OFFICE_CODE">해외사무소</TD>
        <TD>
            <ANY:SELECT id="EXT_OFFICE_CODE" codeData="/common/extOfficeCode" firstName="sel" />
        </TD>
    </TR>
    <TR>
        <TD req="any_extInvoiceFile">해외 INVOICE 파일</TD>
        <TD colspan="3">
            <ANY:FILE id="any_extInvoiceFile" mode="C" policy="cost_invoice" />
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
