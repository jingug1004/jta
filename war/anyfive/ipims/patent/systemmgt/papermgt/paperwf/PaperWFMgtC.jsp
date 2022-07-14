<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>진행서류 워크플로우관리 작성</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("WF_ID");
    addBind("WF_KIND");
    addBind("WF_NAME");
    addBind("WF_DESC");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    WF_ID.focus();
}

//저장
function fnSave()
{
    if (!cfCheckAllReqValid()) return;

    if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.papermgt.paperwf.act.CreatePaperWF.do";
    prx.addData("ds_mainInfo");

    prx.onSuccess = function()
    {
        parent.WF_CODE = this.result;
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        window.location.replace("PaperWFMgtUD.jsp");
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
        <TD req="WF_ID">W/F 아이디</TD>
        <TD>
            <INPUT type="text" id="WF_ID" maxByte="10">
        </TD>
        <TD req="WF_KIND">W/F 종류</TD>
        <TD>
            <ANY:SELECT id="WF_KIND" firstName="sel" codeData="/systemmgt/wfKind" />
        </TD>
    </TR>
    <TR>
        <TD req="WF_NAME">W/F 이름</TD>
        <TD colspan="3">
            <INPUT type="text" id="WF_NAME" maxByte="300">
        </TD>
    </TR>
    <TR>
        <TD>W/F 설명</TD>
        <TD colspan="3">
            <INPUT type="text" id="WF_DESC" maxByte="1000">
        </TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="list"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
