<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<%@page import="any.util.etc.NDateUtil"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>팀별실적조회 - <%= app.userInfo.getDeptName() %></TITLE>
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
    var ldr = gr_applyPlanInvActualList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.applyplan.invactual.act.RetrieveApplyPlanInvActualList.do";
    ldr.addParam("PLAN_YEAR", PLAN_YEAR.value);

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

//합계
function fnSubtotal()
{
    var gr = gr_applyPlanInvActualList;

    if (gr.fg.Rows <= gr.fg.FixedRows) return;

    gr.fg.SubtotalPosition = flexSTAbove;
    gr.fg.Subtotal(flexSTClear);
    gr.fg.FrozenRows = 1;

    gr.fg.Subtotal(flexSTSum    , -1, gr.fg.ColIndex("INT_PLAN_CNT"), null, "&HFFAA55", "&HFFFFFF", true , "합 계");
    gr.fg.Subtotal(flexSTSum    , -1, gr.fg.ColIndex("INT_REQ_CNT"));
    gr.fg.Subtotal(flexSTSum    , -1, gr.fg.ColIndex("INT_ACT_CNT"));
    gr.fg.Subtotal(flexSTSum    , -1, gr.fg.ColIndex("INT_RET_CNT"));
    gr.fg.Subtotal(flexSTAverage, -1, gr.fg.ColIndex("INT_RATIO"));
    gr.fg.Subtotal(flexSTSum    , -1, gr.fg.ColIndex("EXT_PLAN_CNT"));
    gr.fg.Subtotal(flexSTSum    , -1, gr.fg.ColIndex("EXT_ACT_CNT"));
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
                    <COL class="conddata" width="85%">
                </COLGROUP>
                <TR>
                    <TD>조회연도</TD>
                    <TD>
                        <ANY:SELECT id="PLAN_YEAR" codeData="/applymgt/applyPlanYear" value="<%= NDateUtil.getFormatDate("yyyy") %>" />
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
            <ANY:GRID id="gr_applyPlanInvActualList" pagingType="0"><COMMENT>
                addHeader([ null, null, null, null, "국내", "", "", "", "", "해외", "", "" ]);
                addColumn({ width:50 , align:"center", type:"number", sort:false, id:"ROW_NUM"              , name:"No" });
                addColumn({ width:75 , align:"center", type:"string", sort:false, id:"EMP_HNAME"            , name:"성명" });
                addColumn({ width:70 , align:"center", type:"string", sort:false, id:"POSITION_NAME"        , name:"직급" });
                addColumn({ width:60 , align:"center", type:"string", sort:false, id:"HT_CODE_NAME"         , name:"휴퇴\n구분" });
                addColumn({ width:70 , align:"right" , type:"number", sort:false, id:"INT_PLAN_CNT"         , name:"목표(건)" , format:"#,###" });
                addColumn({ width:70 , align:"right" , type:"number", sort:false, id:"INT_REQ_CNT"          , name:"제안(건)" , format:"#,##0.##" });
                addColumn({ width:70 , align:"right" , type:"number", sort:false, id:"INT_ACT_CNT"          , name:"실적(건)" , format:"#,##0.##" });
                addColumn({ width:70 , align:"right" , type:"number", sort:false, id:"INT_RET_CNT"          , name:"반려(건)" , format:"#,##0.##" });
                addColumn({ width:70 , align:"right" , type:"number", sort:false, id:"INT_RATIO"            , name:"달성율(%)", format:"#,##0.##" });
                addColumn({ width:70 , align:"right" , type:"number", sort:false, id:"EXT_PLAN_CNT"         , name:"목표(건)" , format:"#,###" });
                addColumn({ width:70 , align:"right" , type:"number", sort:false, id:"EXT_ACT_CNT"          , name:"실적(건)" , format:"#,##0.##" });
                addColumn({ width:70 , align:"right" , type:"number", sort:false, id:"EXT_RATIO"            , name:"달성율(%)", format:"#,##0.##" });
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_NUM", "EMP_HNAME");
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
