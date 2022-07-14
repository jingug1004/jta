<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>국내출원품의 수정</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_APPROVAL); %>
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
    addBind("RIGHT_DIV");
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
    addBind("OFFICE_CODE");
    addBind("OFFICE_CONTACT_YN");
    addBind("REMARK");
    addBind("OFFICE_TRANS_CONTENTS");
    addBind("COSTSHARE_OWNER");
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
        btn_intReq.disabled = (ds_mainInfo.value(0, "INT_REQ_EXIST") != "1");
        KO_APP_TITLE.focus();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//저장
function fnSave(isFileUploaded)
{
    //필수항목 체크
    if (!cfCheckAllReqValid()) return;

    //발명자 목록 체크
    if (!any_inventorList.valid) return;

    if (isFileUploaded != true) {
        if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;
        cfFileUpload("fnSave(true);");
        return;
    }
    var prx = new any.proxy();

    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.intpatent.consult.act.UpdateIntPatentConsult.do";
    prx.addParam("REF_ID", parent.REF_ID);
    prx.addData("ds_mainInfo");
    prx.addData("ds_inventorList");
    prx.addData("ds_techCodeList");
    prx.addData("ds_prodCodeList");
    prx.addData("ds_projectList");
    prx.addData("ds_referRefNoList");
    prx.addData("ds_priorRefNoList");
    prx.addData("ds_unionRefNoList");
    prx.addData("ds_prschList");
    prx.addData("ds_docFile");
    prx.addData("ds_prschFile");
    prx.addData("ds_appManCodeList");
    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        window.location.replace("IntPatentConsultRD.jsp");
    }

    prx.onFail = function()
    {
        this.error.show();
    }
    prx.execute();
}

//직무발명신고서 팝업
function fnOpenIntReq()
{
    var win = new any.window();
    win.path = top.getRoot() + "/anyfive/ipims/patent/applymgt/intpatent/request/IntPatentRequestRD.jsp";
    win.arg.REF_ID = parent.REF_ID;
    win.show();
}

//국내우선권번호/병합출원 추가시
function fnRefNoAdded(refId)
{
    any_inventorList.addList(refId);
    any_projectList.addList(refId);
    any_techCodeList.addList([{ name:"REF_ID", value:refId }], top.getRoot() + "/anyfive.ipims.patent.common.mapping.tech.act.RetrieveTechCodeList.do");
}

//필수여부 설정
function fnSetReqEnable(obj, enable)
{
    var td = document.getElementById(obj.reqTd);

    td.reqEnable = enable;

    for (var i = 0; i < td.req.length; i++) {
        document.getElementById(td.req[i].ctrl).disabled = !enable;
    }
}
</SCRIPT>

<!-- 출원의 완급 변경시 -->
<SCRIPT language="JScript" for="APP_IMMED_YN" event="OnChange()">
    fnSetReqEnable(this, this.value == "1");
</SCRIPT>

<!-- 해외출원필요성 변경시 -->
<SCRIPT language="JScript" for="EXT_APP_NEED_YN" event="OnChange()">
    EXT_APP_NEED_REASON.disabled = (this.value != "1");
</SCRIPT>

<!-- 공동출원여부 변경시 -->
<SCRIPT language="JScript" for="CORGT_YN" event="OnChange()">
    fnSetReqEnable(this, this.value == "1");
</SCRIPT>

<!-- 비용분담여부 변경시 -->
<SCRIPT language="JScript" for="COSTSHARE_YN" event="OnChange()">
    fnSetReqEnable(this, this.value == "1");
</SCRIPT>

<!-- 검토결과 변경시 -->
<SCRIPT language="JScript" for="EXAM_RESULT" event="OnChange()">
    //보완요청이 아닌 경우에만 실적집계대상여부 Yes
    ACTR_SUM_TARGET_YN.value = (this.value == "0" ? "0" : "1");

    //출원의뢰인 경우에만 필수체크
    td_examreqYn.reqEnable = td_officeCode.reqEnable = td_officeContactYn.reqEnable = (this.value == "1");
</SCRIPT>

