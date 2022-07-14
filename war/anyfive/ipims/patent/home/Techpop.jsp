<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>기술별 특허보유현황</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<ANY:DS id="ds_result" />
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();
}

//리스트 조회
function fnRetrieve()
{
    var ldr = gr_nationChartList.loader;
    var gr = gr_nationChartList;
    var fg = gr.fg;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.statistic.viewchart.act.RetrieveMainTechChartPopList.do";


    ldr.onSuccess = function(gr, fg)
    {
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}
</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
    <TR>
        <TD height="100%" width="30%">
        <ANY:GRID id="gr_nationChartList" pagingType="0" width="100%" height="100%"><COMMENT>
                addColumn({ width:80, align:"center", type:"string", sort:false, id:"TECH_CODE" , name:"구분"  })
                addColumn({ width:80, align:"center", type:"string", sort:false, id:"KR" })
                addColumn({ width:80, align:"center", type:"string", sort:false, id:"US" })
                addColumn({ width:80, align:"center", type:"string", sort:false, id:"CN" })
                addColumn({ width:80, align:"center", type:"string", sort:false, id:"TW" })
                addColumn({ width:80, align:"center", type:"string", sort:false, id:"JP" })
                addColumn({ width:80, align:"center", type:"string", sort:false, id:"PCT" })
                addColumn({ width:80, align:"center", type:"string", sort:false, id:"EP" })
                addColumn({ width:80, align:"center", type:"string", sort:false, id:"DE" })

                setFixedColumn("TECH_CODE");
          </COMMENT></ANY:GRID>
        </TD>
     </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
