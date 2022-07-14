<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.share.workprocess.util.WorkProcessConst"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>국내출원품의상세</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_WORKPROC); %>
<% app.writeHTCImport(app.HTC_APPROVAL); %>
<ANY:WORKPROC id="wp" />
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("REF_NO");
    addBind("PATTEAM_RCPT_DATE");
    addBind("KO_APP_TITLE");
    addBind("EN_APP_TITLE");
    addBind("INV_COMPLETION");
    addBind("APP_IMMED_YN");
    addBind("APP_IMMED_REASON");
    addBind("EXT_APP_NEED_YN");
    addBind("EXT_APP_NEED_REASON");
    addBind("DOC_FILE", "any_docFile");
    addBind("PRSCH_FILE", "any_prschFile");
    addBind("RIGHT_DIV_NAME");
    addBind("JOB_MAN_NAME");
    addBind("CORGT_YN");
    addBind("CORGT_MAN");
    addBind("COSTSHARE_YN");
    addBind("COSTSHARE_RATIO");
    addBind("EXAMREQ_YN");
    addBind("INV_GRADE");
    addBind("EXAM_RESULT");
    addBind("ACTR_SUM_TARGET_YN");
    addBind("EXAM_RESULT_OPINION");
    addBind("FIRM_HNAME");
    addBind("OFFICE_CONTACT_YN");
    addBind("REMARK");
    addBind("OFFICE_TRANS_CONTENTS");
    addBind("COSTSHARE_OWNER_NAME");
    addBind("REVIEW_RESULT");
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.intpatent.consult.act.RetrieveIntPatentConsult.do";
    prx.addParam("REF_ID", parent.REF_ID);
    prx.checkData = ds_mainInfo;

    prx.onSuccess = function()
    {
        //건담당자이고, 검토결과가 입력되어 있지 않는 경우 수정화면으로 이동
        if (ds_mainInfo.value(0, "JOB_MAN") == "<%= app.userInfo.getUserId() %>" && ds_mainInfo.value(0, "EXAM_RESULT") == "") {
            window.location.replace("IntPatentConsultU.jsp");
            return;
        }

        btn_intReq.disabled = (ds_mainInfo.value(0, "INT_REQ_EXIST") != "1");

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
    window.location.href = "IntPatentConsultU.jsp";
}

//발명평가표 팝업
function fnOpenInvEval(isEditable)
{
    var win = new any.window();
    win.path = top.getRoot() + "/anyfive/ipims/patent/applymgt/priorjob/evaluation/EvaluationE01.jsp";
    win.arg.REF_ID = parent.REF_ID;
    win.arg.isPatMode = true;
    win.arg.isPatEditable = isEditable;
    win.opt.width = 700;
    win.opt.height = 500;
    win.show();

    if (win.rtn == null) return;

    INV_GRADE.value = win.rtn.invGrade;

    return "OK";
}

