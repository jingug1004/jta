<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<%@page import="any.util.etc.NDateUtil"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>해외비용입력 목록</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<ANY:DS id="ds_extInvoiceList" />
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();
}

//목록 조회
function fnRetrieve()
{
    var ldr = gr_extInvoiceList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.costmgt.cost.extinvoice.act.RetrieveExtInvoiceList.do";
    ldr.addParam("REF_NO"         , REF_NO.value);
    ldr.addParam("LETTER_SUBJECT" , LETTER_SUBJECT.value);
    ldr.addParam("DATE_START"     , DATE_START.value);
    ldr.addParam("DATE_END"       , DATE_END.value);

    ldr.onStart = function(gr, fg)
    {
    }
    ldr.onSuccess = function(gr, fg)
    {

    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

//작성
function fnCreate(gr, fg, row, colId)
{
    var win = new any.window();
    win.path = top.getRoot() + "/anyfive/ipims/share/cost/extinvoice/ExtInvoiceC.jsp";
    win.arg.gr = gr_extInvoiceList;
    win.opt.width = 850;
    win.opt.height = 700;
    win.opt.resizable = "yes";


    win.onReload = function()
    {
        gr_extInvoiceList.loader.reload();
    }

    win.show();
}


//상세
function fnDetail(gr, fg, row, colId)
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
        gr_extInvoiceList.loader.reload();
    }

    win.show();
}


//청구서 생성
function fnCreateRequest()
{
    if (!cfCheckAllReqValid()) return;

    var gr = document.getElementById("gr_extInvoiceList");
    var ds = document.getElementById("ds_extInvoiceList");

    ds.init();

    for (var r = gr.fg.FixedRows; r < gr.fg.Rows; r++) {
        if (gr.checked(r, "ROW_CHK") != true) continue;
        if (gr.value(r, "WON_PRICE") == "" || gr.value(r, "PRICE") == "") {
            alert("비용입력을 해주세요.");
//             return;
        }
        ds.value(ds.addRow(), "LETTER_SEQ") = gr.value(r, "LETTER_SEQ");
    }

    if (ds.rowCount == 0) {
        alert("선택된 건이 없습니다");
        return;
    }

    if (!confirm("청구서를 생성하시겠습니까?")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.share.cost.request.act.CreateExtInvoiceRequest.do";
    prx.addData(ds);

    prx.onSuccess = function()
    {
        gr.loader.reload();
        alert("처리되었습니다.");

        var win = new any.window();
        win.path = top.getRoot() + "/anyfive/ipims/share/cost/request/ExtCostRequestU.jsp";
        win.arg.REQ_ID = this.result;
        win.arg.gr = gr_extInvoiceList;
        win.opt.width = 800;
        win.opt.height = 650;

        win.onReload = function()
        {
            gr.loader.reload();
        }

        win.show();
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

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
    <TR>
        <TD>
            <TABLE border="0" cellspacing="1" cellpadding="2" class="main" onEnter="javascript:fnRetrieve();">
                <COLGROUP>
                    <COL class="condhead" width="15%">
                    <COL class="conddata" width="35%">
                    <COL class="condhead" width="15%">
                    <COL class="conddata" width="35%">
                </COLGROUP>
                <TR>
                    <TD>INVOICE 제목</TD>
                    <TD>
                        <INPUT type="text" id="LETTER_SUBJECT">
                    </TD>
                    <TD>REF-NO</TD>
                    <TD>
                        <INPUT type="text" id="REF_NO">
                    </TD>
                </TR>
                <TR>
                    <TD>작성일 </TD>
                    <TD colspan="3">
                        <ANY:DATE id="DATE_START" />&nbsp;~
                        <ANY:DATE id="DATE_END" />
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
                        <BUTTON auto="line"></BUTTON>
                        <BUTTON text="<%= app.message.get("btn.com.write").toHTML() %>" onClick="javascript:fnCreate();"></BUTTON>
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
            <ANY:GRID id="gr_extInvoiceList" pagingType="0"><COMMENT>
                addColumn({ width:30 , align:"center", type:"string", sort:false, id:"ROW_CHK" });
                addColumn({ width:120, align:"left"  , type:"string", sort:true , id:"REF_NO"           , name:"REF-NO" });
                addColumn({ width:150, align:"left"  , type:"string", sort:true , id:"LETTER_SUBJECT"   , name:"INVOICE 제목" });
                addColumn({ width:90 , align:"left"  , type:"string", sort:true , id:"OFFICE_NAME"      , name:"국내사무소" });
                addColumn({ width:90 , align:"right" , type:"number", sort:true , id:"WON_PRICE"        , name:"원화금액" , format:"#,###" });
                addColumn({ width:90 , align:"right" , type:"number", sort:true , id:"PRICE"            , name:"외화금액" , format:"#,##0.##" });
                addColumn({ width:120, align:"left"  , type:"string", sort:true , id:"EXT_INVOICE_NO"   , name:"해외청구서번호" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"APP_NO"           , name:"출원번호" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"APP_DATE"         , name:"출원일" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"REG_NO"           , name:"등록번호" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"REG_DATE"         , name:"등록일" });
                addColumn({ width:60 , align:"center", type:"string", sort:true , id:"CRE_USER_NAME"    , name:"작성자" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"CRE_DATE"         , name:"작성일" });
                useConfig = true;
                messageSpan = "spn_gridMessage";
                setFixedColumn(null, "LETTER_SUBJECT");
                addSorting("REF_NO", "DESC");
                addAction("LETTER_SUBJECT", fnDetail);

                addCheck("ROW_CHK", function(gr, fg, row, colId)
                {
                    if (element.value(row, "WON_PRICE") != "" || element.value(row, "PRICE") != "" ) return flexUnchecked;
                });
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
    <TR>
        <TD height="1">
            <DIV class="button_area">
                <BUTTON text="청구서작성" onClick="javascript:fnCreateRequest();"></BUTTON>
            </DIV>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
