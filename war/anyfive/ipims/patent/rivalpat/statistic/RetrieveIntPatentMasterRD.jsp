<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>국내출원마스터</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("REF_NO");
    addBind("JOB_MAN_NAME");
    addBind("PATTEAM_RCPT_DATE");
    addBind("RIGHT_DIV_NAME");
    addBind("STATUS_NAME");
    addBind("STATUS_DATE");
    addBind("EXAMREQ_YN");
    addBind("EXAMREQ_DATE");
    addBind("KO_APP_TITLE");
    addBind("EN_APP_TITLE");
    addBind("OFFICE_NAME");
    addBind("OFFICE_SEND_DATE");
    addBind("OFFICE_CONTACT_YN");
    addBind("OFFICE_REF_NO");
    addBind("OFFICE_JOB_MAN_NAME");
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
    addBind("COSTSHARE_OWNER_NAME");
    addBind("REVIEW_RESULT");
    addBind("SALE_YN");
    addBind("SALE_PLACE");
    addBind("SALE_DATE");
    addBind("REVIEW_GRADE");
    addBind("LAST_GRADE");
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
        var isPatGroupUser = <%= app.userInfo.isMenuGroupUser("PAT") %>;

        if (ds_mainInfo.value(0, "EXT_APP_STATUS") == "9") {
            btn_extApplyAbd.text = "해외출원포기 내역";
        }

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
        <TD><SPAN id="JOB_MAN_NAME"></SPAN></TD>
    </TR>
    <TR>
        <TD>특허팀 접수일</TD>
        <TD><ANY:SPAN id="PATTEAM_RCPT_DATE" format="date" /></TD>
        <TD>권리구분</TD>
        <TD><SPAN id="RIGHT_DIV_NAME"></SPAN></TD>
    </TR>
    <TR>
        <TD>현재상태/일자</TD>
        <TD><SPAN id="STATUS_NAME"></SPAN>&nbsp;/&nbsp;<ANY:SPAN id="STATUS_DATE" format="date" /></TD>
        <TD>심사청구유무/일자</TD>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD width="100%"><ANY:RADIO id="EXAMREQ_YN" codeData="{EXAMREQ_YN}" readOnly /></TD>
                    <TD noWrap>&nbsp;/&nbsp;<ANY:SPAN id="EXAMREQ_DATE" format="date" style="width:70px; text-align:right;" /></TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD>출원의 명칭(한)</TD>
        <TD colspan="3"><SPAN id="KO_APP_TITLE"></SPAN></TD>
    </TR>
    <TR>
        <TD>출원의 명칭(영)</TD>
        <TD colspan="3"><SPAN id="EN_APP_TITLE"></SPAN></TD>
    </TR>
    <TR>
        <TD>특허사무소/발송일</TD>
        <TD><SPAN id="OFFICE_NAME"></SPAN>&nbsp;/&nbsp;<ANY:SPAN id="OFFICE_SEND_DATE" format="date" /></TD>
        <TD>사무소연계방법</TD>
        <TD><ANY:RADIO id="OFFICE_CONTACT_YN" codeData="{OFFICE_CONTACT_YN}" readOnly /></TD>
    </TR>
    <TR>
        <TD>사무소REF</TD>
        <TD><SPAN id="OFFICE_REF_NO"></SPAN></TD>
        <TD>사무소담당자</TD>
        <TD><SPAN id="OFFICE_JOB_MAN_NAME"></SPAN></TD>
    </TR>
    <TR>
        <TD>출원번호/출원일</TD>
        <TD><SPAN id="APP_NO"></SPAN>&nbsp;/&nbsp;<ANY:SPAN id="APP_DATE" format="date" /></TD>
        <TD>공개번호/공개일</TD>
        <TD><SPAN id="PUB_NO"></SPAN>&nbsp;/&nbsp;<ANY:SPAN id="PUB_DATE" format="date" /></TD>
    </TR>
    <TR>
        <TD>공고번호/공고일</TD>
        <TD><SPAN id="NOTICE_NO"></SPAN>&nbsp;/&nbsp;<ANY:SPAN id="NOTICE_DATE" format="date" /></TD>
        <TD>등록번호/등록일</TD>
        <TD><SPAN id="REG_NO"></SPAN>&nbsp;/&nbsp;<ANY:SPAN id="REG_DATE" format="date" /></TD>
    </TR>
    <TR>
        <TD>IPC 분류 코드</TD>
        <TD colspan="3"><SPAN id="IPC_CLS_CODE"></SPAN></TD>
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
        <TD>선행조사</TD>
        <TD colspan="3">
            <ANY:PRSCH id="any_prschList" mode="R" />
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
                            codeData = "/applymgt/priorityAppRefNo," + parent.REF_ID;
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
                            codeData = "/applymgt/unionRefNo," + parent.REF_ID;
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
            <ANY:RADIO id="CORGT_YN" codeData="{YES_NO}" readOnly />
        </TD>
        <TD>공동권리자</TD>
        <TD><SPAN id="CORGT_MAN"></SPAN></TD>
    </TR>
    <TR>
        <TD>비용분담여부</TD>
        <TD>
            <ANY:RADIO id="COSTSHARE_YN" codeData="{COSTSHARE_YN}" readOnly />
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
            <ANY:RADIO id="REVIEW_RESULT" codeData="{EXAM_RESULT_YN}"  readOnly/>
        </TD>
    </TR>
    <TR>
        <TD>심의등급</TD>
        <TD>
            <ANY:RADIO id="REVIEW_GRADE" codeData="{LAST_GRADE}" readOnly/>
        </TD>
        <TD>최종등급</TD>
        <TD>
            <ANY:RADIO id="LAST_GRADE" codeData="{LAST_GRADE}"  readOnly/>
        </TD>
    </TR>
    <TR>
        <TD>독립항/종속항</TD>
        <TD>
            <SPAN id="INDEP_CLAIM"></SPAN>&nbsp;/&nbsp;<SPAN id="SUBORD_CLAIM"></SPAN>
        </TD>
        <TD>면수/도면수</TD>
        <TD>
            <SPAN id="PAPER_CNT"></SPAN>&nbsp;/&nbsp;<SPAN id="DRAWING_CNT"></SPAN>
        </TD>
    </TR>
    <TR>
        <TD>발명평가등급</TD>
        <TD>
            <ANY:RADIO id="INV_GRADE" codeData="{INV_GRADE}" readOnly />
        </TD>
        <TD>실적집계대상여부</TD>
        <TD>
            <ANY:RADIO id="ACTR_SUM_TARGET_YN" codeData="{YES_NO}" readOnly />
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
        <TD>해외출원여부</TD>
        <TD><ANY:RADIO id="EXT_APP_STATUS" codeData="{EXT_APP_STATUS}" readOnly /></TD>
        <TD>해외출원품의번호</TD>
        <TD><SPAN id="EXT_GROUPS"></SPAN></TD>
    </TR>
    <TR>
        <TD>매입구분</TD>
        <TD><ANY:RADIO id="BUY_YN" codeData="{YES_NO}" readOnly /></TD>
        <TD>매입처/매입일</TD>
        <TD><SPAN id="BUY_PLACE"></SPAN>&nbsp;/&nbsp;<ANY:SPAN id="BUY_DATE" format="date" /></TD>
    </TR>
     <TR>
        <TD>매각구분</TD>
        <TD><ANY:RADIO id="SALE_YN" codeData="{YES_NO}" readOnly /></TD>
        <TD>매각처/매각일</TD>
        <TD><SPAN id="SALE_PLACE"></SPAN>&nbsp;/&nbsp;<ANY:SPAN id="SALE_DATE" format="date" /></TD>
    </TR>
    <TR>
        <TD>포기일/포기사유</TD>
        <TD colspan="3">
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD>
                        <ANY:RADIO id="ABD_YN" codeData="{ABD_YN}" readOnly />
                    </TD>
                    <TD noWrap>&nbsp;/&nbsp;</TD>
                    <TD noWrap>
                        <ANY:SPAN id="ABD_DATE" format="date" style="width:70px; text-align:center;" />
                    </TD>
                    <TD noWrap>&nbsp;/&nbsp;</TD>
                    <TD width="100%">
                        <SPAN id="ABD_MEMO"></SPAN>
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD>핵심특허여부</TD>
        <TD><ANY:CHECK id="KEY_PAT_YN" text="핵심특허" readOnly /></TD>
        <TD>분쟁특허여부</TD>
        <TD><ANY:CHECK id="DISPUTE_PAT_YN" text="분쟁특허" readOnly /></TD>
    </TR>
    <TR>
        <TD>출원서파일</TD>
        <TD colspan="3">
            <ANY:FILE id="any_appdocFile" mode="R" />
        </TD>
    </TR>
    <TR>
        <TD>비고</TD>
        <TD colspan="3"><SPAN id="ETC_MEMO"></SPAN></TD>
    </TR>
    <TR>
        <TD>초록</TD>
        <TD colspan="3"><SPAN id="AB_ABSTRACT"></SPAN></TD>
    </TR>
    <TR>
        <TD>청구범위</TD>
        <TD colspan="3"><SPAN id="AB_CLAIM"></SPAN></TD>
    </TR>
    <TR>
        <TD colspan="2" class="title_table">[출원 보상금]</TD>
        <TD colspan="2" class="title_table">[등록 보상금]</TD>
    </TR>
    <TR>
        <TD>지급대상 여부</TD>
        <TD><ANY:CHECK id="APP_REWARD_GIVETARGET_YN" text="출원보상금 대상" readOnly /></TD>
        <TD>지급대상 여부</TD>
        <TD><ANY:CHECK id="REG_REWARD_GIVETARGET_YN" text="등록보상금 대상" readOnly /></TD>
    </TR>
    <TR>
        <TD>지급금액/지급일</TD>
        <TD><ANY:SPAN id="APP_REWARD_GIVE_AMOUNT" format="number2" />&nbsp;/&nbsp;<ANY:SPAN id="APP_REWARD_GIVE_DATE" format="date" /></TD>
        <TD>지급금액/지급일</TD>
        <TD><ANY:SPAN id="REG_REWARD_GIVE_AMOUNT" format="number2" />&nbsp;/&nbsp;<ANY:SPAN id="REG_REWARD_GIVE_DATE" format="date" /></TD>
    </TR>
</TABLE>

<DIV class="button_area">
   <BUTTON auto="list"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
