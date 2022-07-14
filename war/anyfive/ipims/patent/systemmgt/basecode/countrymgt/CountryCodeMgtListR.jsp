<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>국가정보 관리</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<ANY:DS id="ds_countryCodeList" />
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();
}

//목록 조회
function fnRetrieve()
{
    var ldr = gr_countryCodeList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.basecode.countrymgt.act.RetrieveCountryCodeMgtList.do";
    ldr.addParam("SEARCH_TEXT", SEARCH_TEXT.value);
    ldr.addParam("CURRENCY_CODE", CURRENCY_CODE.value);

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
    var win = new any.window();
    win.path = "CountryCodeMgtC.jsp";
    win.opt.width = 600;
    win.opt.height = 300;

    win.onReload = function()
    {
        gr_countryCodeList.loader.reload();
    }

    win.show();
}

//수정
function fnModify(gr, fg, row, colId)
{
    var win = new any.window();
    win.path = "CountryCodeMgtUD.jsp";
    win.arg.COUNTRY_CODE = gr.value(row, "COUNTRY_CODE");
    win.opt.width = 600;
    win.opt.height = 300;

    win.onReload = function()
    {
        gr.loader.reload();
    }

    win.show();
}

//위/아래 이동
function fnMoveRowData(dir)
{
    gr_countryCodeList.moveRowData(dir);
}

//저장
function fnSave()
{
    var gr = gr_countryCodeList;
    var ds = ds_countryCodeList;

    for (var r = gr.fg.FixedRows; r < gr.fg.Rows; r++) {
        gr.value(r, "DISP_ORD") = r - gr.fg.FixedRows + 1;
    }

    if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;

    ds.init();

    for (var r = gr.fg.FixedRows; r < gr.fg.Rows; r++) {
        ds.addRow();
        ds.value(r - gr.fg.FixedRows, "COUNTRY_CODE") = gr.value(r, "COUNTRY_CODE");
        ds.value(r - gr.fg.FixedRows, "DISP_ORD") = gr.value(r, "DISP_ORD");
    }

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.basecode.countrymgt.act.UpdateCountryDispOrdList.do";
    prx.addData(ds);

    prx.onSuccess = function()
    {
        gr.loader.reload();
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
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
                    <TD>국가명/국가코드</TD>
                    <TD>
                        <INPUT type="text" id="SEARCH_TEXT">
                    </TD>
                    <TD>통용화폐</TD>
                    <TD>
                        <INPUT type="text" id="CURRENCY_CODE">
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
            <ANY:GRID id="gr_countryCodeList" pagingType="0"><COMMENT>
                fg.SelectionMode = 3;
                addColumn({ width:60 , align:"center", type:"number" , sort:false, id:"ROW_NUM"         , name:"No" });
                addColumn({ width:120, align:"center", type:"string" , sort:false, id:"COUNTRY_CODE"    , name:"국가코드" });
                addColumn({ width:150, align:"left"  , type:"string" , sort:false, id:"COUNTRY_NAME"    , name:"국가명" });
                addColumn({ width:100, align:"center", type:"string" , sort:false, id:"CURRENCY_CODE"   , name:"통용화폐" });
                addColumn({ width:100, align:"center", type:"number" , sort:false, id:"DISP_ORD"        , name:"표시순서" });
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_NUM", "COUNTRY_CODE");
                addAction("COUNTRY_CODE", fnModify);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
    <TR>
        <TD height="5"></TD>
    </TR>
    <TR>
        <TD height="1" align="right">
            <BUTTON text="위로" onClick="javascript:fnMoveRowData(-1);"></BUTTON>
            <BUTTON text="아래로" onClick="javascript:fnMoveRowData(1);"></BUTTON>
            <BUTTON text="저장" onClick="javascript:fnSave();"></BUTTON>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
