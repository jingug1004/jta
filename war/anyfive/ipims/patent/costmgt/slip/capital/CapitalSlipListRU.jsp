<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<%@page import="any.util.etc.NDateUtil"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>자본적 지출 전표  목록</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<ANY:DS id="ds_costSeqList" />
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();
}

//목록 조회
function fnRetrieve()
{
    var ldr = gr_capitalSlipList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.costmgt.slip.capital.act.RetrieveCapitalSlipList.do";

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
    var win = new any.window();
    win.path = top.getRoot() + "/anyfive/ipims/share/cost/input/CostInputRD.jsp";
    win.arg.COST_SEQ = gr.value(row, "COST_SEQ");
    win.arg.gr = gr;
    win.opt.width = 800;
    win.opt.height = 600;

    win.onReload = function()
    {
        gr.loader.reload();
    }

    win.show();
}

//전표 작성
function fnCreateSlip()
{
    if (!cfCheckAllReqValid()) return;

    var gr = document.getElementById("gr_capitalSlipList");
    var ds = document.getElementById("ds_costSeqList");

    ds.init();

    for (var r = gr.fg.FixedRows; r < gr.fg.Rows; r++) {
        if (gr.checked(r, "ROW_CHK") == true) ds.value(ds.addRow(), "COST_SEQ") = gr.value(r, "COST_SEQ");
    }

    if (ds.rowCount == 0) {
        alert("선택된 건이 없습니다");
        return;
    }

    if(ds.rowCount > 1){
        alert("1건만 선택할 수 있습니다.");
        return;
    }

    if (!confirm("자본적 지출 전표를 작성하시겠습니까?")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.costmgt.slip.proc.act.CreateSlipProc.do";
    prx.addParam("SLIP_SUBJECT", "<%= NDateUtil.getFormatDate("yyyy")%>년 <%= NDateUtil.getFormatDate("MM")%>월 자본적");
    prx.addParam("SLIP_KIND", "I");
    prx.addData(ds);

    prx.onSuccess = function()
    {
        gr.loader.reload();
        alert("처리되었습니다.");

        var win = new any.viewer();
        win.path = "CapitalSlipU.jsp";
        win.arg.SLIP_ID = this.result;

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
                    <COL class="conddata" width="85%">

                </COLGROUP>
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
                    <TD align="right">*한 건만 선택하세요.
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
            <ANY:GRID id="gr_capitalSlipList" pagingType="0"><COMMENT>
                addColumn({ width:30 , align:"center", type:"check"  , sort:false, id:"ROW_CHK" });
                addColumn({ width:120, align:"left"  , type:"string" , sort:true , id:"REF_NO"         , name:"REF-NO" });
                addColumn({ width:50 , align:"center", type:"string" , sort:true , id:"INOUT_DIV_NAME" , name:"국내외" });
                addColumn({ width:130, align:"left"  , type:"string" , sort:true , id:"OFFICE_NAME"    , name:"국내사무소" });
                addColumn({ width:80 , align:"center", type:"string" , sort:true , id:"COST_KIND_NAME" , name:"비용종류" });
                addColumn({ width:80 , align:"center", type:"string" , sort:true , id:"GRAND_NAME"     , name:"대분류" });
                addColumn({ width:80 , align:"center", type:"string" , sort:true , id:"DETAIL_NAME"    , name:"상세분류" });
                addColumn({ width:80 , align:"right" , type:"number" , sort:true , id:"WON_PRICE"      , name:"원화금액" , format:"#,###" });
                addColumn({ width:80 , align:"right" , type:"number" , sort:true , id:"PRICE"          , name:"외화금액" , format:"#,##0.##" });
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_CHK", "REF_NO");
                addSorting("REF_NO", "DESC");
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
    <TR>
        <TD height="1">
            <DIV class="button_area">
                <BUTTON text="전표작성" onClick="javascript:fnCreateSlip();"></BUTTON>
            </DIV>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
