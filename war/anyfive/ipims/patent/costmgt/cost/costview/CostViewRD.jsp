<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<%@page import="any.util.etc.NDateUtil"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>건별비용현황 상세</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<SCRIPT language="JScript">

//윈도우 로딩시
window.onready = function()
{
    fnRetrieveInput();
}

//비용목록 조회
function fnRetrieveInput()
{
    var ldr = gr_costViewListInputList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.costmgt.cost.costview.act.RetrieveCostViewInputList.do";
    ldr.addParam("REF_ID", parent.REF_ID);

    ldr.onSuccess = function(gr, fg)
    {
        any_abstractInfo.refId = parent.REF_ID;
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

//작성
function fnAddInput()
{
    var win = new any.window();
    win.path = top.getRoot() + "/anyfive/ipims/share/cost/input/CostInputC.jsp";
    win.arg.REF_ID = parent.REF_ID;
    win.opt.width = 800;
    win.opt.height = 600;
    win.arg.gr = gr_costViewListInputList;

    win.onReload = function()
    {
        gr_costViewListInputList.loader.reload();
    }

    win.show();
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
        gr_costViewListInputList.loader.reload();
    }

    win.show();
}

</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
    <TR>
        <TD height="1">
            <ANY:ABSTRACT id="any_abstractInfo" masterLink="false" />
        </TD>
    </TR>
    <TR>
        <TD>
            <DIV class="button_area">
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
        <TD height="<%= "1".equals(request.getParameter("MASTER")) ? "300px" : "100%" %>">
            <ANY:GRID id="gr_costViewListInputList" pagingType="0" minHeight="250px"><COMMENT>
                addColumn({ width:125, align:"left"  , type:"string", sort:true , id:"GRAND_NAME"           , name:"대분류" });
                addColumn({ width:120, align:"left"  , type:"string", sort:true , id:"DETAIL_NAME"          , name:"상세분류" });
                addColumn({ width:80 , align:"right" , type:"number", sort:true , id:"WON_PRICE"            , name:"원화금액" , format:"#,###" });
                addColumn({ width:80 , align:"right" , type:"number", sort:true , id:"PRICE"                , name:"외화금액" , format:"#,##0.##" });
                addColumn({ width:60 , align:"center", type:"string", sort:true , id:"CONFIRM_STATUS"       , name:"승인여부" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"CRE_DATE"             , name:"입력일" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"REQ_DATE"             , name:"청구일" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"CONSULT_DATE"         , name:"품의일" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"SLIP_DATE"            , name:"결재완료일" });
                addColumn({ width:90 , align:"center", type:"string", sort:true , id:"ACCOUNT_PROC_YN_NAME" , name:"전표처리상태" });
                useConfig = true;
                messageSpan = "spn_gridMessage";
                addAction("WON_PRICE", fnDetail);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
    <TR>
        <TD height="1">
            <DIV class="button_area">
                <BUTTON text="비용추가" onClick="javascript:fnAddInput();"></BUTTON>
            </DIV>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
