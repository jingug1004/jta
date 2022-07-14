<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>비용품의서 수정</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("CONSULT_SUBJECT");
    addBind("CRE_USER_NAME");
    addBind("CRE_DATE");
    addBind("TOTAL_PRICE");
    addBind("TOTAL_WON_PRICE");
    addBind("TAX");
</COMMENT></ANY:DS>
<ANY:DS id="ds_costConsultList" />
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.costmgt.cost.consult.act.RetrieveCostConsult.do";
    prx.addParam("CONSULT_ID", parent.CONSULT_ID);
    prx.checkData = ds_mainInfo;

    prx.onSuccess = function()
    {
        fnRetrieveCostInput();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//비용목록 조회
function fnRetrieveCostInput()
{
    var ldr = gr_costInputList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.costmgt.cost.consult.act.RetrieveCostConsultInputList.do";
    ldr.addParam("CONSULT_ID", parent.CONSULT_ID);

    ldr.onSuccess = function()
    {

    }

    ldr.onFail = function()
    {
        this.error.show();
    }

    ldr.execute();
}

//저장
function fnSave()
{
    if (!cfCheckAllReqValid()) return;

    if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.costmgt.cost.consult.act.UpdateCostConsult.do";
    prx.addParam("CONSULT_ID", parent.CONSULT_ID);
    prx.addData("ds_mainInfo");

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        window.location.replace("CostConsultRD.jsp");
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//청구서상세
function fnCostRequestDetail(gr, fg, row, colId)
{
    var win = new any.window();
    if( gr.value(row, "INOUT_DIV") == "INT") {
        win.path = top.getRoot() + "/anyfive/ipims/patent/costmgt/cost/request/IntCostRequestRD.jsp";
    }
    else {
        win.path = top.getRoot() + "/anyfive/ipims/patent/costmgt/cost/request/ExtCostRequestRD.jsp";
    }
    win.arg.REQ_ID = gr.value(row, "REQ_ID");
    win.arg.CONSULT_ID = parent.CONSULT_ID;
    win.opt.width = "800";
    win.opt.height = "650";
    win.arg.gr = gr;
    win.arg.fg = fg;

    win.onReload = function()
    {
        gr_intCostInputList.loader.reload();
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
            <TABLE border="0" cellspacing="1" cellpadding="2" class="main">
                <COLGROUP>
                    <COL class="conthead" width="15%">
                    <COL class="contdata" width="35%">
                    <COL class="conthead" width="15%">
                    <COL class="contdata" width="35%">
                </COLGROUP>
                <TR>
                    <TD req="CONSULT_SUBJECT">품의서 제목</TD>
                    <TD colspan="3"><INPUT type="text" id="CONSULT_SUBJECT" maxByte="2000" /></TD>
                </TR>
                <TR>
                     <TD>합계금액/부가세(원화)</TD>
                    <TD><ANY:SPAN id="TOTAL_WON_PRICE" format="number2" />/
                    <ANY:SPAN id="TAX" format="number2" /></TD>
                    <TD>합계금액(외화)</TD>
                    <TD><ANY:SPAN id="TOTAL_PRICE" format="number2(16.2)" /></TD>
                </TR>
                <TR>
                    <TD>작성자</TD>
                    <TD><ANY:SPAN id="CRE_USER_NAME" /></TD>
                    <TD>작성일</TD>
                    <TD><ANY:SPAN id="CRE_DATE" format="date" /></TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD height="5"></TD>
    </TR>
    <TR>
        <TD>
            <SPAN id="spn_gridMessage"></SPAN>
        </TD>
    </TR>
    <TR>
        <TD height="5"></TD>
    </TR>
    <TR>
        <TD height="100%">
            <ANY:GRID id="gr_costInputList" pagingType="0" minHeight="200px"><COMMENT>
                addColumn({ width:160, align:"left"  , type:"string" , sort:true , id:"REQ_SUBJECT"    , name:"청구서명" });
                addColumn({ width:120, align:"left"  , type:"string" , sort:true , id:"REF_NO"         , name:"REF-NO" });
                addColumn({ width:80 , align:"center", type:"string" , sort:true , id:"COST_KIND_NAME" , name:"비용종류" });
                addColumn({ width:50 , align:"center", type:"string" , sort:true , id:"INOUT_DIV_NAME" , name:"국내외" });
                addColumn({ width:60 , align:"center", type:"string" , sort:true , id:"RIGHT_DIV_NAME" , name:"권리구분" });
                addColumn({ width:100, align:"center", type:"string" , sort:true , id:"GRAND_NAME"     , name:"대분류" });
                addColumn({ width:100, align:"center", type:"string" , sort:true , id:"DETAIL_NAME"    , name:"상세분류" });
                addColumn({ width:80 , align:"right" , type:"number" , sort:true , id:"WON_PRICE"      , name:"원화금액" , format:"#,###" });
                addColumn({ width:80 , align:"right" , type:"number" , sort:true , id:"TAX"            , name:"부가세금액" , format:"#,###" });
                addColumn({ width:80 , align:"right" , type:"number" , sort:true , id:"PRICE"          , name:"외화금액" , format:"#,##0.##" });
                addColumn({ width:75 , align:"center", type:"date"   , sort:true , id:"REQ_DATE"       , name:"청구일" });
                addColumn({ width:80 , align:"center", type:"string" , sort:true , id:"REQ_USER_NAME"  , name:"청구자" });
                messageSpan = "spn_gridMessage";
                addSorting("REF_NO", "ASC");
                setFixedColumn(null, "LETTER_SEQ");
                addAction("REQ_SUBJECT", fnCostRequestDetail);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
    <TR>
        <TD>
            <DIV class="button_area">
                <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>
                <BUTTON text="<%= app.message.get("btn.com.cancel").toHTML() %>" onClick="javascript:history.back();"></BUTTON>
                <BUTTON auto="line"></BUTTON>
                <BUTTON auto="list"></BUTTON>
            </DIV>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
