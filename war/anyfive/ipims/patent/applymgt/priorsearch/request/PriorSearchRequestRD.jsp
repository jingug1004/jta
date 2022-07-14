<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="any.util.etc.NDateUtil"%>
<%@page import="anyfive.ipims.share.workprocess.util.WorkProcessConst"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>선행기술조사의뢰 상세</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_WORKPROC); %>
<% app.writeHTCImport(app.HTC_APPROVAL); %>
<ANY:WORKPROC id="wp" />
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("PRSCH_NO");
    addBind("PRSCH_DIV_NAME");
    addBind("PRSCH_SUBJECT");
    addBind("CRE_USER_NAME");
    addBind("CRE_DATE");
    addBind("PRSCH_GOAL");
    addBind("ATTACH_FILE", "any_attachFile");
    addBind("PRSCH_REQ_CONTENTS");
    addBind("EXAM_OPINION");
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.priorsearch.request.act.RetrievePriorSearchRequest.do";
    prx.addParam("PRSCH_ID", parent.PRSCH_ID);
    prx.checkData = ds_mainInfo;

    prx.onSuccess = function()
    {
        cfShowObjects([div_examOpinion], ds_mainInfo.value(0, "CONSULT_EXIST") == "1");

        any_approval.reset();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//재작성
function fnRewrite()
{
    if (!confirm("보완요청을 확인하시겠습니까?")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.priorsearch.request.act.RewritePriorSearchRequest.do";
    prx.addParam("PRSCH_ID", parent.PRSCH_ID);

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        window.location.replace("PriorSearchRequestU.jsp");
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
    window.location.href = "PriorSearchRequestU.jsp";
}

//조사결과 표시
function fnShowResult()
{
    var prschResult = ds_mainInfo.value(0, "PRSCH_RESULT");
    var resultFile = ds_mainInfo.value(0, "RESULT_FILE");

    if (prschResult == "" && resultFile == "") return;

    PRSCH_RESULT.innerText = prschResult;
    any_resultFile.fileId = resultFile;

    cfShowObjects([div_result], true);
}
</SCRIPT>

<!-- 결재현황 로딩시 -->
<SCRIPT language="JScript" for="any_approval" event="OnLoad()">
    wp.reset(parent.PRSCH_ID);
</SCRIPT>

<!-- 업무프로세스 로딩시 -->
<SCRIPT language="JScript" for="wp" event="OnLoad()">
    var isCreUser = (ds_mainInfo.value(0, "CRE_USER") == "<%= app.userInfo.getUserId() %>");
    var actRewrite = "<%= WorkProcessConst.Action.REWRITE %>";
    var actModify = "<%= WorkProcessConst.Action.MODIFY %>";

    cfShowObjects([btn_rewrite, btn_line1], isCreUser && wp.avail([actRewrite]));
    cfShowObjects([btn_modify, btn_line2], isCreUser && wp.avail([actModify]));
    fnShowResult();
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
        <TD>작성자</TD>
        <TD><SPAN id="CRE_USER_NAME"></SPAN></TD>
        <TD>작성일</TD>
        <TD><ANY:SPAN id="CRE_DATE" format="date"></ANY:SPAN></TD>
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
    <TR id="div_examOpinion" style="display:none;">
        <TD>검토의견</TD>
        <TD colspan="3">
            <SPAN id="EXAM_OPINION"></SPAN>
        </TD>
    </TR>
</TABLE>
<DIV class="button_area">
    <BUTTON text="보완요청 확인" onClick="javascript:fnRewrite();" id="btn_rewrite" display="none"></BUTTON>
    <BUTTON auto="line" id="btn_line1" display="none"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.modify").toHTML() %>" onClick="javascript:fnModify();" id="btn_modify" display="none"></BUTTON>
    <BUTTON auto="line" id="btn_line2" display="none"></BUTTON>
    <BUTTON auto="list"></BUTTON>
</DIV>

<ANY:APPROVAL id="any_approval" code="S01"><COMMENT>
    reqUser = ds_mainInfo.value(0, "CRE_USER");
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
        <TD>조사결과내역</TD>
        <TD><SPAN id="PRSCH_RESULT"></SPAN></TD>
    </TR>
    <TR>
        <TD>조사결과<BR>첨부파일</TD>
        <TD>
            <ANY:FILE id="any_resultFile" mode="R" />
        </TD>
    </TR>
</TABLE>
<DIV class="button_area">
    <BUTTON auto="list"></BUTTON>
</DIV>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
