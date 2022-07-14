<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>진행서류 이벤트 수정</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("EVENT_ID");
    addBind("EVENT_NAME");
    addBind("EVENT_DESC");
    addBind("NEXT_URGENT_DATE_QRY");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();
    fnRetrieveEventPaperList();
}

//조회
function fnRetrieve()
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.papermgt.paperevent.act.RetrievePaperEvent.do";
    prx.addParam("EVENT_SEQ", parent.EVENT_SEQ);
    prx.checkData = ds_mainInfo;

    prx.onSuccess = function()
    {
        EVENT_ID.focus();
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.papermgt.paperevent.act.UpdatePaperEvent.do";
    prx.addParam("EVENT_SEQ", parent.EVENT_SEQ);
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.papermgt.paperevent.act.DeletePaperEvent.do";
    prx.addParam("EVENT_SEQ", parent.EVENT_SEQ);

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

//이벤트별 진행서류 목록 조회
function fnRetrieveEventPaperList()
{
    var ldr = gr_eventPaperList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.papermgt.paperevent.act.RetrievePaperEventPaperList.do";
    ldr.addParam("EVENT_SEQ", parent.EVENT_SEQ);

    ldr.onSuccess = function(gr, fg)
    {
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

//이벤트별 진행서류 상세
function fnDetailEventPaper(gr, fg, row, colId)
{
    var win = new any.window();
    win.path = "PaperEventPaperCUD.jsp";
    win.arg.EVENT_SEQ = parent.EVENT_SEQ;
    win.arg.PAPER_DIV = gr.value(row, "PAPER_DIV");
    win.arg.INOUT_DIV = gr.value(row, "INOUT_DIV");
    win.opt.width = 600;
    win.opt.height = 200;

    win.onReload = function()
    {
        gr_eventPaperList.loader.reload();
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
            <TABLE border="0" cellspacing="1" cellpadding="2" class="main">
                <COLGROUP>
                    <COL class="conthead" width="15%">
                    <COL class="contdata" width="85%">
                </COLGROUP>
                <TR>
                    <TD req="EVENT_ID">이벤트 ID</TD>
                    <TD>
                        <INPUT type="text" id="EVENT_ID" maxByte="30" style="text-transform:uppercase;">
                    </TD>
                </TR>
                <TR>
                    <TD req="EVENT_NAME">이벤트 이름</TD>
                    <TD>
                        <INPUT type="text" id="EVENT_NAME" maxByte="300">
                    </TD>
                </TR>
                <TR>
                    <TD>이벤트 설명</TD>
                    <TD>
                        <INPUT type="text" id="EVENT_DESC" maxByte="1000">
                    </TD>
                </TR>
                <TR>
                    <TD>다음업무처리기한일<BR>쿼리문</TD>
                    <TD>
                        <TEXTAREA id="NEXT_URGENT_DATE_QRY" rows="3" maxByte="4000"></TEXTAREA>
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
                    <TD class="title_sub">이벤트별 진행서류</TD>
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
            <ANY:GRID id="gr_eventPaperList" pagingType="0" minHeight="150px"><COMMENT>
                addColumn({ width:50 , align:"center", type:"number" , sort:false, id:"ROW_NUM"             , name:"No" });
                addColumn({ width:150, align:"center", type:"string" , sort:false, id:"PAPER_DIV_NAME"      , name:"서류구분" });
                addColumn({ width:100, align:"center", type:"string" , sort:false, id:"INOUT_DIV_NAME"      , name:"국내외구분" });
                addColumn({ width:250, align:"left"  , type:"string" , sort:false, id:"PAPER_NAME"          , name:"진행서류" });
                addColumn({ width:200, align:"left"  , type:"string" , sort:false, id:"PAPER_SUBNAME"       , name:"세부서류" });
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_NUM", "INOUT_DIV_NAME");
                addAction("PAPER_NAME", fnDetailEventPaper);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