<!-- 국내우선권번호 추가시 -->
<SCRIPT language="JScript" for="any_priorRefNoList" event="OnAddRow()">
    fnRefNoAdded(event.REF_ID);
</SCRIPT>

<!-- 병합출원 추가시 -->
<SCRIPT language="JScript" for="any_unionRefNoList" event="OnAddRow()">
    fnRefNoAdded(event.REF_ID);
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
        <TD req="KO_APP_TITLE">발명의 명칭(한)</TD>
        <TD colspan="3"><INPUT type="text" id="KO_APP_TITLE" maxByte="1000"></TD>
    </TR>
    <TR>
        <TD>발명의 명칭(영)</TD>
        <TD colspan="3"><INPUT type="text" id="EN_APP_TITLE" maxByte="1000"></TD>
    </TR>
    <TR>
        <TD req="any_inventorList">발명자</TD>
        <TD colspan="3">
            <ANY:INV id="any_inventorList" mode="U" />
        </TD>
    </TR>
    <TR>
        <TD>대표PJT</TD>
        <TD colspan="3">
            <ANY:PJT id="any_projectList" mode="U" />
        </TD>
    </TR>
    <TR>
        <TD>기술분류코드</TD>
        <TD>
            <ANY:MSEARCH id="any_techCodeList" mode="U"><COMMENT>
                win.path = top.getRoot() + "/anyfive/ipims/patent/common/popup/search/TechCodeSearchTreeR.jsp";
                codeColumn = "TECH_CODE";
                nameExpr = "[{#TECH_CODE}] {#TECH_PATHNAME}";
                size = 6;
            </COMMENT></ANY:MSEARCH>
        </TD>
        <TD>관련제품코드</TD>
        <TD>
            <ANY:MSEARCH id="any_prodCodeList" mode="U"><COMMENT>
                win.path = top.getRoot() + "/anyfive/ipims/patent/common/popup/search/ProdCodeSearchListR.jsp";
                win.opt.width = 650;
                codeColumn = "PROD_CODE";
                nameExpr = "[{#PROD_CODE}] {#PROD_NAME}";
                size = 6;
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
            <ANY:RADIO id="INV_COMPLETION" codeData="{INV_COMPLETION}" readOnly/>
        </TD>
    </TR>
    <TR>
        <TD req="APP_IMMED_YN">출원의 완급</TD>
        <TD>
            <ANY:RADIO id="APP_IMMED_YN" codeData="{APP_IMMED_YN}" reqTd="td_appImmedReason"/>
        </TD>
        <TD id="td_appImmedReason" req="APP_IMMED_REASON" reqEnable="false">출원긴급이유</TD>
        <TD><INPUT type="text" id="APP_IMMED_REASON" maxByte="1000" disabled></TD>
    </TR>
    <TR>
        <TD>해외출원필요성</TD>
        <TD>
            <ANY:RADIO id="EXT_APP_NEED_YN" codeData="{EXT_APP_NEED_YN}" />
        </TD>
        <TD>해외출원이유</TD>
        <TD><INPUT type="text" id="EXT_APP_NEED_REASON" maxByte="100" disabled></TD>
    </TR>
    <TR>
        <TD>직무발명신고서</TD>
        <TD colspan="3">
            <ANY:FILE id="any_docFile" mode="U" policy="invdoc" />
        </TD>
    </TR>
    <TR>
        <TD>선행기술자료</TD>
        <TD colspan="3">
            <ANY:FILE id="any_prschFile" mode="U" policy="prsch" />
        </TD>
    </TR>
    <TR>
        <TD colspan="4" class="title_table">[특허팀 추가 입력사항]</TD>
    </TR>
    <TR>
        <TD req="RIGHT_DIV">권리구분</TD>
        <TD>
            <ANY:SELECT id="RIGHT_DIV" codeData="{RIGHT_DIV_PAT}" />
        </TD>
        <TD>특허담당자</TD>
        <TD>
            <SPAN id="JOB_MAN_NAME"></SPAN>
        </TD>
    </TR>
    <TR>
        <TD req="CORGT_YN">공동출원여부</TD>
        <TD>
            <ANY:RADIO id="CORGT_YN" codeData="{YES_NO}" reqTd="td_corgtMan"/>
        </TD>
        <TD id="td_corgtMan" req="CORGT_MAN" reqEnable="false">공동권리자</TD>
        <TD><INPUT type="text" id="CORGT_MAN" maxByte="100" disabled></TD>
    </TR>
    <TR>
        <TD>비용분담여부</TD>
        <TD>
            <ANY:RADIO id="COSTSHARE_YN" codeData="{COSTSHARE_YN}" reqTd="td_costshareRatio" />
        </TD>
        <TD id="td_costshareRatio" req="COSTSHARE_RATIO" reqEnable="false">비용분담율</TD>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD width="100%">
                        <INPUT type="text" id="COSTSHARE_RATIO" format="number" maxByte="3" disabled>
                    </TD>
                    <TD noWrap>&nbsp;%&nbsp;(당사분담율)</TD>
                </TR>
            </TABLE>
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
        <TD req="REVIEW_RESULT">국내출원 심의결과</TD>
        <TD colspan="3">
            <ANY:RADIO id="REVIEW_RESULT" codeData="{EXAM_RESULT_YN}"  value="1"/>
        </TD>
    </TR>
    <TR>
        <TD id="td_examreqYn" req="EXAMREQ_YN" reqEnable="false">심사청구여부</TD>
        <TD>
            <ANY:RADIO id="EXAMREQ_YN" codeData="{EXAMREQ_YN}" />
        </TD>
        <TD>발명평가등급</TD>
        <TD>
            <ANY:RADIO id="INV_GRADE" codeData="{INV_GRADE}" readOnly />
        </TD>
    </TR>
    <TR>
        <TD req="EXAM_RESULT">검토결과</TD>
        <TD>
            <ANY:RADIO id="EXAM_RESULT" codeData="{EXAM_RESULT}" />
        </TD>
        <TD>실적집계대상여부</TD>
        <TD>
            <ANY:RADIO id="ACTR_SUM_TARGET_YN" codeData="{YES_NO}" readOnly />
        </TD>
    </TR>
    <TR>
        <TD>검토결과의견</TD>
        <TD colspan="3"><TEXTAREA id="EXAM_RESULT_OPINION" rows="3" maxByte="4000"></TEXTAREA></TD>
    </TR>
    <TR>
        <TD id="td_officeCode" req="OFFICE_CODE" reqEnable="false">사무소 선택</TD>
        <TD>
            <ANY:SELECT id="OFFICE_CODE" codeData="/common/intOfficeCode" firstName="sel" />
        </TD>
        <TD id="td_officeContactYn" req="OFFICE_CONTACT_YN" reqEnable="false">사무소연계방법</TD>
        <TD>
            <ANY:RADIO id="OFFICE_CONTACT_YN" codeData="{OFFICE_CONTACT_YN}"  />
        </TD>
    </TR>
    <TR>
        <TD>국내우선권번호</TD>
        <TD colspan="3">
            <ANY:REFNO id="any_priorRefNoList" mode="U" rightDiv="10,20" inoutDiv="INT" appNoNotNull="1" />
        </TD>
    </TR>
     <TR>
        <TD>병합출원</TD>
        <TD colspan="3">
            <ANY:REFNO id="any_unionRefNoList" mode="U" rightDiv="10,20" inoutDiv="INT" />
        </TD>
    </TR>
    <TR>
        <TD>선행조사</TD>
        <TD colspan="3">
            <ANY:PRSCH id="any_prschList" mode="U" />
        </TD>
    </TR>
    <TR>
        <TD>비고</TD>
        <TD colspan="3"><TEXTAREA id="REMARK" rows="5" maxByte="4000"></TEXTAREA></TD>
    </TR>
    <TR>
        <TD>사무소전달내용</TD>
        <TD colspan="3"><TEXTAREA id="OFFICE_TRANS_CONTENTS" rows="5" maxByte="4000"></TEXTAREA></TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="직무발명신고서" onClick="javascript:fnOpenIntReq();" id="btn_intReq" disabled></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.cancel").toHTML() %>" onClick="javascript:history.back();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="list"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
