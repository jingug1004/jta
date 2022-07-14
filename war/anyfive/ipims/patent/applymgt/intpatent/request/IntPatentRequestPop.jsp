<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.share.workprocess.util.WorkProcessConst"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>직무발명신고현황</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_WORKPROC); %>
<% app.writeHTCImport(app.HTC_APPROVAL); %>
<ANY:WORKPROC id="wp" />
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("REF_NO");
    addBind("CRE_USER_NAME");
    addBind("CRE_DATE");
    addBind("RIGHT_DIV_NAME");
    addBind("KO_APP_TITLE");
    addBind("EN_APP_TITLE");
    addBind("APP_IMMED_YN");
    addBind("APP_IMMED_REASON");
    addBind("EXT_APP_NEED_YN");
    addBind("EXT_APP_NEED_REASON");
    addBind("CORGT_YN");
    addBind("CORGT_MAN");
    addBind("INV_COMPLETION");
    addBind("INV_ABSTRACT");
    addBind("DOC_FILE", "any_docFile");
    addBind("PRSCH_FILE", "any_prschFile");
    addBind("REMARK");
    addBind("EXAM_RESULT_OPINION");
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.intpatent.request.act.RetrieveIntPatentRequest.do";
    prx.addParam("REF_ID", parent.REF_ID);
    prx.checkData = ds_mainInfo;

    prx.onSuccess = function()
    {
        if (ds_mainInfo.value(0, "CRE_USER") == "<%= app.userInfo.getUserId() %>" && ds_mainInfo.value(0, "WRITE_END_YN") != "1") {
            window.location.replace("IntPatentRequestU.jsp");
            return;
        }

        cfShowObjects([tr_examResultOpinion], ds_mainInfo.value(0, "EXAM_RESULT") == "2");

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
        <TD>REF-NO</TD>
        <TD><SPAN id="REF_NO"></SPAN></TD>
        <TD>작성자</TD>
        <TD><SPAN id="CRE_USER_NAME"></SPAN></TD>
    </TR>
    <TR>
        <TD>권리구분</TD>
        <TD><SPAN id="RIGHT_DIV_NAME"></SPAN></TD>
        <TD>작성일</TD>
        <TD><ANY:SPAN format="date" id="CRE_DATE" /></TD>
    </TR>
    <TR>
        <TD>발명의 명칭(한)</TD>
        <TD colspan="3"><SPAN id="KO_APP_TITLE"></SPAN></TD>
    </TR>
    <TR>
        <TD>발명의 명칭(영)</TD>
        <TD colspan="3"><SPAN id="EN_APP_TITLE"></SPAN></TD>
    </TR>
    <TR>
        <TD>발명자</TD>
        <TD colspan="3">
            <ANY:INV id="any_inventorList" mode="R" />
        </TD>
    </TR>
    <TR>
        <TD>프로젝트</TD>
        <TD colspan="3">
            <ANY:PJT id="any_projectList" mode="R" />
        </TD>
    </TR>
    <TR>
        <TD>기술분류코드</TD>
        <TD>
            <ANY:MSEARCH id="any_techCodeList" mode="R"><COMMENT>
                codeColumn = "TECH_CODE";
                nameExpr = "[{#TECH_CODE}] {#TECH_PATHNAME}";
            </COMMENT></ANY:MSEARCH>
        </TD>
        <TD>관련제품코드</TD>
        <TD>
            <ANY:MSEARCH id="any_prodCodeList" mode="R"><COMMENT>
                codeColumn = "PROD_CODE";
                nameExpr = "[{#PROD_CODE}] {#PROD_NAME}";
            </COMMENT></ANY:MSEARCH>
        </TD>
    </TR>
    <TR>
        <TD>인용REF</TD>
        <TD colspan="3">
            <ANY:REFNO id="any_referRefNoList" mode="R" />
        </TD>
    </TR>
    <TR>
        <TD>출원의 완급</TD>
        <TD>
            <ANY:RADIO id="APP_IMMED_YN" codeData="{APP_IMMED_YN}" readOnly />
        </TD>
        <TD>출원긴급이유</TD>
        <TD><SPAN id="APP_IMMED_REASON"></SPAN></TD>
    </TR>
    <TR>
        <TD>해외출원필요성</TD>
        <TD>
            <ANY:RADIO id="EXT_APP_NEED_YN" codeData="{EXT_APP_NEED_YN}" readOnly />
        </TD>
        <TD>해외출원이유</TD>
        <TD><SPAN id="EXT_APP_NEED_REASON"></SPAN></TD>
    </TR>
    <TR>
        <TD>타사공동출원여부</TD>
        <TD>
            <ANY:RADIO id="CORGT_YN" codeData="{YES_NO}" readOnly />
        </TD>
        <TD>공동권리자</TD>
        <TD><SPAN id="CORGT_MAN"></SPAN></TD>
    </TR>
    <TR>
        <TD>발명의 완성도</TD>
        <TD colspan="3">
            <ANY:RADIO id="INV_COMPLETION" codeData="{INV_COMPLETION}" readOnly />
        </TD>
    </TR>
    <TR>
        <TD>초록정보</TD>
        <TD colspan="3"><SPAN id="INV_ABSTRACT"></SPAN></TD>
    </TR>
    <TR>
        <TD>직무발명신고서</TD>
        <TD colspan="3">
            <ANY:FILE id="any_docFile" mode="R" />
        </TD>
    </TR>
    <TR>
        <TD>선행기술자료</TD>
        <TD colspan="3">
            <ANY:FILE id="any_prschFile" mode="R" />
        </TD>
    </TR>
    <TR style="display:none;">
        <TD>선행조사</TD>
        <TD colspan="3">
            <ANY:PRSCH id="any_prschList" mode="R" />
        </TD>
    </TR>
    <TR>
        <TD>비고</TD>
        <TD colspan="3"><SPAN id="REMARK"></SPAN></TD>
    </TR>
    <TR id="tr_examResultOpinion" style="display:none;">
        <TD>출원전 포기<BR>검토의견</TD>
        <TD colspan="3"><SPAN id="EXAM_RESULT_OPINION"></SPAN></TD>
    </TR>
</TABLE>

<DIV class="button_area">
   <BUTTON auto="list" list="IntPatentRequestListR.jsp"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
