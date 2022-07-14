<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<%@page import="any.util.etc.NDateUtil"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>보상금전표작성 목록</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<ANY:DS id="ds_consultIdList" />
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();
}

//목록 조회
function fnRetrieve()
{
    var ldr = gr_rewardSlipList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.costmgt.slip.reward.act.RetrieveRewardSlipList.do";

    ldr.onSuccess = function(gr, fg)
    {
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}


//상세
function fnDetail(gr, fg, row, colId)
{
    var win = new any.window();
    win.path = top.getRoot() + "/anyfive/ipims/patent/costmgt/reward/consult/RewardConsultRD.jsp";
    win.arg.CONSULT_ID = gr.value(row, "CONSULT_ID");
    win.arg.gr = gr;
    win.opt.width = 800;
    win.opt.height = 600;

    win.onReload = function()
    {
        gr.loader.reload();
    }

    win.show();
}

//전표 작성
function fnCreateSlip()
{
    if (!cfCheckAllReqValid()) return;

    var gr = document.getElementById("gr_rewardSlipList");
    var ds = document.getElementById("ds_consultIdList");

    ds.init();

    for (var r = gr.fg.FixedRows; r < gr.fg.Rows; r++) {
        if (gr.checked(r, "ROW_CHK") == true) ds.value(ds.addRow(), "CONSULT_ID") = gr.value(r, "CONSULT_ID");
    }

    if (ds.rowCount == 0) {
        alert("선택된 건이 없습니다");
        return;
    }

    if (!confirm("보상금 전표를 작성하시겠습니까?")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.costmgt.slip.proc.act.CreateSlipProc.do";
    prx.addParam("SLIP_SUBJECT", "<%= NDateUtil.getFormatDate("yyyy")%>년 <%= NDateUtil.getFormatDate("MM")%>월 보상금");
    prx.addParam("SLIP_KIND", "B");
    prx.addData(ds);

    prx.onSuccess = function()
    {
        gr.loader.reload();
        alert("처리되었습니다.");

        var win = new any.viewer();
        win.path = "RewardSlipU.jsp";
        win.arg.SLIP_ID = this.result;

        win.onReload = function()
        {
            gr.loader.reload();
        }

        win.show();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}
</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
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
            <ANY:GRID id="gr_rewardSlipList" pagingType="0"><COMMENT>
                addColumn({ width:30 , align:"center", type:"check"  , sort:false, id:"ROW_CHK" });
                addColumn({ width:200, align:"left"  , type:"string" , sort:true , id:"CONSULT_SUBJECT" , name:"품의제목" });
                addColumn({ width:60 , align:"right" , type:"number" , sort:true , id:"TOT_CNT"         , name:"건수" });
                addColumn({ width:70 , align:"center", type:"string" , sort:true , id:"CRE_USER_NAME"   , name:"작성자" });
                addColumn({ width:75 , align:"center", type:"date"   , sort:true , id:"CRE_DATE"        , name:"작성일" });
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_CHK", "CONSULT_SUBJECT");
                addAction("CONSULT_SUBJECT", fnDetail);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
    <TR>
        <TD height="1">
            <DIV class="button_area">
                <BUTTON text="전표작성" onClick="javascript:fnCreateSlip();"></BUTTON>
            </DIV>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
