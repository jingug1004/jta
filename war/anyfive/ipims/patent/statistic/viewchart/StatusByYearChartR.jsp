<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>연도별 출원/등록현황</TITLE>
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
    var ldr = gr_yearChartList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.statistic.viewchart.act.RetrieveStatusByYearChartForGrid.do";

    ldr.onSuccess = function(gr, fg)
    {
        fg.MergeCells=flexMergeFree;
        fg.MergeCol(0)=true;
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}
//목록 초기화
function fnInitList(gr, fg, row, colId)
{
    var ldr_app = gr_yearChartListDetail_app.loader;
    var ldr_reg = gr_yearChartListDetail_reg.loader;

    ldr_app.init();
    ldr_reg.init();
    ldr_app.path = top.getRoot() + "/anyfive.ipims.patent.statistic.viewchart.act.RetrieveStatusByYearChartDetailApp.do";
    ldr_reg.path = top.getRoot() + "/anyfive.ipims.patent.statistic.viewchart.act.RetrieveStatusByYearChartDetailReg.do";
    var COL2= gr.value(row, "COL2");

    ldr_app.addParam("APP_DATE", COL2);
    ldr_reg.addParam("APP_DATE", COL2);


    ldr_app.onSuccess = function(gr, fg)
    {
    }

    ldr_reg.onSuccess = function(gr, fg)
    {
    }

    ldr_app.onFail = function(gr, fg)
    {
        this.error.show();
    }
    ldr_reg.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr_app.execute();
    ldr_reg.execute();

}
//팝업으로 해당데이터 상세보기
function fnDetail(gr, fg, row, colId)
{
    var win = new any.window();
    win.path = top.getRoot() + "/anyfive/ipims/patent/applymgt/common/IntMasterTabR.jsp";
    win.arg.REF_ID = gr.value(row, "REF_ID");
    win.arg.gr = gr;
    win.opt.width = 800;
    win.opt.height = 600;

    win.onReload = function()
    {
        gr_yearChartList.loader.reload();
    }

    win.show();
}

</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>
<TABLE border="0" width="100%">
      <TR>
          <TD align="right" >
                  <SPAN id="spn_gridMessage_app"></SPAN>&nbsp;&nbsp;
              <b> <FONT color="#6C1D39"  size="2">출원현황</FONT></b>
          </TD>
          <TD align="right" width="35%">
                   <SPAN id="spn_gridMessage_reg"></SPAN>&nbsp;&nbsp;
              <b> <FONT color="#6C1D39"  size="2">등록현황</FONT></b>
          </TD>
      </TR>
</TABLE>
<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="35%">
    <TR>
        <TD height="100%" width="30%">
        <ANY:GRID id="gr_yearChartList" pagingType="0" width="30%"><COMMENT>
                addColumn({ width:100, align:"center", type:"string", sort:false, id:"COL2", name:"연도" });
                addColumn({ width:120, align:"center", type:"string", sort:false, id:"COL1", name:"구분" });
                addColumn({ width:150, align:"left"  , type:"number", sort:false, id:"CNT" , name:"현황(건)" });
                setFixedColumn("COL2", "COL1");
                addAction("COL2",fnInitList);
          </COMMENT></ANY:GRID>
        </TD>
        <TD width="2%"></TD>
        <TD width="30%">
            <ANY:GRID id="gr_yearChartListDetail_app" pagingType="0" width="60%"><COMMENT>
                addColumn({ width:100, align:"center", type:"string", sort:true, id:"REF_NO"              , name:"REF-NO" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true, id:"APP_NO"              , name:"출원번호" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true, id:"APP_DATE"            , name:"출원일" });
                addColumn({ width:200, align:"left"  , type:"string", sort:true, id:"KO_APP_TITLE"        , name:"발명의 명칭" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true, id:"REG_NO"              , name:"등록번호" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true, id:"REG_DATE"            , name:"등록일" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true, id:"OFFICE_NAME"         , name:"사무소" });
                addColumn({ width:75 , align:"center", type:"string", sort:true, id:"JOB_MAN_NAME"        , name:"담당자" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true, id:"STATUS_NAME"         , name:"진행상태" });
                addColumn({ width:75 , align:"left"  , type:"string", sort:true, id:"EXT_APP_NEED_YN_NAME", name:"해외출원필요성" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true, id:"INVENTOR_NAMES"      , name:"발명자" });
                setFixedColumn("REF_NO", "APP_NO");
                addAction("KO_APP_TITLE", fnDetail);
                messageSpan = "spn_gridMessage_app";
           </COMMENT></ANY:GRID>
        </TD>
         <TD width="2%"></TD>
        <TD width="30%">
            <ANY:GRID id="gr_yearChartListDetail_reg" pagingType="0" width="60%"><COMMENT>
                addColumn({ width:100, align:"center", type:"string", sort:true, id:"REF_NO"              , name:"REF-NO" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true, id:"APP_NO"              , name:"출원번호" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true, id:"APP_DATE"            , name:"출원일" });
                addColumn({ width:200, align:"left"  , type:"string", sort:true, id:"KO_APP_TITLE"        , name:"발명의 명칭" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true, id:"REG_NO"              , name:"등록번호" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true, id:"REG_DATE"            , name:"등록일" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true, id:"OFFICE_NAME"         , name:"사무소" });
                addColumn({ width:75 , align:"center", type:"string", sort:true, id:"JOB_MAN_NAME"        , name:"담당자" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true, id:"STATUS_NAME"         , name:"진행상태" });
                addColumn({ width:75 , align:"left"  , type:"string", sort:true, id:"EXT_APP_NEED_YN_NAME", name:"해외출원필요성" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true, id:"INVENTOR_NAMES"      , name:"발명자" });
                setFixedColumn("REF_NO", "APP_NO");
                addAction("KO_APP_TITLE", fnDetail);
                messageSpan = "spn_gridMessage_reg";
           </COMMENT></ANY:GRID>
        </TD>


    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
