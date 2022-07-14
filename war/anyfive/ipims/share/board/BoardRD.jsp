<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.share.common.app.ShareApp"%><% ShareApp app = new ShareApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>게시판 상세</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("CRE_USER_NAME");
    addBind("READ_CNT");
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
    cfSetPageTitle(brdConfig.MENU_NAME + " - 상세");

    cfShowObjects([tr_noticePeriod], brdConfig.NOTICE_PERIOD == "1");
    cfShowObjects([tr_attachFile], brdConfig.FILE_POLICY != null && brdConfig.FILE_POLICY != "");
    cfShowObjects([btn_reply], brdConfig.ANS_AVAIL == "1");
    cfShowObjects([btn_movePrev, btn_moveNext, btn_line2], parent.fg != null);
    fnRetrieve();
}

//조회
function fnRetrieve()
{

    if (parent.fg != null) {
        btn_movePrev.disabled = (parent.fg.Row <= parent.fg.FixedRows);
        btn_moveNext.disabled = (parent.fg.Row >= parent.fg.Rows - 1);
    }

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.share.board.act.RetrieveBoard.do";

    prx.addParam("BRD_ID", brdConfig.BRD_ID);
    prx.addParam("BRD_NO", parent.BRD_NO);
    prx.addParam("readCntAdd", parent.readCntAdd);
    prx.checkData = ds_mainInfo;

    prx.onSuccess = function()
    {
        cfShowObjects([btn_modify, btn_delete], brdConfig.WRITE_AVAIL == "1" && ds_mainInfo.value(0, "CRE_USER") == "<%= app.userInfo.getUserId() %>");
        cfShowObjects([btn_line1], btn_modify.display != "none" || btn_delete.display != "none" || btn_reply.display != "none");

        parent.RE_PARENT = ds_mainInfo.value(0, "RE_PARENT");
        parent.readCntAdd = 0;
        parent.reloadList();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//수정
function fnModify()
{
    window.location.href = "BoardU.jsp";
}

//삭제
function fnDelete()
{
    if (!confirm("삭제하시겠습니까?")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.share.board.act.DeleteBoard.do";
    prx.addParam("BRD_ID", brdConfig.BRD_ID);
    prx.addParam("BRD_NO", parent.BRD_NO);
    prx.addParam("RE_PARENT", parent.RE_PARENT);

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

//답변
function fnReply()
{
    window.location.href = "BoardC.jsp";
}

//이전/다음
function fnMoveList(dir, bool)
{
    if (parent.gr == null) return;
    if (parent.fg == null) return;

    parent.gr.moveRowPos(dir, "SUBJECT");

    if (bool != true && parent.gr.value(parent.fg.Row, "DEL_YN") != "0") {
        fnMoveList(dir, true);
        return;
    }

    parent.BRD_NO = parent.gr.value(parent.fg.Row, "BRD_NO");

    parent.readCntAdd = 1;

    fnRetrieve();
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
        <TD><SPAN id="CRE_USER_NAME"></SPAN></TD>
        <TD>조회수</TD>
        <TD><ANY:SPAN id="READ_CNT" format="number2" /></TD>
    </TR>
    <TR>
        <TD>제목</TD>
        <TD colspan="3"><SPAN id="SUBJECT"></SPAN></TD>
    </TR>
    <TR id="tr_noticePeriod" style="display:none;">
        <TD>공지기간</TD>
        <TD colspan="3">
            <ANY:SPAN id="NOTICE_START" format="date"></ANY:SPAN>&nbsp;~
            <ANY:SPAN id="NOTICE_END" format="date"></ANY:SPAN>
        </TD>
    </TR>
    <TR height="100%">
        <TD>내용</TD>
        <TD colspan="3"><SPAN id="CONTENTS"></SPAN></TD>
    </TR>
    <TR id="tr_attachFile" style="display:none;">
        <TD>첨부파일</TD>
        <TD colspan="3">
            <ANY:FILE id="any_attachFile" mode="R" />
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
    <BUTTON text="<%= app.message.get("btn.com.modify").toHTML() %>" onClick="javascript:fnModify();" id="btn_modify" display="none"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.delete").toHTML() %>" onClick="javascript:fnDelete();" id="btn_delete" display="none"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.reply").toHTML() %>" onClick="javascript:fnReply();" id="btn_reply" display="none"></BUTTON>
    <BUTTON auto="line" id="btn_line1" display="none"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.move.prev").toHTML() %>" onClick="javascript:fnMoveList(-1);" id="btn_movePrev" display="none" disabled></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.move.next").toHTML() %>" onClick="javascript:fnMoveList(1);" id="btn_moveNext" display="none" disabled></BUTTON>
    <BUTTON auto="line" id="btn_line2" display="none"></BUTTON>
    <BUTTON auto="list"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
