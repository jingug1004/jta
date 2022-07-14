<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.share.common.app.ShareApp"%><% ShareApp app = new ShareApp(request, response, out); %>
<%@page import="anyfive.ipims.share.common.util.SystemTypes"%>
<%@page import="any.util.etc.NDateUtil"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>해외비용 INVOICE 작성</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("LETTER_SUBJECT");
    addBind("EXT_INVOICE_NO");
    addBind("EXT_INVOICE_FILE", "any_extInvoiceFile");
    addBind("EXT_OFFICE_CODE");
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

    prx.onSuccess = function(gr, fg)
    {
        any_abstractInfo.refId = ds_mainInfo.value(0, "REF_ID");
    }

    prx.onFail = function(gr, fg)
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
    prx.path = top.getRoot() + "/anyfive.ipims.share.cost.extinvoice.act.UpdateExtInvoice.do";
    prx.addParam("LETTER_SEQ", parent.LETTER_SEQ);
    prx.addData("ds_mainInfo");
    prx.addData("ds_extInvoiceFile");

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
    window.location.replace("ExtInvoiceRD.jsp");
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

//비용 추가
function fnAddCost()
{
    var win = new any.window();
    win.path = top.getRoot() + "/anyfive/ipims/share/cost/input/CostInputC.jsp";
    win.arg.REF_ID = any_abstractInfo.refId;
    win.arg.LETTER_SEQ = parent.LETTER_SEQ;
    win.arg.gr = gr_extCostList;
    win.opt.width = 800;
    win.opt.height = 600;

    win.onReload = function()
    {
        gr_extCostList.loader.reload();
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
                    <TD req="LETTER_SUBJECT">INVOICE 제목</TD>
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
                        <ANY:SELECT id="EXT_OFFICE_CODE" codeData="/common/extOfficeCode"/>
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
                    <TD req="any_extInvoiceFile">해외 INVOICE 파일</TD>
                    <TD colspan="3">
                        <ANY:FILE id="any_extInvoiceFile" mode="C" policy="cost_invoice"/>
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
            <ANY:GRID id="gr_extCostList" pagingType="0" minHeight="200px"><COMMENT>
                addColumn({ width:120, align:"left"  , type:"string", sort:true , id:"REF_NO"           , name:"REF-NO" });
                addColumn({ width:50 , align:"center", type:"string", sort:true , id:"INOUT_DIV_NAME"   , name:"국내외" });
                addColumn({ width:60 , align:"center", type:"string", sort:true , id:"RIGHT_DIV_NAME"   , name:"권리구분" });
                addColumn({ width:150, align:"left"  , type:"string", sort:true , id:"KO_APP_TITLE"     , name:"발명의 명칭" });
                addColumn({ width:120, align:"left"  , type:"string", sort:true , id:"GRAND_NAME"       , name:"대분류" });
                addColumn({ width:120, align:"left"  , type:"string", sort:true , id:"DETAIL_NAME"      , name:"상세분류" });
                addColumn({ width:60 , align:"center", type:"string", sort:true , id:"CONFIRM_STATUS"   , name:"승인현황" });
                addColumn({ width:90 , align:"right" , type:"number", sort:true , id:"WON_PRICE"        , name:"원화금액" , format:"#,###" });
                addColumn({ width:90 , align:"right" , type:"number", sort:true , id:"PRICE"            , name:"외화금액" , format:"#,##0.##" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"APP_NO"           , name:"출원번호" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"APP_DATE"         , name:"출원일" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"REG_NO"           , name:"등록번호" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"REG_DATE"         , name:"등록일" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"JOB_MAN_NAME"     , name:"건담당자" });
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
