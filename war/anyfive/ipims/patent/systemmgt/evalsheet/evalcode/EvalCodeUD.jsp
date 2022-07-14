<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>평가코드 수정</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("EVAL_TITLE");
    addBind("INVDEPT_EVAL_SHEET_ID");
    addBind("PATDEPT_EVAL_SHEET_ID");
    addBind("EVAL_VIEW_PATH");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    EVAL_CODE.value = parent.EVAL_CODE;

    fnRetrieve();
}

//조회
function fnRetrieve()
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.evalsheet.evalcode.act.RetrieveEvalCodeMgt.do";
    prx.addParam("EVAL_CODE", parent.EVAL_CODE);

    prx.onSuccess = function()
    {
        EVAL_TITLE.focus();
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.evalsheet.evalcode.act.UpdateEvalCodeMgt.do";
    prx.addParam("EVAL_CODE", parent.EVAL_CODE);
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.evalsheet.evalcode.act.DeleteEvalCodeMgt.do";
    prx.addParam("EVAL_CODE", parent.EVAL_CODE);

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
        <TD>평가 코드</TD>
        <TD>
            <INPUT type="text" id="EVAL_CODE" readOnly style="border:none;">
        </TD>
    </TR>
    <TR>
        <TD req="EVAL_TITLE">평가 명칭</TD>
        <TD>
            <INPUT type="text" id="EVAL_TITLE" maxByte="1000">
        </TD>
    </TR>
    <TR>
        <TD>발명자 평가서</TD>
        <TD>
            <ANY:SELECT id="INVDEPT_EVAL_SHEET_ID" codeData="/systemmgt/evalSheetId" firstName="none" />
        </TD>
    </TR>
    <TR>
        <TD>특허팀 평가서</TD>
        <TD>
            <ANY:SELECT id="PATDEPT_EVAL_SHEET_ID" codeData="/systemmgt/evalSheetId" firstName="none" />
        </TD>
    </TR>
    <TR>
        <TD>평가서 경로</TD>
        <TD>
            <INPUT type="text" id="EVAL_VIEW_PATH" maxByte="1000">
        </TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.delete").toHTML() %>" onClick="javascript:fnDelete();"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.cancel").toHTML() %>" onClick="javascript:top.window.close();"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
