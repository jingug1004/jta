<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<%@page import="any.util.etc.NDateUtil"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>출원목표수립</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<ANY:DS id="ds_applyPlanGoalList" />
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();
}

//목록 조회
function fnRetrieve()
{
    var ldr = gr_applyPlanGoalList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.applyplan.goal.act.RetrieveApplyPlanGoalList.do";
    ldr.addParam("PLAN_YEAR", PLAN_YEAR.value);
    ldr.addParam("ACTR_STD", ACTR_STD.value);

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

//저장
function fnSave()
{
    var gr = gr_applyPlanGoalList;
    var ds = ds_applyPlanGoalList;

    var intPlanCnt;
    var extPlanCnt;
    var colIdx;

    ds.init();

    for (var r = gr.fg.FixedRows; r < gr.fg.Rows; r++) {
        if (gr.fg.IsSubtotal(r) == true) continue;

        intPlanCnt = cfGetUnformatNumber(gr.text(r, "INT_PLAN_CNT"));
        extPlanCnt = cfGetUnformatNumber(gr.text(r, "EXT_PLAN_CNT"));
        colIdx = -1;

        if (isNaN(intPlanCnt) == true) {
            colIdx = gr.fg.ColIndex("INT_PLAN_CNT");
        }

        if (isNaN(extPlanCnt) == true) {
            colIdx = gr.fg.ColIndex("EXT_PLAN_CNT");
        }

        if (colIdx != -1) {
            alert("올바른 숫자형식이 아닙니다.");
            gr.fg.Select(r, colIdx);
            gr.fg.EditCell();
            return;
        }

        ds.addRow();
        ds.value(ds.rowCount - 1, "DEPT_CODE") = gr.value(r, "DEPT_CODE");
        ds.value(ds.rowCount - 1, "INT_PLAN_CNT") = intPlanCnt;
        ds.value(ds.rowCount - 1, "EXT_PLAN_CNT") = extPlanCnt;
    }

    if (ACTR_STD.value == "") {
        alert("실적기준을 선택하세요.");
        ACTR_STD.focus();
        return;
    }

    //저장 확인
    if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.applyplan.goal.act.UpdateApplyPlanGoalList.do";
    prx.addParam("PLAN_DIV", 'DEPT');
    prx.addParam("PLAN_YEAR", gr.loader.getParam("PLAN_YEAR"));
    prx.addParam("ACTR_STD", ACTR_STD.value);
    prx.addData("ds_applyPlanGoalList");

    prx.onSuccess = function()
    {
        gr.loader.reload();
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//합계
function fnSubtotal()
{
    var gr = gr_applyPlanGoalList;

    if (gr.fg.Rows <= gr.fg.FixedRows) return;

    gr.fg.SubtotalPosition = flexSTAbove;
    gr.fg.Subtotal(flexSTClear);
    gr.fg.FrozenRows = 1;

    gr.fg.Subtotal(flexSTSum, -1, gr.fg.ColIndex("INT_PLAN_CNT"), null, "&HFFAA55", "&HFFFFFF", true , "합 계");
    gr.fg.Subtotal(flexSTSum, -1, gr.fg.ColIndex("EXT_PLAN_CNT"));

    gr.fg.Cell(flexcpAlignment, gr.fg.FixedRows, 1) = flexAlignCenterCenter;
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
                        <ANY:SELECT id="ACTR_STD" codeData="{RESULT_DIV}" index="0" style="width:100px;" firstName="sel"/>
                        <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>
                        <BUTTON auto="line" ></BUTTON>
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
            <ANY:GRID id="gr_applyPlanGoalList" pagingType="0"><COMMENT>
                fg.Editable = flexEDKbdMouse;
                fg.attachEvent("AfterEdit", function(iRow, iCol)
                {
                    if (isNaN(cfGetUnformatNumber(fg.Cell(0, iRow, iCol))) == true) {
                        fg.Cell(0, iRow, iCol) = "";
                    }
                    fnSubtotal();
                });
                addColumn({ width:50 , align:"center", type:"number" , sort:false, id:"ROW_NUM"             , name:"No" });
                addColumn({ width:300, align:"left"  , type:"string" , sort:false, id:"DEPT_NAME"           , name:"부서이름(팀)" });
                addColumn({ width:200, align:"right" , type:"number" , sort:false, id:"INT_PLAN_CNT"        , name:"국내목표(건수)" , format:"#,###", edit:true, editMask:"99999" });
                addColumn({ width:200, align:"right" , type:"number" , sort:false, id:"EXT_PLAN_CNT"        , name:"해외목표(건수)" , format:"#,###", edit:true, editMask:"99999" });
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_NUM", "DEPT_NAME");
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
    <TR>
        <TD height="5"></TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
