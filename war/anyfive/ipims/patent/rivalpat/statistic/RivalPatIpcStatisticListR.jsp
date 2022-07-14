<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>IPC분류분석현황</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{

    fnRetrieve();
}

//목록 조회
function fnRetrieve()
{
    var ldr = gr_rivalPatIpcStatisticList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.rivalpat.statistic.act.RetrieveRivalPatIpcStatisticList.do";

    ldr.onSuccess = function(gr, fg)
    {
        fnSubtotal(gr);
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

//합계
function fnSubtotal(gr)
{
    var totalCnt = 0;
    var evalCnt = 0;

    for(var i = 2; i < gr.fg.Rows ; i++){
        totalCnt += Number(gr.value(i, "TOTAL_CNT"));
        evalCnt  += Number(gr.value(i, "EVAL_CNT"));
    }

    gr.value(1, "TOTAL_CNT") = totalCnt;
    gr.value(1, "EVAL_CNT") = evalCnt;

    if (evalCnt == 0) evalCnt = 1;

    gr.value(gr.fg.FixedRows, "EVAL_PERCENT") = Math.round(Number(evalCnt) / Number(totalCnt) * 10000) / 100;
}

function fnSearch(gr, fg, row, colId)
{
    var win = new any.window();
    win.path = top.getRoot() + "/anyfive/ipims/patent/rivalpat/evalmaster/RivalPatEvalMasterListRPop.jsp";
    win.arg.IPC_CODE = gr.value(row, "IPC_CODE");
    win.arg.EVAL_CNT = gr.value(row, "EVAL_CNT");
    win.arg.GUBUN = "T";


    win.opt.width = 1150;
    win.opt.height = 600;
    win.opt.resizable = "yes";

    win.onReload = function()
    {
        gr_rivalPatList.loader.reload();
    }

    win.show();
}

function fnSearch_Eval(gr, fg, row, colId)
{
    var win = new any.window();
    win.path = top.getRoot() + "/anyfive/ipims/patent/rivalpat/evalmaster/RivalPatEvalMasterListRPop.jsp";
    win.arg.IPC_CODE = gr.value(row, "IPC_CODE");
    win.arg.EVAL_CNT = gr.value(row, "EVAL_CNT");
    win.arg.GUBUN = "E";

    win.opt.width = 1150;
    win.opt.height = 600;
    win.opt.resizable = "yes";

    win.onReload = function()
    {
        gr_rivalPatList.loader.reload();
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
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>

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
            <ANY:GRID id="gr_rivalPatIpcStatisticList" pagingType="0"><COMMENT>
                addColumn({ width:200, align:"left"  , type:"string", sort:false, id:"IPC_HNAME"        , name:"IPC분류" });
                addColumn({ width:120, align:"center", type:"string", sort:false, id:"TOTAL_CNT"        , name:"총건수(건)", format:"#,###" });
                addColumn({ width:120, align:"center", type:"string", sort:false, id:"EVAL_CNT"         , name:"IPC검토(건)", format:"#,###" });
                addColumn({ width:120, align:"right" , type:"number", sort:false, id:"EVAL_PERCENT"     , name:"검토율(%)", format:"#,##0.##" });
                addColumn({ width:"", align:"left"  , type:"string", sort:false, id:"IPC_CODE"           , name:"IPC_CODE" , hide:true});
                addColumn({ width:"", align:"left"  , type:"string", sort:false, id:"EVAL_CNT"          , name:"EVAL_CNT" , hide:true});
                setOutline("전체", "IPC_HNAME", "IPC_LEVEL", 1);
                addAction("TOTAL_CNT", fnSearch);
                addAction("EVAL_CNT", fnSearch_Eval);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
