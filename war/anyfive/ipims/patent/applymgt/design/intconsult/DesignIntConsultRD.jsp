<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<%@page import="anyfive.ipims.share.workprocess.util.WorkProcessConst"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>디자인출원품의 상세</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_WORKPROC); %>
<% app.writeHTCImport(app.HTC_APPROVAL); %>
<ANY:WORKPROC id="wp" />
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("REF_NO");
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
    addBind("OFFICE_NAME");
    addBind("DESIGN_DIV_NAME");
    addBind("DESIGN_DESC");
    addBind("DESIGN_CREATE_CONTENTS");
    addBind("OFFICE_TRANS_CONTENTS");
    addBind("COSTSHARE_OWNER_NAME");
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
        //건담당자이고, 검토결과가 입력되어 있지 않는 경우 수정화면으로 이동
        if (ds_mainInfo.value(0, "JOB_MAN") == "<%= app.userInfo.getUserId() %>" && ds_mainInfo.value(0, "EXAM_RESULT") == "") {
            window.location.replace("DesignIntConsultU.jsp");
            return;
        }

        any_approval.reset();
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
    window.location.href = "DesignIntConsultU.jsp";
}
</SCRIPT>

<!-- 결재현황 로딩시 -->
<SCRIPT language="JScript" for="any_approval" event="OnLoad()">
    wp.reset(parent.REF_ID);
</SCRIPT>

<!-- 업무프로세스 로딩시 -->
<SCRIPT language="JScript" for="wp" event="OnLoad()">
    var isJobMan = (ds_mainInfo.value(0, "JOB_MAN") == "<%= app.userInfo.getUserId() %>");
    var actModify = "<%= WorkProcessConst.Action.MODIFY %>";

    cfShowObjects([btn_modify, btn_line], isJobMan && wp.avail([actModify]));
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
        <TD>
            <SPAN id="OUT_MODEL_NAME1"></SPAN>
        </TD>
        <TD>양산계획일</TD>
        <TD>
            <ANY:SPAN id="PROD_PLAN_DATE1" format="date"></ANY:SPAN>
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
        <TD>검토결과</TD>
        <TD>
            <ANY:RADIO id="EXAM_RESULT" codeData="{EXAM_RESULT}" readonly/>
        </TD>
        <TD>디자인 구분</TD>
        <TD>
            <SPAN id="DESIGN_DIV_NAME"></SPAN>
        </TD>
    </TR>
    <TR>
        <TD>양산계획일</TD>
        <TD>
            <ANY:SPAN id="PROD_PLAN_DATE2" format="date"></ANY:SPAN>
        </TD>
        <TD>출시모델명</TD>
        <TD>
            <SPAN id="OUT_MODEL_NAME2"></SPAN>
        </TD>
    </TR>
    <TR>
        <TD>검토결과의견</TD>
        <TD colspan=3>
            <SPAN id="EXAM_RESULT_OPINION"></SPAN>
        </TD>
    </TR>
    <TR>
        <TD>비용분담주체</TD>
        <TD><SPAN id="COSTSHARE_OWNER_NAME" ></SPAN></TD>
        <TD>출원인</TD>
        <TD>
            <ANY:MSEARCH id="any_appManCodeList" mode="R"><COMMENT>
                nameExpr = "[{#APP_MAN_CODE}] {#APP_MAN_NAME}";
            </COMMENT></ANY:MSEARCH>
        </TD>
    </TR>
    <TR>
        <TD>지정사무소 </TD>
        <TD>
            <SPAN id="OFFICE_NAME"></SPAN>
        </TD>
        <TD>사무소연계 여부</TD>
        <TD>
            <ANY:RADIO id="OFFICE_CONTACT_YN" codeData="{OFFICE_CONTACT_YN}" readonly/>
        </TD>
    </TR>
    <TR>
        <TD>사무소전달 내용</TD>
        <TD colspan=3>
            <SPAN id="OFFICE_TRANS_CONTENTS"></SPAN>
        </TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.modify").toHTML() %>" onClick="javascript:fnModify();" id="btn_modify" display="none"></BUTTON>
    <BUTTON auto="line" id="btn_line" display="none"></BUTTON>
    <BUTTON auto="list"></BUTTON>
</DIV>

<ANY:APPROVAL id="any_approval" code="D02"><COMMENT>
    reqUser = ds_mainInfo.value(0, "JOB_MAN");
    addKey("REF_ID", parent.REF_ID);
</COMMENT></ANY:APPROVAL>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
