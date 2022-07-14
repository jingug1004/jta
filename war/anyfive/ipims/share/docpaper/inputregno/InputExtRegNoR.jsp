<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.share.common.app.ShareApp"%><% ShareApp app = new ShareApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>해외등록정보</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("REF_NO");
    addBind("REG_NO");
    addBind("REG_DATE");
    addBind("EN_APP_TITLE");
    addBind("REMARK");
    addBind("DUE_DATE");
    addBind("FILE_ID", "any_fileId");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
if (parent.LIST_SEQ == null) {
    window.location.replace("InputExtRegNoU.jsp");
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
    prx.path = top.getRoot() + "/anyfive.ipims.share.docpaper.inputregno.act.RetrieveInputRegNo.do";
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
        <TD>등록번호</TD>
        <TD><SPAN id="REG_NO"></SPAN></TD>
    </TR>
    <TR>
        <TD>등록결정일자</TD>
        <TD><ANY:SPAN id="REG_DATE" format="date"></ANY:SPAN></TD>
    </TR>
    <TR>
        <TD>법정기한</TD>
        <TD><ANY:SPAN id="DUE_DATE" format="date"></ANY:SPAN></TD>
    </TR>
    <TR>
        <TD>출원의 명칭(영)</TD>
        <TD><SPAN id="EN_APP_TITLE"></SPAN></TD>
    </TR>
    <TR>
        <TD>비고</TD>
        <TD><SPAN id="REMARK"></SPAN></TD>
    </TR>
    <TR>
        <TD>등록원부</TD>
        <TD>
            <ANY:FILE id="any_fileId" mode="R" />
        </TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON auto="close"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
