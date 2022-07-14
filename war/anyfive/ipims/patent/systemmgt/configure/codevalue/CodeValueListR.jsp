<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>공통코드 목록</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<ANY:DS id="ds_codeValueList" />
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    cfSetPageTitle(document.title + " - " + parent.CODE_GRP_NAME);

    fnRetrieve();
}

//목록 조회
function fnRetrieve()
{
    var ldr = gr_codeValueList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.configure.codevalue.act.RetrieveCodeValueList.do";
    ldr.addParam("CODE_GRP", parent.CODE_GRP);

    ldr.onSuccess = function(gr, fg)
    {
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

//작성 팝업
function fnOpenCreate()
{
    var win = new any.window();
    win.path = "CodeValueC.jsp";
    win.arg.CODE_GRP = parent.CODE_GRP;
    win.arg.CODE_GRP_NAME = parent.CODE_GRP_NAME;
    win.opt.width = 600;
    win.opt.height = 330;

    win.onReload = function()
    {
        gr_codeValueList.loader.reload();
    }

    win.show();
}

//상세 팝업
function fnOpenView(gr, fg, row, colId)
{
    var win = new any.window();
    win.path = "CodeValueUD.jsp";
    win.arg.CODE_GRP = parent.CODE_GRP;
    win.arg.CODE_GRP_NAME = parent.CODE_GRP_NAME;
    win.arg.CODE_VALUE = gr.value(row, "CODE_VALUE");
    win.opt.width = 600;
    win.opt.height = 350;

    win.onReload = function()
    {
        gr.loader.reload();
    }

    win.show();
}

//위/아래 이동
function fnMoveRowData(dir)
{
    gr_codeValueList.moveRowData(dir);
}

//저장
function fnSave()
{
    var gr = gr_codeValueList;
    var ds = ds_codeValueList;

    for (var r = gr.fg.FixedRows; r < gr.fg.Rows; r++) {
        gr.value(r, "DISP_ORD") = r - gr.fg.FixedRows + 1;
    }

    if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;

    ds.init();

    for (var r = gr.fg.FixedRows; r < gr.fg.Rows; r++) {
        ds.addRow();
        ds.value(r - gr.fg.FixedRows, "CODE_GRP") = gr.value(r, "CODE_GRP");
        ds.value(r - gr.fg.FixedRows, "CODE_VALUE") = gr.value(r, "CODE_VALUE");
        ds.value(r - gr.fg.FixedRows, "DISP_ORD") = gr.value(r, "DISP_ORD");
    }

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.configure.codevalue.act.UpdateCodeValueDispOrdList.do";
    prx.addData(ds);

    prx.onSuccess = function()
    {
        gr_codeValueList.loader.reload();
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
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD><SPAN id="spn_gridMessage"></SPAN></TD>
                    <TD align="right">
                        <BUTTON text="<%= app.message.get("btn.com.write").toHTML() %>" onClick="javascript:fnOpenCreate();"></BUTTON>
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
            <ANY:GRID id="gr_codeValueList" pagingType="0"><COMMENT>
                fg.SelectionMode = 3;
                addColumn({ width:50 , align:"center", type:"number", sort:false, id:"ROW_NUM"          , name:"<%= app.message.get("lbl.com.no").toJS() %>" });
                addColumn({ width:100, align:"center", type:"string", sort:false, id:"CODE_VALUE_ID"    , name:"코드값" });
                addColumn({ width:150, align:"left"  , type:"string", sort:false, id:"CODE_NAME"        , name:"코드이름" });
                addColumn({ width:60 , align:"center", type:"string", sort:false, id:"USE_YN_NAME"      , name:"사용여부" });
                addColumn({ width:200, align:"left"  , type:"string", sort:false, id:"CODE_DESC"        , name:"코드설명" });
                addColumn({ width:60 , align:"center", type:"number", sort:false, id:"DISP_ORD"         , name:"표시순서" });
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_NUM", "CODE_VALUE_ID");
                addAction("CODE_VALUE_ID", fnOpenView);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
    <TR>
        <TD height="1">
            <DIV class="button_area">
                <BUTTON text="위로" onClick="javascript:fnMoveRowData(-1);"></BUTTON>
                <BUTTON text="아래로" onClick="javascript:fnMoveRowData(1);"></BUTTON>
                <BUTTON text="저장" onClick="javascript:fnSave();"></BUTTON>
                <BUTTON auto="line"></BUTTON>
                <BUTTON auto="close"></BUTTON>
            </DIV>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
