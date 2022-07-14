<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.share.workprocess.util.WorkProcessConst"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>선행기술조사 상세</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_WORKPROC); %>
<% app.writeHTCImport(app.HTC_APPROVAL); %>
<ANY:WORKPROC id="wp" />
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
    addBind("OFFICE_NAME");
    addBind("PUB_YN");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
var gScrollBottom = false;

//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();
}

//조회
function fnRetrieve(scrollBottom)
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.priorsearch.consult.act.RetrievePriorSearchConsult.do";
    prx.addParam("PRSCH_ID", parent.PRSCH_ID);
    prx.checkData = ds_mainInfo;

    prx.onSuccess = function()
    {
        //건담당자이고, 검토결과가 입력되어 있지 않는 경우 수정화면으로 이동
        if (ds_mainInfo.value(0, "JOB_MAN") == "<%= app.userInfo.getUserId() %>" && ds_mainInfo.value(0, "EXAM_RESULT") == "") {
            window.location.replace("PriorSearchConsultU.jsp");
            return;
        }

        fnShowHideItem();

        any_approval.reset();
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

//수정
function fnModify()
{
    window.location.href = "PriorSearchConsultU.jsp";
}

//조사결과 표시
function fnShowResult()
{
    var actPrschResultInput = "<%= WorkProcessConst.Action.PRSCH_RESULT_INPUT %>";
    var actPrschResultComplete = "<%= WorkProcessConst.Action.PRSCH_RESULT_COMPLETE %>";
    var actModify = "<%= WorkProcessConst.Action.MODIFY %>";

    PRSCH_RESULT.innerText = ds_mainInfo.value(0, "PRSCH_RESULT");
    any_resultFile.fileId = ds_mainInfo.value(0, "RESULT_FILE");
    INFORM_DATE.value = ds_mainInfo.value(0, "INFORM_DATE");

    cfShowObjects([div_result], wp.avail([actPrschResultInput], "PAT") || ds_mainInfo.value(0, "PRSCH_RESULT_INPUT_YN") == "1");
    cfShowObjects([btn_result], wp.avail([actPrschResultInput], "PAT") || wp.avail([actModify], "PAT"));
    cfShowObjects([btn_complete], wp.avail([actPrschResultComplete], "OFF") && ds_mainInfo.value(0, "INFORM_DATE") == "");

    btn_line2.display = (btn_result.display == "none" && btn_complete.display == "none" ? "none" : "");
}

//결과 입력
function fnInputResult()
{
    var win = new any.window();
    win.path = top.getRoot() + "/anyfive/ipims/patent/applymgt/priorsearch/result/PriorSearchResultCU.jsp";
    win.arg.PRSCH_ID = parent.PRSCH_ID;
    win.opt.width = 700;
    win.opt.height = 400;

    win.onReload = function()
    {
        gScrollBottom = true;
        fnRetrieve();
    }

    win.show();
}

//조사결과 완료
function fnSaveComplete()
{
    //저장 확인
    if (!confirm("조사결과를 완료하시겠습니까?")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.priorsearch.result.act.UpdatePriorSearchComplete.do";
    prx.addParam("PRSCH_ID", parent.PRSCH_ID);

    prx.onSuccess = function()
    {
        wp.reset(parent.PRSCH_ID);
        alert("조사결과를 완료처리 하였습니다.");
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
    wp.reset(parent.PRSCH_ID);
</SCRIPT>

<!-- 업무프로세스 로딩시 -->
<SCRIPT language="JScript" for="wp" event="OnLoad()">
    var isJobMan = (ds_mainInfo.value(0, "JOB_MAN") == "<%= app.userInfo.getUserId() %>");
    var actModify = "<%= WorkProcessConst.Action.MODIFY %>";

    cfShowObjects([btn_modify, btn_line1], isJobMan && wp.avail([actModify], "PAT"));
    fnShowResult();

    if (gScrollBottom == true) {
        gScrollBottom = false;
        cfSetScrollBottom();
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
            <SPAN id="PRSCH_REQ_CONTENTS"></SPAN>
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
        <TD>검토결과</TD>
        <TD colspan="3">
            <ANY:RADIO id="EXAM_RESULT" codeData="{PRSCH_EXAM_RESULT}" style="width:50%" readOnly />
        </TD>
    </TR>
    <TR>
        <TD>검토결과의견</TD>
        <TD colspan="3">
            <SPAN id="EXAM_OPINION"></SPAN>
        </TD>
    </TR>
    <TR id="tr_prschType" style="display:none;">
        <TD>내/외조사</TD>
        <TD colspan="3">
            <ANY:RADIO id="PRSCH_TYPE" codeData="{PRSCH_TYPE}" style="width:50%" readOnly />
        </TD>
    </TR>
     <TR>
        <TD>첨부파일</TD>
        <TD colspan="3">
            <ANY:FILE id="any_attachFileConsult" mode="R" />
        </TD>
    </TR>
    <TR id="tr_OfficeCode" style="display:none;">
        <TD>조사기관</TD>
        <TD colspan="3">
            <SPAN id="OFFICE_NAME" /></SPAN>
        </TD>
    </TR>
    <TR id="tr_PubYn" style="display:none;" >
        <TD>공개여부</TD>
        <TD colspan="3">
            <ANY:RADIO id="PUB_YN" codeData="{OPEN_YN}"  readOnly/>
        </TD>
    </TR>


</TABLE>

<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.modify").toHTML() %>" onClick="javascript:fnModify();" id="btn_modify" display="none"></BUTTON>
    <BUTTON auto="line" id="btn_line1" display="none"></BUTTON>
    <BUTTON auto="list"></BUTTON>
</DIV>

<ANY:APPROVAL id="any_approval" code="S02"><COMMENT>
    reqUser = ds_mainInfo.value(0, "JOB_MAN");
    addKey("PRSCH_ID", parent.PRSCH_ID);
</COMMENT></ANY:APPROVAL>

<DIV id="div_result" style="margin-top:10px; display:none;">
<TABLE border="0" cellspacing="1" cellpadding="2" class="main">
    <COLGROUP>
        <COL class="conthead" width="15%">
        <COL class="contdata" width="85%">
    </COLGROUP>
    <TR>
        <TD colspan="2" class="title_table">[조사결과 입력사항]</TD>
    </TR>
    <TR>
        <TD>결과내역</TD>
        <TD><SPAN id="PRSCH_RESULT"></SPAN></TD>
    </TR>
    <TR>
        <TD>결과첨부파일</TD>
        <TD>
            <ANY:FILE id="any_resultFile" mode="R" />
        </TD>
    </TR>
    <TR>
        <TD>결과통보일</TD>
        <TD><ANY:SPAN id="INFORM_DATE" format="date" /></TD>
    </TR>
</TABLE>
<DIV class="button_area">
    <BUTTON text="조사결과 입력" onClick="javascript:fnInputResult();" id="btn_result" display="none"></BUTTON>
    <BUTTON text="조사결과 완료" onClick="javascript:fnSaveComplete();" id="btn_complete" display="none"></BUTTON>
    <BUTTON auto="line" id="btn_line2" display="none"></BUTTON>
    <BUTTON auto="list"></BUTTON>
</DIV>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
