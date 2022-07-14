<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.share.common.app.ShareApp"%><% ShareApp app = new ShareApp(request, response, out); %>
<%@page import="anyfive.ipims.share.common.util.SystemTypes"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>국내비용청구서 수정</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("REQ_SUBJECT");
    <% if (SystemTypes.PATENT.equals(SystemTypes.getSystemType(request))) { %>
    addBind("OFFICE_CODE");
    <% } %>
    addBind("REQ_YN_NAME");
    addBind("INVOICE_NO");
    addBind("REQ_WON_PRICE");
    addBind("INVOICE_FILE", "any_invoiceFile");
</COMMENT></ANY:DS>
<ANY:DS id="ds_intCostList" />
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    <% if (SystemTypes.OFFICE.equals(SystemTypes.getSystemType(request))) { %>
    ds_mainInfo.value(0, "OFFICE_CODE") = "<%= app.userInfo.getOfficeCode() %>";
    <% } %>

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
function fnSave(isFileUploaded)
{
    if (!cfCheckAllReqValid()) return;

    if (isFileUploaded != true) {
        if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;
        cfFileUpload("fnSave(true);");
        return;
    }

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.share.cost.request.act.UpdateCostRequest.do";
    prx.addParam("REQ_ID", parent.REQ_ID);
    prx.addData("ds_mainInfo");
    prx.addData("ds_invoiceFile");

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        fnDetail();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//상세
function fnDetail()
{
    window.location.replace("IntCostRequestRD.jsp");
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
        gr_intCostList.loader.reload();
    }

    win.show();
}

//비용 추가
function fnAddCost()
{
    var win = new any.window();
    win.path = top.getRoot() + "/anyfive/ipims/share/cost/input/CostInputC.jsp";
    win.arg.REQ_ID = parent.REQ_ID;
    win.arg.gr = gr_intCostList;
    win.opt.width = 800;
    win.opt.height = 600;

    win.onReload = function()
    {
        gr_intCostList.loader.reload();
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
                    <TD req="REQ_SUBJECT">청구서 제목</TD>
                    <TD colspan="3"><INPUT type="text" id="REQ_SUBJECT" maxByte="2000" /></TD>
                </TR>
                <% if (SystemTypes.PATENT.equals(SystemTypes.getSystemType(request))) { %>
                <TR>
                    <TD req="OFFICE_CODE">사무소</TD>
                    <TD colspan="3"><ANY:SELECT id="OFFICE_CODE" codeData="/common/intOfficeCode" firstName="sel" /></TD>
                </TR>
                <% } %>
                <TR>
                    <TD>청구상태</TD>
                    <TD colspan="3"><ANY:SPAN id="REQ_YN_NAME" /></TD>
                </TR>
                <TR>
                    <TD req="INVOICE_NO">INVOICE 번호</TD>
                    <TD><INPUT type="text" id="INVOICE_NO" maxByte="30" /></TD>
                    <TD>청구금액</TD>
                    <TD><ANY:SPAN id="REQ_WON_PRICE" format="number2" /></TD>
                </TR>
                <TR>
                    <TD >INVOICE 파일</TD>
                    <TD colspan="3">
                        <ANY:FILE id="any_invoiceFile" mode="U" policy="cost_invoice" />
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD>
            <DIV class="button_area">
                <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>
                <BUTTON text="<%= app.message.get("btn.com.cancel").toHTML() %>" onClick="javascript:fnDetail();"></BUTTON>
                <BUTTON auto="line"></BUTTON>
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
                addColumn({ width:120, align:"left"  , type:"string", sort:true , id:"REF_NO"           , name:"REF-NO" });
                addColumn({ width:50 , align:"center", type:"string", sort:true , id:"INOUT_DIV_NAME"   , name:"국내외" });
                addColumn({ width:60 , align:"center", type:"string", sort:true , id:"RIGHT_DIV_NAME"   , name:"권리구분" });
                addColumn({ width:60 , align:"center", type:"string", sort:true , id:"CONFIRM_STATUS"   , name:"승인현황" });
                addColumn({ width:80 , align:"center", type:"string", sort:true , id:"COST_KIND_NAME"   , name:"비용종류" });
                addColumn({ width:130, align:"left"  , type:"string", sort:true , id:"KO_APP_TITLE"     , name:"발명의 명칭" });
                addColumn({ width:120, align:"left"  , type:"string", sort:true , id:"GRAND_NAME"       , name:"대분류" });
                addColumn({ width:120, align:"left"  , type:"string", sort:true , id:"DETAIL_NAME"      , name:"상세분류" });
                addColumn({ width:90 , align:"right" , type:"number", sort:true , id:"WON_PRICE"        , name:"원화금액" , format:"#,###" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"APP_NO"           , name:"출원번호" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"APP_DATE"         , name:"출원일" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"REG_NO"           , name:"등록번호" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"REG_DATE"         , name:"등록일" });
                addColumn({ width:60 , align:"center", type:"string", sort:true , id:"JOB_MAN_NAME"     , name:"건담당자" });
                addColumn({ width:150 , align:"left", type:"string", sort:true , id:"PJT_NAME"             , name:"프로젝트이름" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"PJT_END_DATE"        , name:"수행종료일" });
                messageSpan = "spn_gridMessage";
                setFixedColumn(null, "REF_NO");
                addAction("REF_NO", fnDetailCost);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
    <TR>
        <TD height="1">
            <DIV class="button_area">
                <BUTTON text="비용추가" onClick="javascript:fnAddCost();"></BUTTON>
            </DIV>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
