<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.share.common.app.ShareApp"%><% ShareApp app = new ShareApp(request, response, out); %>
<%@page import="anyfive.ipims.share.common.util.SystemTypes"%>
<%@page import="any.util.etc.NDateUtil"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>해외비용 INVOICE 상세</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("LETTER_SUBJECT");
    addBind("EXT_INVOICE_NO");
    addBind("EXT_INVOICE_FILE", "any_extInvoiceFile");
    addBind("EXT_OFFICE_NAME");
    addBind("TOT_WON_PRICE");
    addBind("TOT_PRICE");
</COMMENT></ANY:DS>
<ANY:DS id="ds_extCostList" />
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

    prx.path = top.getRoot() + "/anyfive.ipims.share.cost.extinvoice.act.RetrieveExtInvoice.do";
    prx.addParam("LETTER_SEQ", parent.LETTER_SEQ);

    prx.onSuccess = function()
    {
        any_abstractInfo.refId = ds_mainInfo.value(0, "REF_ID");

        <% if (SystemTypes.PATENT.equals(SystemTypes.getSystemType(request))) { %>
        cfShowObjects([btn_modify, btn_delete, btn_line, td_confirm], ds_mainInfo.value(0, "CONSULT_ID") == "");
        gr_extCostList.fg.ColHidden(gr_extCostList.fg.ColIndex("ROW_CHK")) = (ds_mainInfo.value(0, "CONSULT_ID") != "");
        <% } else { %>
        cfShowObjects([btn_modify, btn_delete, btn_line], ds_mainInfo.value(0, "CONSULT_ID") == "" && ds_mainInfo.value(0, "REQ_ID") == "");
        <% } %>
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//비용목록 조회
function fnRetrieveCostList()
{
    var ldr = gr_extCostList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.share.cost.extinvoice.act.RetrieveExtCostDetailList.do";
    ldr.addParam("LETTER_SEQ", parent.LETTER_SEQ);

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
    window.location.href = "ExtInvoiceU.jsp";
}

//삭제
function fnDelete()
{
    if (!confirm("<%= app.message.get("msg.com.confirm.delete").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.share.cost.extinvoice.act.DeleteExtInvoice.do";
    prx.addParam("LETTER_SEQ", parent.LETTER_SEQ);

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

//비용 상세
function fnDetailCost(gr, fg, row, colId)
{
    var win = new any.window();
    win.path = top.getRoot() + "/anyfive/ipims/share/cost/input/CostInputRD.jsp";
    win.arg.COST_SEQ = gr.value(row, "COST_SEQ");
    win.arg.gr = gr_extCostList;
    win.opt.width = 800;
    win.opt.height = 600;

    win.onReload = function()
    {
        gr_extCostList.loader.reload();
    }

    win.show();
}

<% if (SystemTypes.PATENT.equals(SystemTypes.getSystemType(request))) { %>
//일괄확인
function fnConfirmCost()
{
    if (CONFIRM_YN.value == "") {
        alert("비용승인 여부를 선택하세요.");
        return ;
    }

    if (!confirm("승인여부를 일괄수정 하시겠습니까?")) return;

    var gr = document.getElementById("gr_extCostList");
    var ds = document.getElementById("ds_extCostList");

    ds.init();

    for (var r = gr.fg.FixedRows; r < gr.fg.Rows; r++) {
        if (gr.checked(r, "ROW_CHK") == true) ds.value(ds.addRow(), "COST_SEQ") = gr.value(r, "COST_SEQ");
    }

    if (ds.rowCount == 0) {
        alert("선택된 건이 없습니다");
        return;
    }

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.share.cost.extinvoice.act.UpdateExtCostConfirmYn.do";
    prx.addParam("CONFIRM_YN", CONFIRM_YN.value);
    prx.addData(ds);

    prx.onSuccess = function()
    {
        alert("처리되었습니다.");
        gr_extCostList.loader.reload();
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
            <ANY:ABSTRACT id="any_abstractInfo"<% if (SystemTypes.PATENT.equals(SystemTypes.getSystemType(request))) { %> masterLink="true"<% } %> />
        </TD>
    </TR>
    <TR>
        <TD height="5"></TD>
    </TR>
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
                    <TD colspan="4" class="title_table">[해외비용 INVOICE 정보]</TD>
                </TR>
                <TR>
                    <TD>INVOICE 제목</TD>
                    <TD colspan="3">
                        <ANY:SPAN id="LETTER_SUBJECT" />
                    </TD>
                </TR>
                <TR>
                    <TD>해외 INVOICE 번호</TD>
                    <TD>
                        <ANY:SPAN id="EXT_INVOICE_NO" />
                    </TD>
                    <TD >해외사무소</TD>
                    <TD>
                        <ANY:SPAN id="EXT_OFFICE_NAME" />
                    </TD>
                </TR>
                <TR>
                    <TD>총 원화금액</TD>
                    <TD>
                        <ANY:SPAN id="TOT_WON_PRICE" format="number2" />
                    </TD>
                    <TD>총 외화금액</TD>
                    <TD>
                        <ANY:SPAN id="TOT_PRICE" format="number2(-16.2)" />
                    </TD>
                </TR>
                <TR>
                    <TD>해외 INVOICE 파일</TD>
                    <TD colspan="3">
                        <ANY:FILE id="any_extInvoiceFile" mode="R" policy="cost_invoice"/>
                    </TD>
                </TR>
                <TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD>
            <DIV class="button_area">
                <BUTTON text="<%= app.message.get("btn.com.modify").toHTML() %>" onClick="javascript:fnModify();" id="btn_modify" display="none"></BUTTON>
                <BUTTON text="<%= app.message.get("btn.com.delete").toHTML() %>" onClick="javascript:fnDelete();" id="btn_delete" display="none"></BUTTON>
                <BUTTON auto="line" id="btn_line" display="none"></BUTTON>
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
            <ANY:GRID id="gr_extCostList" pagingType="0" minHeight="200px"><COMMENT>
                <% if (SystemTypes.PATENT.equals(SystemTypes.getSystemType(request))) { %>
                addColumn({ width:30 , align:"center", type:"check" , sort:false, id:"ROW_CHK"             , hide:true });
                <% } %>
                addColumn({ width:120, align:"left"  , type:"string", sort:true , id:"REF_NO"              , name:"REF-NO" });
                addColumn({ width:50 , align:"center", type:"string", sort:true , id:"INOUT_DIV_NAME"      , name:"국내외" });
                addColumn({ width:60 , align:"center", type:"string", sort:true , id:"RIGHT_DIV_NAME"      , name:"권리구분" });
                addColumn({ width:150, align:"left"  , type:"string", sort:true , id:"KO_APP_TITLE"        , name:"발명의 명칭" });
                addColumn({ width:120, align:"left"  , type:"string", sort:true , id:"GRAND_NAME"          , name:"대분류" });
                addColumn({ width:120, align:"left"  , type:"string", sort:true , id:"DETAIL_NAME"         , name:"상세분류" });
                addColumn({ width:60 , align:"center", type:"string", sort:true , id:"CONFIRM_STATUS"      , name:"승인현황" });
                addColumn({ width:60 , align:"center", type:"string", sort:true , id:"CHECKS"              , name:"중복여부" });
                addColumn({ width:60 , align:"center", type:"string", sort:true , id:"COST_PROC_DIV_NAME"  , name:"비용처리" });
                addColumn({ width:90 , align:"right" , type:"number", sort:true , id:"WON_PRICE"           , name:"원화금액" , format:"#,###" });
                addColumn({ width:90 , align:"right" , type:"number", sort:true , id:"PRICE"               , name:"외화금액" , format:"#,##0.##" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"APP_NO"              , name:"출원번호" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"APP_DATE"            , name:"출원일" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"REG_NO"              , name:"등록번호" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"REG_DATE"            , name:"등록일" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"JOB_MAN_NAME"        , name:"건담당자" });
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
