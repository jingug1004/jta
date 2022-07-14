<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>시스템 업데이트 파일 상세</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("FILE_NAME");
    addBind("FILE_SIZE");
    addBind("FILE_DATETIME");
</COMMENT></ANY:DS>
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.configure.update.act.RetrieveUpdateFile.do";
    prx.addParam("FILE_NAME", parent.FILE_NAME);

    prx.onSuccess = function()
    {
        btn_viewContent.disabled = !(ds_mainInfo.value(0, "FILE_TYPE") == "DDL" || ds_mainInfo.value(0, "FILE_TYPE") == "SQL");
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//내용보기
function fnViewContent()
{
    var win = new any.window();
    win.path = "SystemUpdateFileContentR.jsp";
    win.arg.FILE_NAME = parent.FILE_NAME;
    win.opt.width = 800;
    win.opt.height = 600;
    win.opt.resizable = "yes";
    win.show();
}

//파일삭제
function fnDeleteFile()
{
    if (!confirm("<%= app.message.get("msg.com.confirm.delete").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.configure.update.act.DeleteUpdateFile.do";
    prx.addParam("FILE_NAME", parent.FILE_NAME);

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.delete").toJS() %>");
        top.window.close();
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
        <TD>파일이름</TD>
        <TD><SPAN id="FILE_NAME"></SPAN></TD>
    </TR>
    <TR>
        <TD>파일크기</TD>
        <TD><ANY:SPAN id="FILE_SIZE" format="number2" />&nbsp;Byte</TD>
    </TR>
    <TR>
        <TD>파일날짜</TD>
        <TD><SPAN id="FILE_DATETIME"></SPAN></TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="내용보기" onClick="javascript:fnViewContent();" id="btn_viewContent" disabled></BUTTON>
    <BUTTON text="파일삭제" onClick="javascript:fnDeleteFile();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="close"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
