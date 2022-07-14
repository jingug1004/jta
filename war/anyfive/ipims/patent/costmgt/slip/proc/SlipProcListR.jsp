<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<%@page import="any.util.etc.NDateUtil"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>전표처리목록</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<ANY:DS id="ds_costSlipList" />
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();
}

//목록 조회
function fnRetrieve()
{
    var ldr = gr_costSlipList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.costmgt.slip.proc.act.RetrieveSlipProcList.do";
    ldr.addParam("SLIP_SUBJECT"   , SLIP_SUBJECT.value);
    ldr.addParam("SLIP_KIND"      , SLIP_KIND.value);
    ldr.addParam("ACCOUNT_PROC_YN", ACCOUNT_PROC_YN.value);

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
    var win = new any.viewer();
    switch (gr.value(row, "SLIP_KIND")) {
    case "C"://비용
        win.path = top.getRoot() + "/anyfive/ipims/patent/costmgt/slip/cost/CostSlipRD.jsp";
        break;
    case "B"://보상금
        win.path = top.getRoot() + "/anyfive/ipims/patent/costmgt/slip/reward/RewardSlipRD.jsp";
        break;
    case "A"://연차료
        win.path = top.getRoot() + "/anyfive/ipims/patent/costmgt/slip/annual/AnnualSlipRD.jsp";
        break;
    case "S"://자산
        win.path = top.getRoot() + "/anyfive/ipims/patent/costmgt/slip/asset/AssetSlipRD.jsp";
        break;
    case "R"://거절
        win.path = top.getRoot() + "/anyfive/ipims/patent/costmgt/slip/reject/RejectSlipRD.jsp";
        break;
    case "T"://수수료
        win.path = top.getRoot() + "/anyfive/ipims/patent/costmgt/slip/tax/TaxSlipRD.jsp";
        break;
    case "I"://자본적지출
        win.path = top.getRoot() + "/anyfive/ipims/patent/costmgt/slip/capital/CapitalSlipRD.jsp";
        break;
    }
    win.arg.SLIP_ID = gr.value(row, "SLIP_ID");

    win.onReload = function()
    {
        gr.loader.reload();
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
            <TABLE border="0" cellspacing="1" cellpadding="2" class="main" onEnter="javascript:fnRetrieve();">
                <COLGROUP>
                    <COL class="condhead" width="13%">
                    <COL class="conddata" width="20%">
                    <COL class="condhead" width="13%">
                    <COL class="conddata" width="20%">
                    <COL class="condhead" width="13%">
                    <COL class="conddata" width="20%">
                </COLGROUP>
                <TR>
                    <TD>전표제목</TD>
                    <TD>
                        <INPUT type="text" id="SLIP_SUBJECT" />
                    </TD>
                    <TD>전표종류</TD>
                    <TD>
                        <ANY:SELECT id="SLIP_KIND" codeData="{SLIP_KIND}" firstname="all" />
                    </TD>
                    <TD>처리현황</TD>
                    <TD>
                        <ANY:SELECT id="ACCOUNT_PROC_YN" codeData="{ACCOUNT_PROC_YN}" firstName="all" />
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
            <ANY:GRID id="gr_costSlipList" pagingType="1"><COMMENT>
                addColumn({ width:120, align:"left"  , type:"string" , sort:true , id:"SLIP_SUBJECT"         , name:"전표제목" });
                addColumn({ width:70 , align:"center", type:"string" , sort:true , id:"SLIP_KIND_NAME"       , name:"전표종류" });
                addColumn({ width:70 , align:"center", type:"string" , sort:true , id:"ACCOUNT_PROC_YN_NAME" , name:"처리상태" });
                addColumn({ width:50 , align:"center", type:"number" , sort:true , id:"SLIP_CNT"             , name:"건수" });
                addColumn({ width:80 , align:"center", type:"string" , sort:true , id:"CRE_USER_NAME"        , name:"작성자" });
                addColumn({ width:75 , align:"center", type:"date"   , sort:true , id:"CRE_DATE"             , name:"작성일" });
                messageSpan = "spn_gridMessage";
                addSorting("SLIP_ID", "DESC");
                addAction("SLIP_SUBJECT", fnDetail);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
