<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>비용대분류 수정</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("MST_DIV");
    addBind("INOUT_DIV");
    addBind("GRAND_NAME");
    addBind("USE_YN");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();
    fnRetrieveCostDetailCodeList();
}

//조회
function fnRetrieve()
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.basecode.costcode.act.RetrieveCostCode.do";
    prx.addParam("GRAND_CODE", parent.GRAND_CODE);
    prx.checkData = ds_mainInfo;

    prx.onSuccess = function()
    {
        GRAND_NAME.focus();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//저장
function fnSave()
{
    if (!cfCheckAllReqValid()) return;

    if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.basecode.costcode.act.UpdateCostCode.do";
    prx.addParam("GRAND_CODE", parent.GRAND_CODE);
    prx.addData("ds_mainInfo");

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//삭제
function fnDelete()
{
    if (!confirm("<%= app.message.get("msg.com.confirm.delete").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.basecode.costcode.act.DeleteCostCode.do";
    prx.addParam("GRAND_CODE", parent.GRAND_CODE);

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

//상세분류 목록 조회
function fnRetrieveCostDetailCodeList()
{
    var ldr = gr_costDetailCodeList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.basecode.costcode.act.RetrieveCostDetailCodeList.do";
    ldr.addParam("GRAND_CODE", parent.GRAND_CODE);

    ldr.onSuccess = function(gr, fg)
    {
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

//상세분류 추가
function fnAddCostDetailCode()
{
    var win = new any.window();
    win.path = "CostDetailCodeCUD.jsp";
    win.arg.GRAND_CODE = parent.GRAND_CODE;
    win.opt.width = 500;
    win.opt.height = 200;

    win.onReload = function()
    {
        gr_costDetailCodeList.loader.reload();
    }

    win.show();
}

//상세분류 상세
function fnDetailCostCode(gr, fg, row, colId)
{
    var win = new any.window();
    win.path = "CostDetailCodeCUD.jsp";
    win.arg.GRAND_CODE = parent.GRAND_CODE;
    win.arg.DETAIL_CODE = gr.value(row, "DETAIL_CODE");
    win.opt.width = 500;
    win.opt.height = 200;

    win.onReload = function()
    {
        gr_costDetailCodeList.loader.reload();
    }

    win.show();
}
</SCRIPT>

<!-- 마스터구분 변경시 -->
<SCRIPT language="JScript" for="MST_DIV" event="OnChange()">
    INOUT_DIV.codeData = "{COST_INOUT_DIV" + (this.value == "A" ? "" : "_COM") + "}";
</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
    <TR>
        <TD height="1">
            <TABLE border="0" cellspacing="1" cellpadding="2" class="main">
                <COLGROUP>
                    <COL class="conthead" width="15%">
                    <COL class="contdata" width="35%">
                    <COL class="conthead" width="15%">
                    <COL class="contdata" width="35%">
                </COLGROUP>
                <TR>
                    <TD req="MST_DIV">구분</TD>
                    <TD>
                        <ANY:SELECT id="MST_DIV" codeData="{COST_MST_DIV}" />
                    </TD>
                    <TD req="INOUT_DIV">국내외구분</TD>
                    <TD>
                        <ANY:SELECT id="INOUT_DIV" codeData="{COST_INOUT_DIV}" />
                    </TD>
                </TR>
                <TR>
                    <TD req="GRAND_NAME">대분류명</TD>
                    <TD>
                        <INPUT type="text" id="GRAND_NAME" maxByte="500">
                    </TD>
                    <TD req="USE_YN">사용여부</TD>
                    <TD>
                        <ANY:RADIO id="USE_YN" codeData="{USE_YN}" />
                    </TD>
                </TR>
            </TABLE>
            <DIV class="button_area">
                <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>
                <BUTTON text="<%= app.message.get("btn.com.delete").toHTML() %>" onClick="javascript:fnDelete();"></BUTTON>
                <BUTTON auto="line"></BUTTON>
                <BUTTON auto="list"></BUTTON>
            </DIV>
        </TD>
    </TR>
    <TR>
        <TD height="10"></TD>
    </TR>
    <TR>
        <TD height="1">
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD class="title_sub">상세분류 목록</TD>
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
            <ANY:GRID id="gr_costDetailCodeList" pagingType="0"><COMMENT>
                addColumn({ width:50 , align:"center", type:"number" , sort:false, id:"ROW_NUM"             , name:"No" });
                addColumn({ width:200, align:"left"  , type:"string" , sort:false, id:"DETAIL_NAME"         , name:"상세분류명" });
                addColumn({ width:100, align:"center", type:"string" , sort:false, id:"TAX_YN_NAME"         , name:"과세여부" });
                addColumn({ width:80 , align:"center", type:"string" , sort:false, id:"DISP_ORD"            , name:"표시순서" });
                addColumn({ width:100, align:"center", type:"string" , sort:false, id:"USE_YN_NAME"         , name:"사용여부" });
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_NUM", "DETAIL_NAME");
                addAction("DETAIL_NAME", fnDetailCostCode);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
    <TR>
        <TD height="1">
            <DIV class="button_area">
                <BUTTON text="<%= app.message.get("btn.com.add").toHTML() %>" onClick="javascript:fnAddCostDetailCode();"></BUTTON>
            </DIV>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
