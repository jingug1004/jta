<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.share.common.app.ShareApp"%><% ShareApp app = new ShareApp(request, response, out); %>
<%@page import="anyfive.ipims.share.common.util.SystemTypes"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>국내비용청구서 상세</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("REQ_SUBJECT");
    <% if (SystemTypes.PATENT.equals(SystemTypes.getSystemType(request))) { %>
    addBind("OFFICE_NAME");
    <% } %>
    addBind("REQ_YN_NAME");
    addBind("INVOICE_NO");
    addBind("REQ_WON_PRICE");
    addBind("SUPER_TAX");
    addBind("INVOICE_FILE", "any_invoiceFile");
</COMMENT></ANY:DS>
<ANY:DS id="ds_intCostList" />
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
        <% if (SystemTypes.PATENT.equals(SystemTypes.getSystemType(request))) { %>
        gr_intCostList.fg.ColHidden(gr_intCostList.fg.ColIndex("ROW_CHK")) = (ds_mainInfo.value(0, "CONSULT_ID") != "");
        cfShowObjects([td_confirm], ds_mainInfo.value(0, "CONSULT_ID") == "");
        cfShowObjects([tr_return,btn_consult_return, btn_line4], ds_mainInfo.value(0, "REQ_YN") == "1" && ds_mainInfo.value(0, "CONSULT_ID") == "");
        <% } %>

        cfShowObjects([btn_modify, btn_delete, btn_line1, btn_consult, btn_line2], ds_mainInfo.value(0, "REQ_YN") == "0");

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

