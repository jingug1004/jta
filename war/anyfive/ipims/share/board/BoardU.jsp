<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.share.common.app.ShareApp"%><% ShareApp app = new ShareApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>게시판 수정</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("CRE_USER_NAME");
    addBind("SUBJECT");
    addBind("NOTICE_START");
    addBind("NOTICE_END");
    addBind("CONTENTS");
    addBind("ATTACH_FILE", "any_attachFile");
    addBind("CRE_DATE_TIME");
    addBind("UPD_DATE_TIME");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
var brdConfig = parent.brdConfig;

//윈도우 로딩시
window.onready = function()
{
    cfSetPageTitle(brdConfig.MENU_NAME + " - 수정");

    tr_noticePeriod.style.display = (brdConfig.NOTICE_PERIOD == "1" ? "block" : "none");

    if (brdConfig.FILE_POLICY != null && brdConfig.FILE_POLICY != "") {
        tr_attachFile.style.display = "block";
        any_attachFile.policy = brdConfig.FILE_POLICY;
    }

    fnRetrieve();
}

//조회
function fnRetrieve()
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.share.board.act.RetrieveBoard.do";
    prx.addParam("BRD_ID", brdConfig.BRD_ID);
    prx.addParam("BRD_NO", parent.BRD_NO);
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

//저장
function fnSave(isFileUploaded)
{
    if (!cfCheckAllReqValid()) return;

    if (isFileUploaded != true) {
        if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;
        cfFileUpload("fnSave(true);");
        return;
    }

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.share.board.act.UpdateBoard.do";
    prx.addParam("BRD_ID", brdConfig.BRD_ID);
    prx.addParam("BRD_NO", parent.BRD_NO);
    prx.addData("ds_mainInfo");
    prx.addData("ds_attachFile");

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        fnGoView();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//상세
function fnGoView()
{
    window.location.replace("BoardRD.jsp");
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
        <TD>작성자</TD>
        <TD colspan="3"><SPAN id="CRE_USER_NAME"></SPAN></TD>
    </TR>
    <TR>
        <TD req="SUBJECT">제목</TD>
        <TD colspan="3">
            <INPUT type="text" id="SUBJECT" maxByte="100">
        </TD>
    </TR>
    <TR id="tr_noticePeriod" style="display:none;">
        <TD req="NOTICE_START:공지시작일, NOTICE_END:공지종료일">공지기간</TD>
        <TD colspan="3">
            <ANY:DATE id="NOTICE_START" />&nbsp;~
            <ANY:DATE id="NOTICE_END" />
        </TD>
    </TR>
    <TR height="100%">
        <TD>내용</TD>
        <TD colspan="3">
            <TEXTAREA id="CONTENTS" rows="20"></TEXTAREA>
        </TD>
    </TR>
    <TR id="tr_attachFile" style="display:none;">
        <TD>첨부파일</TD>
        <TD colspan="3">
            <ANY:FILE id="any_attachFile" mode="U" />
        </TD>
    </TR>
    <TR>
        <TD>작성일</TD>
        <TD><SPAN id="CRE_DATE_TIME"></SPAN></TD>
        <TD>수정일</TD>
        <TD><SPAN id="UPD_DATE_TIME"></SPAN></TD>
    </TR>
</TABLE>
<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.cancel").toHTML() %>" onClick="javascript:fnGoView();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="list"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
