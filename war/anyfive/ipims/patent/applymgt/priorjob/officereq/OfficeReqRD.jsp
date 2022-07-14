<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>사무소요청사항</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("REQ_USER_NAME");
    addBind("REQ_DATE");
    addBind("REQ_MAIL_YN_NAME");
    addBind("INOUT_DIV_NAME");
    addBind("REF_NO");
    addBind("JOB_MAN_NAME");
    addBind("JOB_MAN_NO");
    addBind("REQ_SUBJECT");
    addBind("REQ_CONTENTS");
    addBind("REQ_FILE", "any_reqFile");
    addBind("ANS_USER_NAME");
    addBind("ANS_USER_NO");
    addBind("ANS_DATE");
    addBind("STATUS_NAME");
    addBind("ANS_SUBJECT");
    addBind("ANS_CONTENTS");
    addBind("ANS_FILE", "any_ansFile");
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.priorjob.officereq.act.RetrievePriorJobOfficeReq.do";
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
    window.location.href = top.getRoot() + "/anyfive/ipims/patent/applymgt/priorjob/officereq/OfficeReqU.jsp";
}

</SCRIPT>

</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="1" cellpadding="2" class="main">
    <COLGROUP>
        <COL class="conthead" width="13%">
        <COL class="contdata" width="20%">
        <COL class="conthead" width="13%">
        <COL class="contdata" width="20%">
        <COL class="conthead" width="14%">
        <COL class="contdata" width="20%">
    </COLGROUP>
    <TR>
        <TD colspan="6" class="title_table">사무소 수정요청 내용</TD>
    </TR>
    <TR>
        <TD>요청자명</TD>
        <TD>
            <ANY:SPAN id="REQ_USER_NAME" />
        </TD>
        <TD>요청일시</TD>
        <TD>
            <ANY:SPAN id="REQ_DATE" format="date" />
        </TD>
        <TD>요청메일</TD>
        <TD>
            <ANY:SPAN id="REQ_MAIL_YN_NAME" />
        </TD>
    </TR>
    <TR>
        <TD>건구분</TD>
        <TD>
            <ANY:SPAN id="INOUT_DIV_NAME" />
        </TD>
        <TD>의뢰번호</TD>
        <TD>
            <ANY:SPAN id="REF_NO" />
        </TD>
        <TD>지적재산팀담당자</TD>
        <TD>
            <ANY:SPAN id="JOB_MAN_NAME" format="date" />(<ANY:SPAN id="JOB_MAN_NO" />)
        </TD>
    </TR>
    <TR>
        <TD>요청제목</TD>
        <TD colspan="5">
            <ANY:SPAN id="REQ_SUBJECT" />
        </TD>
    </TR>
    <TR>
        <TD>요청내용</TD>
        <TD colspan="5">
            <ANY:SPAN id="REQ_CONTENTS" />
        </TD>
    </TR>
    <TR>
        <TD>첨부화일</TD>
        <TD colspan="5">
            <ANY:FILE id="any_reqFile" mode="R" />
        </TD>
    </TR>
    <TR>
        <TD colspan="6" class="title_table">담당자 요청 처리 사항</TD>
    </TR>
    <TR>
        <TD>처리자명(사번)</TD>
        <TD>
            <ANY:SPAN id="ANS_USER_NAME" />(<ANY:SPAN id="ANS_USER_NO" />)
        </TD>
        <TD>처리일시</TD>
        <TD>
            <ANY:SPAN id="ANS_DATE" format="date" />
        </TD>
        <TD>처리상태</TD>
        <TD>
            <ANY:SPAN id="STATUS_NAME" />
        </TD>
    </TR>
    <TR>
        <TD>답변제목</TD>
        <TD colspan="5">
            <ANY:SPAN id="ANS_SUBJECT" />
        </TD>
    </TR>
    <TR>
        <TD>답변내용</TD>
        <TD colspan="5">
            <ANY:SPAN id="ANS_CONTENTS" />
        </TD>
    </TR>
    <TR>
        <TD>답변 첨부화일</TD>
        <TD colspan="5">
            <ANY:FILE id="any_ansFile" mode="R" />
        </TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="답변" onClick="javascript:fnModify();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="list"></BUTTON>

</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
