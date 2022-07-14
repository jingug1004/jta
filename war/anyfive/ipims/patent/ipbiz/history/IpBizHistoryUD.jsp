<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<%@page import="any.util.etc.NDateUtil"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>HISTORY 수정</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("HIST_DATE");
    addBind("HIST_DIV");
    addBind("HIST_TITLE");
    addBind("HIST_RECV");
    addBind("HIST_CHARGE");
    addBind("HIST_FILE", "any_histFile");
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.ipbiz.history.act.RetrieveIpBizHistory.do";
    prx.addParam("REF_ID", parent.REF_ID);
    prx.addParam("HIST_SEQ", parent.HIST_SEQ);
    prx.checkData = ds_mainInfo;

    prx.onSuccess = function()
    {
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//수정
function fnSave(isFileUploaded)
{
    if (!cfCheckAllReqValid()) return;

    if (isFileUploaded != true) {
        if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;
        cfFileUpload("fnSave(true);");
        return;
    }

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.ipbiz.history.act.UpdateIpBizHistory.do";
    prx.addParam("REF_ID", parent.REF_ID);
    prx.addParam("HIST_SEQ", parent.HIST_SEQ);
    prx.addData("ds_mainInfo");
    prx.addData("ds_histFile");

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        parent.goList();
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.ipbiz.history.act.DeleteIpBizHistory.do";
    prx.addParam("REF_ID", parent.REF_ID);
    prx.addParam("HIST_SEQ", parent.HIST_SEQ);

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.delete").toJS() %>");
        parent.goList();
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
        <COL class="conthead" width="18%">
        <COL class="contdata" width="32%">
        <COL class="conthead" width="15%">
        <COL class="contdata" width="35%">
    </COLGROUP>
    <TR>
        <TD req="HIST_DATE">날짜</TD>
        <TD colspan="3"><ANY:DATE id="HIST_DATE" /></TD>
    </TR>
    <TR>
        <TD req="HIST_DIV">구분</TD>
        <TD colspan="3"><ANY:SELECT id="HIST_DIV" codeData="{IPBIZ_HIST_DIV}"/></TD>
    </TR>
    <TR>
        <TD req="HIST_TITLE">업무처리내용</TD>
        <TD colspan="3"><INPUT type="text" id="HIST_TITLE"></TD>
    </TR>
    <TR>
        <TD req="HIST_RECV">수신자</TD>
        <TD><INPUT type="text" id="HIST_RECV"></TD>
        <TD req="HIST_CHARGE">담당자</TD>
        <TD><INPUT type="text" id="HIST_CHARGE"></TD>
    </TR>
    <TR>
        <TD>파일</TD>
        <TD colspan="3">
            <ANY:FILE id="any_histFile" mode="U" policy="ipbiz_history" />
        </TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.delete").toHTML() %>" onClick="javascript:fnDelete();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="list"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
