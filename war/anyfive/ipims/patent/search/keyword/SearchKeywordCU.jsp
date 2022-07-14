<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>검색식 설정</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("KEYWORD");
    addBind("ADD_DESC");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    KEYWORD.value = parent.KEYWORD;
    ADD_DESC.value = "";

    if (parent.isCreate != true) fnRetrieve();
}

//조회
function fnRetrieve()
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.search.keyword.act.RetrieveSearchKeyword.do";
    prx.addParam("SEQ_NO", parent.SEQ_NO);
    prx.checkData = ds_mainInfo;

    prx.onSuccess = function()
    {
        KEYWORD.focus();
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
    KEYWORD.value = KEYWORD.value.trim();
    KEYWORD.value = KEYWORD.value.replaceAll("\r\n", "");
    KEYWORD.value = KEYWORD.value.replaceAll("\r", "");
    KEYWORD.value = KEYWORD.value.replaceAll("\n", "");

    if (ADD_DESC.value.trim() == "") {
        alert("부연설명을 입력하세요.");
        ADD_DESC.focus();
        return;
    }

    if (KEYWORD.value.trim() == "") {
        alert("검색식을 입력하세요.");
        KEYWORD.focus();
        return;
    }

    if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;

    var prx = new any.proxy();

    if (parent.isCreate == true) {
        prx.path = top.getRoot() + "/anyfive.ipims.patent.search.keyword.act.CreateSearchKeyword.do";
        prx.addParam("SEARCH_KIND", parent.SEARCH_KIND);
    } else {
        prx.path = top.getRoot() + "/anyfive.ipims.patent.search.keyword.act.UpdateSearchKeyword.do";
        prx.addParam("SEQ_NO", parent.SEQ_NO);
    }

    prx.addData("ds_mainInfo");

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        top.window.close();
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.search.keyword.act.DeleteSearchKeyword.do";
    prx.addParam("SEQ_NO", parent.SEQ_NO);

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
        <COL class="conthead" width="20%"></COL>
        <COL class="contdata" width="80%"></COL>
    </COLGROUP>
    <TR>
        <TD req="ADD_DESC">부연설명</TD>
        <TD><INPUT type="text" id="ADD_DESC" maxByte="1000"></TD>
    </TR>
    <TR>
        <TD req="KEYWORD">검색식</TD>
        <TD><TEXTAREA id="KEYWORD" rows="5" maxByte="4000"></TEXTAREA></TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.delete").toHTML() %>" onClick="javascript:fnDelete();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="close"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
