<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>결재처리함</TITLE>
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
    var ldr = gr_approvalAnsList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.approval.act.RetrieveApprovalAnsList.do";
    ldr.addParam("APPR_CODE", APPR_CODE.value);
    ldr.addParam("ANS_STATUS", ANS_STATUS.value);
    ldr.addParam("DATE_START", DATE_START.value);
    ldr.addParam("DATE_END", DATE_END.value);

    ldr.onStart = function(gr, fg)
    {
        gr.columnInfo("ROW_CHK").nouse = gr.fg.ColHidden(gr.fg.ColIndex("ROW_CHK")) = (this.getParam("ANS_STATUS") != "1");
    }

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
function fnGoView(gr, fg, row, colId)
{
    var win = new any.viewer();
    win.path = "ApprovalViewR.jsp";
    win.arg.APPR_NO = gr.value(row, "APPR_NO");
    win.arg.gr = gr;
    win.arg.fg = fg;

    win.onReload = function()
    {
        gr.loader.reload();
    }

    win.show();
}

//일괄결재
function fnApproveAll(ansStatus, apprEvent)
{
    var gr = gr_approvalAnsList;
    var apprEventName = (apprEvent == "AGREE" ? "승인" : "반려");
    var bundleList = new Array();

    for (var i = gr.fg.FixedRows; i < gr.fg.Rows; i++) {
        if (gr.checked(i, "ROW_CHK") != true) continue;
        bundleList.push({});
        bundleList[bundleList.length - 1].APPR_ACTION_PATH = gr.value(i, "APPR_ACTION_PATH");
        bundleList[bundleList.length - 1].APPR_CODE = gr.value(i, "APPR_CODE");
        bundleList[bundleList.length - 1].APPR_NO = gr.value(i, "APPR_NO");
        bundleList[bundleList.length - 1].REQ_SEQ = gr.value(i, "REQ_SEQ");
        bundleList[bundleList.length - 1].ANS_ORD = gr.value(i, "ANS_ORD");
    }

    if (bundleList.length == 0) {
        alert("\"일괄" + apprEventName + "\" 처리할 건을 선택하세요.");
        return;
    }

    if (!confirm("총 " + cfGetFormatNumber(bundleList.length) + " 개의 건을 \"일괄" + apprEventName + "\" 처리하시겠습니까?")) return;

    var win = new any.window();
    win.path = "ApprovalBundleU.jsp";
    win.arg.bundleList = bundleList;
    win.arg.ansStatus = ansStatus;
    win.arg.apprEvent = apprEvent;
    win.opt.width = 650;
    win.opt.height = 400;

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
                    <COL class="condhead" width="10%">
                    <COL class="conddata" width="30%">
                    <COL class="condhead" width="10%">
                    <COL class="conddata" width="20%">
                    <COL class="condhead" width="10%">
                    <COL class="conddata" width="20%">
                </COLGROUP>
                <TR>
                    <TD>결재구분</TD>
                    <TD>
                        <ANY:SELECT id="APPR_CODE" codeData="/approval/apprCode" firstName="all" />
                    </TD>
                    <TD>처리상태</TD>
                    <TD>
                        <ANY:SELECT id="ANS_STATUS" codeData="/approval/apprAnsStatus" value="1" firstName="all" />
                    </TD>
                    <TD>요청일자</TD>
                    <TD noWrap>
                        <ANY:DATE id="DATE_START" />&nbsp;~
                        <ANY:DATE id="DATE_END" />
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
            <ANY:GRID id="gr_approvalAnsList" pagingType="1"><COMMENT>
                addColumn({ width:50 , align:"center", type:"number" , sort:false, id:"ROW_NUM"       , name:"No" });
                addColumn({ width:30 , align:"center", type:"string" , sort:false, id:"ROW_CHK" });
                addColumn({ width:120, align:"center", type:"string" , sort:true , id:"APPR_NUM"      , name:"결재번호", hide:true });
                addColumn({ width:120, align:"left"  , type:"string" , sort:true , id:"APPR_NAME"     , name:"결재구분" });
                addColumn({ width:200, align:"left"  , type:"string" , sort:true , id:"APPR_TITLE"    , name:"결재명" });
                addColumn({ width:70 , align:"center", type:"string" , sort:true , id:"REQ_USER_NAME" , name:"요청자" });
                addColumn({ width:75 , align:"center", type:"date"   , sort:true , id:"REQ_DATE"      , name:"요청일" });
                addColumn({ width:70 , align:"center", type:"string" , sort:true , id:"STATUS_NAME"   , name:"처리상태" });
                useConfig = true;
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_NUM", "ROW_CHK");
                addSorting("APPR_NUM", "DESC");
                addAction("APPR_TITLE", fnGoView);
                addCheck("ROW_CHK", function(gr, fg, row, colId)
                {
                    if (element.value(row, "BUNDLE_APPR_AVAIL_YN") == "1") return flexUnchecked;
                });
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
    <TR>
        <TD height="5"></TD>
    </TR>
    <TR>
        <TD height="1" align="right">
            <BUTTON text="일괄승인" onClick="javascript:fnApproveAll('8', 'AGREE');"></BUTTON>
            <BUTTON text="일괄반려" onClick="javascript:fnApproveAll('9', 'REJECT');"></BUTTON>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
