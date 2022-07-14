<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>국내출원마스터 수정</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("REF_NO");
    addBind("JOB_MAN");
    addBind("PATTEAM_RCPT_DATE");
    addBind("RIGHT_DIV");
    addBind("STATUS");
    addBind("STATUS_DATE");
    addBind("EXAMREQ_YN");
    addBind("EXAMREQ_DATE");
    addBind("KO_APP_TITLE");
    addBind("EN_APP_TITLE");
    addBind("OFFICE_CODE");
    addBind("OFFICE_SEND_DATE");
    addBind("OFFICE_CONTACT_YN");
    addBind("OFFICE_REF_NO");
    addBind("OFFICE_JOB_MAN");
    addBind("APP_NO");
    addBind("APP_DATE");
    addBind("PUB_NO");
    addBind("PUB_DATE");
    addBind("NOTICE_NO");
    addBind("NOTICE_DATE");
    addBind("REG_NO");
    addBind("REG_DATE");
    addBind("IPC_CLS_CODE");
    addBind("FIRST_APP_NO");
    addBind("FIRST_APP_DATE");
    addBind("PRIORITY_REF_NO");
    addBind("UNION_REF_NO");
    addBind("CORGT_YN");
    addBind("CORGT_MAN");
    addBind("COSTSHARE_YN");
    addBind("COSTSHARE_RATIO");
    addBind("INDEP_CLAIM");
    addBind("SUBORD_CLAIM");
    addBind("PAPER_CNT");
    addBind("DRAWING_CNT");
    addBind("INV_GRADE");
    addBind("ACTR_SUM_TARGET_YN");
    addBind("APP_IMMED_YN");
    addBind("APP_IMMED_REASON");
    addBind("EXT_APP_NEED_YN");
    addBind("EXT_APP_NEED_REASON");
    addBind("EXT_APP_STATUS");
    addBind("BUY_YN");
    addBind("BUY_PLACE");
    addBind("BUY_DATE");
    addBind("APP_REWARD_GIVETARGET_YN");
    addBind("REG_REWARD_GIVETARGET_YN");
    addBind("ABD_YN");
    addBind("ABD_DATE");
    addBind("ABD_MEMO");
    addBind("KEY_PAT_YN");
    addBind("DISPUTE_PAT_YN");
    addBind("APPDOC_FILE", "any_appdocFile");
    addBind("ETC_MEMO");
    addBind("AB_ABSTRACT");
    addBind("AB_CLAIM");
    addBind("APP_REWARD_GIVE_AMOUNT");
    addBind("APP_REWARD_GIVE_DATE");
    addBind("REG_REWARD_GIVE_AMOUNT");
    addBind("REG_REWARD_GIVE_DATE");
    addBind("COSTSHARE_OWNER");
    addBind("REVIEW_RESULT");
    addBind("SALE_YN");
    addBind("SALE_PLACE");
    addBind("SALE_DATE");
    addBind("REVIEW_GRADE");
    addBind("LAST_GRADE");
    addBind("DEPT_CODE");
