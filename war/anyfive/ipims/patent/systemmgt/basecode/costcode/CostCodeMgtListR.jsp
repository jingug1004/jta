<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>비용종류코드 </TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();
}

//코드 조회
function fnRetrieve()
{
    var ldr = gr_costCodeList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.basecode.costcode.act.RetrieveCostCodeList.do";
    ldr.addParam("MST_DIV", MST_DIV.value);
    ldr.addParam("INOUT_DIV", INOUT_DIV.value);
    ldr.addParam("GRAND_NAME", GRAND_NAME.value);

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
function fnCreate()
{
    var win = new any.viewer();
    win.path = "CostCodeC.jsp";

    win.onReload = function()
    {
        gr_costCodeList.loader.reload();
    }

    win.show();
}

//상세
function fnDetail(gr, fg, row, colId)
{
    var win = new any.viewer();
    win.path = "CostCodeUD.jsp";
    win.arg.GRAND_CODE = gr.value(row, "GRAND_CODE");

    win.onReload = function()
    {
        gr.loader.reload();
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
            <TABLE border="0" cellspacing="1" cellpadding="2" class="main" onEnter="javascript:fnRetrieve();">
                <COLGROUP>
                    <COL class="condhead" width="13%">
                    <COL class="conddata" width="20%">
                    <COL class="condhead" width="13%">
                    <COL class="conddata" width="20%">
                    <COL class="condhead" width="13%">
                    <COL class="conddata" width="20%">
                </COLGROUP>
                <TR>
                    <TD>구분</TD>
                    <TD>
                        <ANY:SELECT id="MST_DIV" codeData="{COST_MST_DIV}" firstName="all" />
                    </TD>
                    <TD>국내외구분</TD>
                    <TD>
                        <ANY:SELECT id="INOUT_DIV" codeData="{COST_INOUT_DIV}" firstName="all" />
                    </TD>
                    <TD>대분류명</TD>
                    <TD>
                        <INPUT type="text" id="GRAND_NAME">
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
                        <BUTTON text="작성" onClick="javascript:fnCreate();"></BUTTON>
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
            <ANY:GRID id="gr_costCodeList" pagingType="1"><COMMENT>
                addColumn({ width:50 , align:"center", type:"number" , sort:false, id:"ROW_NUM"             , name:"No" });
                addColumn({ width:100, align:"left"  , type:"string" , sort:true , id:"MST_DIV_NAME"        , name:"구분" });
                addColumn({ width:100, align:"center", type:"string" , sort:true , id:"INOUT_DIV_NAME"      , name:"국내외구분" });
                addColumn({ width:200, align:"left"  , type:"string" , sort:true , id:"GRAND_NAME"          , name:"비용대분류명" });
                addColumn({ width:80 , align:"center", type:"string" , sort:true , id:"CRE_USER_NAME"       , name:"작성자" });
                addColumn({ width:80 , align:"center", type:"string" , sort:true , id:"USE_YN_NAME"         , name:"사용여부" });
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_NUM", "GRAND_NAME");
                addSorting("GRAND_NAME", "ASC");
                addAction("GRAND_NAME", fnDetail);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
