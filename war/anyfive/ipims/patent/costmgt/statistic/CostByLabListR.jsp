<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>부서별 비용통계</TITLE>
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
    var ldr = gr_costByLabList.loader;

    ldr.init();
    ldr.path =  top.getRoot() + "/anyfive.ipims.patent.costmgt.statistic.act.RetrieveCostByLabList.do";
    ldr.addParam("DATE_START", DATE_START.value);
    ldr.addParam("DATE_END", DATE_END.value);

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
}

//상세
function fnDetail(gr, fg, row, colId)
{
    var win = new any.window();
    var nationDiv; // 국내외구분
    var costDiv;  // 관납료/수수료 구분

    win.path = "DetailCostListR.jsp";
    win.arg.DATE_START = DATE_START.value;
    win.arg.DATE_END = DATE_END.value;
    win.arg.LAB_CODE = gr.value(row, "LAB_CODE");


    switch(colId)
    {
        case "INT_GOV" :
            nationDiv = "INT";
            costDiv = "0";
            break;
        case "INT_OFF" :
            nationDiv = "INT";
            costDiv = "1";
            break;
        case "EXT_GOV" :
            nationDiv = "EXT";
            costDiv = "0";
            break;
        case "EXT_OFF" :
            nationDiv = "EXT";
            costDiv = "1";
            break;
        case "TOTAL"   :
            nationDiv = "";
            costDiv = "";
            break;
        default :
            break;
    }

    win.arg.NATION_DIV = nationDiv;
    win.arg.COST_DIV = costDiv;

    win.arg.gr = gr;
    win.opt.width = 800;
    win.opt.height = 600;

    win.onReload = function()
    {
        gr_intCostList.loader.reload();
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
                    <COL class="condhead" width="20%">
                    <COL class="conddata" width="80%">
                </COLGROUP>
                <TR>
                    <TD>기간</TD>
                    <TD colspan="3" noWrap>
                        <ANY:DATE id="DATE_START" />&nbsp;~
                        <ANY:DATE id="DATE_END" />
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
            <ANY:GRID id="gr_costByLabList" pagingType="1"><COMMENT>
                addHeader([null, null, "국내건", "", "해외건", "", "합계" ]);

                addColumn({ width:100 , align:"left"  , type:"string" , sort:true , id:"LAB_CODE" , name:"부서코드", hide:true });
                addColumn({ width:150 , align:"left"  , type:"string" , sort:true , id:"LAB_NAME" , name:"부   서" });
                addColumn({ width:140 , align:"right" , type:"string" , sort:true , id:"INT_GOV" , name:"관납료", format:"#,###" });
                addColumn({ width:140 , align:"right" , type:"string" , sort:true , id:"INT_OFF" , name:"국내수수료", format:"#,###" });
                addColumn({ width:140 , align:"right" , type:"string" , sort:true , id:"EXT_GOV" , name:"해외비용", format:"#,###" });
                addColumn({ width:140 , align:"right" , type:"string" , sort:true , id:"EXT_OFF" , name:"특허수수료", format:"#,###" });
                addColumn({ width:140 , align:"right" , type:"string" , sort:true , id:"TOTAL" , name:"합계", format:"#,###" });

                messageSpan = "spn_gridMessage";
                addAction("INT_GOV", fnDetail);
                addAction("INT_OFF", fnDetail);
                addAction("EXT_GOV", fnDetail);
                addAction("EXT_OFF", fnDetail);
                addAction("TOTAL", fnDetail);

            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
