<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>상표출원품의 수정</TITLE>
<% app.writeHTMLHeader(); %>
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
    addBind("OFFICE_CODE");
    addBind("TMARK_DIV");
    addBind("SPEC_PROD");
    addBind("COSTSHARE_OWNER");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    any_prschList.refId = parent.REF_ID;

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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.tmark.intconsult.act.UpdateTMarkIntConsult.do";
    prx.addParam("REF_ID", parent.REF_ID);
    prx.addData("ds_mainInfo");
    prx.addData("ds_tmarkClsList");
    prx.addData("ds_prschList");
    prx.addData("ds_appManCodeList");

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        window.location.replace("TMarkIntConsultRD.jsp");
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
    td_tmarkDiv.reqEnable = td_examResultOpinion.reqEnable = td_officeCode.reqEnable = td_officeContactYn.reqEnable = (this.value != "2");
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
        <TD>발명자</TD>
        <TD colspan="3">
            <ANY:INV id="any_inventorList" mode="R" />
        </TD>
    </TR>
    <TR>
        <TD>상표이미지</TD>
        <TD colspan="3">
            <ANY:FILE id="any_tmarkImgFile" mode="R" imageMode="true" />
        </TD>
    </TR>
    <TR>
        <TD>출시예정시기</TD>
        <TD>
            <SPAN id="OUT_PLAN_DATE"></SPAN>
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
        <TD>발명자 의뢰내용</TD>
        <TD colspan="3"><SPAN id="REQ_CONTENTS"></SPAN></TD>
    </TR>
    <TR>
        <TD colspan="4" class="title_table">[특허팀 검토 입력 사항]</TD>
    </TR>
    <TR>
        <TD req="EXAM_RESULT">검토결과</TD>
        <TD>
            <ANY:RADIO id="EXAM_RESULT" codeData="{EXAM_RESULT}" />
        </TD>
        <TD id="td_tmarkDiv" req="TMARK_DIV" reqEnable="false">상표구분</TD>
        <TD>
            <ANY:SELECT id="TMARK_DIV" codeData="{TMARK_DIV}" />
        </TD>
    </TR>
    <TR>
        <TD>상품류</TD>
        <TD colspan="3">
            <ANY:TMARKCLS id="any_tmarkClsList" mode="U" />
        </TD>
    </TR>
    <TR>
        <TD>지정상품</TD>
        <TD colspan="3"><TEXTAREA name="SPEC_PROD" rows="3"></TEXTAREA></TD>
    </TR>
    <TR>
        <TD id="td_examResultOpinion" req="EXAM_RESULT_OPINION" reqEnable="false">검토결과의견</TD>
        <TD colspan="3"><input type="text" name="EXAM_RESULT_OPINION" maxByte="1000"></TD>
    </TR>
    <TR>
        <TD id="td_officeCode" req="OFFICE_CODE" reqEnable="false">사무소 선택</TD>
        <TD>
            <ANY:SELECT id="OFFICE_CODE" codeData="/common/officeCode" firstName="all" />
        </TD>
        <TD id="td_officeContactYn" req="OFFICE_CONTACT_YN" reqEnable="false">사무소연계여부</TD>
        <TD>
            <ANY:RADIO id="OFFICE_CONTACT_YN" codeData="{OFFICE_CONTACT_YN}" />
        </TD>
    </TR>
    <TR>
        <TD>선행조사</TD>
        <TD colspan="3">
            <ANY:PRSCH id="any_prschList" mode="U" />
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
</TABLE>

<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();" id="btn_save"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.cancel").toHTML() %>" onClick="javascript:history.back();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="list"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
