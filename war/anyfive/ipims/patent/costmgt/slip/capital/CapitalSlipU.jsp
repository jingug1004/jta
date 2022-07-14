<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>전표처리 수정</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("SLIP_KIND_NAME");
    addBind("SLIP_SUBJECT");
    addBind("COST_DATE");
    addBind("INVOICE_DATE");
    addBind("PAYMENT_DATE");
    addBind("SUPER_TAX");
    addBind("TOT_WON_PRICE");
    addBind("ACCOUNT_PROC_YN_NAME");
    addBind("ACCOUNT_PROC_DATE");
    addBind("ACCOUNT_PROC_USER_NAME");
    addBind("ACCOUNT_SLIP_NO");
    addBind("CRE_USER_NAME");
    addBind("CRE_DATE");
    addBind("ASSET_NO");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();
    fnRetrieveSlipProcCostList();
}

//조회
function fnRetrieve()
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.costmgt.slip.proc.act.RetrieveSlipProc.do";
    prx.addParam("SLIP_ID", parent.SLIP_ID);
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

//전표 비용 목록 조회
function fnRetrieveSlipProcCostList()
{
    var ldr = gr_slipProcCostList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.costmgt.slip.capital.act.RetrieveCapitalSlipDetailList.do";
    ldr.addParam("SLIP_ID", parent.SLIP_ID);

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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.costmgt.slip.proc.act.UpdateSlipProc.do";
    prx.addParam("SLIP_ID" , parent.SLIP_ID);
    prx.addData("ds_mainInfo");

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        window.location.href = "CapitalSlipRD.jsp";
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
    window.location.replace("CapitalSlipRD.jsp");
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
                    <COL class="contdata" width="18%">
                    <COL class="conthead" width="15%">
                    <COL class="contdata" width="18%">
                    <COL class="conthead" width="15%">
                    <COL class="contdata" width="18%">
                </COLGROUP>
                <TR>
                    <TD req="SLIP_SUBJECT">전표 제목</TD>
                    <TD colspan="5"><INPUT type="text" id="SLIP_SUBJECT" maxByte="2000"/></TD>
                </TR>
                <TR>
                    <TD>전표종류</TD>
                    <TD><ANY:SPAN id="SLIP_KIND_NAME" /></TD>
                    <TD>작성자</TD>
                    <TD><ANY:SPAN id="CRE_USER_NAME" /></TD>
                    <TD>작성일</TD>
                    <TD><ANY:SPAN id="CRE_DATE" format="date"/></TD>
                </TR>
                <TR>
                     <TD req="COST_DATE">전기일자</TD>
                    <TD><ANY:DATE id="COST_DATE"  /></TD>
                    <TD req="INVOICE_DATE">증빙일자</TD>
                    <TD><ANY:DATE id="INVOICE_DATE" /></TD>
                    <TD>만기출금일자</TD>
                    <TD><ANY:DATE id="PAYMENT_DATE"  /></TD>
                </TR>
                <TR>
                    <TD>회계전표번호(자산번호)</TD>
                    <TD><ANY:SPAN id="ACCOUNT_SLIP_NO"/>(<ANY:SPAN id="ASSET_NO"/>)</TD>
                    <TD>부가세</TD>
                    <TD><INPUT id="SUPER_TAX" format="number2" maxByte="16" /></TD>
                    <TD>합계금액</TD>
                    <TD><ANY:SPAN id="TOT_WON_PRICE" format="number2"/>원</TD>
                </TR>
                <TR>
                    <TD>회계처리여부</TD>
                    <TD><ANY:SPAN id="ACCOUNT_PROC_YN_NAME" /></TD>
                    <TD>회계처리자</TD>
                    <TD><ANY:SPAN id="ACCOUNT_PROC_USER_NAME" /></TD>
                    <TD>회계처리일</TD>
                    <TD><ANY:SPAN id="ACCOUNT_PROC_DATE" format="date" /></TD>
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
            <ANY:GRID id="gr_slipProcCostList" pagingType="0" minHeight="200px"><COMMENT>
                addColumn({ width:120, align:"left"  , type:"string" , sort:true , id:"REF_NO"         , name:"REF-NO" });
                addColumn({ width:50 , align:"center", type:"string" , sort:true , id:"INOUT_DIV_NAME" , name:"국내외" });
                addColumn({ width:130, align:"left"  , type:"string" , sort:true , id:"OFFICE_NAME"    , name:"국내사무소" });
                addColumn({ width:80 , align:"center", type:"string" , sort:true , id:"COST_KIND_NAME" , name:"비용종류" });
                addColumn({ width:100, align:"left"  , type:"string" , sort:true , id:"GRAND_NAME"     , name:"대분류" });
                addColumn({ width:100, align:"left"  , type:"string" , sort:true , id:"DETAIL_NAME"    , name:"상세분류" });
                addColumn({ width:90 , align:"right" , type:"number" , sort:true , id:"WON_PRICE"      , name:"원화금액" , format:"#,###" });
                addColumn({ width:90 , align:"right" , type:"number" , sort:true , id:"PRICE"          , name:"외화금액" , format:"#,##0.##" });
                messageSpan = "spn_gridMessage";
                addSorting("REF_NO", "DESC");
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
