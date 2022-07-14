<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>진행서류 워크플로우관리 수정</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("WF_ID");
    addBind("WF_KIND");
    addBind("WF_NAME");
    addBind("WF_DESC");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();
    fnRetrieveWFPaperList();
}

//조회
function fnRetrieve()
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.papermgt.paperwf.act.RetrievePaperWF.do";
    prx.addParam("WF_CODE", parent.WF_CODE);
    prx.checkData = ds_mainInfo;

    prx.onSuccess = function()
    {
        WF_NAME.focus();
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.papermgt.paperwf.act.UpdatePaperWF.do";
    prx.addParam("WF_CODE", parent.WF_CODE);
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.papermgt.paperwf.act.DeletePaperWF.do";
    prx.addParam("WF_CODE", parent.WF_CODE);

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

//워크플로우별 진행서류 목록 조회
function fnRetrieveWFPaperList()
{
    var ldr = gr_wfPaperList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.papermgt.paperwf.act.RetrievePaperWFPaperList.do";
    ldr.addParam("WF_CODE", parent.WF_CODE);

    ldr.onSuccess = function(gr, fg)
    {
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

//워크플로우별 진행서류 추가
function fnCreateWFPaper()
{
    var win = new any.window();
    win.path = "PaperWFPaperC.jsp";
    win.arg.WF_CODE = parent.WF_CODE;
    win.opt.width = 600;
    win.opt.height = 130;

    win.onReload = function()
    {
        gr_wfPaperList.loader.reload();
    }

    win.show();
}

//워크플로우별 진행서류 상세
function fnDetailWFPaper(gr, fg, row, colId)
{
    var win = new any.window();
    win.path = "PaperWFPaperUD.jsp";
    win.arg.WF_CODE = parent.WF_CODE;
    win.arg.LIST_SEQ = gr.value(row, "LIST_SEQ");
    win.opt.width = 600;
    win.opt.height = 130;

    win.onReload = function()
    {
        gr_wfPaperList.loader.reload();
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
                    <COL class="contdata" width="35%">
                    <COL class="conthead" width="15%">
                    <COL class="contdata" width="35%">
                </COLGROUP>
                <TR>
                    <TD req="WF_ID">W/F 아이디</TD>
                    <TD>
                        <INPUT type="text" id="WF_ID" maxByte="10">
                    </TD>
                    <TD req="WF_KIND">W/F 종류</TD>
                    <TD>
                        <ANY:SELECT id="WF_KIND" firstName="sel" codeData="/systemmgt/wfKind" />
                    </TD>
                </TR>
                <TR>
                    <TD req="WF_NAME">W/F 이름</TD>
                    <TD colspan="3">
                        <INPUT type="text" id="WF_NAME" maxByte="300">
                    </TD>
                </TR>
                <TR>
                    <TD>W/F 설명</TD>
                    <TD colspan="3">
                        <INPUT type="text" id="WF_DESC" maxByte="1000">
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
                    <TD class="title_sub">업무별 진행서류</TD>
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
            <ANY:GRID id="gr_wfPaperList" pagingType="0" minHeight="150px"><COMMENT>
                addColumn({ width:50 , align:"center", type:"number" , sort:false, id:"ROW_NUM"             , name:"No" });
                addColumn({ width:100, align:"center", type:"string" , sort:false, id:"PAPER_DIV_NAME"      , name:"서류구분" });
                addColumn({ width:80 , align:"center", type:"string" , sort:false, id:"INOUT_DIV_NAME"      , name:"국내외구분" });
                addColumn({ width:255, align:"left"  , type:"string" , sort:false, id:"PAPER_NAME"          , name:"진행서류" });
                addColumn({ width:250, align:"left"  , type:"string" , sort:false, id:"PAPER_SUBNAME"       , name:"세부서류" });
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_NUM", "PAPER_NAME");
                addAction("PAPER_NAME", fnDetailWFPaper);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
    <TR>
        <TD height="1">
            <DIV class="button_area">
                <BUTTON text="<%= app.message.get("btn.com.add").toHTML() %>" onClick="javascript:fnCreateWFPaper();"></BUTTON>
            </DIV>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
