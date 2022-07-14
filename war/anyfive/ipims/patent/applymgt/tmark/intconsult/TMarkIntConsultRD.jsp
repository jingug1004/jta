<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<%@page import="anyfive.ipims.share.workprocess.util.WorkProcessConst"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>상표출원품의 상세</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_WORKPROC); %>
<% app.writeHTCImport(app.HTC_APPROVAL); %>
<ANY:WORKPROC id="wp" />
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("REF_NO");
    addBind("KO_APP_TITLE");
    addBind("EN_APP_TITLE");
    addBind("APP_IMMED_YN");
    addBind("APP_IMMED_REASON");
    addBind("JOB_MAN_NAME");
    addBind("TMARK_IMG_FILE", "any_tmarkImgFile");
    addBind("PATTEAM_RCPT_DATE");
    addBind("OUT_PLAN_DATE");
    addBind("APPLY_MODEL_NAME");
    addBind("ETC_FILE", "any_etcFile");
    addBind("REQ_CONTENTS");
    addBind("EXAM_RESULT");
    addBind("EXAM_RESULT_OPINION");
    addBind("OFFICE_CONTACT_YN");
    addBind("OFFICE_CODE_NAME");
    addBind("TMARK_DIV_NAME");
    addBind("SPEC_PROD");
    addBind("COSTSHARE_OWNER_NAME");
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.tmark.intconsult.act.RetrieveTMarkIntConsult.do";
    prx.addParam("REF_ID", parent.REF_ID);
    prx.checkData = ds_mainInfo;

    prx.onSuccess = function()
    {
        //건담당자이고, 검토결과가 입력되어 있지 않는 경우 수정화면으로 이동
        if (ds_mainInfo.value(0, "JOB_MAN") == "<%= app.userInfo.getUserId() %>" && ds_mainInfo.value(0, "EXAM_RESULT") == "") {
            window.location.replace("TMarkIntConsultU.jsp");
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
    window.location.href = "TMarkIntConsultU.jsp";
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
        <TD>상표명(한)</TD>
        <TD colspan="3"><SPAN id="KO_APP_TITLE"></SPAN></TD>
    </TR>
    <TR>
        <TD>상표명(영)</TD>
        <TD colspan="3"><SPAN id="EN_APP_TITLE"></SPAN></TD>
    </TR>
    <TR>
        <TD>창작자</TD>
        <TD colspan="3">
            <ANY:INV id="any_inventorList" mode="R" />
        </TD>
    </TR>
    <TR>
        <TD>상표이미지</TD>
        <TD colspan="3">
            <ANY:FILE id="any_tmarkImgFile" mode="R" imageMode="true" />
    </TR>
    <TR>
        <TD>출시예정시기</TD>
        <TD>
            <ANY:SPAN id="OUT_PLAN_DATE" format="date" />
        </TD>
        <TD>적용모델</TD>
        <TD><SPAN id="APPLY_MODEL_NAME"></SPAN></TD>
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
        <TD>기타자료</TD>
        <TD colspan="3">
            <ANY:FILE id="any_etcFile" mode="R" />
        </TD>
    </TR>
    <TR>
        <TD>창작자 의뢰내용</TD>
        <TD colspan="3"><SPAN id="REQ_CONTENTS"></SPAN></TD>
    </TR>
    <TR>
        <TD colspan="4" class="title_table">[특허팀 검토 입력 사항]</TD>
    </TR>
    <TR>
        <TD>검토결과</TD>
        <TD>
            <ANY:RADIO id="EXAM_RESULT" codeData="{EXAM_RESULT}" readOnly />
        </TD>
        <TD>상표구분</TD>
        <TD>
            <SPAN id="TMARK_DIV_NAME"></SPAN>
        </TD>
    </TR>
    <TR>
        <TD>상품류</TD>
        <TD colspan="3">
            <ANY:TMARKCLS id="any_tmarkClsList" mode="R" />
        </TD>
    </TR>
    <TR>
        <TD>지정상품</TD>
        <TD colspan="3"><SPAN id="SPEC_PROD"></SPAN></TD>
    </TR>
    <TR>
        <TD>검토결과의견</TD>
        <TD colspan="3"><SPAN id="EXAM_RESULT_OPINION"></SPAN></TD>
    </TR>
    <TR>
        <TD>사무소 선택</TD>
        <TD>
            <SPAN id="OFFICE_CODE_NAME"></SPAN>
        </TD>
        <TD>사무소연계여부</TD>
        <TD>
            <ANY:RADIO id="OFFICE_CONTACT_YN" codeData="{OFFICE_CONTACT_YN}" readOnly/>
        </TD>
    </TR>
    <TR>
        <TD>선행조사</TD>
        <TD colspan="3">
            <ANY:PRSCH id="any_prschList" mode="R" />
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
</TABLE>

<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.modify").toHTML() %>" onClick="javascript:fnModify();" id="btn_modify" display="none"></BUTTON>
    <BUTTON auto="line" id="btn_line" display="none"></BUTTON>
    <BUTTON auto="list"></BUTTON>
</DIV>

<ANY:APPROVAL id="any_approval" code="T02"><COMMENT>
    reqUser = ds_mainInfo.value(0, "JOB_MAN");
    addKey("REF_ID", parent.REF_ID);
</COMMENT></ANY:APPROVAL>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
