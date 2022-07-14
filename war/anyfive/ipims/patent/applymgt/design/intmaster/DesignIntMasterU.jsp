<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>디자인국내출원마스터 수정</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("REF_NO");
    addBind("JOB_MAN");
    addBind("STATUS");
    addBind("STATUS_DATE");
    addBind("KO_APP_TITLE");
    addBind("EN_APP_TITLE");
    addBind("OUT_MODEL_NAME");
    addBind("PROD_PLAN_DATE");
    addBind("DESIGN_DIV");
    addBind("OFFICE_CODE");
    addBind("OFFICE_JOB_MAN");
    addBind("OFFICE_CONTACT_YN");
    addBind("OFFICE_REF_NO");
    addBind("OFFICE_RCPT_DATE");
    addBind("OFFICE_SEND_DATE");
    addBind("NOTICE_NO");
    addBind("NOTICE_DATE");
    addBind("PATTEAM_RCPT_DATE");
    addBind("APP_NO");
    addBind("APP_DATE");
    addBind("REG_NO");
    addBind("REG_DATE");
    addBind("APP_IMMED_YN");
    addBind("APP_IMMED_REASON");
    addBind("DESIGN_IMG_FILE", "any_designImgFile");
    addBind("ETC_FILE", "any_etcFile");
    addBind("ETC_MEMO");
    addBind("APPDOC_FILE", "any_appdocFile");
    addBind("APP_REWARD_GIVETARGET_YN");
    addBind("REG_REWARD_GIVETARGET_YN");
    addBind("APP_REWARD_GIVE_AMOUNT");
    addBind("APP_REWARD_GIVE_DATE");
    addBind("REG_REWARD_GIVE_AMOUNT");
    addBind("REG_REWARD_GIVE_DATE");
    addBind("COSTSHARE_OWNER");
    addBind("DEPT_CODE");
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.design.intmaster.act.UpdateDesignIntMaster.do";
    prx.addParam("REF_ID", parent.REF_ID);
    prx.addData("ds_mainInfo");
    prx.addData("ds_inventorList");
    prx.addData("ds_designImgFile");
    prx.addData("ds_etcFile");
    prx.addData("ds_appdocFile");
    prx.addData("ds_appManCodeList");

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        fnDetail();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//취소
function fnDetail()
{
    window.location.replace("DesignIntMasterRD.jsp");
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

<!-- 포기여부 변경시 -->
<SCRIPT language="JScript" for="ABD_YN" event="OnChange()">
    ABD_DATE.disabled = ABD_MEMO.disabled = (this.value != "1");
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
        <TD><ANY:SELECT id="JOB_MAN" codeData="/common/jobMan,DES"/></TD>
    </TR>
    <TR>
        <TD>현재상태/일자</TD>
        <TD colspan="3">
            <ANY:SELECT id="STATUS" codeData="/applymgt/masterStatus,30,INT" firstName="sel"  style="width:200;" />&nbsp;
            <ANY:DATE id="STATUS_DATE" />
        </TD>
     </TR>
    <TR>
        <TD req="KO_APP_TITLE">디자인명(한)</TD>
        <TD colspan="3"><INPUT type="text" id="KO_APP_TITLE"></TD>
    </TR>
    <TR>
        <TD>디자인명(영)</TD>
        <TD colspan="3"><INPUT type="text" id="EN_APP_TITLE"></TD>
    </TR>
    <TR>
        <TD req="any_inventorList">발명자</TD>
        <TD colspan="3"><ANY:INV id="any_inventorList" mode="U" /></TD>
    </TR>
    <TR>
        <TD>출시모델명</TD>
        <TD><INPUT type="text" id="OUT_MODEL_NAME"></TD>
        <TD>양산계획일</TD>
        <TD><ANY:DATE id="PROD_PLAN_DATE" /></TD>
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
        <TD req="DESIGN_DIV">디자인 구분</TD>
        <TD><ANY:SELECT id="DESIGN_DIV" codeData="{DESIGN_DIV}" firstName="sel" /></TD>
        <TD req="OFFICE_CONTACT_YN">사무소연계방법</TD>
        <TD><ANY:RADIO id="OFFICE_CONTACT_YN" codeData="{OFFICE_CONTACT_YN}" /></TD>
    </TR>
    <TR>
        <TD req="OFFICE_CODE">국내사무소/발송일</TD>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD width="100%">
                        <ANY:SELECT id="OFFICE_CODE" codeData="/common/intOfficeCode" firstName="sel"/>
                    </TD>
                    <TD>&nbsp;</TD>
                    <TD>
                        <ANY:DATE id="OFFICE_SEND_DATE" />
                    </TD>
                </TR>
            </TABLE>
        </TD>
        <TD>사무소 담당자</TD>
        <TD><INPUT type="text" id="OFFICE_JOB_MAN" maxByte="10"></TD>
    </TR>
    <TR>
        <TD>국내 사무소 RefNo</TD>
        <TD><INPUT type="text" id="OFFICE_REF_NO"></TD>
        <TD>공고번호/일자</TD>
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
    </TR>
    <TR>
        <TD>특허팀 접수일</TD>
        <TD><ANY:DATE id="PATTEAM_RCPT_DATE" /></TD>
        <TD>사무소 접수일</TD>
        <TD><ANY:SPAN id="OFFICE_RCPT_DATE" format="date" /></TD>
    </TR>
    <TR>
        <TD>출원번호/일자</TD>
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
        <TD>등록번호/일자</TD>
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
        <TD>진행여부/포기일</TD>
        <TD colspan="3">
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD noWrap>
                        <ANY:RADIO id="ABD_YN" codeData="{ABD_YN}" />&nbsp;
                    </TD>
                    <TD noWrap>
                        <ANY:DATE id="ABD_DATE" />&nbsp;
                    </TD>
                    <TD width="100%">
                        <INPUT type="text" id="ABD_MEMO" maxByte="4000">
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD req="APP_IMMED_YN">출원의 완급</TD>
        <TD><ANY:RADIO id="APP_IMMED_YN" codeData="{APP_IMMED_YN}" reqTd="td_appImmedReason" /></TD>
        <TD id="td_appImmedReason" req="APP_IMMED_REASON" reqEnable="false">출원긴급이유</TD>
        <TD><INPUT type="text" id="APP_IMMED_REASON" maxByte="1000"></TD>
    </TR>
    <TR>
        <TD req="any_designImgFile">디자인이미지</TD>
        <TD colspan="3">
            <ANY:FILE id="any_designImgFile" mode="U" policy="design_image" imageMode="true" />
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
        <TD>6면도 및 사시도<BR>또는 의장출원품의서</TD>
        <TD colspan="3">
            <ANY:FILE id="any_etcFile" mode="U" policy="design_etc" />
        </TD>
    </TR>
    <TR>
        <TD>출원서 파일</TD>
        <TD colspan="3">
            <ANY:FILE id="any_appdocFile" mode="U" policy="paper" />
        </TD>
    </TR>
    <TR>
        <TD>비고</TD>
        <TD colspan="3"><TEXTAREA id="ETC_MEMO" rows="5" maxByte="4000"></TEXTAREA></TD>
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
    <BUTTON text="<%= app.message.get("btn.com.cancel").toHTML() %>" onClick="javascript:fnDetail();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="list"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
