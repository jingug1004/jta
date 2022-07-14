<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>업무코드 작성</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("CODE_KIND");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    if (parent.CODE_KIND == null) {
        CODE_KIND.focus();
    } else {
        CODE_KIND.value = parent.CODE_KIND;
        any_codeNameList.focus();
    }
}

//저장
function fnSave()
{
    if (!cfCheckAllReqValid()) return;

    if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.workprocess.workcode.act.CreateWorkCodeMgt.do";
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
        <TD>코드 값</TD>
        <TD disabled>(<%= app.message.get("msg.com.autocreate") %>)</TD>
    </TR>
    <TR>
        <TD req="CODE_KIND">코드 종류</TD>
        <TD>
            <ANY:RADIO id="CODE_KIND" codeData="/systemmgt/workCodeKind" />
        </TD>
    </TR>
    <TBODY id="any_codeNameList" class="LangCodeList" colId="CODE_NAME" maxByte="300">
    </TBODY>
</TABLE>
<DIV class="button_area">
    <BUTTON text="저장" onClick="javascript:fnSave();"></BUTTON>
    <BUTTON text="취소" onClick="javascript:top.window.close();"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
