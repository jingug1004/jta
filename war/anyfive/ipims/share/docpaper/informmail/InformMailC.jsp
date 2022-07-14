<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.share.common.app.ShareApp"%><% ShareApp app = new ShareApp(request, response, out); %>
<%@page import="any.util.etc.NDateUtil"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>진행서류 알림메일 발송</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("KO_APP_TITLE");
    addBind("REF_NO");
    addBind("APP_NO");
    addBind("SUBJECT");
    addBind("BODY");
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
    prx.path = top.getRoot() + "/anyfive.ipims.share.docpaper.informmail.act.RetrieveInformMailInfo.do";
    prx.addParam("REF_ID", parent.REF_ID);
    prx.addParam("LIST_SEQ", parent.LIST_SEQ);

    prx.onSuccess = function()
    {
        SUBJECT.value = "[알림] 지재권관리시스템으로부터 진행서류가 작성되었습니다.";
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
    //필수항목 체크
    if (!cfCheckAllReqValid()) return;

    //저장 확인
    if (!confirm("알림메일을 발송하시겠습니까?")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.share.docpaper.informmail.act.CreateInformMail.do";
    prx.addParam("REF_ID", parent.REF_ID);
    prx.addParam("LIST_SEQ", parent.LIST_SEQ);
    prx.addData("ds_mainInfo");
    prx.addData("ds_toList");
    prx.addData("ds_ccList");

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
        <COL class="conthead" width="15%">
        <COL class="contdata" width="35%">
        <COL class="conthead" width="15%">
        <COL class="contdata" width="35%">
    </COLGROUP>
    <TR>
        <TD>발명의 명칭</TD>
        <TD colspan="3"><SPAN id="KO_APP_TITLE"></SPAN></TD>
    </TR>
    <TR>
        <TD>REF_NO</TD>
        <TD><SPAN id="REF_NO"></SPAN></TD>
        <TD>출원번호</TD>
        <TD><SPAN id="APP_NO"></SPAN></TD>
    </TR>
    <TR>
        <TD>발신인</TD>
        <TD colspan="3"><%= app.userInfo.getEmpHname() + " (" + app.userInfo.getMailAddr() + ")" %></TD>
    </TR>
    <TR>
        <TD req="any_toList">수신인</TD>
        <TD colspan="3">
            <ANY:MSEARCH id="any_toList" mode="C"><COMMENT>
                prx.path = top.getRoot() + "/anyfive.ipims.share.docpaper.informmail.act.RetrieveInformMailReceiverSearchList.do";
                win.path = "InformMailReceiverSearchListR.jsp";
                win.opt.width = 700;
                codeColumn = "USER_ID";
                nameExpr = "{#EMP_HNAME} ({#MAIL_ADDR})";
                size = 4;
            </COMMENT></ANY:MSEARCH>
        </TD>
    </TR>
    <TR>
        <TD>참조인</TD>
        <TD colspan="3">
            <ANY:MSEARCH id="any_ccList" mode="C"><COMMENT>
                prx.path = top.getRoot() + "/anyfive.ipims.share.docpaper.informmail.act.RetrieveInformMailReceiverSearchList.do";
                win.path = "InformMailReceiverSearchListR.jsp";
                win.opt.width = 700;
                codeColumn = "USER_ID";
                nameExpr = "{#EMP_HNAME} ({#MAIL_ADDR})";
                size = 4;
            </COMMENT></ANY:MSEARCH>
        </TD>
    </TR>
    <TR>
        <TD req="SUBJECT">제목</TD>
        <TD colspan="3"><INPUT type="text" id="SUBJECT"></TD>
    </TR>
    <TR>
        <TD req="BODY">송부내용</TD>
        <TD colspan="3"><TEXTAREA id="BODY" rows="18"></TEXTAREA></TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="발송" onClick="javascript:fnSave();"></BUTTON>
    <BUTTON text="취소" onClick="javascript:top.window.close();"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
