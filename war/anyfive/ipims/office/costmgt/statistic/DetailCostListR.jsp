<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.office.common.app.OfficeApp"%><% OfficeApp app = new OfficeApp(request, response, out); %>
<%@page import="any.util.etc.NDateUtil"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>비용현황 상세</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();
}

//비용목록 조회
function fnRetrieve()
{
    var ldr = gr_detailCostList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.office.costmgt.statistic.act.RetrieveDetailCostList.do";
    ldr.addParam("DATE_START", parent.DATE_START);
    ldr.addParam("DATE_END", parent.DATE_END);
    ldr.addParam("COST_KIND", parent.COST_KIND);
    ldr.addParam("YEAR_MON", parent.YEAR_MON);
    ldr.addParam("COST_DIV", parent.COST_DIV);
    ldr.addParam("NATION_DIV", parent.NATION_DIV);
    ldr.addParam("OFFICE_CODE", parent.OFFICE_CODE);
    ldr.addParam("LAB_CODE", parent.LAB_CODE);
    ldr.addParam("PJT_CODE", parent.PJT_CODE);

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
        <TD>
            <SPAN id="spn_gridMessage"></SPAN>
        </TD>
    </TR>
    <TR>
        <TD height="5"></TD>
    </TR>
    <TR>
        <TD height="100%">
            <ANY:GRID id="gr_detailCostList" pagingType="0" minHeight="250px"><COMMENT>
                addColumn({ width:100 , align:"left"  , type:"string" , sort:true , id:"REF_NO" , name:"REF-NO" });
                addColumn({ width:200 , align:"left"  , type:"string" , sort:true , id:"KO_APP_TITLE"  , name:"발명의명칭"});
                addColumn({ width:80  , align:"left"  , type:"string" , sort:true , id:"COUNTRY_NAME"      , name:"국가"});
                addColumn({ width:120 , align:"left"  , type:"string" , sort:true , id:"LAB_NAME"    , name:"연구소"});
                addColumn({ width:120 , align:"left"  , type:"string" , sort:true , id:"OFFICE_NAME" , name:"사무소" });
                addColumn({ width:100 , align:"left"  , type:"string" , sort:true , id:"GRAND_NAME"    , name:"비용대분류"});
                addColumn({ width:100 , align:"left"  , type:"string" , sort:true , id:"DETAIL_NAME"    , name:"비용상세"});
                addColumn({ width:80  , align:"right" , type:"number" , sort:true , id:"WON_PRICE"    , name:"원화금액", format:"#,###"});
                addColumn({ width:120 , align:"center", type:"string" , sort:true , id:"SLIP_ID"    , name:"전표번호"});
                addColumn({ width:80  , align:"center", type:"date"   , sort:true , id:"ANS_DATE"    , name:"결재완료일"});
                addColumn({ width:80  , align:"center", type:"string" , sort:true , id:"APPR_STATUS_NAME"    , name:"진행상태"});
                addColumn({ width:100 , align:"left"  , type:"string" , sort:true , id:"APP_NO"    , name:"출원번호"});
                addColumn({ width:100 , align:"left"  , type:"string" , sort:true , id:"REG_NO"    , name:"등록번호"});
                addColumn({ width:80  , align:"left"  , type:"string" , sort:true , id:"JOB_MAN"    , name:"건담당자"});
                addColumn({ width:100 , align:"left"  , type:"string" , sort:true , id:"DEPT_NAME"    , name:"부서명"});
                addColumn({ width:300 , align:"left"  , type:"string" , sort:true , id:"INVENTOR"    , name:"발명자"});

                useConfig = true;
                messageSpan = "spn_gridMessage";
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
    <TR>
        <TD>
            <DIV class="button_area">
                <BUTTON auto="list"></BUTTON>
            </DIV>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
