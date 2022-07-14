<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>상표국내출원마스터</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_APPROVAL); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("REF_NO");
    addBind("JOB_MAN_NAME");
    addBind("STATUS_NAME");
    addBind("STATUS_DATE");
    addBind("KO_APP_TITLE");
    addBind("EN_APP_TITLE");
    addBind("SPEC_PROD");
    addBind("APPLY_MODEL_NAME");
    addBind("TMARK_DIV_NAME");
    addBind("OFFICE_NAME");
    addBind("OFFICE_JOB_MAN_NAME");
    addBind("OFFICE_CONTACT_YN");
    addBind("OFFICE_REF_NO");
    addBind("NOTICE_NO");
    addBind("NOTICE_DATE");
    addBind("PATTEAM_RCPT_DATE");
    addBind("OFFICE_SEND_DATE");
    addBind("OFFICE_RCPT_DATE");
    addBind("APP_NO");
    addBind("APP_DATE");
    addBind("PRIOR_APP_NO");
    addBind("PRIOR_APP_DATE");
    addBind("REG_NO");
    addBind("REG_DATE");
    addBind("RENEW_CNT");
    addBind("APP_IMMED_YN");
    addBind("APP_IMMED_REASON");
    addBind("TMARK_IMG_FILE", "any_tmarkImgFile");
    addBind("ETC_FILE", "any_etcFile");
    addBind("REQ_CONTENTS");
    addBind("APPDOC_FILE", "any_appdocFile");
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.tmark.intmaster.act.RetrieveTMarkIntMaster.do";
    prx.addParam("REF_ID", parent.REF_ID);
    prx.checkData = ds_mainInfo;

    prx.onSuccess = function()
    {
        cfShowObjects([btn_renewal, btn_line1], ds_mainInfo.value(0, "APP_NO") != "" && ds_mainInfo.value(0, "DIVISION_TYPE") != "R");
        cfShowObjects([btn_modify, btn_line2], <%= app.userInfo.isMenuGroupUser("TRA") %>);
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
    window.location.href = top.getRoot() + "/anyfive/ipims/patent/applymgt/tmark/intmaster/TMarkIntMasterU.jsp";
}

//갱신
function fnRenewal()
{
    if (!confirm("갱신처리하시겠습니까?")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.tmark.intmasterrenew.act.CreateTMarkIntMasterRenew.do";
    prx.addParam("REF_ID", parent.REF_ID);

    prx.onSuccess = function()
    {
        parent.REF_ID = this.result;
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        window.location.replace("TMarkIntMasterRD.jsp");
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
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
        <TD>상표명(한)</TD>
        <TD colspan="3"><SPAN id="KO_APP_TITLE"></SPAN></TD>
    </TR>
    <TR>
        <TD>상표명(영)</TD>
        <TD colspan="3"><SPAN id="EN_APP_TITLE"></SPAN></TD>
    </TR>
    <TR>
        <TD>발명자</TD>
        <TD colspan="3"><ANY:INV id="any_inventorList" mode="R" /></TD>
    </TR>
    <TR>
        <TD>상품류</TD>
        <TD colspan="3">
            <ANY:TMARKCLS id="any_tmarkClsList" mode="R" />
        </TD>
    </TR>
    <TR>
        <TD>부서</TD>
        <TD colspan="3"><SPAN id="DEPT_NAME"></SPAN></TD>
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
        <TD>지정상품</TD>
        <TD><SPAN id="SPEC_PROD"></SPAN></TD>
        <TD>적용모델</TD>
        <TD><SPAN id="APPLY_MODEL_NAME"></SPAN></TD>
    </TR>
    <TR>
        <TD>상표구분</TD>
        <TD><SPAN id="TMARK_DIV_NAME"></SPAN></TD>
        <TD>특허사무소 담당자</TD>
        <TD><SPAN id="OFFICE_JOB_MAN_NAME"></SPAN></TD>
    </TR>
    <TR>
        <TD>국내 특허사무소/담당자</TD>
        <TD><SPAN id="OFFICE_NAME"></SPAN>&nbsp;/&nbsp;<ANY:SPAN id="OFFICE_SEND_DATE" format="date" /></TD>
        <TD>사무소연계방법</TD>
        <TD><ANY:RADIO id="OFFICE_CONTACT_YN" codeData="{OFFICE_CONTACT_YN}" readOnly /></TD>
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
        <TD>원출원번호/일자</TD>
        <TD><SPAN id="PRIOR_APP_NO"></SPAN>&nbsp;/&nbsp;<ANY:SPAN id="PRIOR_APP_DATE" format="date" /></TD>
    </TR>
    <TR>
        <TD>등록번호/등록일자</TD>
        <TD><SPAN id="REG_NO"></SPAN>&nbsp;/&nbsp;<ANY:SPAN id="REG_DATE" format="date" /></TD>
        <TD>갱신횟수</TD>
        <TD><SPAN id="RENEW_CNT"></SPAN></TD>
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
        <TD>상표이미지</TD>
        <TD colspan="3">
            <ANY:FILE id="any_tmarkImgFile" mode="R" imageMode="true" />
        </TD>
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
        <TD>출원서파일</TD>
        <TD colspan="3">
            <ANY:FILE id="any_appdocFile" mode="R" />
        </TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="갱신" onClick="javascript:fnRenewal();" id="btn_renewal" display="none"></BUTTON>
    <BUTTON auto="line" id="btn_line1" display="none"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.modify").toHTML() %>" onClick="javascript:fnModify();" id="btn_modify" display="none"></BUTTON>
    <BUTTON auto="line" id="btn_line2" display="none"></BUTTON>
    <BUTTON auto="list"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</body>
</html>