</COMMENT></ANY:DS>
<ANY:DS id="ds_extGroupList" />
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.intpatent.master.act.RetrieveIntPatentMaster.do";
    prx.addParam("REF_ID", parent.REF_ID);
    prx.checkData = ds_mainInfo;

    prx.onSuccess = function()
    {
        KO_APP_TITLE.focus();
        fnWriteExtGroups();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//해외출원품의번호 표시
function fnWriteExtGroups()
{
    var html = new Array();

    for (var i = 0; i < ds_extGroupList.rowCount; i++) {
        html.push('<A href="javascript:fnOpenExtGroup(' + i + ');">' + ds_extGroupList.value(i, "GRP_NO") + '</A>');
    }

    EXT_GROUPS.innerHTML = html.join(", ");
}

//해외출원품의서 팝업
function fnOpenExtGroup(idx)
{
    var win = new any.window(2);
    win.path = top.getRoot() + "/anyfive/ipims/patent/applymgt/extpatent/group/ExtPatentGroupRD.jsp";
    win.arg.GRP_ID = ds_extGroupList.value(idx, "GRP_ID");
    win.show();
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.intpatent.master.act.UpdateIntPatentMaster.do";
    prx.addParam("REF_ID", parent.REF_ID);
    prx.addData("ds_mainInfo");
    prx.addData("ds_inventorList");
    prx.addData("ds_projectList");
    prx.addData("ds_techCodeList");
    prx.addData("ds_prodCodeList");
    prx.addData("ds_prschList");
    prx.addData("ds_appdocFile");
    prx.addData("ds_appManCodeList");

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        window.location.replace("IntPatentMasterRD.jsp");
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
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

<!-- 사무소 변경시 -->
<SCRIPT language="JScript" for="OFFICE_CODE" event="OnChange()">
    OFFICE_JOB_MAN.codeData = "/applymgt/officeJobMan," + this.value;
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

<!-- 매입구분 변경시 -->
<SCRIPT language="JScript" for="BUY_YN" event="OnChange()">
    fnSetReqEnable(this, this.value == "1");
</SCRIPT>

<!-- 포기여부 변경시 -->
<SCRIPT language="JScript" for="ABD_YN" event="OnChange()">
    ABD_DATE.disabled = ABD_MEMO.disabled = (this.value != "1");
</SCRIPT>

<!-- 매각구분 변경시 -->
<SCRIPT language="JScript" for="SALE_YN" event="OnChange()">
    fnSetReqEnable(this, this.value == "1");
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
        <TD>담당자</TD>
        <TD><ANY:SELECT id="JOB_MAN" codeData="/common/jobMan,PAT" firstName="sel" /></TD>
    </TR>
    <TR>
        <TD>특허팀 접수일</TD>
        <TD><ANY:SPAN id="PATTEAM_RCPT_DATE" format="date" /></TD>
        <TD req="RIGHT_DIV">권리구분</TD>
        <TD><ANY:SELECT id="RIGHT_DIV" codeData="{RIGHT_DIV_PAT}" /></TD>
    </TR>
    <TR>
        <TD>현재상태/일자</TD>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD width="100%">
                        <ANY:SELECT id="STATUS" codeData="/applymgt/masterStatus,10,INT" firstName="sel" />
                    </TD>
                    <TD>&nbsp;</TD>
                    <TD>
                        <ANY:DATE id="STATUS_DATE" />
                    </TD>
                </TR>
            </TABLE>
        </TD>
        <TD>심사청구유무/일자</TD>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD width="100%">
                        <ANY:RADIO id="EXAMREQ_YN" codeData="{EXAMREQ_YN}" />
                    </TD>
                    <TD>&nbsp;</TD>
                    <TD>
                        <ANY:DATE id="EXAMREQ_DATE" />
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD req="KO_APP_TITLE">출원의 명칭(한)</TD>
        <TD colspan="3"><INPUT type="text" id="KO_APP_TITLE" maxByte="1000"></TD>
    </TR>
    <TR>
        <TD>출원의 명칭(영)</TD>
        <TD colspan="3"><INPUT type="text" id="EN_APP_TITLE" maxByte="1000"></TD>
    </TR>
    <TR>
        <TD>부서</TD>
        <TD colspan="3"><ANY:SEARCH id="DEPT_CODE" mode="U" style="width:40%"><COMMENT>
                win.path = top.getRoot() + "/anyfive/ipims/patent/common/popup/search/DeptCodeSearchListR.jsp";
                win.opt.width = 600;
                codeColumn = "DEPT_CODE";
                nameExpr = "[{#DEPT_CODE}] {#DEPT_NAME}";
            </COMMENT></ANY:SEARCH>
        </TD>
    </TR>
    <TR>
        <TD>특허사무소/발송일</TD>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD width="100%">
                        <ANY:SELECT id="OFFICE_CODE" codeData="/common/intOfficeCode" />
                    </TD>
                    <TD>&nbsp;</TD>
                    <TD>
                        <ANY:DATE id="OFFICE_SEND_DATE" />
                    </TD>
                </TR>
            </TABLE>
        </TD>
        <TD>사무소연계방법</TD>
        <TD><ANY:RADIO id="OFFICE_CONTACT_YN" codeData="{OFFICE_CONTACT_YN}" /></TD>
    </TR>
    <TR>
        <TD>사무소REF</TD>
        <TD><INPUT type="text" id="OFFICE_REF_NO" maxByte="30"></TD>
        <TD>사무소담당자</TD>
        <TD><ANY:SELECT id="OFFICE_JOB_MAN" firstName="sel" /></TD>
    </TR>
    <TR>
        <TD>출원번호/출원일</TD>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD width="100%">
                        <INPUT type="text" id="APP_NO" maxByte="30">
                    </TD>
                    <TD>&nbsp;</TD>
                    <TD>
                        <ANY:DATE id="APP_DATE" />
                    </TD>
                </TR>
            </TABLE>
        </TD>
        <TD>공개번호/공개일</TD>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD width="100%">
                        <INPUT type="text" id="PUB_NO" maxByte="30">
                    </TD>
                    <TD>&nbsp;</TD>
                    <TD>
                        <ANY:DATE id="PUB_DATE" />
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD>공고번호/공고일</TD>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD width="100%">
                        <INPUT type="text" id="NOTICE_NO" maxByte="30">
                    </TD>
                    <TD>&nbsp;</TD>
                    <TD>
                        <ANY:DATE id="NOTICE_DATE" />
                    </TD>
                </TR>
            </TABLE>
        </TD>
        <TD>등록번호/등록일</TD>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD width="100%">
                        <INPUT type="text" id="REG_NO" maxByte="30">
                    </TD>
                    <TD>&nbsp;</TD>
                    <TD>
                        <ANY:DATE id="REG_DATE" />
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD>IPC 분류 코드</TD>
        <TD colspan="3"><INPUT type="text" id="IPC_CLS_CODE" maxByte="100"></TD>
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
        <TD>선행조사</TD>
        <TD colspan="3">
            <ANY:PRSCH id="any_prschList" mode="U" />
        </TD>
    </TR>
    <TR>
        <TD>우선권 출원번호</TD>
        <TD><SPAN id="FIRST_APP_NO"></SPAN></TD>
        <TD>우선권 출원일</TD>
        <TD><ANY:SPAN id="FIRST_APP_DATE" format="date" /></TD>
    </TR>
    <TR>
        <TD>우선권 REF_NO</TD>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD noWrap>(진행)&nbsp;</TD>
                    <TD width="50%"><SPAN id="PRIORITY_REF_NO"></SPAN></TD>
                    <TD noWrap>&nbsp;(취하)&nbsp;</TD>
                    <TD width="50%">
                        <ANY:SELECT><COMMENT>
                            codeData="/applymgt/priorityAppRefNo," + parent.REF_ID;
                        </COMMENT></ANY:SELECT>
                    </TD>
                </TR>
            </TABLE>
        </TD>
        <TD>병합출원</TD>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD noWrap>(진행)&nbsp;</TD>
                    <TD width="50%"><SPAN id="UNION_REF_NO"></SPAN></TD>
                    <TD noWrap>&nbsp;(포기)&nbsp;</TD>
                    <TD width="50%">
                        <ANY:SELECT><COMMENT>
                            codeData="/applymgt/unionRefNo," + parent.REF_ID;
                        </COMMENT></ANY:SELECT>
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD>모출원</TD>
        <TD>
            <ANY:SELECT><COMMENT>
                codeData="/applymgt/divisionPriorRefId," + parent.REF_ID;
            </COMMENT></ANY:SELECT>
        </TD>
        <TD>분할출원</TD>
        <TD>
            <ANY:SELECT><COMMENT>
                codeData="/applymgt/divisionChildRefId," + parent.REF_ID;
            </COMMENT></ANY:SELECT>
        </TD>
    </TR>
    <TR>
        <TD>공동출원여부</TD>
        <TD>
            <ANY:RADIO id="CORGT_YN" codeData="{YES_NO}" reqTd="td_corgtMan" />
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
            <ANY:RADIO id="REVIEW_RESULT" codeData="{EXAM_RESULT_YN}"  />
        </TD>
    </TR>
    <TR>
        <TD>심의등급</TD>
        <TD>
            <ANY:RADIO id="REVIEW_GRADE" codeData="{LAST_GRADE}" />
        </TD>
        <TD>최종등급</TD>
        <TD>
            <ANY:RADIO id="LAST_GRADE" codeData="{LAST_GRADE}"  />
        </TD>
    </TR>
    <TR>
        <TD>독립항/종속항</TD>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD width="50%">
                        <INPUT type="text" id="INDEP_CLAIM" format="number" maxByte="2" style="text-align:center;">
                    </TD>
                    <TD>&nbsp;</TD>
                    <TD width="50%">
                        <INPUT type="text" id="SUBORD_CLAIM" format="number" maxByte="2" style="text-align:center;">
                    </TD>
                </TR>
            </TABLE>
        </TD>
        <TD>면수/도면수</TD>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD width="50%">
                        <INPUT type="text" id="PAPER_CNT" format="number" maxByte="3" style="text-align:center;">
                    </TD>
                    <TD>&nbsp;</TD>
                    <TD width="50%">
                        <INPUT type="text" id="DRAWING_CNT" format="number" maxByte="3" style="text-align:center;">
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD>발명평가등급</TD>
        <TD>
            <ANY:RADIO id="INV_GRADE" codeData="{INV_GRADE}" />
        </TD>
        <TD>실적집계대상여부</TD>
        <TD>
            <ANY:RADIO id="ACTR_SUM_TARGET_YN" codeData="{YES_NO}" />
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
        <TD req="APP_IMMED_YN">출원의 완급</TD>
        <TD>
            <ANY:RADIO id="APP_IMMED_YN" codeData="{APP_IMMED_YN}" reqTd="td_appImmedReason" />
        </TD>
        <TD id="td_appImmedReason" req="APP_IMMED_REASON" reqEnable="false">출원긴급이유</TD>
        <TD><INPUT type="text" id="APP_IMMED_REASON" maxByte="1000"></TD>
    </TR>
    <TR>
        <TD>해외출원필요성</TD>
        <TD>
            <ANY:RADIO id="EXT_APP_NEED_YN" codeData="{EXT_APP_NEED_YN}" />
        </TD>
        <TD>해외출원이유</TD>
        <TD><INPUT type="text" id="EXT_APP_NEED_REASON" maxByte="100"></TD>
    </TR>
    <TR>
        <TD>해외출원여부</TD>
        <TD><ANY:RADIO id="EXT_APP_STATUS" codeData="{EXT_APP_STATUS}" /></TD>
        <TD>해외출원품의번호</TD>
        <TD><SPAN id="EXT_GROUPS"></SPAN></TD>
    </TR>
    <TR>
        <TD req="BUY_YN">매입구분</TD>
        <TD><ANY:RADIO id="BUY_YN" codeData="{YES_NO}" reqTd="td_buyPlaceDate" /></TD>
        <TD id="td_buyPlaceDate" req="BUY_PLACE:매입처,BUY_DATE:매입일" reqEnable="false">매입처/매입일</TD>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD width="100%">
                        <INPUT type="text" id="BUY_PLACE" maxByte="50" disabled>
                    </TD>
                    <TD>&nbsp;</TD>
                    <TD>
                        <ANY:DATE id="BUY_DATE" disabled />
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
       <TD>매각구분</TD>
        <TD>
            <ANY:RADIO id="SALE_YN" codeData="{YES_NO}"  reqTd="td_salePlaceDate" />
        </TD>
        <TD id="td_salePlaceDate" req="SALE_PLACE:매각처,SALE_DATE:매긱일" reqEnable="false">매각처/매각일</TD>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD width="100%">
                        <INPUT type="text" id="SALE_PLACE" maxByte="50" disabled>
                    </TD>
                    <TD>&nbsp;</TD>
                    <TD>
                        <ANY:DATE id="SALE_DATE" disabled />
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>

    <TR>
        <TD>포기일/포기사유</TD>
        <TD colspan="3">
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD>
                        <ANY:RADIO id="ABD_YN" codeData="{ABD_YN}" />
                    </TD>
                    <TD>&nbsp;</TD>
                    <TD>
                        <ANY:DATE id="ABD_DATE" />
                    </TD>
                    <TD>&nbsp;</TD>
                    <TD width="100%">
                        <INPUT type="text" id="ABD_MEMO" maxByte="4000">
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD>핵심특허여부</TD>
        <TD><ANY:CHECK id="KEY_PAT_YN" text="핵심특허" /></TD>
        <TD>분쟁특허여부</TD>
        <TD><ANY:CHECK id="DISPUTE_PAT_YN" text="분쟁특허" /></TD>
    </TR>
    <TR>
        <TD>출원서파일</TD>
        <TD colspan="3">
            <ANY:FILE id="any_appdocFile" mode="U" policy="paper"/>
        </TD>
    </TR>
    <TR>
        <TD>비고</TD>
        <TD colspan="3"><TEXTAREA id="ETC_MEMO" rows="5" maxByte="4000"></TEXTAREA></TD>
    </TR>
    <TR>
        <TD>초록</TD>
        <TD colspan="3"><TEXTAREA id="AB_ABSTRACT" rows="5"></TEXTAREA></TD>
    </TR>
    <TR>
        <TD>청구범위</TD>
        <TD colspan="3"><TEXTAREA id="AB_CLAIM" rows="5"></TEXTAREA></TD>
    </TR>
    <TR>
        <TD colspan="2" class="title_table">[출원 보상금]</TD>
        <TD colspan="2" class="title_table">[등록 보상금]</TD>
    </TR>
    <TR>
        <TD>지급대상 여부</TD>
        <TD><ANY:CHECK id="APP_REWARD_GIVETARGET_YN" text="출원보상금 대상" /></TD>
        <TD>지급대상 여부</TD>
        <TD><ANY:CHECK id="REG_REWARD_GIVETARGET_YN" text="등록보상금 대상" /></TD>
    </TR>
    <TR>
        <TD>지급금액/지급일</TD>
        <TD><ANY:SPAN id="APP_REWARD_GIVE_AMOUNT" format="number2" />&nbsp;/&nbsp;<ANY:SPAN id="APP_REWARD_GIVE_DATE" format="date" /></TD>
        <TD>지급금액/지급일</TD>
        <TD><ANY:SPAN id="REG_REWARD_GIVE_AMOUNT" format="number2" />&nbsp;/&nbsp;<ANY:SPAN id="REG_REWARD_GIVE_DATE" format="date" /></TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.cancel").toHTML() %>" onClick="javascript:history.back();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="list"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
