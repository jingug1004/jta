<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>디자인국내출원마스터</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_APPROVAL); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("REF_NO");
    addBind("JOB_MAN_NAME");
    addBind("STATUS_NAME");
    addBind("STATUS_DATE");
    addBind("KO_APP_TITLE");
    addBind("EN_APP_TITLE");
    addBind("OUT_MODEL_NAME");
    addBind("PROD_PLAN_DATE");
    addBind("DESIGN_DIV_NAME");
    addBind("OFFICE_NAME");
    addBind("OFFICE_CONTACT_YN");
    addBind("OFFICE_REF_NO");
    addBind("NOTICE_NO");
    addBind("NOTICE_DATE");
    addBind("PATTEAM_RCPT_DATE");
    addBind("OFFICE_SEND_DATE");
    addBind("OFFICE_RCPT_DATE");
    addBind("APP_NO");
    addBind("APP_DATE");
    addBind("REG_NO");
    addBind("REG_DATE");
    addBind("APP_IMMED_YN");
    addBind("APP_IMMED_REASON");
    addBind("OFFICE_JOB_MAN");
    addBind("DESIGN_IMG_FILE", "any_designImgFile");
    addBind("ETC_FILE", "any_etcFile");
    addBind("APPDOC_FILE", "any_appdocFile");
    addBind("ETC_MEMO");
    addBind("APP_REWARD_GIVETARGET_YN");
    addBind("REG_REWARD_GIVETARGET_YN");
    addBind("APP_REWARD_GIVE_AMOUNT");
    addBind("APP_REWARD_GIVE_DATE");
    addBind("REG_REWARD_GIVE_AMOUNT");
    addBind("REG_REWARD_GIVE_DATE");
    addBind("COSTSHARE_OWNER_NAME");
    addBind("DEPT_NAME");
    addBind("ABD_YN");
    addBind("ABD_DATE");
    addBind("ABD_MEMO");
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.design.intmaster.act.RetrieveDesignIntMaster.do";
    prx.addParam("REF_ID", parent.REF_ID);
    prx.checkData = ds_mainInfo;

    prx.onSuccess = function()
    {
        var isJobMan = <%= app.userInfo.isMenuGroupUser("DES") %>;

        cfShowObjects([btn_modify, btn_line], isJobMan);
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
    window.location.href = top.getRoot() + "/anyfive/ipims/patent/applymgt/design/intmaster/DesignIntMasterU.jsp";
}
</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="1" cellpadding="2" width="100%" class="main">
    <COLGROUP>
        <COL class="conthead" width="15%">
        <COL class="contdata" width="35%">
        <COL class="conthead" width="15%">
        <COL class="contdata" width="35%">
    </COLGROUP>
    <TR>
        <TD>REF-NO</TD>
        <TD><SPAN id="REF_NO"></SPAN></TD>
        <TD>건담당자</TD>
        <TD><SPAN id="JOB_MAN_NAME"></SPAN></TD>
    </TR>
    <TR>
        <TD>현재상태/일자</TD>
        <TD colspan="3"><SPAN id="STATUS_NAME"></SPAN>&nbsp;/&nbsp;<ANY:SPAN id="STATUS_DATE" format="date" /></TD>
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
        <TD colspan="3"><ANY:INV id="any_inventorList" mode="R" /></TD>
    </TR>
    <TR>
        <TD>출시모델명</TD>
        <TD><SPAN id="OUT_MODEL_NAME"></SPAN></TD>
        <TD>양산계획일</TD>
        <TD><ANY:SPAN id="PROD_PLAN_DATE" format="date" /></TD>
    </TR>
    <TR>
        <TD>부서</TD>
        <TD colspan="3"><SPAN id="DEPT_NAME"></SPAN></TD>
    </TR>
    <TR>
        <TD>디자인구분</TD>
        <TD><SPAN id="DESIGN_DIV_NAME"></SPAN></TD>
        <TD>사무소연계방법</TD>
        <TD><ANY:RADIO id="OFFICE_CONTACT_YN" codeData="{OFFICE_CONTACT_YN}" readOnly /></TD>
    </TR>
    <TR>
        <TD>국내 사무소/발송일</TD>
        <TD><SPAN id="OFFICE_NAME"></SPAN>&nbsp;/&nbsp;<ANY:SPAN id="OFFICE_SEND_DATE" format="date" /></TD>
        <TD>사무소 담당자</TD>
        <TD><SPAN id="OFFICE_JOB_MAN"></SPAN></TD>
    </TR>
    <TR>
        <TD>국내 사무소 RefNo</TD>
        <TD><SPAN id="OFFICE_REF_NO"></SPAN></TD>
        <TD>공고번호/공고일자</TD>
        <TD><SPAN id="NOTICE_NO"></SPAN>&nbsp;/&nbsp;<ANY:SPAN id="NOTICE_DATE" format="date" /></TD>
    </TR>
    <TR>
        <TD>특허팀 접수일</TD>
        <TD><ANY:SPAN id="PATTEAM_RCPT_DATE" format="date" /></TD>
        <TD>사무소 접수일</TD>
        <TD><ANY:SPAN id="OFFICE_RCPT_DATE" format="date" /></TD>
    </TR>
    <TR>
        <TD>출원번호/출원일자</TD>
        <TD><SPAN id="APP_NO"></SPAN>&nbsp;/&nbsp;<ANY:SPAN id="APP_DATE" format="date" /></TD>
        <TD>등록번호/등록일자</TD>
        <TD><SPAN id="REG_NO"></SPAN>&nbsp;/&nbsp;<ANY:SPAN id="REG_DATE" format="date" /></TD>
    </TR>
    <TR>
        <TD>진행여부/포기일</TD>
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
        <TD>출원의 완급</TD>
        <TD><ANY:RADIO id="APP_IMMED_YN" codeData="{APP_IMMED_YN}" readOnly /></TD>
        <TD>출원긴급이유</TD>
        <TD><SPAN id="APP_IMMED_REASON"></SPAN></TD>
    </TR>
    <TR>
        <TD>디자인이미지</TD>
        <TD colspan="3">
            <ANY:FILE id="any_designImgFile" mode="R" imageMode="true" />
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
        <TD>6면도 및 사시도<BR>또는 의장출원품의서</TD>
        <TD colspan="3">
            <ANY:FILE id="any_etcFile" mode="R" />
        </TD>
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
    <BUTTON text="<%= app.message.get("btn.com.modify").toHTML() %>" onClick="javascript:fnModify();" id="btn_modify" display="none"></BUTTON>
    <BUTTON auto="line" id="btn_line" display="none"></BUTTON>
    <BUTTON auto="list"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>

