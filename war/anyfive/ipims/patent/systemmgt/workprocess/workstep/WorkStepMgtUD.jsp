<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>업무단계 수정</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("BIZ_MGT_NAME");
    addBind("BIZ_STEP_ID");
    addBind("BIZ_STEP_NAME");
    addBind("APPR_CODE");
    addBind("BIZ_TBL_NAME");
    addBind("BIZ_ID_COL_NAME");
    addBind("BIZ_VIEW_PATH");
</COMMENT></ANY:DS>
<ANY:DS id="ds_workProcMgtList" />
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();
    fnRetrieveWorkProcList();
}

//조회
function fnRetrieve()
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.workprocess.workstep.act.RetrieveWorkStepMgt.do";
    prx.addParam("BIZ_STEP_ID", parent.BIZ_STEP_ID);
    prx.checkData = ds_mainInfo;

    prx.onSuccess = function()
    {
        BIZ_STEP_NAME.focus();
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.workprocess.workstep.act.UpdateWorkStepMgt.do";
    prx.addParam("BIZ_STEP_ID", parent.BIZ_STEP_ID);
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.workprocess.workstep.act.DeleteWorkStepMgt.do";
    prx.addParam("BIZ_STEP_ID", parent.BIZ_STEP_ID);

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

//프로세스 목록 조회
function fnRetrieveWorkProcList()
{
    var ldr = gr_workProcMgtList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.workprocess.workproc.act.RetrieveWorkProcMgtList.do";
    ldr.addParam("BIZ_STEP_ID", parent.BIZ_STEP_ID);

    ldr.onSuccess = function(gr, fg)
    {
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

//프로세스 추가
function fnAddWorkProc()
{
    var win = new any.window();
    win.path = top.getRoot() + "/anyfive/ipims/patent/systemmgt/workprocess/workproc/WorkProcCUD.jsp";
    win.arg.BIZ_STEP_ID = parent.BIZ_STEP_ID;
    win.opt.width = 700;
    win.opt.height = 500;

    win.onReload = function()
    {
        gr_workProcMgtList.loader.reload();
        parent.reloadList();
    }

    win.show();
}

//프로세스 수정
function fnModWorkProc(gr, fg, row, colId)
{
    var win = new any.window();
    win.path = top.getRoot() + "/anyfive/ipims/patent/systemmgt/workprocess/workproc/WorkProcCUD.jsp";
    win.arg.BIZ_STEP_ID = parent.BIZ_STEP_ID;
    win.arg.BIZ_PROC_SEQ = gr.value(row, "BIZ_PROC_SEQ");
    win.opt.width = 700;
    win.opt.height = 500;

    win.onReload = function()
    {
        gr_workProcMgtList.loader.reload();
        parent.reloadList();
    }

    win.show();
}

//위/아래 이동
function fnMoveRowData(dir)
{
    gr_workProcMgtList.moveRowData(dir);
}

//표시순서 저장
function fnSaveDispOrd()
{
    var gr = gr_workProcMgtList;
    var ds = ds_workProcMgtList;

    for (var r = gr.fg.FixedRows; r < gr.fg.Rows; r++) {
        gr.value(r, "DISP_ORD") = r - gr.fg.FixedRows + 1;
    }

    if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;

    ds.init();

    for (var r = gr.fg.FixedRows; r < gr.fg.Rows; r++) {
        ds.addRow();
        ds.value(r - gr.fg.FixedRows, "BIZ_STEP_ID") = gr.value(r, "BIZ_STEP_ID");
        ds.value(r - gr.fg.FixedRows, "BIZ_PROC_SEQ") = gr.value(r, "BIZ_PROC_SEQ");
        ds.value(r - gr.fg.FixedRows, "DISP_ORD") = gr.value(r, "DISP_ORD");
    }

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.workprocess.workproc.act.UpdateWorkProcMgtDispOrdList.do";
    prx.addData(ds);

    prx.onSuccess = function()
    {
        gr_workProcMgtList.loader.reload();
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
        <TD height="1">
            <TABLE border="0" cellspacing="1" cellpadding="2" class="main">
                <COLGROUP>
                    <COL class="conthead" width="15%">
                    <COL class="contdata" width="35%">
                    <COL class="conthead" width="15%">
                    <COL class="contdata" width="35%">
                </COLGROUP>
                <TR>
                    <TD>업무</TD>
                    <TD><SPAN id="BIZ_MGT_NAME"></SPAN></TD>
                    <TD>업무단계 ID</TD>
                    <TD><SPAN id="BIZ_STEP_ID"></SPAN></TD>
                </TR>
                <TR>
                    <TD req="BIZ_STEP_NAME">업무단계 이름</TD>
                    <TD>
                        <INPUT type="text" id="BIZ_STEP_NAME" maxByte="500">
                    </TD>
                    <TD>결재코드</TD>
                    <TD>
                        <ANY:SELECT id="APPR_CODE" codeData="/systemmgt/apprCode" firstName="sel" />
                    </TD>
                </TR>
                <TR>
                    <TD req="BIZ_TBL_NAME">업무테이블명</TD>
                    <TD>
                        <INPUT type="text" id="BIZ_TBL_NAME" maxByte="30">
                    </TD>
                    <TD req="BIZ_ID_COL_NAME">업무ID컬럼명</TD>
                    <TD>
                        <INPUT type="text" id="BIZ_ID_COL_NAME" maxByte="30">
                    </TD>
                </TR>
                <TR>
                    <TD>업무화면 경로</TD>
                    <TD colspan="3">
                        <INPUT type="text" id="BIZ_VIEW_PATH" maxByte="500">
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
                    <TD class="title_sub">프로세스 목록</TD>
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
            <ANY:GRID id="gr_workProcMgtList" pagingType="0"><COMMENT>
                fg.SelectionMode = 3;
                addColumn({ width:40 , align:"center", type:"number" , sort:false, id:"ROW_NUM"             , name:"No" });
                addColumn({ width:150, align:"left"  , type:"string" , sort:false, id:"CURR_STATUS_NAME"    , name:"현재 상태" });
                addColumn({ width:150, align:"left"  , type:"string" , sort:false, id:"BIZ_ACT_NAME"        , name:"업무 액션" });
                addColumn({ width:150, align:"left"  , type:"string" , sort:false, id:"NEXT_STATUS_NAME"    , name:"다음 상태" });
                addColumn({ width:70 , align:"center", type:"string" , sort:false, id:"ACT_OWNER_NAME"      , name:"액션 주체" });
                addColumn({ width:60 , align:"center", type:"string" , sort:false, id:"ACT_COND_NO"         , name:"액션 조건 번호" });
                addColumn({ width:150, align:"left"  , type:"string" , sort:false, id:"ACT_COND_QRY"        , name:"액션 조건 쿼리문" });
                addColumn({ width:150, align:"left"  , type:"string" , sort:false, id:"NEXT_STEP_NAME"      , name:"다음 업무단계" });
                addColumn({ width:70 , align:"center", type:"string" , sort:false, id:"TODO_DISP_YN_NAME"   , name:"TODO표시" });
                addColumn({ width:150, align:"left"  , type:"string" , sort:false, id:"URGENT_DATE_QRY"     , name:"업무처리기한일 쿼리문" });
                addColumn({ width:150, align:"left"  , type:"string" , sort:false, id:"DUE_DATE_QRY"        , name:"법정기한일 쿼리문" });
                addColumn({ width:100, align:"left"  , type:"string" , sort:false, id:"PAPER_NAME"          , name:"진행서류" });
                addColumn({ width:80 , align:"left"  , type:"string" , sort:false, id:"PAPER_SUBNAME"       , name:"세부서류" });
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_NUM", "BIZ_ACT_NAME");
                addAction("BIZ_ACT_NAME", fnModWorkProc);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
    <TR>
        <TD height="1">
            <DIV class="button_area">
                <BUTTON text="<%= app.message.get("btn.com.add").toHTML() %>" onClick="javascript:fnAddWorkProc();"></BUTTON>
                <BUTTON auto="line"></BUTTON>
                <BUTTON text="위로" onClick="javascript:fnMoveRowData(-1);"></BUTTON>
                <BUTTON text="아래로" onClick="javascript:fnMoveRowData(1);"></BUTTON>
                <BUTTON text="저장" onClick="javascript:fnSaveDispOrd();"></BUTTON>
            </DIV>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
