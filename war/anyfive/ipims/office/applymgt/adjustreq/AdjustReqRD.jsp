<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.office.common.app.OfficeApp"%><% OfficeApp app = new OfficeApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>수정요청 상세</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("REQ_USER_NAME");
    addBind("REQ_USER_NO");
    addBind("REQ_DATE");
    addBind("REQ_MAIL_YN");
    addBind("REF_NO");
    addBind("REQ_SUBJECT");
    addBind("REQ_CONTENTS");
    addBind("REQ_FILE", "any_reqFile");
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
    prx.path = top.getRoot() + "/anyfive.ipims.office.applymgt.adjustreq.act.RetrieveAdjustReq.do";
    prx.addParam("REQ_ID", parent.REQ_ID);
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
function fnModify()
{
    window.location.href = top.getRoot() + "/anyfive/ipims/office/applymgt/adjustreq/AdjustReqU.jsp";
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
        <TD>요청자명</TD>
        <TD>
            <ANY:SPAN id="REQ_USER_NAME" />(<ANY:SPAN id="REQ_USER_NO" />)
        </TD>
        <TD>요청일시</TD>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD>
                        <ANY:SPAN id="REQ_DATE"  format="date" />
                    </TD>
                    <TD>
                        <ANY:RADIO id="REQ_MAIL_YN" codeData="/applymgt/reqMailSendYn" readOnly />
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD>의뢰번호</TD>
        <TD>
            <ANY:SPAN id="REF_NO" />
        </TD>
        <TD>요청제목</TD>
        <TD>
            <ANY:SPAN id="REQ_SUBJECT" />
        </TD>
    </TR>
    <TR>
        <TD>요청내용</TD>
        <TD colspan="3"><ANY:SPAN id="REQ_CONTENTS" /></TD>
    </TR>
    <TR>
        <TD>첨부화일</TD>
        <TD colspan="3">
            <ANY:FILE id="any_reqFile" mode="R" />
        </TD>
    </TR>
</TABLE>
<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.modify").toHTML() %>" onClick="javascript:fnModify();" id="btn_modify"></BUTTON>
    <BUTTON auto="line" id="btn_line" display="none"></BUTTON>
    <BUTTON auto="list"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
