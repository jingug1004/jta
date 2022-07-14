<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>사용자 로그 상세</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("LOG_SEQ");
    addBind("EMP_HNAME");
    addBind("SYSTEM_TYPE_NAME");
    addBind("LOG_TYPE_NAME");
    addBind("CLIENT_IP");
    addBind("SERVER_IP");
    addBind("REFERER_URL");
    addBind("SERVLET_PATH");
    addBind("LOG_DATETIME");
    addBind("ERROR_YN_NAME");
    addBind("ERROR_MSG");
</COMMENT></ANY:DS>
<ANY:DS id="ds_recvList" />
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();
}

//조회
function fnRetrieve()
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.log.user.act.RetrieveUserLog.do";
    prx.addParam("LOG_SEQ", parent.LOG_SEQ);
    prx.checkData = ds_mainInfo;

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
        <COL class="conthead" width="15%">
        <COL class="contdata" width="35%">
        <COL class="conthead" width="15%">
        <COL class="contdata" width="35%">
    </COLGROUP>
    <TR>
        <TD>로그번호</TD>
        <TD><SPAN id="LOG_SEQ"></SPAN></TD>
        <TD>사용자명</TD>
        <TD><SPAN id="EMP_HNAME"></SPAN></TD>
    </TR>
    <TR>
        <TD>시스템구분</TD>
        <TD><SPAN id="SYSTEM_TYPE_NAME"></SPAN></TD>
        <TD>로그구분</TD>
        <TD><SPAN id="LOG_TYPE_NAME"></SPAN></TD>
    </TR>
    <TR>
        <TD>사용자IP</TD>
        <TD><SPAN id="CLIENT_IP"></SPAN></TD>
        <TD>서버IP</TD>
        <TD><SPAN id="SERVER_IP"></SPAN></TD>
    </TR>
    <TR>
        <TD>호출URL</TD>
        <TD colspan="3"><SPAN id="REFERER_URL"></SPAN></TD>
    </TR>
    <TR>
        <TD>서블릿경로</TD>
        <TD colspan="3"><SPAN id="SERVLET_PATH"></SPAN></TD>
    </TR>
    <TR>
        <TD>로그일시</TD>
        <TD><SPAN id="LOG_DATETIME"></SPAN></TD>
        <TD>성공여부</TD>
        <TD><SPAN id="ERROR_YN_NAME"></SPAN></TD>
    </TR>
    <TR>
        <TD>에러메세지</TD>
        <TD colspan="3">
            <TEXTAREA id="ERROR_MSG" rows="15" readOnly></TEXTAREA>
        </TD>
    </TR>
</TABLE>
<DIV class="button_area">
    <BUTTON auto="close"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
