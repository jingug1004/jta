<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>결재요청함</TITLE>
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
    var ldr = gr_approvalReqList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.approval.act.RetrieveApprovalReqList.do";
    ldr.addParam("APPR_CODE", APPR_CODE.value);
    ldr.addParam("REQ_STATUS", REQ_STATUS.value);
    ldr.addParam("DATE_START", DATE_START.value);
    ldr.addParam("DATE_END", DATE_END.value);

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
                    <TD>진행상태</TD>
                    <TD>
                        <ANY:SELECT id="REQ_STATUS" codeData="/approval/apprReqStatus" value="1" firstName="all" />
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
            <ANY:GRID id="gr_approvalReqList" pagingType="1"><COMMENT>
                addColumn({ width:50 , align:"center", type:"number" , sort:false, id:"ROW_NUM"       , name:"No" });
                addColumn({ width:120, align:"center", type:"string" , sort:true , id:"APPR_NUM"      , name:"결재번호", hide:true });
                addColumn({ width:120, align:"left"  , type:"string" , sort:true , id:"APPR_NAME"     , name:"결재구분" });
                addColumn({ width:200, align:"left"  , type:"string" , sort:true , id:"APPR_TITLE"    , name:"결재명" });
                addColumn({ width:70 , align:"center", type:"string" , sort:true , id:"REQ_USER_NAME" , name:"요청자" });
                addColumn({ width:75 , align:"center", type:"date"   , sort:true , id:"REQ_DATE"      , name:"요청일" });
                addColumn({ width:70 , align:"center", type:"string" , sort:true , id:"STATUS_NAME"   , name:"처리상태" });
                useConfig = true;
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_NUM", null);
                addSorting("APPR_NUM", "DESC");
                addAction("APPR_TITLE", fnGoView);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
