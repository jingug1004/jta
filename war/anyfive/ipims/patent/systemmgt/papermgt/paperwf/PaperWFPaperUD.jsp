<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>워크플로우별 진행서류 수정</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("PAPER_CODE");
    addBind("PAPER_SUBCODE");
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.papermgt.paperwf.act.RetrievePaperWFPaper.do";
    prx.addParam("WF_CODE", parent.WF_CODE);
    prx.addParam("LIST_SEQ", parent.LIST_SEQ);

    prx.onSuccess = function()
    {
        PAPER_SUBCODE.codeData = "/common/paperSubcodeAll," + ds_mainInfo.value(0, "PAPER_CODE");
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.papermgt.paperwf.act.UpdatePaperWFPaper.do";
    prx.addParam("WF_CODE", parent.WF_CODE);
    prx.addParam("LIST_SEQ", parent.LIST_SEQ);
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.papermgt.paperwf.act.DeletePaperWFPaper.do";
    prx.addParam("WF_CODE", parent.WF_CODE);
    prx.addParam("LIST_SEQ", parent.LIST_SEQ);

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

<!-- 진행서류 변경시 -->
<SCRIPT language="JScript" for="PAPER_CODE" event="OnChange()">
    if (this.value == "") {
        PAPER_SUBCODE.clearAll();
    } else {
        PAPER_SUBCODE.codeData = "/common/paperSubcodeAll," + this.value;
        PAPER_SUBCODE.index = 0;
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
        <TD req="PAPER_CODE">진행서류</TD>
        <TD>
            <ANY:SEARCH id="PAPER_CODE" mode="U"><COMMENT>
                win.path = top.getRoot() + "/anyfive/ipims/patent/common/popup/search/PaperSearchListR.jsp";
                win.opt.width = 600;
                codeColumn = "PAPER_CODE";
                nameExpr = "[{#PAPER_CODE}] {#PAPER_NAME}";
            </COMMENT></ANY:SEARCH>
        </TD>
    </TR>
    <TR>
        <TD req="PAPER_SUBCODE">세부서류</TD>
        <TD>
            <ANY:SELECT id="PAPER_SUBCODE" />
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
