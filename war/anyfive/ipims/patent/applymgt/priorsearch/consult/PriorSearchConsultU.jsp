<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>선행기술조사 수정</TITLE>
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
    addBind("ATTACH_FILE_REQ", "any_attachFileReq");
    addBind("PRSCH_REQ_CONTENTS");
    addBind("JOB_MAN_NAME");
    addBind("REQ_DATE");
    addBind("EXAM_RESULT");
    addBind("EXAM_OPINION");
    addBind("PRSCH_TYPE");
    addBind("ATTACH_FILE_CONSULT", "any_attachFileConsult");
    addBind("OFFICE_CODE");
    addBind("PUB_YN");
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

    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.priorsearch.consult.act.RetrievePriorSearchConsult.do";

    prx.addParam("PRSCH_ID", parent.PRSCH_ID);
    prx.checkData = ds_mainInfo;

    prx.onSuccess = function()
    {
        fnShowHideItem();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//항목 숨김/표시
function fnShowHideItem()
{
    cfShowObjects([tr_prschType], EXAM_RESULT.value == "1");

    cfShowObjects([tr_OfficeCode], EXAM_RESULT.value == "1");
    cfShowObjects([tr_PubYn], EXAM_RESULT.value == "1");
}

//저장
function fnSave(isFileUploaded)
{
    //필수항목 체크
    if (!cfCheckAllReqValid()) return;

    if (isFileUploaded != true) {
        if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;
        cfFileUpload("fnSave(true);");
        return;
    }

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.priorsearch.consult.act.UpdatePriorSearchConsult.do";
    prx.addParam("PRSCH_ID", parent.PRSCH_ID);
    prx.addData("ds_mainInfo");
    prx.addData("ds_attachFileConsult");

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        window.location.replace("PriorSearchConsultRD.jsp");
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}
</SCRIPT>

<!-- 검토결과 변경시 -->
<SCRIPT language="JScript" for="EXAM_RESULT" event="OnChange()">
    fnShowHideItem();
</SCRIPT>

<!-- 내/외조사 변경시 -->
<SCRIPT language="JScript" for="PRSCH_TYPE" event="OnChange()">
    fnShowHideItem();
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
            <ANY:FILE id="any_attachFileReq" mode="R" />
        </TD>
    </TR>
    <TR>
        <TD>조사의뢰내역</TD>
        <TD colspan="3">
            <SPAN  id="PRSCH_REQ_CONTENTS"></SPAN>
        </TD>
    </TR>
    <TR>
        <TD colspan="4" class="title_table">[특허팀 추가 입력사항]</TD>
    </TR>
    <TR>
        <TD>특허팀담당자</TD>
        <TD><SPAN id="JOB_MAN_NAME"></SPAN></TD>
        <TD>의뢰일</TD>
        <TD><ANY:SPAN id="REQ_DATE" format="date" /></TD>
    </TR>
    <TR>
        <TD req="EXAM_RESULT" >검토결과</TD>
        <TD colspan="3">
            <ANY:RADIO id="EXAM_RESULT" codeData="{PRSCH_EXAM_RESULT}" style="width:50%" />
        </TD>
    </TR>
    <TR>
        <TD>검토결과의견</TD>
        <TD colspan="3">
            <TEXTAREA id="EXAM_OPINION" rows="3" maxByte="4000"></TEXTAREA>
        </TD>
    </TR>
    <TR id="tr_prschType" style="display:none;">
        <TD req="PRSCH_TYPE">조사기관</TD>
        <TD colspan="3">
            <ANY:RADIO id="PRSCH_TYPE" codeData="{PRSCH_TYPE}" style="width:50%" />
        </TD>
    </TR>
    <TR>
        <TD>첨부파일</TD>
        <TD colspan="3">
            <ANY:FILE id="any_attachFileConsult" mode="U" policy="prior_search" />
        </TD>
    </TR>
    <TR id="tr_OfficeCode" style="display:none;">
        <TD>조사기관</TD>
        <TD colspan="3">
            <ANY:SELECT id="OFFICE_CODE" codeData="/common/inInspOrgan" firstName="sel" />
        </TD>
    </TR>
    <TR id="tr_PubYn" style="display:none;" >
        <TD req="PUB_YN">공개여부</TD>
        <TD colspan="3">
            <ANY:RADIO id="PUB_YN" codeData="{OPEN_YN}"  value="2" />
        </TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>

    <BUTTON text="<%= app.message.get("btn.com.cancel").toHTML() %>" onClick="javascript:history.back();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="list"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
