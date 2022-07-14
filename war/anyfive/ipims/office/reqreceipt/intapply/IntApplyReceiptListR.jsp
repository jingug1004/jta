<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.office.common.app.OfficeApp"%><% OfficeApp app = new OfficeApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>국내출원의뢰접수</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();
}

//목록 조회
function fnRetrieve()
{
    var ldr = gr_intApplyReqList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.office.reqreceipt.intapply.act.RetrieveIntApplyReceiptList.do";
    ldr.addParam("RECEIPT_YN", RECEIPT_YN.value);
    ldr.addParam("REF_NO", REF_NO.value);
    ldr.addParam("DATE_START", DATE_START.value);
    ldr.addParam("DATE_END", DATE_END.value);

    ldr.onSuccess = function(gr, fg)
    {
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

//상세
function fnDetail(gr, fg, row, colId)
{
    var win = new any.viewer();
    win.path = "IntApplyReceiptU.jsp";
    win.arg.REF_ID = gr.value(row, "REF_ID");

    win.onReload = function()
    {
        gr.loader.reload();
    }

    win.show();
}
</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
    <TR>
        <TD>
            <TABLE border="0" cellspacing="1" cellpadding="2" class="main" onEnter="javascript:fnRetrieve();">
                <COLGROUP>
                    <COL class="condhead" width="10%">
                    <COL class="conddata" width="23%">
                    <COL class="condhead" width="10%">
                    <COL class="conddata" width="23%">
                    <COL class="condhead" width="10%">
                    <COL class="conddata" width="23%">
                </COLGROUP>
                <TR>
                    <TD>REF-NO</TD>
                    <TD>
                        <INPUT type="text" id="REF_NO">
                    </TD>
                    <TD>의뢰일</TD>
                    <TD noWrap>
                        <ANY:DATE id="DATE_START" />&nbsp;~
                        <ANY:DATE id="DATE_END" />
                    </TD>
                    <TD>상태</TD>
                    <TD>
                        <ANY:SELECT id="RECEIPT_YN" codeData="/reqreceipt/receiptYn" />
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD height="5"></TD>
    </TR>
    <TR>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD><SPAN id="spn_gridMessage"></SPAN></TD>
                    <TD align="right">
                        <BUTTON auto="retrieve" onClick="javascript:fnRetrieve();"></BUTTON>
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD height="5"></TD>
    </TR>
    <TR>
        <TD height="100%">
            <ANY:GRID id="gr_intApplyReqList" pagingType="1"><COMMENT>
                addColumn({ width:120, align:"left"  , type:"string", sort:true , id:"REF_NO"               , name:"REF-NO" });
                addColumn({ width:80 , align:"center", type:"string", sort:true , id:"RIGHT_DIV_NAME"       , name:"구분" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"DIVISION_TYPE_NAME"   , name:"분할출원" });
                addColumn({ width:200, align:"left"  , type:"string", sort:true , id:"KO_APP_TITLE"         , name:"발명의 명칭" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"OFFICE_SEND_DATE"     , name:"의뢰일" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"OFFICE_RCPT_DATE"     , name:"접수일" });
                useConfig = true;
                messageSpan = "spn_gridMessage";
                addSorting("OFFICE_SEND_DATE", "ASC");
                addAction("KO_APP_TITLE", fnDetail);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
