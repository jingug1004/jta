<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>전체 출원/등록현황</TITLE>
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
function fnRetrieve2()
{
    var ldr = gr_allChartList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.statistic.viewchart.act.RetrieveStatusByAllChartForGrid.do";

    ldr.onSuccess = function(gr, fg)
    {

    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

function fnDetail(gr, fg, row, colId)//아래 오른쪽에 뿌려질 해당 그리드 리스트
{
    var ldr = gr_allRightChartList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.statistic.viewchart.act.RetrieveStatusByAllChartDetail.do";
    var COL1 = gr.value(row, "COL1");

    ldr.addParam("COL1", COL1);

    ldr.onSuccess = function(gr, fg)
    {

    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

function fnDetail2(gr, fg, row, colId)//팝업으로 해당데이터 상세보기
{
    var win = new any.window();
    win.path = top.getRoot() + "/anyfive/ipims/patent/applymgt/common/IntMasterTabR.jsp";
    win.arg.REF_ID = gr.value(row, "REF_ID");
    win.arg.gr = gr;
    win.opt.width = 800;
    win.opt.height = 600;

    win.onReload = function()
    {
        gr_allChartList.loader.reload();
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
            </BR>
            </BR>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="35%">
                <TR>
                    <TD width="35%">
                        <ANY:GRID id="gr_allChartList" pagingType="0"><COMMENT>
                            addColumn({ width:100, align:"center", type:"string", sort:false, id:"COL1", name:"상태" });
                            addColumn({ width:70 , align:"center", type:"number", sort:false, id:"CNT" , name:"건수" });

                            useConfig = true;
                            setFixedColumn(null, "COL1");
                            addAction("COL1", fnDetail);
                        </COMMENT></ANY:GRID>
                    </TD>
                    <TD width="2%"></TD>
                    <TD width="61%">
                        <ANY:GRID id="gr_allRightChartList" pagingType="0" width="60%"><COMMENT>
                            addColumn({ width:100, align:"center", type:"string" , sort:true , id:"REF_NO"              , name:"REF-NO" });
                            addColumn({ width:100, align:"left"  , type:"string" , sort:true , id:"APP_NO"              , name:"출원번호" });
                            addColumn({ width:75 , align:"center", type:"date"   , sort:true , id:"APP_DATE"            , name:"출원일" });
                            addColumn({ width:200, align:"left"  , type:"string" , sort:true , id:"KO_APP_TITLE"        , name:"발명의 명칭" });
                            addColumn({ width:100, align:"left"  , type:"string" , sort:true , id:"REG_NO"              , name:"등록번호" });
                            addColumn({ width:75 , align:"center", type:"date"   , sort:true , id:"REG_DATE"            , name:"등록일" });
                            addColumn({ width:100, align:"left"  , type:"string" , sort:true , id:"OFFICE_NAME"         , name:"사무소" });
                            addColumn({ width:75 , align:"center", type:"string" , sort:true , id:"JOB_MAN_NAME"        , name:"담당자" });
                            addColumn({ width:100, align:"left"  , type:"string" , sort:true , id:"STATUS_NAME"         , name:"진행상태" });
                            addColumn({ width:75 , align:"left"  , type:"string" , sort:true , id:"EXT_APP_NEED_YN_NAME", name:"해외출원필요성" });
                            addColumn({ width:100, align:"left"  , type:"string" , sort:true , id:"INVENTOR_NAMES"      , name:"발명자" });

                            setFixedColumn(null, "KO_APP_TITLE");
                            addAction("REF_NO", fnDetail2);
                        </COMMENT></ANY:GRID>
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
