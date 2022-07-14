<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.share.common.app.ShareApp"%><% ShareApp app = new ShareApp(request, response, out); %>
<%@page import="anyfive.ipims.share.common.util.SystemTypes"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>해외비용청구서 상세</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("REQ_SUBJECT");
    <% if (SystemTypes.PATENT.equals(SystemTypes.getSystemType(request))) { %>
    addBind("OFFICE_NAME");
    <% } %>
    addBind("INVOICE_NO");
    addBind("REQ_YN_NAME");
    addBind("REQ_WON_PRICE");
    addBind("REQ_PRICE");
    addBind("SUPER_TAX");
    addBind("INVOICE_FILE", "any_invoiceFile");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();
    fnRetrieveCostList();
}

//조회
function fnRetrieve()
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.share.cost.request.act.RetrieveCostRequest.do";
    prx.addParam("REQ_ID", parent.REQ_ID);
    prx.checkData = ds_mainInfo;

    prx.onSuccess = function()
    {
        cfShowObjects([btn_modify, btn_delete, btn_line1, btn_consult, btn_line2], ds_mainInfo.value(0, "REQ_YN") == "0");
        <% if (SystemTypes.PATENT.equals(SystemTypes.getSystemType(request))) { %>
        cfShowObjects([tr_return_kind,tr_return,btn_consult_return, btn_line4], ds_mainInfo.value(0, "REQ_YN") == "1" && ds_mainInfo.value(0, "CONSULT_ID") == "");
        <% } %>
        if (ds_mainInfo.value(0, "INVOICE_NO") == "") {
            btn_consult.disabled = true;
            btn_consult.title = "INVOICE 번호를 먼저 입력해야 합니다.";
        } else {
            btn_consult.disabled = false;
            btn_consult.title = "";
        }
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//해외비용 INVOICE 상세목록 조회
function fnRetrieveCostList()
{
    var ldr = gr_extInvoiceList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.share.cost.request.act.RetrieveExtInvoiceDetailList.do";
    ldr.addParam("REQ_ID", parent.REQ_ID);

    ldr.onSuccess = function()
    {
    }

    ldr.onFail = function()
    {
        this.error.show();
    }

    ldr.execute();
}

//해외비용 INVOICE 상세
function fnDetailInvoice(gr, fg, row, colId)
{
    var win = new any.window();
    win.path = top.getRoot() + "/anyfive/ipims/share/cost/extinvoice/ExtInvoiceRD.jsp";
    win.arg.LETTER_SEQ = gr.value(row, "LETTER_SEQ");
    win.arg.gr = gr_extInvoiceList;
    win.opt.width = 850;
    win.opt.height = 700;
    win.opt.resizable = "yes";

    win.onReload = function()
    {
    }

    win.show();
}

//수정
function fnModify()
{
    window.location.href = "ExtCostRequestU.jsp";
}

//삭제
function fnDelete()
{
    if (!confirm("<%= app.message.get("msg.com.confirm.delete").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.share.cost.request.act.DeleteExtInvoiceRequest.do";
    prx.addParam("REQ_ID", parent.REQ_ID);

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

//청구
function fnConsult()
{
    if (!confirm("청구하시겠습니까?")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.share.cost.request.act.UpdateCostRequestConfirm.do";
    prx.addParam("REQ_ID", parent.REQ_ID);

    prx.onSuccess = function()
    {
        alert("처리되었습니다.");
        fnRetrieve();
    }

    prx.onFail = function()
    {
        this.error.show();
        window.location.href = "ExtCostRequestU.jsp";
    }

    prx.execute();
}
<% if (SystemTypes.PATENT.equals(SystemTypes.getSystemType(request))) { %>
//청구서 반려처리
function fnReConsult()
{

    if (!cfCheckAllReqValid()) return;
    if (!confirm("청구서 반려처리 하시겠습니까?")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.share.cost.request.act.UpdateReCostRequestConfirm.do";
    prx.addParam("REQ_ID", parent.REQ_ID);
    prx.addParam("RETURN_REQ_MEMO", RETURN_REQ_MEMO.value);
    prx.addParam("RETURN_KIND", RETURN_KIND.value);

    prx.onSuccess = function()
    {
        alert("처리되었습니다.");
        window.close();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}
<% } %>

</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
    <TR>
        <TD>
            <TABLE border="0" cellspacing="1" cellpadding="2" class="main">
                <COLGROUP>
                    <COL class="conthead" width="17%">
                    <COL class="contdata" width="35%">
                    <COL class="conthead" width="13%">
                    <COL class="contdata" width="35%">
                </COLGROUP>
                <TR>
                    <TD>청구서 제목</TD>
                    <TD colspan="3"><ANY:SPAN id="REQ_SUBJECT" /></TD>
                </TR>
                <% if (SystemTypes.PATENT.equals(SystemTypes.getSystemType(request))) { %>
                <TR>
                    <TD>사무소</TD>
                    <TD colspan="3"><ANY:SPAN id="OFFICE_NAME" /></TD>
                </TR>
                <% } %>
                <TR>
                    <TD>INVOICE 번호</TD>
                    <TD><ANY:SPAN id="INVOICE_NO" /></TD>
                    <TD>청구상태</TD>
                    <TD><ANY:SPAN id="REQ_YN_NAME" /></TD>
                </TR>
                <TR>
                    <TD>청구금액/부가세(원화)</TD>
                    <TD><ANY:SPAN id="REQ_WON_PRICE" format="number2" />/
                        <ANY:SPAN id="SUPER_TAX" format="number2" />
                    </TD>
                    <TD>청구금액(외화)</TD>
                    <TD><ANY:SPAN id="REQ_PRICE" format="number2" /></TD>
                </TR>
                <TR>
                    <TD>INVOICE 파일 또는<br>송금영수증</TD>
                    <TD colspan="3">
                        <ANY:FILE id="any_invoiceFile" mode="R" />
                    </TD>
                </TR>
                <% if (SystemTypes.PATENT.equals(SystemTypes.getSystemType(request))) { %>
                <TR id="tr_return_kind" style="display:none;">
                    <TD req="RETURN_KIND">반려구분</TD>
                    <TD colspan="3">
                        <ANY:RADIO id="RETURN_KIND" codeData="{RETURN_KIND}" />
                    </TD>
                </TR>
                <TR id="tr_return" style="display:none;">
                    <TD req="RETURN_REQ_MEMO">청구서 반려 사유</TD>
                    <TD colspan="3">
                        <TEXTAREA id="RETURN_REQ_MEMO" rows="4" maxByte="4000"></TEXTAREA>
                    </TD>
                </TR>
                <% } %>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD>
            <DIV class="button_area">
                <BUTTON text="<%= app.message.get("btn.com.modify").toHTML() %>" onClick="javascript:fnModify();" id="btn_modify" display="none"></BUTTON>
                <BUTTON text="<%= app.message.get("btn.com.delete").toHTML() %>" onClick="javascript:fnDelete();" id="btn_delete" display="none"></BUTTON>
                <BUTTON auto="line" id="btn_line1" display="none"></BUTTON>
                <BUTTON text="청구" onClick="javascript:fnConsult();" id="btn_consult" disabled></BUTTON>
                <BUTTON auto="line" id="btn_line2" display="none"></BUTTON>
                <BUTTON text="청구서 반려" onClick="javascript:fnReConsult();" id="btn_consult_return" display="none"></BUTTON>
                <BUTTON auto="line" id="btn_line4" display="none"></BUTTON>
                <BUTTON auto="list"></BUTTON>
            </DIV>
        </TD>
    </TR>
    <TR>
        <TD height="10"></TD>
    </TR>
    <TR>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD class="title_sub">해외비용 INVOICE 목록</TD>
                    <TD align="right">
                        <SPAN id="spn_gridMessage"></SPAN>
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
            <ANY:GRID id="gr_extInvoiceList" pagingType="0" minHeight="200px"><COMMENT>
                addHeader([ null, null, "승인현황", "", "", null, null, null, null, null ]);
                addColumn({ width:120, align:"left"  , type:"string", sort:true , id:"REF_NO"           , name:"REF-NO" });
                addColumn({ width:150, align:"left"  , type:"string", sort:true , id:"LETTER_SUBJECT"   , name:"INVOICE 제목" });
                addColumn({ width:60 , align:"center", type:"number", sort:true , id:"CNT_CNF_NULL"     , name:"미확인" });
                addColumn({ width:60 , align:"center", type:"number", sort:true , id:"CNT_CNF_YES"      , name:"승인" });
                addColumn({ width:60 , align:"center", type:"number", sort:true , id:"CNT_CNF_NO"       , name:"반려" });
                addColumn({ width:80 , align:"right" , type:"number", sort:true , id:"WON_PRICE"        , name:"원화금액" , format:"#,###" });
                addColumn({ width:80 , align:"right" , type:"number", sort:true , id:"PRICE"            , name:"외화금액" , format:"#,##0.##" });
                addColumn({ width:120, align:"left"  , type:"string", sort:true , id:"EXT_INVOICE_NO"   , name:"해외청구서번호" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"APP_NO"           , name:"출원번호" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"APP_DATE"         , name:"출원일" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"REG_NO"           , name:"등록번호" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"REG_DATE"         , name:"등록일" });
                addColumn({ width:60 , align:"center", type:"string", sort:true , id:"CRE_USER_NAME"    , name:"작성자" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"CRE_DATE"         , name:"작성일" });
                addColumn({ width:150 , align:"left", type:"string", sort:true , id:"PJT_NAME"          , name:"프로젝트이름" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"PJT_END_DATE"     , name:"수행종료일" });
                messageSpan = "spn_gridMessage";
                setFixedColumn(null, "LETTER_SUBJECT");
                addSorting("REF_NO", "DESC");
                addAction("LETTER_SUBJECT", fnDetailInvoice);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
