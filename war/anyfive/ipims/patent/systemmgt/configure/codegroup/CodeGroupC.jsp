<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>코드그룹 생성</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("CODE_GRP_ID");
    addBind("CODE_GRP_NAME");
    addBind("CODE_GRP_DESC");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    CODE_GRP_ID.focus();
}

//저장
function fnSave()
{
    if (!cfCheckAllReqValid()) return;

    if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.configure.codegroup.act.CreateCodeGroup.do";
    prx.addData("ds_mainInfo");

    prx.onSuccess = function()
    {
        parent.CODE_GRP = this.result;
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        window.location.replace("CodeGroupUD.jsp");
    }

    prx.onFail = function()
    {
        this.error.show();

        if (this.error.number == 1) {
            CODE_GRP_ID.focus();
            CODE_GRP_ID.select();
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
</TABLE>
<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.cancel").toHTML() %>" onClick="javascript:top.window.close();"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
