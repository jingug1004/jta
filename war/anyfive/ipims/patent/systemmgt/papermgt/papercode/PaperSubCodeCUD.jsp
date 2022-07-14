<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>세부서류 작성</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("PAPER_SUBNAME");
    addBind("MST_ABD_YN");
    addBind("BIZ_BUTTON_NAME");
    addBind("BIZ_VIEW_PATH");
    addBind("USE_YN");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    if (parent.PAPER_SUBCODE == "000") {
        PAPER_SUBNAME.style.border = "none";
    } else {
        PAPER_SUBNAME.readOnly = false;
    }

    if (parent.PAPER_SUBCODE == null) {
        PAPER_SUBNAME.focus();
    } else {
        fnRetrieve();
    }
}

//조회
function fnRetrieve()
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.papermgt.papercode.act.RetrieveSubPaperCode.do";
    prx.addParam("PAPER_CODE", parent.PAPER_CODE);
    prx.addParam("PAPER_SUBCODE", parent.PAPER_SUBCODE);

    prx.onSuccess = function()
    {
        PAPER_SUBNAME.focus();
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
    if (parent.PAPER_SUBCODE == null) {
        prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.papermgt.papercode.act.CreateSubPaperCode.do";
    } else {
        prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.papermgt.papercode.act.UpdateSubPaperCode.do";
        prx.addParam("PAPER_SUBCODE", parent.PAPER_SUBCODE);
    }
    prx.addParam("PAPER_CODE", parent.PAPER_CODE);
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.papermgt.papercode.act.DeleteSubPaperCode.do";
    prx.addParam("PAPER_SUBCODE", parent.PAPER_SUBCODE);
    prx.addParam("PAPER_CODE", parent.PAPER_CODE);

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
        <COL class="conthead" width="25%">
        <COL class="contdata" width="75%">
    </COLGROUP>
    <TR>
        <TD req="PAPER_SUBNAME">세부서류명</TD>
        <TD>
            <INPUT type="text" id="PAPER_SUBNAME" maxByte="300" readOnly>
        </TD>
    </TR>
    <TR>
        <TD req="MST_ABD_YN">마스터포기처리</TD>
        <TD>
            <ANY:RADIO id="MST_ABD_YN" codeData="{YES_NO}" />
        </TD>
    </TR>
    <TR>
        <TD>업무버튼 이름</TD>
        <TD>
            <INPUT type="text" id="BIZ_BUTTON_NAME" maxByte="300">
        </TD>
    </TR>
    <TR>
        <TD>업무화면 경로</TD>
        <TD>
            <INPUT type="text" id="BIZ_VIEW_PATH" maxByte="500">
        </TD>
    </TR>
    <TR>
        <TD req="USE_YN">사용여부</TD>
        <TD>
            <ANY:RADIO id="USE_YN" codeData="{USE_YN}" value="1" />
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
