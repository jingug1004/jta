<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>공통코드 생성</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("CODE_VALUE_ID");
    addBind("CODE_DESC");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    cfSetPageTitle(document.title + " - " + parent.CODE_GRP_NAME);

    CODE_VALUE_ID.focus();
}

//저장
function fnSave()
{
    if (!cfCheckAllReqValid()) return;

    if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.configure.codevalue.act.CreateCodeValue.do";
    prx.addParam("CODE_GRP", parent.CODE_GRP);
    prx.addData("ds_mainInfo");
    prx.addData("ds_codeNameList");

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        top.window.close();
    }

    prx.onFail = function()
    {
        this.error.show();

        if (this.error.number == 1) {
            CODE_VALUE_ID.focus();
            CODE_VALUE_ID.select();
        }
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
        <TD req="CODE_VALUE_ID">코드 값</TD>
        <TD>
            <INPUT type="text" id="CODE_VALUE_ID" maxByte="50">
        </TD>
    </TR>
    <TBODY id="any_codeNameList" class="LangCodeList" colId="CODE_NAME" maxByte="1000">
    </TBODY>
    <TR>
        <TD>코드 설명</TD>
        <TD>
            <INPUT type="text" id="CODE_DESC" maxByte="4000">
        </TD>
    </TR>
</TABLE>
<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.cancel").toHTML() %>" onClick="javascript:top.window.close();"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
