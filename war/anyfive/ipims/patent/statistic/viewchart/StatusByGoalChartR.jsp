<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>출원목표 대비 실적현황</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_CHART); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<ANY:DS id="ds_result" />
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieve2();
}

//조회
//리스트 조회
function fnRetrieve2()
{
    var ldr = gr_goalChartList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.statistic.viewchart.act.RetrieveStatusByGoalChartForGrid.do";


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

<BR>
<BR>
<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="35%">
    <TR>
        <TD height="100%">
        <ANY:GRID id="gr_goalChartList" pagingType="1"><COMMENT>
                addColumn({ width:100, align:"center", type:"string", sort:false, id:"TEAM", name:"팀" });
                addColumn({ width:100, align:"center", type:"string", sort:false, id:"C1"  , name:"국내출원목표" });
                addColumn({ width:100, align:"center", type:"string", sort:false, id:"C2"  , name:"해외출원목표" });
                addColumn({ width:100, align:"center", type:"string", sort:false, id:"C3"  , name:"국내실적" });
                addColumn({ width:100, align:"center", type:"string", sort:false, id:"C4"  , name:"국내출원의뢰" });
                addColumn({ width:100, align:"center", type:"string", sort:false, id:"C5"  , name:"국내등록" });
                addColumn({ width:100, align:"center", type:"string", sort:false, id:"C6"  , name:"해외실적" });
                addColumn({ width:100, align:"center", type:"string", sort:false, id:"C7"  , name:"국내제안" });

                setFixedColumn("TEAM", "C1");
          </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
