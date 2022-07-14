<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="any.util.etc.NCommonUtil"%>
<%@page import="any.util.etc.NDateUtil"%>
<%@page import="anyfive.ipims.office.common.app.OfficeApp"%><% OfficeApp app = new OfficeApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>조사의뢰</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("PRSCH_NO");
    addBind("PRSCH_DIV_NAME");
    addBind("CRE_USER_NAME");
    addBind("CRE_DATE");
    addBind("PRSCH_SUBJECT");
    addBind("PRSCH_GOAL");
    addBind("ATTACH_FILE", "any_attachFile");
    addBind("PRSCH_REQ_CONTENTS");
    addBind("OFFICE_JOB_MAN_NAME");
    addBind("OFFICE_REF_NO");
    addBind("INFORM_DATE");
    addBind("OFFICE_CODE_NAME");
    addBind("EXAM_OPINION");
    addBind("PRSCH_RESULT");
    addBind("RESULT_FILE", "any_resultFile");
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
    prx.path = top.getRoot() + "/anyfive.ipims.office.reqreceipt.priorsearch.act.RetrievePriorSearchResult.do";
    prx.addParam("PRSCH_ID", parent.PRSCH_ID);
    prx.checkData = ds_mainInfo;

    prx.onSuccess = function()
    {
        cfShowObjects([btn_modify, btn_complete, btn_line], ds_mainInfo.value(0, "INFORM_DATE") == "");
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
    window.location.href = "PriorSearchResultU.jsp";
}

//조사결과 완료
function fnSaveComplete()
{
    //저장 확인
    if (!confirm("조사결과를 완료하시겠습니까?")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.office.reqreceipt.priorsearch.act.UpdatePriorSearchComplete.do";
    prx.addParam("PRSCH_ID", parent.PRSCH_ID);

    prx.onSuccess = function()
    {
        alert("조사결과를 완료처리 하였습니다.");
        fnRetrieve();
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
        <TD colspan="4" class="title_table">[조사의뢰 내역]</TD>
    </TR>
    <TR>
        <TD>조사의뢰번호</TD>
        <TD><SPAN id="PRSCH_NO"></SPAN></TD>
        <TD>조사구분</TD>
        <TD><SPAN id="PRSCH_DIV_NAME"></SPAN></TD>
    </TR>
    <TR>
        <TD>작성자</TD>
        <TD><SPAN id="CRE_USER_NAME"></SPAN></TD>
        <TD>작성일</TD>
        <TD><ANY:SPAN id="CRE_DATE" format="date" /></TD>
    </TR>
    <TR>
        <TD>조사제목</TD>
        <TD colspan="3"><SPAN id="PRSCH_SUBJECT"></SPAN></TD>
    </TR>
    <TR>
        <TD>조사목적</TD>
        <TD colspan="3"><SPAN id="PRSCH_GOAL"></SPAN></TD>
    </TR>
    <TR style="display:none;">
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
    <TR>
        <TD colspan="4" class="title_table">[조사결과 입력사항]</TD>
    </TR>
    <TR>
        <TD>사무소담당자</TD>
        <TD><SPAN id="OFFICE_JOB_MAN_NAME"></SPAN></TD>
        <TD>사무소REF</TD>
        <TD><SPAN id="OFFICE_REF_NO"></SPAN></TD>
    </TR>
    <TR>
        <TD>결과답변일</TD>
        <TD><ANY:SPAN id="INFORM_DATE" format="date" /></TD>
        <TD>조사진행사무소</TD>
        <TD><SPAN id="OFFICE_CODE_NAME"></SPAN></TD>
    </TR>
    <TR>
        <TD>검토의견</TD>
        <TD colspan="3"><SPAN id="EXAM_OPINION"></SPAN></TD>
    </TR>
    <TR>
        <TD>조사결과내역</TD>
        <TD colspan="3"><SPAN id="PRSCH_RESULT"></SPAN></TD>
    </TR>
    <TR>
        <TD>조사결과관련<br>첨부파일</TD>
        <TD colspan="3">
            <ANY:FILE id="any_resultFile" mode="R" />
        </TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.modify").toHTML() %>" onClick="javascript:fnModify();" id="btn_modify" display="none"></BUTTON>
    <BUTTON text="조사결과 완료" onClick="javascript:fnSaveComplete();" id="btn_complete" display="none"></BUTTON>
    <BUTTON auto="line" id="btn_line" display="none"></BUTTON>
    <BUTTON auto="list"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
