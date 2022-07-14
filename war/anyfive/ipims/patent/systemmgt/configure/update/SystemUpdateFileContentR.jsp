<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>시스템 업데이트 파일 내용</TITLE>
<% app.writeHTMLHeader(); %>
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.configure.update.act.RetrieveUpdateFileContent.do";
    prx.addParam("FILE_NAME", parent.FILE_NAME);

    prx.onSuccess = function()
    {
        FILE_CONTENT.value = this.result;
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
        <TD style="padding-bottom:1px;">
            <TEXTAREA id="FILE_CONTENT"
                style="width:100%; height:100%; overflow:auto; font-family:'Courier New';"
                wrap="off"
                readOnly
            ></TEXTAREA>
        </TD>
    </TR>
    <TR>
        <TD height="1">
            <DIV class="button_area">
                <BUTTON text="새로고침" onClick="javascript:fnRetrieve();"></BUTTON>
                <BUTTON auto="line"></BUTTON>
                <BUTTON auto="close"></BUTTON>
            </DIV>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
