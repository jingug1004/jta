<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>공통코드 그룹 수정</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("CODE_GRP_ID");
    addBind("CODE_GRP_NAME");
    addBind("CODE_GRP_DESC");
    addBind("USE_YN");
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.configure.codegroup.act.RetrieveCodeGroup.do";
    prx.addParam("CODE_GRP", parent.CODE_GRP);
    prx.checkData = ds_mainInfo;

    prx.onSuccess = function()
    {
        CODE_GRP_ID.focus();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//저장
function fnSave()
{
    if (!cfCheckAllReqValid()) return;

    if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.configure.codegroup.act.UpdateCodeGroup.do";
    prx.addParam("CODE_GRP", parent.CODE_GRP);
    prx.addData("ds_mainInfo");

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//삭제
function fnDelete()
{
    if (!confirm("<%= app.message.get("msg.com.confirm.delete").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.configure.codegroup.act.DeleteCodeGroup.do";
    prx.addParam("CODE_GRP", parent.CODE_GRP);

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

//상세목록 팝업
function fnOpenList()
{
    var win = new any.window();
    win.path = top.getRoot() + "/anyfive/ipims/patent/systemmgt/configure/codevalue/CodeValueListR.jsp";
    win.arg.CODE_GRP = parent.CODE_GRP;
    win.arg.CODE_GRP_NAME = ds_mainInfo.value(0, "CODE_GRP_NAME");
    win.opt.width = 700;
    win.opt.height = 450;
    win.show();
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
        <TD req="CODE_GRP_ID">그룹 ID</TD>
        <TD>
            <INPUT type="text" id="CODE_GRP_ID" maxByte="50">
        </TD>
    </TR>
    <TR>
        <TD req="CODE_GRP_NAME">그룹 이름</TD>
        <TD>
            <INPUT type="text" id="CODE_GRP_NAME" maxByte="1000">
        </TD>
    </TR>
    <TR>
        <TD>그룹 설명</TD>
        <TD>
            <INPUT type="text" id="CODE_GRP_DESC" maxByte="4000">
        </TD>
    </TR>
    <TR>
        <TD req="USE_YN"><%= app.message.get("lbl.com.useyn") %></TD>
        <TD>
            <ANY:RADIO id="USE_YN" codeData="{USE_YN}" />
        </TD>
    </TR>
</TABLE>
<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.delete").toHTML() %>" onClick="javascript:fnDelete();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON text="코드목록 편집" onClick="javascript:fnOpenList();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="close"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
