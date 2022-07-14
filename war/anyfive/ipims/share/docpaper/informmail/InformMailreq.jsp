<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.share.common.app.ShareApp"%><% ShareApp app = new ShareApp(request, response, out); %>
<%@page import="any.util.etc.NDateUtil"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>이메일 발송</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("SUBJECT");
    addBind("BODY");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    SUBJECT.value = parent.REQ_SUBJECT;
    BODY.value = parent.REQ_CONTENTS;
}

//저장
function fnSave()
{
    //필수항목 체크
    if (!cfCheckAllReqValid()) return;

    //저장 확인
    if (!confirm("수정요청사항을 발송하시겠습니까?")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.share.docpaper.informmail.act.CreateInformMail.do";
    prx.addParam("REF_ID", parent.REF_ID);
    prx.addParam("LIST_SEQ", parent.LIST_SEQ);
    prx.addData("ds_mainInfo");
    prx.addData("ds_toList");


    prx.onSuccess = function()
    {
        alert("발송하였습니다.");
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
        <COL class="conthead" width="10%">
        <COL class="contdata" width="35%">
    </COLGROUP>
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
