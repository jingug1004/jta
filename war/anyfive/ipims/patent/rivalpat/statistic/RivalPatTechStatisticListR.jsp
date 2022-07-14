<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>기술분류별 분석현황</TITLE>
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
    var ldr = gr_rivalPatTechStatisticList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.rivalpat.statistic.act.RetrieveRivalPatTechStatisticList.do";

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


function fnSearchPopup(gr, fg, row, colId)
{
    var win = new any.window();
    win.path = top.getRoot() + "/anyfive/ipims/patent/rivalpat/statistic/RivalPatTechStatisticListRPop.jsp";
    win.arg.TECH_CODE = gr.value(row, "TECH_CODE");

    win.opt.width = 1150;
    win.opt.height = 600;
    win.opt.resizable = "yes";

    win.onReload = function()
    {
        gr_rivalPatTechStatisticList.loader.reload();
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
            <ANY:GRID id="gr_rivalPatTechStatisticList" pagingType="0"><COMMENT>
                addHeader([ null, "출원", "", "", "", "", "", "", "", "등록", "", "", "", "", "", "", "", null, null, null]);
                addColumn({ width:200, align:"left"  , type:"string", sort:false, id:"TECH_HNAME"       , name:"기술분류" });
                addColumn({ width:40, align:"center", type:"string", sort:false, id:"KRAPP_CNT"         , name:"한국", format:"#,###" });
                addColumn({ width:40, align:"center", type:"string", sort:false, id:"USAPP_CNT"         , name:"미국", format:"#,###" });
                addColumn({ width:40, align:"center", type:"string", sort:false, id:"CNAPP_CNT"         , name:"중국", format:"#,###" });
                addColumn({ width:40, align:"center", type:"string", sort:false, id:"TWAPP_CNT"         , name:"대만", format:"#,###" });
                addColumn({ width:40, align:"center", type:"string", sort:false, id:"JPAPP_CNT"         , name:"일본", format:"#,###" });
                addColumn({ width:40, align:"center", type:"string", sort:false, id:"EPAPP_CNT"         , name:"유럽", format:"#,###" });
                addColumn({ width:40, align:"center", type:"string", sort:false, id:"DEAPP_CNT"         , name:"독일", format:"#,###" });
                addColumn({ width:40, align:"center", type:"string", sort:false, id:"ECTAPP_CNT"         , name:"기타", format:"#,###" });
                addColumn({ width:40, align:"center", type:"string", sort:false, id:"KRREG_CNT"         , name:"한국", format:"#,###" });
                addColumn({ width:40, align:"center", type:"string", sort:false, id:"USREG_CNT"         , name:"미국", format:"#,###" });
                addColumn({ width:40, align:"center", type:"string", sort:false, id:"CNREG_CNT"         , name:"중국", format:"#,###" });
                addColumn({ width:40, align:"center", type:"string", sort:false, id:"TWREG_CNT"         , name:"대만", format:"#,###" });
                addColumn({ width:40, align:"center", type:"string", sort:false, id:"JPREG_CNT"         , name:"일본", format:"#,###" });
                addColumn({ width:40, align:"center", type:"string", sort:false, id:"EPREG_CNT"         , name:"유럽", format:"#,###" });
                addColumn({ width:40, align:"center", type:"string", sort:false, id:"DEREG_CNT"         , name:"독일", format:"#,###" });
                addColumn({ width:40, align:"center", type:"string", sort:false, id:"ECTREG_CNT"         , name:"기타", format:"#,###" });
                addColumn({ width:80, align:"center", type:"string", sort:false, id:"TOTAL_CNT"        , name:"총건수(건)", format:"#,###" });
                addColumn({ width:80, align:"center", type:"string", sort:false, id:"EVAL_CNT"         , name:"기술검토(건)", format:"#,###" });
                addColumn({ width:80, align:"right" , type:"number", sort:false, id:"EVAL_PERCENT"     , name:"검토율(%)", format:"#,##0.##" });
                addColumn({ width:50, align:"left"  , type:"string", sort:false, id:"TECH_CODE"       , name:"기술분류", hide:true });
                setOutline("전체", "TECH_HNAME", "TECH_LEVEL", 1);
                useConfig = true;
                setFixedColumn(null, "TECH_HNAME");
                addAction("TOTAL_CNT", fnSearchPopup);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
