<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>선행기술조사의뢰 접수</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_APPROVAL); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("PRSCH_NO");
    addBind("PRSCH_DIV_NAME");
    addBind("DEPT_NAME");
    addBind("CRE_USER_NAME");
    addBind("CRE_DATE");
    addBind("PRSCH_SUBJECT");
    addBind("PRSCH_GOAL");
    addBind("ATTACH_FILE", "any_attachFile");
    addBind("PRSCH_REQ_CONTENTS");
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.priorsearch.receipt.act.RetrievePriorSearchReceipt.do";
    prx.addParam("PRSCH_ID", parent.PRSCH_ID);
    prx.checkData = ds_mainInfo;

    prx.onSuccess = function()
    {
        any_approval.reset();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//담당자 지정
function fnSave()
{
    if (!confirm(any.message.get("msg.com.jobman.save", JOB_MAN.text))) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.priorsearch.receipt.act.UpdatePriorSearchReceiptJobMan.do";
    prx.addParam("PRSCH_ID", parent.PRSCH_ID);
    prx.addParam("JOB_MAN", JOB_MAN.value);

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.jobman.info").toJS() %>");
        parent.goList();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

</SCRIPT>

<!-- 결재현황 로딩시 -->
<SCRIPT language="JScript" for="any_approval" event="OnLoad()">
</SCRIPT>

<!-- 결재현황 처리성공시 -->
<SCRIPT language="JScript" for="any_approval" event="OnSuccess()">
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
        <TD>조사의뢰번호
        <TD><SPAN id="PRSCH_NO"></SPAN></TD>
        <TD>조사구분</TD>
        <TD><SPAN id="PRSCH_DIV_NAME"></SPAN></TD>
    </TR>
    <TR>
        <TD>조사의뢰부서</TD>
        <TD><SPAN id="DEPT_NAME"></SPAN></TD>
        <TD>작성자(작성일)</TD>
        <TD><SPAN id="CRE_USER_NAME"></SPAN>(<ANY:SPAN id="CRE_DATE" format="date" />)</TD>
    </TR>
    <TR>
        <TD>조사제목</TD>
        <TD colspan="3"><SPAN id="PRSCH_SUBJECT"></SPAN></TD>
    </TR>
    <TR>
        <TD>조사목적</TD>
        <TD colspan="3"><SPAN id="PRSCH_GOAL"></SPAN></TD>
    </TR>
    <TR>
        <TD>대표PJT</TD>
        <TD colspan="3">
            <ANY:PJT id="any_projectList" mode="R" />
        </TD>
    </TR>
    <TR>
        <TD>조사국가</TD>
        <TD>
            <ANY:MSEARCH id="any_countryList" mode="R"><COMMENT>
                codeColumn = "COUNTRY_CODE";
                nameExpr = "[{#COUNTRY_CODE}] {#COUNTRY_NAME}";
                size = 6;
            </COMMENT></ANY:MSEARCH>
        </TD>
        <TD>기술분류코드</TD>
        <TD>
            <ANY:MSEARCH id="any_techCodeList" mode="R"><COMMENT>
                codeColumn = "TECH_CODE";
                nameExpr = "[{#TECH_CODE}] {#TECH_PATHNAME}";
                size = 6;
            </COMMENT></ANY:MSEARCH>
        </TD>
    </TR>
    <TR>
        <TD>의뢰서관련<BR>첨부파일</TD>
        <TD colspan="3">
            <ANY:FILE id="any_attachFile" mode="R" />
        </TD>
    </TR>
    <TR>
        <TD>조사의뢰내역</TD>
        <TD colspan="3">
            <SPAN id="PRSCH_REQ_CONTENTS"></SPAN>
        </TD>
    </TR>
</TABLE>
<DIV class="button_area">
    <ANY:SELECT id="JOB_MAN" codeData="/common/jobManAll" value="<%= app.userInfo.getUserId() %>" style="width:100px;"/>
    <BUTTON text="<%= app.message.get("btn.com.jobman").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="list"></BUTTON>
</DIV>

<ANY:APPROVAL id="any_approval" code="S01"><COMMENT>
    addKey("PRSCH_ID", parent.PRSCH_ID);
</COMMENT></ANY:APPROVAL>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
