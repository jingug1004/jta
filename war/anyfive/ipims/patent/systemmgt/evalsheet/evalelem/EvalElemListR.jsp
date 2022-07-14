<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>평가서 항목별 요소 목록</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<ANY:DS id="ds_evalElemList" />
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();
}

//목록 조회
function fnRetrieve()
{
    var ldr = gr_evalElemList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.evalsheet.evalelem.act.RetrieveEvalElemMgtList.do";
    ldr.addParam("EVAL_SHEET_ID", parent.EVAL_SHEET_ID);
    ldr.addParam("ITEM_SEQ", parent.ITEM_SEQ);

    ldr.onSuccess = function(gr, fg)
    {
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

//평가요소 추가
function fnAddEvalElem()
{
    var win = new any.window();
    win.path = "EvalElemC.jsp";
    win.arg.EVAL_SHEET_ID = parent.EVAL_SHEET_ID;
    win.arg.ITEM_SEQ = parent.ITEM_SEQ;
    win.opt.width = 400;
    win.opt.height = 150;

    win.onReload = function()
    {
        gr_evalElemList.loader.reload();
    }

    win.show();
}

//평가요소 수정
function fnModEvalElem(gr, fg, row, colId)
{
    var win = new any.window();
    win.path = "EvalElemUD.jsp";
    win.arg.EVAL_SHEET_ID = parent.EVAL_SHEET_ID;
    win.arg.ITEM_SEQ = parent.ITEM_SEQ;
    win.arg.ELEM_SEQ = gr.value(row, "ELEM_SEQ");
    win.opt.width = 400;
    win.opt.height = 150;

    win.onReload = function()
    {
        gr.loader.reload();
    }

    win.show();
}

//위/아래 이동
function fnMoveRowData(dir)
{
    gr_evalElemList.moveRowData(dir);
}

//표시순서 저장
function fnSaveDispOrd()
{
    var gr = gr_evalElemList;
    var ds = ds_evalElemList;

    for (var r = gr.fg.FixedRows; r < gr.fg.Rows; r++) {
        gr.value(r, "DISP_ORD") = r - gr.fg.FixedRows + 1;
    }

    if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;

    ds.init();

    for (var r = gr.fg.FixedRows; r < gr.fg.Rows; r++) {
        ds.addRow();
        ds.value(r - gr.fg.FixedRows, "ELEM_SEQ") = gr.value(r, "ELEM_SEQ");
        ds.value(r - gr.fg.FixedRows, "DISP_ORD") = gr.value(r, "DISP_ORD");
    }

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.evalsheet.evalelem.act.UpdateEvalElemMgtDispOrdList.do";
    prx.addParam("EVAL_SHEET_ID", parent.EVAL_SHEET_ID);
    prx.addParam("ITEM_SEQ", parent.ITEM_SEQ);
    prx.addData(ds);

    prx.onSuccess = function()
    {
        gr_evalElemList.loader.reload();
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
        <TD height="100%">
            <ANY:GRID id="gr_evalElemList" pagingType="0"><COMMENT>
                fg.SelectionMode = 3;
                addColumn({ width:50 , align:"center", type:"number" , sort:false, id:"ROW_NUM"             , name:"No" });
                addColumn({ width:200, align:"left"  , type:"string" , sort:false, id:"ELEM_NAME"           , name:"요소 이름" });
                addColumn({ width:100, align:"center", type:"string" , sort:false, id:"ELEM_VALUE"          , name:"요소 값" });
                setFixedColumn("ROW_NUM", null);
                addAction("ELEM_NAME", fnModEvalElem);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
    <TR>
        <TD height="5"></TD>
    </TR>
    <TR>
        <TD align="right">
            <BUTTON text="<%= app.message.get("btn.com.add").toHTML() %>" onClick="javascript:fnAddEvalElem();"></BUTTON>
            <BUTTON auto="line"></BUTTON>
            <BUTTON text="위로" onClick="javascript:fnMoveRowData(-1);"></BUTTON>
            <BUTTON text="아래로" onClick="javascript:fnMoveRowData(1);"></BUTTON>
            <BUTTON text="저장" onClick="javascript:fnSaveDispOrd();"></BUTTON>
            <BUTTON auto="line"></BUTTON>
            <BUTTON auto="close"></BUTTON>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
