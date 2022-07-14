<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="any.util.etc.NCommonUtil"%>
<%@page import="any.util.etc.NDateUtil"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>선행기술조사의뢰 작성</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("PRSCH_DIV");
    addBind("PRSCH_SUBJECT");
    addBind("PRSCH_GOAL");
    addBind("ATTACH_FILE", "any_attachFile");
    addBind("PRSCH_REQ_CONTENTS");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    PRSCH_SUBJECT.focus();
}

//저장
function fnSave(isFileUploaded)
{
    //필수항목 체크
    if (!cfCheckAllReqValid()) return;

    //조사국가 목록 체크
    if (any_countryList.valid) return;

    if (isFileUploaded != true) {
        if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;
        cfFileUpload("fnSave(true);");
        return;
    }

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.priorsearch.request.act.CreatePriorSearchRequest.do";
    prx.addData("ds_mainInfo");
    prx.addData("ds_projectList");
    prx.addData("ds_countryList");
    prx.addData("ds_techCodeList");
    prx.addData("ds_attachFile");

    prx.onSuccess = function()
    {
        parent.PRSCH_ID = this.result;
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        window.location.replace("PriorSearchRequestRD.jsp");
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
        <TD>조사의뢰번호
        <TD disabled>(<%= app.message.get("msg.com.autocreate") %>)</TD>
        <TD req="PRSCH_DIV">조사구분</TD>
        <TD><ANY:SELECT id="PRSCH_DIV" codeData="{PRSCH_DIV}" firstName="sel" /></TD>
    </TR>
    <TR>
        <TD>작성자</TD>
        <TD><%= app.userInfo.getEmpHname() %></TD>
        <TD>작성일</TD>
        <TD><ANY:SPAN format="date" value="<%= NDateUtil.getSysDate() %>" /></TD>
    </TR>
    <TR>
        <TD req="PRSCH_SUBJECT">조사제목</TD>
        <TD colspan="3"><INPUT type="text" id="PRSCH_SUBJECT" maxByte="1000"></TD>
    </TR>
    <TR>
        <TD>조사목적</TD>
        <TD colspan="3"><INPUT type="text" id="PRSCH_GOAL" maxByte="1000"></TD>
    </TR>
    <TR style="display:none;">
        <TD>대표PJT</TD>
        <TD colspan="3">
            <ANY:PJT id="any_projectList" mode="C1" />
        </TD>
    </TR>
    <TR>
        <TD>조사국가</TD>
        <TD>
            <ANY:MSEARCH id="any_countryList" mode="C"><COMMENT>
                win.path = top.getRoot() + "/anyfive/ipims/patent/common/popup/search/CountrySearchListR.jsp";
                codeColumn = "COUNTRY_CODE";
                nameExpr = "[{#COUNTRY_CODE}] {#COUNTRY_NAME}";
                size = 6;
            </COMMENT></ANY:MSEARCH>
        </TD>
        <TD>기술분류코드</TD>
        <TD>
            <ANY:MSEARCH id="any_techCodeList" mode="C"><COMMENT>
                win.path = top.getRoot() + "/anyfive/ipims/patent/common/popup/search/TechCodeSearchTreeR.jsp";
                codeColumn = "TECH_CODE";
                nameExpr = "[{#TECH_CODE}] {#TECH_PATHNAME}";
                size = 6;
            </COMMENT></ANY:MSEARCH>
        </TD>
    </TR>
    <TR>
        <TD>의뢰서관련<BR>첨부파일</TD>
        <TD colspan="3">
            <ANY:FILE id="any_attachFile" mode="C" policy="prior_search" />
        </TD>
    </TR>
    <TR>
        <TD>조사의뢰내역</TD>
        <TD colspan="3">
            <TEXTAREA id="PRSCH_REQ_CONTENTS" rows="5" maxByte="4000"></TEXTAREA>
        </TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="list" list="PriorSearchRequestListR.jsp"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
