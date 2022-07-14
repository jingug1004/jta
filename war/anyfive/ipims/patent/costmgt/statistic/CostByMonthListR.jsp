<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>월별 비용통계현황</TITLE>
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
    var ldr = gr_costByMonthList.loader;

    ldr.init();
    ldr.path =  top.getRoot() + "/anyfive.ipims.patent.costmgt.statistic.act.RetrieveCostByMonthList.do";
    ldr.addParam("DATE_START", DATE_START.value);
    ldr.addParam("DATE_END", DATE_END.value);

    ldr.onSuccess = function(gr, fg)
    {
        fnSubtotal();
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
  var costKind; // 비용구분(장기선급, 수수료)

  win.path = top.getRoot() + "/anyfive/ipims/patent/costmgt/statistic/DetailCostListR.jsp";
  win.arg.DATE_START = DATE_START.value;
  win.arg.DATE_END = DATE_END.value;
  win.arg.YEAR_MON = gr.value(row, "YEAR_MON");

  if(colId == "PREPAID")
      costKind = "4";
  else if(colId == "FEE")
      costKind = "3";
  else
      costKind = "";

  win.arg.COST_KIND = costKind;

  win.arg.gr = gr;
  win.opt.width = 800;
  win.opt.height = 600;

  win.onReload = function()
  {
      gr_intCostList.loader.reload();
  }

  win.show();
}

//전체상세
function fnDetailAll(gr, fg, row, colId)
{
  var win = new any.window();
  var costKind; // 비용구분(장기선급, 수수료)

  win.path = top.getRoot() + "/anyfive/ipims/patent/costmgt/statistic/CostByAllListRT.jsp";

  if(colId == "PREPAID")
      costKind = "4";
  else if(colId == "INTEREST")
      costKind = "7";
  else if(colId == "FEE")
      costKind = "3";
  else if(colId == "REFUSAL")
      costKind = "2";
  else if(colId == "OTHER")
      costKind = "1";
  else
      costKind = "";


  win.arg.COST_KIND = costKind;
  win.arg.YEAR_MON = gr.value(row, "YEAR_MON");

  win.arg.gr = gr;
  win.opt.width = 800;
  win.opt.height = 600;

  win.onReload = function()
  {
      gr_intCostList.loader.reload();
  }

  win.show();
}

//합계
function fnSubtotal()
{
    var gr = gr_costByMonthList;

    if (gr.fg.Rows <= gr.fg.FixedRows) return;

    gr.fg.SubtotalPosition = flexSTBelow;
    gr.fg.Subtotal(flexSTClear);

    gr.fg.Subtotal(flexSTSum, -1, gr.fg.ColIndex("PREPAID"));
    gr.fg.Subtotal(flexSTSum, -1, gr.fg.ColIndex("INTEREST"));
    gr.fg.Subtotal(flexSTSum, -1, gr.fg.ColIndex("FEE"));
    gr.fg.Subtotal(flexSTSum, -1, gr.fg.ColIndex("REFUSAL"));
    gr.fg.Subtotal(flexSTSum, -1, gr.fg.ColIndex("OTHER"));
    gr.fg.Subtotal(flexSTSum, -1, gr.fg.ColIndex("TOTAL"));
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
            <ANY:GRID id="gr_costByMonthList" pagingType="1"><COMMENT>
                addHeader(["",  "" , "수수료", "", ""]);
                addColumn({ width:200 , align:"center", type:"string" , sort:true , id:"YEAR_MON" , name:"년월" });
                addColumn({ width:150 , align:"right" , type:"number" , sort:true , id:"PREPAID"  , name:"장기선급금" , format:"#,###" });
                addColumn({ width:150 , align:"right" , type:"number" , sort:true , id:"INTEREST" , name:"연차유지비용" , format:"#,###" });
                addColumn({ width:150 , align:"right" , type:"number" , sort:true , id:"REFUSAL"  , name:"선급금 수수료처리비용" , format:"#,###" });
                addColumn({ width:150 , align:"right" , type:"number" , sort:true , id:"FEE"      , name:"기타 수수료" , format:"#,###" });
                addColumn({ width:150 , align:"right" , type:"number" , sort:true , id:"OTHER"    , name:"자산처리비용" , format:"#,###" });
                addColumn({ width:150 , align:"right" , type:"number" , sort:true , id:"TOTAL"    , name:"소계" , format:"#,###" });

                fnSubtotal();

                messageSpan = "spn_gridMessage";
                addAction("PREPAID", fnDetailAll);
                addAction("INTEREST", fnDetailAll);
                addAction("REFUSAL", fnDetailAll);
                addAction("FEE", fnDetailAll);
                addAction("OTHER", fnDetailAll);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
