<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.share.common.app.ShareApp"%><% ShareApp app = new ShareApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>국내출원정보</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("REF_NO");
    addBind("APP_NO");
    addBind("APP_DATE");
    addBind("INDEP_CLAIM");
    addBind("SUBORD_CLAIM");
    addBind("DRAWING_CNT");
    addBind("PAPER_CNT");
    addBind("KO_APP_TITLE");
    addBind("EN_APP_TITLE");
    addBind("EXAMREQ_DATE");
    addBind("REMARK");
    addBind("APPDOC_FILE", "any_appdocFile");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
if (parent.LIST_SEQ == null) {
    window.location.replace("InputIntAppNoU.jsp");
}

//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();
}

//조회
function fnRetrieve()
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.share.docpaper.inputappno.act.RetrieveInputAppNo.do";
    prx.addParam("REF_ID", parent.REF_ID);
    prx.addParam("LIST_SEQ", parent.LIST_SEQ);

    prx.onSuccess = function()
    {
        cfShowObjects(["tr_patOnly"], ds_mainInfo.value(0, "RIGHT_DIV") == "10" || ds_mainInfo.value(0, "RIGHT_DIV") == "20");
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

<TABLE border="0" cellspacing="1" cellpadding="2" class="main">
    <COLGROUP>
        <COL class="conthead" width="20%">
        <COL class="contdata" width="80%">
    </COLGROUP>
    <TR>
        <TD>REF-NO</TD>
        <TD><SPAN id="REF_NO"></SPAN></TD>
    </TR>
    <TR>
        <TD>출원번호</TD>
        <TD><SPAN id="APP_NO"></SPAN></TD>
    </TR>
    <TR>
        <TD>출원일자</TD>
        <TD><ANY:SPAN id="APP_DATE" format="date"></ANY:SPAN></TD>
    </TR>
    <TR id="tr_patOnly" style="display:none;">
        <TD>독립항</TD>
        <TD><SPAN id="INDEP_CLAIM"></SPAN></TD>
    </TR>
    <TR id="tr_patOnly" style="display:none;">
        <TD>종속항</TD>
        <TD><SPAN id="SUBORD_CLAIM"></SPAN></TD>
    </TR>
    <TR id="tr_patOnly" style="display:none;">
        <TD>도면수</TD>
        <TD><SPAN id="DRAWING_CNT"></SPAN></TD>
    </TR>
    <TR id="tr_patOnly" style="display:none;">
        <TD>면수</TD>
        <TD><SPAN id="PAPER_CNT"></SPAN></TD>
    </TR>
    <TR>
        <TD>출원의 명칭(한)</TD>
        <TD><SPAN id="KO_APP_TITLE"></SPAN></TD>
    </TR>
    <TR>
        <TD>출원의 명칭(영)</TD>
        <TD><SPAN id="EN_APP_TITLE"></SPAN></TD>
    </TR>
    <TR id="tr_patOnly" style="display:none;">
        <TD>심사청구일자</TD>
        <TD><ANY:SPAN id="EXAMREQ_DATE" format="date"></ANY:SPAN></TD>
    </TR>
    <TR>
        <TD>IPC분류코드</TD>
        <TD>
            <ANY:MSEARCH id="any_ipcCodeList" mode="C"><COMMENT>
                win.path = top.getRoot() + "/anyfive/ipims/patent/common/popup/search/IpcCodeSearchTreeR.jsp";
                codeColumn = "IPC_CODE";
                nameExpr = "[{#IPC_CODE}] {#IPC_PATHNAME}";
                size = 6;
            </COMMENT></ANY:MSEARCH>
        </TD>
    </TR>
    <TR>
        <TD>비고</TD>
        <TD><SPAN id="REMARK"></SPAN></TD>
    </TR>
    <TR>
        <TD>출원명세서</TD>
        <TD>
            <ANY:FILE id="any_appdocFile" mode="R" />
        </TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON auto="close"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
