<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>메일내용 보기</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo" />
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.log.mail.act.RetrieveMailLogBody.do";
    prx.addParam("MAIL_ID", parent.MAIL_ID);
    prx.checkData = ds_mainInfo;

    prx.onSuccess = function()
    {
        ifr_mailBody.document.write(ds_mainInfo.value(0, "BODY"));
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
            <TABLE border="0" cellspacing="1" cellpadding="2" class="main" height="100%">
                <TR>
                    <TD class="contdata" height="100%">
                        <IFRAME id="ifr_mailBody" frameborder="0" width="100%" height="100%" marginheight="7" marginwidth="7" scrolling="auto"></IFRAME>
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD height="5"></TD>
    </TR>
    <TR>
        <TD height="1" align="right">
            <BUTTON text="뒤로" onClick="javascript:history.back();"></BUTTON>
            <BUTTON auto="line"></BUTTON>
            <BUTTON auto="list"></BUTTON>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(true); %>

</BODY>
</HTML>
