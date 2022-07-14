<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="any.util.etc.NDateUtil"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>해외출원 포기 내역</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("EXT_APP_ABD_DATE");
    addBind("EXT_APP_ABD_USER_NAME");
    addBind("EXT_APP_ABD_REASON");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    REF_NO.value = parent.REF_NO;

    fnRetrieve();
}

//조회
function fnRetrieve()
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.intpatent.extabd.act.RetrieveExtApplyAbd.do";
    prx.addParam("REF_ID", parent.REF_ID);

    prx.onSuccess = function()
    {
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
        <COL class="conthead" width="25%">
        <COL class="contdata" width="75%">
    </COLGROUP>
    <TR>
        <TD>REF-NO</TD>
        <TD><INPUT type="text" id="REF_NO" readOnly style="border:none;"></TD>
    </TR>
    <TR>
        <TD>해외출원 포기일</TD>
        <TD><ANY:SPAN id="EXT_APP_ABD_DATE" format="date" /></TD>
    </TR>
    <TR>
        <TD>해외출원 포기 처리자</TD>
        <TD><SPAN id="EXT_APP_ABD_USER_NAME"></SPAN></TD>
    </TR>
    <TR>
        <TD>해외출원 포기 사유</TD>
        <TD><SPAN id="EXT_APP_ABD_REASON"></SPAN></TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON auto="close"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
