<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>디자인출원품의 수정</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("REF_NO");
    addBind("PATTEAM_RCPT_DATE");
    addBind("KO_APP_TITLE");
    addBind("EN_APP_TITLE");
    addBind("OUT_MODEL_NAME1");
    addBind("OUT_MODEL_NAME2");
    addBind("PROD_PLAN_DATE1");
    addBind("PROD_PLAN_DATE2");
    addBind("APP_IMMED_YN");
    addBind("APP_IMMED_REASON");
    addBind("JOB_MAN_NAME");
    addBind("PATTEAM_RCPT_DATE");
    addBind("DESIGN_IMG_FILE", "any_designImgFile");
    addBind("ETC_FILE", "any_etcFile");
    addBind("EXAM_RESULT");
    addBind("EXAM_RESULT_OPINION");
    addBind("OFFICE_CONTACT_YN");
    addBind("OFFICE_CODE");
    addBind("DESIGN_DESC");
    addBind("DESIGN_CREATE_CONTENTS");
    addBind("OFFICE_TRANS_CONTENTS");
    addBind("DESIGN_DIV");
    addBind("COSTSHARE_OWNER");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    REF_NO.innerText = parent.REF_NO;

    fnRetrieve();
}

//조회
function fnRetrieve()
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.design.intconsult.act.RetrieveDesignIntConsult.do";
    prx.addParam("REF_ID", parent.REF_ID);

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

//저장
function fnSave()
{
    //필수항목 체크
    if (!cfCheckAllReqValid()) return;

    //저장 확인
    if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.design.intconsult.act.UpdateDesignIntConsult.do";
    prx.addParam("REF_ID", parent.REF_ID);
    prx.addData("ds_mainInfo");
    prx.addData("ds_appManCodeList");

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        window.location.replace("DesignIntConsultRD.jsp");
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
    //포기인 경우 필수체크 해제
    td_officeCode.reqEnable = td_officeContactYn.reqEnable = (this.value == "1");
</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="1" cellpadding="2" width="100%" class="main">
    <COLGROUP>
        <COL width="15%" class="conthead">
        <COL width="35%" class="contdata">
        <COL width="15%" class="conthead">
        <COL width="35%" class="contdata">
    </COLGROUP>
    <TR>
        <TD>REF_NO</TD>
        <TD><SPAN id="REF_NO"></SPAN></TD>
        <TD>담당자(접수일)</TD>
        <TD><SPAN id="JOB_MAN_NAME"></SPAN>(<ANY:SPAN id="PATTEAM_RCPT_DATE" format="date"></ANY:SPAN>)</TD>
    </TR>
    <TR>
        <TD>디자인명(한)</TD>
        <TD colspan="3"><SPAN id="KO_APP_TITLE"></SPAN></TD>
    </TR>
    <TR>
        <TD>디자인명(영)</TD>
        <TD colspan="3"><SPAN id="EN_APP_TITLE"></SPAN></TD>
    </TR>
    <TR>
        <TD>발명자</TD>
        <TD colspan="3">
            <ANY:INV id="any_inventorList" mode="R" />
        </TD>
    </TR>
    <TR>
        <TD>출원예상국가</TD>
        <TD colspan="3">
            <ANY:MSEARCH id="any_countryList" mode="R"><COMMENT>
                codeColumn = "COUNTRY_CODE";
                nameExpr = "[{#COUNTRY_CODE}] {#COUNTRY_NAME}";
            </COMMENT></ANY:MSEARCH>
        </TD>
    </TR>
    <TR>
        <TD>디자인이미지</TD>
        <TD colspan="3">
            <ANY:FILE id="any_designImgFile" mode="R" imageMode="true" />
        </TD>
    </TR>
    <TR>
        <TD>6면도 및 사시도<BR>또는 의장출원품의서</TD>
        <TD colspan="3">
            <ANY:FILE id="any_etcFile" mode="R" />
        </TD>
    </TR>
    <TR>
        <TD>출시모델명</TD>
        <TD><SPAN id="OUT_MODEL_NAME1"></SPAN></TD>
        <TD>양산계획일</TD>
        <TD><ANY:SPAN id="PROD_PLAN_DATE1" format="date" /></TD>
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
        <TD>디자인 설명</TD>
        <TD colspan="3"><SPAN id="DESIGN_DESC"></SPAN></TD>
    </TR>
    <TR>
        <TD>디자인 창작내용</TD>
        <TD colspan="3"><SPAN id="DESIGN_CREATE_CONTENTS"></SPAN></TD>
    </TR>
    <TR>
        <TD colspan="4" class="title_table">[특허팀 검 토 입력 사항]</TD>
    </TR>
    <TR>
        <TD req="EXAM_RESULT">검토결과</TD>
        <TD>
            <ANY:RADIO id="EXAM_RESULT" codeData="{EXAM_RESULT}" />
        </TD>
        <TD req="DESIGN_DIV">디자인 구분</TD>
        <TD>
            <ANY:SELECT id="DESIGN_DIV" codeData="{DESIGN_DIV}" />
        </TD>
    </TR>
    <TR>
        <TD>양산계획일</TD>
        <TD>
            <ANY:DATE id="PROD_PLAN_DATE2" />
        </TD>
        <TD>출시모델명</TD>
        <TD>
            <INPUT type="text" id="OUT_MODEL_NAME2" maxByte="30">
        </TD>
    </TR>
    <TR>
        <TD>검토결과의견</TD>
        <TD colspan="3">
            <INPUT type="text" id="EXAM_RESULT_OPINION">
        </TD>
    </TR>
    <TR>
        <TD req="COSTSHARE_OWNER">비용분담주체</TD>
        <TD>
            <ANY:SELECT id="COSTSHARE_OWNER" codeData="/common/inAppManCode"  firstName="sel" />
        </TD>
        <TD req="any_appManCodeList">출원인</TD>
        <TD>
           <ANY:MSEARCH id="any_appManCodeList" mode="C"><COMMENT>
                win.path = top.getRoot() + "/anyfive/ipims/patent/common/popup/search/ApplicantLSearchListR.jsp";
                codeColumn = "APP_MAN_CODE";
                nameExpr = "[{#APP_MAN_CODE}] {#APP_MAN_NAME}";
                size = 6;
            </COMMENT></ANY:MSEARCH>
        </TD>
    </TR>
    <TR>
        <TD id="td_officeCode" req="OFFICE_CODE" reqEnable="false">사무소 선택 </TD>
        <TD>
            <ANY:SELECT id="OFFICE_CODE" codeData="/common/officeCode" firstName="all" />
        </TD>
        <TD id="td_officeContactYn" req="OFFICE_CONTACT_YN" reqEnable="false">사무소연계 여부</TD>
        <TD>
            <ANY:RADIO id="OFFICE_CONTACT_YN" codeData="{OFFICE_CONTACT_YN}" />
        </TD>
    </TR>
    <TR>
        <TD>사무소전달 내용</TD>
        <TD colspan="3">
            <TEXTAREA id="OFFICE_TRANS_CONTENTS" rows="5" maxByte="4000"></TEXTAREA>
        </TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();" id="btn_save"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.cancel").toHTML() %>" onClick="javascript:history.back();"></BUTTON>
    <BUTTON auto="line" id="btn_line" display="none"></BUTTON>
    <BUTTON auto="list"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