//비용 상세목록 조회
function fnRetrieveCostList()
{
    var ldr = gr_intCostList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.share.cost.request.act.RetrieveIntCostDetailList.do";
    ldr.addParam("REQ_ID", parent.REQ_ID);

    ldr.onSuccess = function(gr, fg)
    {
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

//수정
function fnModify()
{
    window.location.href = "IntCostRequestU.jsp";
}

//삭제
function fnDelete()
{
    if (!confirm("<%= app.message.get("msg.com.confirm.delete").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.share.cost.request.act.DeleteIntCostRequest.do";
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

//비용 상세
function fnDetailCost(gr, fg, row, colId)
{
    var win = new any.window();
    win.path = top.getRoot() + "/anyfive/ipims/share/cost/input/CostInputRD.jsp";
    win.arg.COST_SEQ = gr.value(row, "COST_SEQ");
    win.arg.gr = gr;
    win.opt.width = 800;
    win.opt.height = 600;

    win.onReload = function()
    {
    }

    win.show();
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
        window.location.href = "IntCostRequestU.jsp";
    }

    prx.execute();
}

<% if (SystemTypes.PATENT.equals(SystemTypes.getSystemType(request))) { %>

//청구서 반려처리
function fnReConsult()
{
    if(RETURN_REQ_MEMO.value == "" ){
        alert("청구서 반려 사유를 입력하여 주십시요.");
        RETURN_REQ_MEMO.focus();
        return;
    }
    if (!confirm("청구서 반려처리 하시겠습니까?")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.share.cost.request.act.UpdateReCostRequestConfirm.do";
    prx.addParam("REQ_ID", parent.REQ_ID);
    prx.addParam("RETURN_REQ_MEMO", RETURN_REQ_MEMO.value);

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

//일괄확인
function fnConfirmCost()
{
    if (CONFIRM_YN.value == "") {
        alert("비용승인 여부를 선택하세요.");
        return ;
    }

    if (!confirm("승인여부를 일괄수정 하시겠습니까?")) return;

    var gr = document.getElementById("gr_intCostList");
    var ds = document.getElementById("ds_intCostList");

    ds.init();

    for (var r = gr.fg.FixedRows; r < gr.fg.Rows; r++) {
        if (gr.checked(r, "ROW_CHK") == true) ds.value(ds.addRow(), "COST_SEQ") = gr.value(r, "COST_SEQ");
    }

    if (ds.rowCount == 0) {
        alert("선택된 건이 없습니다");
        return;
    }

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.share.cost.request.act.UpdateIntCostConfirmYn.do";
    prx.addParam("CONFIRM_YN", CONFIRM_YN.value);
    prx.addData(ds);

    prx.onSuccess = function()
    {
        alert("처리되었습니다.");
        gr_intCostList.loader.reload();
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
                    <COL class="conthead" width="15%">
                    <COL class="contdata" width="35%">
                    <COL class="conthead" width="15%">
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
                    <TD>청구상태</TD>
                    <TD ><ANY:SPAN id="REQ_YN_NAME" /></TD>
                    <TD>청구금액</TD>
                    <TD><ANY:SPAN id="REQ_WON_PRICE" format="number2" /></TD>
                </TR>
                <TR>
                    <TD>INVOICE 번호</TD>
                    <TD><ANY:SPAN id="INVOICE_NO" /></TD>
                    <TD>부가세 금액</TD>
                    <TD><ANY:SPAN id="SUPER_TAX" format="number2" /></TD>
                </TR>
                <TR>
                    <TD>INVOICE 파일</TD>
                    <TD colspan="3">
                        <ANY:FILE id="any_invoiceFile" mode="R" />
                    </TD>
                </TR>
                 <% if (SystemTypes.PATENT.equals(SystemTypes.getSystemType(request))) { %>
                <TR id="tr_return" style="display:none;">
                    <TD>청구서 반려 사유</TD>
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
                <BUTTON text="청구" onClick="javascript:fnConsult();" id="btn_consult" display="none"></BUTTON>
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
                    <TD class="title_sub">비용 목록</TD>
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
            <ANY:GRID id="gr_intCostList" pagingType="0" minHeight="200px"><COMMENT>
                <% if (SystemTypes.PATENT.equals(SystemTypes.getSystemType(request))) { %>
                addColumn({ width:30 , align:"center", type:"check" , sort:false, id:"ROW_CHK"             , hide:true });
                <% } %>
                addColumn({ width:120, align:"left"  , type:"string", sort:true , id:"REF_NO"              , name:"REF-NO" });
                addColumn({ width:50 , align:"center", type:"string", sort:true , id:"INOUT_DIV_NAME"      , name:"국내외" });
                addColumn({ width:60 , align:"center", type:"string", sort:true , id:"RIGHT_DIV_NAME"      , name:"권리구분" });
                addColumn({ width:60 , align:"center", type:"string", sort:true , id:"CONFIRM_STATUS"      , name:"승인현황" });
                addColumn({ width:60 , align:"center", type:"string", sort:true , id:"CHECKS"              , name:"중복여부" });
                addColumn({ width:60 , align:"center", type:"string", sort:true , id:"COST_PROC_DIV_NAME"  , name:"비용처리" });
                addColumn({ width:80 , align:"center", type:"string", sort:true , id:"COST_KIND_NAME"      , name:"비용종류" });
                addColumn({ width:130, align:"left"  , type:"string", sort:true , id:"KO_APP_TITLE"        , name:"발명의 명칭" });
                addColumn({ width:120, align:"left"  , type:"string", sort:true , id:"GRAND_NAME"          , name:"대분류" });
                addColumn({ width:120, align:"left"  , type:"string", sort:true , id:"DETAIL_NAME"         , name:"상세분류" });
                addColumn({ width:90 , align:"right" , type:"number", sort:true , id:"WON_PRICE"           , name:"원화금액" , format:"#,###" });
                addColumn({ width:100 , align:"right" , type:"number", sort:true , id:"TAX"                 , name:"부가세금액" , format:"#,###" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"APP_NO"              , name:"출원번호" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"APP_DATE"            , name:"출원일" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"REG_NO"              , name:"등록번호" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"REG_DATE"            , name:"등록일" });
                addColumn({ width:60 , align:"center", type:"string", sort:true , id:"JOB_MAN_NAME"        , name:"건담당자" });
                addColumn({ width:150 , align:"left", type:"string", sort:true , id:"PJT_NAME"             , name:"프로젝트이름" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"PJT_END_DATE"        , name:"수행종료일" });
                messageSpan = "spn_gridMessage";
                setFixedColumn(null, "REF_NO");
                addAction("REF_NO", fnDetailCost);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
    <% if (SystemTypes.PATENT.equals(SystemTypes.getSystemType(request))) { %>
    <TR>
        <TD height="1" id="td_confirm" style="display:none;">
            <DIV class="button_area">
                <TABLE border="0" cellspacing="0" cellpadding="0">
                    <TR>
                        <TD>
                            <ANY:RADIO id="CONFIRM_YN" codeData="{COST_CONFIRM_YN}" style="width:100px;" />
                        </TD>
                        <TD>
                            <BUTTON text="일괄확인" onClick="javascript:fnConfirmCost();"></BUTTON>
                        </TD>
                    </TR>
                </TABLE>
            </DIV>
        </TD>
    </TR>
    <% } %>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
