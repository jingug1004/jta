<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<%@page import="any.util.etc.NDateUtil"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>청구비용 업로드</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    var ldr = new any.excelImporter();
    ldr.templateFile = "/excel/PaymentList.xls";
    ldr.saveAction = top.getRoot() + "/anyfive.ipims.patent.costmgt.annual.payment.act.UploadAnnualPayment.do";
    ldr.saveParams = function()
    {
        if (cfCheckAllReqValid()) return { OFFICE_CODE:OFFICE_CODE.value, REQ_DATE:REQ_DATE.value };
    }
    ldr.create(div_excel);
}

//확인
function fnConfirm()
{
    if (!cfCheckAllReqValid()) return;

    var rtn = new Object();

    rtn.OFFICE_CODE = OFFICE_CODE.value;
    rtn.REQ_DATE = REQ_DATE.value;

    top.window.returnValue = rtn;
    top.window.close();
}
</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
    <TR>
        <TD height="1">
            <TABLE border="0" cellspacing="1" cellpadding="2" class="main">
                <COLGROUP>
                    <COL class="conthead" width="15%">
                    <COL class="contdata" width="35%">
                    <COL class="conthead" width="15%">
                    <COL class="contdata" width="35%">
                </COLGROUP>
                <TR>
                    <TD>사무소</TD>
                    <TD>
                        <ANY:SELECT id="OFFICE_CODE" codeData="/common/officeCode" firstName="sel" />
                    </TD>
                    <TD req="REQ_DATE">청구일자</TD>
                    <TD>
                        <ANY:DATE id="REQ_DATE" value="<%= NDateUtil.getSysDate() %>" />
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD height="10"></TD>
    </TR>
    <TR>
        <TD height="100%">
            <DIV id="div_excel"></DIV>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
