<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>진행서류 이벤트 작성</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("EVENT_ID");
    addBind("EVENT_NAME");
    addBind("EVENT_DESC");
    addBind("NEXT_URGENT_DATE_QRY");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    EVENT_ID.focus();
}

//저장
function fnSave()
{
    if (!cfCheckAllReqValid()) return;

    if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.papermgt.paperevent.act.CreatePaperEvent.do";
    prx.addData("ds_mainInfo");

    prx.onSuccess = function()
    {
        parent.EVENT_SEQ = this.result;
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        window.location.replace("PaperEventMgtUD.jsp");
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
        <COL class="contdata" width="85%">
    </COLGROUP>
    <TR>
        <TD req="EVENT_ID">이벤트 ID</TD>
        <TD>
            <INPUT type="text" id="EVENT_ID" maxByte="30" style="text-transform:uppercase;">
        </TD>
    </TR>
    <TR>
        <TD req="EVENT_NAME">이벤트 이름</TD>
        <TD>
            <INPUT type="text" id="EVENT_NAME" maxByte="300">
        </TD>
    </TR>
    <TR>
        <TD>이벤트 설명</TD>
        <TD>
            <INPUT type="text" id="EVENT_DESC" maxByte="1000">
        </TD>
    </TR>
    <TR>
        <TD>다음업무처리기한일<BR>쿼리문</TD>
        <TD>
            <TEXTAREA id="NEXT_URGENT_DATE_QRY" rows="3" maxByte="4000"></TEXTAREA>
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
