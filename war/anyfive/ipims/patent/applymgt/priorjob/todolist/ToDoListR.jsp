<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>기한관리현황</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieve()
}

//목록 조회
function fnRetrieve()
{
    var ldr = gr_toDoList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.priorjob.todolist.act.RetrieveToDoList.do";
    ldr.addParam("RIGHT_DIV", RIGHT_DIV.value);
    ldr.addParam("INOUT_DIV", INOUT_DIV.value);
    ldr.addParam("JOB_MAN", JOB_MAN.value);

    ldr.onSuccess = function(gr, fg)
    {
        fg.ReDraw = 0;
        for (var r = fg.FixedRows; r < fg.Rows; r++) {
            fg.Cell(flexcpForeColor, r, fg.ColIndex("URGENT_DATE")) = fg.Cell(flexcpForeColor, r, fg.ColIndex("URGENT_REMAIN_DAYS")) = (gr.value(r, "URGENT_REMAIN_DAYS") >= 0 ? "&HFF0000" : "&H0000FF");
            fg.Cell(flexcpForeColor, r, fg.ColIndex("DUE_DATE")) = fg.Cell(flexcpForeColor, r, fg.ColIndex("DUE_REMAIN_DAYS")) = (gr.value(r, "DUE_REMAIN_DAYS") >= 0 ? "&HFF0000" : "&H0000FF");
        }
        fg.ReDraw = 2;
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

//마스터
function fnMaster(gr, fg, row, colId)
{
    var win = new any.viewer();
    switch (gr.value(row, "INOUT_DIV")) {
    case "INT":
        win.path = top.getRoot() + "/anyfive/ipims/patent/applymgt/common/IntMasterTabR.jsp";
        break;
    case "EXT":
        win.path = top.getRoot() + "/anyfive/ipims/patent/applymgt/common/ExtMasterTabR.jsp";
        break;
    }
    win.arg.REF_ID = gr.value(row, "REF_ID");

    win.onReload = function()
    {
        gr.loader.reload();
    }

    win.show();
}

//진행서류
function fnPaper(gr, fg, row, colId)
{
    var win = new any.viewer();
    switch (gr.value(row, "INOUT_DIV")) {
    case "INT":
        win.path = top.getRoot() + "/anyfive/ipims/patent/applymgt/common/IntMasterTabR.jsp?TAB=paper";
        break;
    case "EXT":
        win.path = top.getRoot() + "/anyfive/ipims/patent/applymgt/common/ExtMasterTabR.jsp?TAB=paper";
        break;
    }
    win.arg.REF_ID = gr.value(row, "REF_ID");

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
                    <TD>권리구분</TD>
                    <TD>
                        <ANY:SELECT id="RIGHT_DIV" codeData="{RIGHT_DIV}" firstName="all" />
                    </TD>
                    <TD>국내외구분</TD>
                    <TD>
                        <ANY:SELECT id="INOUT_DIV" codeData="{INOUT_DIV}" firstName="all" />
                    </TD>
                    <TD>건담당자</TD>
                    <TD>
                        <ANY:SELECT id="JOB_MAN" codeData="/common/jobManAll" firstName="all" value="<%= app.userInfo.getUserId() %>" />
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
            <ANY:GRID id="gr_toDoList" pagingType="1"><COMMENT>
                addHeader([ null, null, null, "업무처리기한", "", "법정기한", "", null, null, null, null, null, null ]);
                addColumn({ width:100, align:"left"  , type:"string", sort:true, id:"REF_NO"            , name:"관련번호" });
                addColumn({ width:200, align:"left"  , type:"string", sort:true, id:"KO_APP_TITLE"      , name:"출원의 명칭" });
                addColumn({ width:150, align:"left"  , type:"string", sort:true, id:"PAPER_NAME"        , name:"진행서류명" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true, id:"URGENT_DATE"       , name:"기한일자" });
                addColumn({ width:70 , align:"center", type:"number", sort:true, id:"URGENT_REMAIN_DAYS", name:"잔여일수" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true, id:"DUE_DATE"          , name:"기한일자" });
                addColumn({ width:70 , align:"center", type:"number", sort:true, id:"DUE_REMAIN_DAYS"   , name:"잔여일수" });
                addColumn({ width:70 , align:"center", type:"string", sort:true, id:"RIGHT_DIV_NAME"    , name:"권리구분" });
                addColumn({ width:55 , align:"center", type:"string", sort:true, id:"INOUT_DIV_NAME"    , name:"국내외\n구분" });
                addColumn({ width:120, align:"left"  , type:"string", sort:true, id:"APP_NO"            , name:"출원번호" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true, id:"STATUS_NAME"       , name:"진행상태" });
                addColumn({ width:60 , align:"center", type:"string", sort:true, id:"JOB_MAN_NAME"      , name:"담당자" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true, id:"OFFICE_NAME"       , name:"사무소" });
                useConfig = true;
                messageSpan = "spn_gridMessage";
                setFixedColumn(null, "PAPER_NAME");
                addSorting("URGENT_REMAIN_DAYS", "ASC");
                addSorting("DUE_REMAIN_DAYS", "ASC");
                addAction("REF_NO", fnMaster);
                addAction("PAPER_NAME", fnPaper);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