//직무발명신고서 팝업
function fnOpenIntReq()
{
    var win = new any.window();
    win.path = top.getRoot() + "/anyfive/ipims/patent/applymgt/intpatent/request/IntPatentRequestRD.jsp";
    win.arg.REF_ID = parent.REF_ID;
    win.show();
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
        <TD>접수일</TD>
        <TD><ANY:SPAN id="PATTEAM_RCPT_DATE" format="date" /></TD>
    </TR>
    <TR>
        <TD colspan="4" class="title_table">[발명자 기본 입력사항]</TD>
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
        <TD>대표PJT</TD>
        <TD colspan="3">
            <ANY:PJT id="any_projectList" mode="R" />
        </TD>
    </TR>
    <TR>
        <TD>기술분류코드</TD>
        <TD>
            <ANY:MSEARCH id="any_techCodeList" mode="R"><COMMENT>
                nameExpr = "[{#TECH_CODE}] {#TECH_PATHNAME}";
            </COMMENT></ANY:MSEARCH>
        </TD>
        <TD>관련제품코드</TD>
        <TD>
            <ANY:MSEARCH id="any_prodCodeList" mode="R"><COMMENT>
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
        <TD>발명의 완성도</TD>
        <TD colspan="3">
            <ANY:RADIO id="INV_COMPLETION" codeData="{INV_COMPLETION}" readOnly />
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
    <TR>
        <TD colspan="4" class="title_table">[특허팀 추가 입력사항]</TD>
    </TR>
    <TR>
        <TD>권리구분</TD>
        <TD><SPAN id="RIGHT_DIV_NAME"></SPAN></TD>
        <TD>특허담당자</TD>
        <TD><SPAN id="JOB_MAN_NAME"></SPAN></TD>
    </TR>
    <TR>
        <TD>공동출원여부</TD>
        <TD>
            <ANY:RADIO id="CORGT_YN" codeData="{YES_NO}" readOnly/>
        </TD>
        <TD>공동권리자</TD>
        <TD><SPAN id="CORGT_MAN"></SPAN></TD>
    </TR>
    <TR>
        <TD>비용분담여부</TD>
        <TD>
            <ANY:RADIO id="COSTSHARE_YN" codeData="{COSTSHARE_YN}" readOnly/>
        </TD>
        <TD>비용분담율</TD>
        <TD><SPAN id="COSTSHARE_RATIO"></SPAN>&nbsp;%&nbsp;(당사분담율)</TD>
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
        <TD>국내출원 심의결과</TD>
        <TD colspan="3">
            <ANY:RADIO id="REVIEW_RESULT" codeData="{EXAM_RESULT_YN}" readOnly/>
        </TD>
    </TR>
    <TR>
        <TD>심사청구여부</TD>
        <TD>
            <ANY:RADIO id="EXAMREQ_YN" codeData="{EXAMREQ_YN}" readOnly />
        </TD>
        <TD>발명평가등급</TD>
        <TD>
            <ANY:RADIO id="INV_GRADE" codeData="{INV_GRADE}" readOnly />
        </TD>
    </TR>
    <TR>
        <TD>검토결과</TD>
        <TD>
            <ANY:RADIO id="EXAM_RESULT" codeData="{EXAM_RESULT}" readOnly />
        </TD>
        <TD>실적집계대상여부</TD>
        <TD>
            <ANY:RADIO id="ACTR_SUM_TARGET_YN" codeData="{YES_NO}" readOnly />
        </TD>
    </TR>
    <TR>
        <TD>검토결과의견</TD>
        <TD colspan="3"><SPAN id="EXAM_RESULT_OPINION"></SPAN></TD>
    </TR>
    <TR>
        <TD>사무소</TD>
        <TD><SPAN id="FIRM_HNAME"></SPAN></TD>
        <TD>사무소연계방법</TD>
        <TD>
            <ANY:RADIO id="OFFICE_CONTACT_YN" codeData="{OFFICE_CONTACT_YN}" readOnly />
        </TD>
    </TR>
    <TR>
        <TD>국내우선권번호</TD>
        <TD colspan="3">
            <ANY:REFNO id="any_priorRefNoList" mode="R" />
        </TD>
    </TR>
     <TR>
        <TD>병합출원</TD>
        <TD colspan="3">
            <ANY:REFNO id="any_unionRefNoList" mode="R" />
        </TD>
    </TR>
    <TR>
        <TD>선행조사</TD>
        <TD colspan="3">
            <ANY:PRSCH id="any_prschList" mode="R" />
        </TD>
    </TR>
    <TR>
        <TD>비고</TD>
        <TD colspan="3"><SPAN id="REMARK"></SPAN></TD>
    </TR>
    <TR>
        <TD>사무소전달내용</TD>
        <TD colspan="3"><SPAN id="OFFICE_TRANS_CONTENTS"></SPAN></TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="발명평가표" onClick="javascript:fnOpenInvEval();"></BUTTON>
    <BUTTON text="직무발명신고서" onClick="javascript:fnOpenIntReq();" id="btn_intReq" disabled></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.modify").toHTML() %>" onClick="javascript:fnModify();" id="btn_modify" display="none"></BUTTON>
    <BUTTON auto="line" id="btn_line" display="none"></BUTTON>
    <BUTTON auto="list"></BUTTON>
</DIV>

<ANY:APPROVAL id="any_approval" code="P02"><COMMENT>
    reqUser = ds_mainInfo.value(0, "JOB_MAN");
    addKey("REF_ID", parent.REF_ID);

    //결재없음/결재요청시 발명평가 작성
    check("NONE") = check("REQUEST") = function()
    {
        //검토결과가 출원의뢰인 경우에만 발명평가 작성
        if (EXAM_RESULT.value == "1") return (fnOpenInvEval(true) == "OK");

        return true;
    }
</COMMENT></ANY:APPROVAL>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
