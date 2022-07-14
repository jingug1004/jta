<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>평가서 수정</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("EVAL_SHEET_NAME");
</COMMENT></ANY:DS>
<ANY:DS id="ds_evalItemList" />
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();
    fnRetrieveEvalItemList();
}

//조회
function fnRetrieve()
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.evalsheet.evalsheet.act.RetrieveEvalSheetMgt.do";
    prx.addParam("EVAL_SHEET_ID", parent.EVAL_SHEET_ID);

    prx.onSuccess = function()
    {
        EVAL_SHEET_NAME.focus();
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.evalsheet.evalsheet.act.UpdateEvalSheetMgt.do";
    prx.addParam("EVAL_SHEET_ID", parent.EVAL_SHEET_ID);
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.evalsheet.evalsheet.act.DeleteEvalSheetMgt.do";
    prx.addParam("EVAL_SHEET_ID", parent.EVAL_SHEET_ID);

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

//평가항목 목록 조회
function fnRetrieveEvalItemList()
{
    var ldr = gr_evalItemList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.evalsheet.evalitem.act.RetrieveEvalItemMgtList.do";
    ldr.addParam("EVAL_SHEET_ID", parent.EVAL_SHEET_ID);

    ldr.onSuccess = function(gr, fg)
    {
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

//평가항목 추가
function fnAddEvalItem()
{
    var win = new any.window();
    win.path = top.getRoot() + "/anyfive/ipims/patent/systemmgt/evalsheet/evalitem/EvalItemC.jsp";
    win.arg.EVAL_SHEET_ID = parent.EVAL_SHEET_ID;
    win.opt.width = 600;
    win.opt.height = 130;

    win.onReload = function()
    {
        gr_evalItemList.loader.reload();
        parent.reloadList();
    }

    win.show();
}

//평가항목 수정
function fnModEvalItem(gr, fg, row, colId)
{
    var win = new any.window();
    win.path = top.getRoot() + "/anyfive/ipims/patent/systemmgt/evalsheet/evalitem/EvalItemUD.jsp";
    win.arg.EVAL_SHEET_ID = parent.EVAL_SHEET_ID;
    win.arg.ITEM_SEQ = gr.value(row, "ITEM_SEQ");
    win.opt.width = 600;
    win.opt.height = 130;

    win.onReload = function()
    {
        gr_evalItemList.loader.reload();
        parent.reloadList();
    }

    win.show();
}

//위/아래 이동
function fnMoveRowData(dir)
{
    gr_evalItemList.moveRowData(dir);
}

//표시순서 저장
function fnSaveDispOrd()
{
    var gr = gr_evalItemList;
    var ds = ds_evalItemList;

    for (var r = gr.fg.FixedRows; r < gr.fg.Rows; r++) {
        gr.value(r, "DISP_ORD") = r - gr.fg.FixedRows + 1;
    }

    if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;

    ds.init();

    for (var r = gr.fg.FixedRows; r < gr.fg.Rows; r++) {
        ds.addRow();
        ds.value(r - gr.fg.FixedRows, "ITEM_SEQ") = gr.value(r, "ITEM_SEQ");
        ds.value(r - gr.fg.FixedRows, "DISP_ORD") = gr.value(r, "DISP_ORD");
    }

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.evalsheet.evalitem.act.UpdateEvalItemMgtDispOrdList.do";
    prx.addParam("EVAL_SHEET_ID", parent.EVAL_SHEET_ID);
    prx.addData(ds);

    prx.onSuccess = function()
    {
        gr_evalItemList.loader.reload();
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//요소 목록 팝업
function fnOpenElemList(gr, fg, row, colId)
{
    var win = new any.window();
    win.path = top.getRoot() + "/anyfive/ipims/patent/systemmgt/evalsheet/evalelem/EvalElemListR.jsp";
    win.arg.EVAL_SHEET_ID = parent.EVAL_SHEET_ID;
    win.arg.ITEM_SEQ = gr.value(row, "ITEM_SEQ");
    win.opt.width = 500;
    win.opt.height = 400;

    win.onReload = function()
    {
        gr_evalItemList.loader.reload();
        parent.reloadList();
    }

    win.show();
}

//미리보기
function fnPreview()
{
    var win = new any.window();
    win.path = "EvalSheetPreviewR.jsp";
    win.arg.EVAL_SHEET_ID = parent.EVAL_SHEET_ID;
    win.opt.width = 700;
    win.opt.height = 400;
    win.show();
}
</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
    <TR>
        <TD height="1">
            <TABLE border="0" cellspacing="1" cellpadding="2" class="main">
                <COLGROUP>
                    <COL class="conthead" width="20%">
                    <COL class="contdata" width="80%">
                </COLGROUP>
                <TR>
                    <TD req="EVAL_SHEET_NAME">평가서 이름</TD>
                    <TD>
                        <INPUT type="text" id="EVAL_SHEET_NAME" maxByte="1000">
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
                    <TD class="title_sub">평가항목 목록</TD>
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
            <ANY:GRID id="gr_evalItemList" pagingType="0" minHeight="200px"><COMMENT>
                fg.SelectionMode = 3;
                addColumn({ width:50 , align:"center", type:"number" , sort:false, id:"ROW_NUM"             , name:"No" });
                addColumn({ width:250, align:"left"  , type:"string" , sort:false, id:"ITEM_NAME"           , name:"항목 이름" });
                addColumn({ width:150, align:"center", type:"number" , sort:false, id:"ELEM_CNT"            , name:"요소 갯수" });
                addColumn({ width:150, align:"center", type:"string" , sort:false, id:"ROW_ELEM_CNT"        , name:"줄당 요소 갯수" });
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_NUM", "ITEM_NAME");
                addAction("ITEM_NAME", fnModEvalItem);
                addAction("ELEM_CNT", fnOpenElemList);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
    <TR>
        <TD height="1">
            <DIV class="button_area">
                <BUTTON text="<%= app.message.get("btn.com.add").toHTML() %>" onClick="javascript:fnAddEvalItem();"></BUTTON>
                <BUTTON auto="line"></BUTTON>
                <BUTTON text="위로" onClick="javascript:fnMoveRowData(-1);"></BUTTON>
                <BUTTON text="아래로" onClick="javascript:fnMoveRowData(1);"></BUTTON>
                <BUTTON text="저장" onClick="javascript:fnSaveDispOrd();"></BUTTON>
                <BUTTON auto="line"></BUTTON>
                <BUTTON text="미리보기" onClick="javascript:fnPreview();"></BUTTON>
            </DIV>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
