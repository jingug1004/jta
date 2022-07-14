<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>IPC 분류코드 검색</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_TREE); %>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    td_autoCheck.style.display = (parent.multiCheck == true ? "block" : "none");

    fnSearch();
}

//검색
function fnSearch()
{
    var ldr = gr_ipcCodeTree.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.common.popup.search.act.RetrieveIpcCodeSearchTree.do";

    ldr.onSuccess = function(gr, fg)
    {
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

//확인
function fnConfirm()
{
    cfPopupSearchResult(parent, gr_ipcCodeTree);
}
</SCRIPT>

<SCRIPT language="JScript" for="ckk_autoCheck" event="OnChange()">
      gr_ipcCodeTree.autoCheck = this.checked;
</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
    <TR>
        <TD id="td_autoCheck" style="padding-bottom:3px; display:none;">
            <ANY:CHECK id="ckk_autoCheck" text="상위항목 자동선택" />
        </TD>
    </TR>
    <TR>
        <TD height="100%">
            <ANY:TREE id="gr_ipcCodeTree"><COMMENT>
                parentColumn = "PRIOR_IPC_CODE";
                codeColumn   = "IPC_CODE";
                nameColumn   = "IPC_HNAME";
                expandLevel  = 0;
                showCheck    = parent.multiCheck;
                autoCheck    = ckk_autoCheck.checked;
            </COMMENT></ANY:TREE>
        </TD>
    </TR>
    <TR>
        <TD height="5"></TD>
    </TR>
    <TR>
        <TD align="right">
            <BUTTON text="확인" onClick="javascript:fnConfirm();"></BUTTON>
            <BUTTON auto="close"></BUTTON>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
