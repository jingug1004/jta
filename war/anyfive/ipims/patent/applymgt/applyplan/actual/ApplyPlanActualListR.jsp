<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<%@page import="any.util.etc.NDateUtil"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>출원실적조회</TITLE>
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
    var ldr = gr_applyPlanActualList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.applyplan.actual.act.RetrieveApplyPlanActualList.do";
    ldr.addParam("DATE_START", DATE_START.value);
    ldr.addParam("DATE_END", DATE_END.value);


    ldr.onSuccess = function(gr, fg)
    {
        <% if (app.userInfo.isPatentTeam() == true) { %>
        fnSubtotal();
        <% } %>
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

//합계
function fnSubtotal()
{
    var gr = gr_applyPlanActualList;

    if (gr.fg.Rows <= gr.fg.FixedRows) return;

    gr.fg.SubtotalPosition = flexSTAbove;
    gr.fg.Subtotal(flexSTClear);
    gr.fg.FrozenRows = 1;

    gr.fg.Subtotal(flexSTSum    , -1, gr.fg.ColIndex("INT_PLAN_CNT"), null, "&HFFAA55", "&HFFFFFF", true , "합 계");
    gr.fg.Subtotal(flexSTSum    , -1, gr.fg.ColIndex("INT_REQ_CNT"));
    gr.fg.Subtotal(flexSTSum    , -1, gr.fg.ColIndex("INT_ACT_CNT"));
    gr.fg.Subtotal(flexSTSum    , -1, gr.fg.ColIndex("INT_RET_CNT"));
    gr.fg.Subtotal(flexSTSum    , -1, gr.fg.ColIndex("INT_GIV_CNT"));
    gr.fg.Subtotal(flexSTSum    , -1, gr.fg.ColIndex("INT_APP_CNT"));
    gr.fg.Subtotal(flexSTSum    , -1, gr.fg.ColIndex("INT_APP_COM_CNT"));
    gr.fg.Subtotal(flexSTSum    , -1, gr.fg.ColIndex("INT_REG_CNT"));
    gr.fg.Subtotal(flexSTAverage, -1, gr.fg.ColIndex("INT_RATIO"));
    gr.fg.Subtotal(flexSTSum    , -1, gr.fg.ColIndex("EXT_PLAN_CNT"));
    gr.fg.Subtotal(flexSTSum    , -1, gr.fg.ColIndex("EXT_ACT_CNT"));
    gr.fg.Subtotal(flexSTSum    , -1, gr.fg.ColIndex("EXT_APP_CNT"));
    gr.fg.Subtotal(flexSTSum    , -1, gr.fg.ColIndex("EXT_APP_COM_CNT"));
    gr.fg.Subtotal(flexSTSum    , -1, gr.fg.ColIndex("EXT_REG_CNT"));
    gr.fg.Subtotal(flexSTAverage, -1, gr.fg.ColIndex("EXT_RATIO"));

    gr.fg.Cell(flexcpAlignment, gr.fg.FixedRows, 1) = flexAlignCenterCenter;

    gr.value(gr.fg.FixedRows, "INT_RATIO") = gr.value(gr.fg.FixedRows, "INT_ACT_CNT") / gr.value(gr.fg.FixedRows, "INT_PLAN_CNT") * 100;
    gr.value(gr.fg.FixedRows, "EXT_RATIO") = gr.value(gr.fg.FixedRows, "EXT_ACT_CNT") / gr.value(gr.fg.FixedRows, "EXT_PLAN_CNT") * 100;
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
                    <COL class="condhead" width="15%">
                    <COL class="conddata" width="35%">
                    <COL class="condhead" width="15%">
                    <COL class="conddata" width="35%">
                </COLGROUP>
               <TR>
                    <TD>검색일자</TD>
                    <TD noWrap colspan="3">
                        <ANY:DATE id="DATE_START"  />&nbsp;~
                        <ANY:DATE id="DATE_END"  />
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
            <ANY:GRID id="gr_applyPlanActualList" pagingType="0"><COMMENT>
                addHeader([ null, null, "국내", "", "", "", "", "", "", "","", "해외", "", "", "", "","","" ]);
                addColumn({ width:50 , align:"center", type:"number" , sort:false, id:"ROW_NUM"             , name:"No" });
                addColumn({ width:120, align:"left"  , type:"string" , sort:true , id:"DEPT_NAME"           , name:"부서이름(팀)" });
                addColumn({ width:60 , align:"right" , type:"number" , sort:false, id:"INT_PLAN_CNT"        , name:"목표\n(건)" , format:"#,###" });
                addColumn({ width:60 , align:"right" , type:"number" , sort:false, id:"INT_REQ_CNT"         , name:"제안\n(건)" , format:"#,##0.##" });
                addColumn({ width:60 , align:"right" , type:"number" , sort:false, id:"INT_ACT_CNT"         , name:"실적\n(건)" , format:"#,##0.##" });
                addColumn({ width:60 , align:"right" , type:"number" , sort:false, id:"INT_RET_CNT"         , name:"보완\n(건)" , format:"#,##0.##" });
                addColumn({ width:60 , align:"right" , type:"number" , sort:false, id:"INT_GIV_CNT"         , name:"포기\n(건)" , format:"#,##0.##" });
                addColumn({ width:60 , align:"right" , type:"number" , sort:false, id:"INT_APP_CNT"         , name:"출원의뢰\n(건)" , format:"#,##0.##" });
                addColumn({ width:60 , align:"right" , type:"number" , sort:false, id:"INT_APP_COM_CNT"     , name:"출원완료\n(건)" , format:"#,##0.##" });
                addColumn({ width:60 , align:"right" , type:"number" , sort:false, id:"INT_REG_CNT"         , name:"등록\n(건)" , format:"#,##0.##" });
                addColumn({ width:70 , align:"right" , type:"number" , sort:false, id:"INT_RATIO"           , name:"달성율\n(%)", format:"#,##0.##" });
                addColumn({ width:60 , align:"right" , type:"number" , sort:false, id:"EXT_PLAN_CNT"        , name:"목표\n(건)" , format:"#,###" });
                addColumn({ width:60 , align:"right" , type:"number" , sort:false, id:"EXT_ACT_CNT"         , name:"실적\n(건)" , format:"#,##0.##" });
                addColumn({ width:60 , align:"right" , type:"number" , sort:false, id:"EXT_APP_CNT"         , name:"출원의뢰\n(건)" , format:"#,##0.##" });
                addColumn({ width:60 , align:"right" , type:"number" , sort:false, id:"EXT_APP_COM_CNT"     , name:"출원완료\n(건)" , format:"#,##0.##" });
                addColumn({ width:60 , align:"right" , type:"number" , sort:false, id:"EXT_REG_CNT"         , name:"등록\n(건)" , format:"#,##0.##" });
                addColumn({ width:70 , align:"right" , type:"number" , sort:false, id:"EXT_RATIO"           , name:"달성율\n(%)", format:"#,##0.##" });
                fg.RowHeight(1) = 550;
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_NUM", "DEPT_NAME");
                addSorting("DEPT_NAME", "ASC");
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
