<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>상표해외출원마스터</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_APPROVAL); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("REF_NO");
    addBind("RIGHT_DIV_NAME");
    addBind("COUNTRY_NAME");
    addBind("GRP_NO");
    addBind("JOB_MAN_NAME");
    addBind("EXAMREQ_YN");
    addBind("FIRSTAPP_DATE");
    addBind("CORGT_YN");
    addBind("CORGT_MAN");
    addBind("COSTSHARE_YN");
    addBind("COSTSHARE_RATIO");
    addBind("SPEC_PROD");
    addBind("KO_APP_TITLE");
    addBind("EN_APP_TITLE");
    addBind("OFFICE_NAME");
    addBind("OFFICE_SEND_DATE");
    addBind("OFFICE_REF_NO");
    addBind("OFFICE_JOB_MAN_NAME");
    addBind("OFFICE_CONTACT_YN");
    addBind("EXT_OFFICE_NAME");
    addBind("EXT_OFFICE_REF_NO");
    addBind("STATUS_NAME");
    addBind("STATUS_DATE");
    addBind("BUY_DATE");
    addBind("BUY_COUNTRY_NAME");
    addBind("PRIORITY_CLAIM_YN");
    addBind("PRIORITY_CLAIM_COUNTRY_NAME");
    addBind("APP_NO");
    addBind("APP_DATE");
    addBind("PUB_NO");
    addBind("PUB_DATE");
    addBind("NOTICE_NO");
    addBind("NOTICE_DATE");
    addBind("REG_NO");
    addBind("REG_DATE");
    addBind("ABD_YN");
    addBind("ABD_DATE");
    addBind("ABD_MEMO");
    addBind("ETC_MEMO");
    addBind("COSTSHARE_OWNER_NAME");
    addBind("DEPT_NAME");
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.tmark.extmaster.act.RetrieveTMarkExtMaster.do";
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
    window.location.href = "TMarkExtMasterU.jsp";
}

//갱신
function fnRenewal()
{
    if (!confirm("갱신처리하시겠습니까?")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.tmark.extmasterrenew.act.CreateTMarkExtMasterRenew.do";
    prx.addParam("REF_ID", parent.REF_ID);

    prx.onSuccess = function()
    {
        parent.REF_ID = this.result;
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        window.location.replace("TMarkExtMasterRD.jsp");
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

<TABLE border="0" cellspacing="1" cellpadding="2" class="main">
    <COLGROUP>
        <COL class="conthead" width="15%">
        <COL class="contdata" width="35%">
        <COL class="conthead" width="15%">
        <COL class="contdata" width="35%">
    </COLGROUP>
    <TR>
        <TD colspan="4" class="title_table">[해외출원품의 정보]</TD>
    </TR>
    <TR>
        <TD>해외품의번호</TD>
        <TD><SPAN id="GRP_NO"></SPAN></TD>
        <TD>선출원일</TD>
        <TD><ANY:SPAN id="FIRSTAPP_DATE" format="date" /></TD>
    </TR>
    <TR>
        <TD>선출원번호</TD>
        <TD colspan="3"><ANY:PRIORAPP id="any_priorAppList" /></TD>
    </TR>
    <TR>
        <TD>발명자</TD>
        <TD colspan="3">
            <ANY:INV id="any_inventorList" mode="R" />
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
        <TD colspan="3">
            <SPAN id="SPEC_PROD"></SPAN>
        </TD>
    </TR>
    <TR>
        <TD colspan="4" class="title_table">[해외마스터 정보]</TD>
    </TR>
    <TR>
        <TD>REF-NO</TD>
        <TD colspan="3"><SPAN id="REF_NO"></SPAN></TD>
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
        <TD>권리구분</TD>
        <TD><SPAN id="RIGHT_DIV_NAME"></SPAN></TD>
        <TD>출원국가</TD>
        <TD><SPAN id="COUNTRY_NAME"></SPAN></TD>
    </TR>
    <TR>
        <TD>건담당자</TD>
        <TD><SPAN id="JOB_MAN_NAME"></SPAN></TD>
        <TD>심사청구</TD>
        <TD><ANY:RADIO id="EXAMREQ_YN" codeData="{EXAMREQ_YN}" readOnly/></TD>
    </TR>
    <TR>
        <TD>부서</TD>
        <TD colspan="3"><SPAN id="DEPT_NAME"></SPAN></TD>
    </TR>
    <TR>
        <TD>공동권리 여부</TD>
        <TD><ANY:RADIO id="CORGT_YN" codeData="{YES_NO}" readOnly/></TD>
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
        <TD>국내사무소/의뢰일</TD>
        <TD><SPAN id="OFFICE_NAME"></SPAN>&nbsp;/&nbsp;<ANY:SPAN id="OFFICE_SEND_DATE" format="date" /></TD>
        <TD>국내사무소 REF</TD>
        <TD><SPAN id="OFFICE_REF_NO"></SPAN></TD>
    </TR>
    <TR>
        <TD>사무소담당자</TD>
        <TD><SPAN id="OFFICE_JOB_MAN_NAME"></SPAN></TD>
        <TD>사무소연계방법</TD>
        <TD><ANY:RADIO id="OFFICE_CONTACT_YN" codeData="{OFFICE_CONTACT_YN}" readOnly/></TD>
    </TR>
    <TR>
        <TD>해외사무소</TD>
        <TD><SPAN id="EXT_OFFICE_NAME"></SPAN></TD>
        <TD>해외사무소 REF</TD>
        <TD><SPAN id="EXT_OFFICE_REF_NO"></SPAN></TD>
    </TR>
    <TR>
        <TD>진행상태/일자</TD>
        <TD><SPAN id="STATUS_NAME"></SPAN>&nbsp;/&nbsp;<ANY:SPAN id="STATUS_DATE" format="date" /></TD>
        <TD>매입일자/국가</TD>
        <TD><ANY:SPAN id="BUY_DATE" format="date" />&nbsp;/&nbsp;<SPAN id="BUY_COUNTRY_NAME"></SPAN></TD>
    </TR>
    <TR>
        <TD>우선권주장여부</TD>
        <TD><ANY:RADIO id="PRIORITY_CLAIM_YN" codeData="{YES_NO}" readOnly/></TD>
        <TD>우선권주장국가</TD>
        <TD><SPAN id="PRIORITY_CLAIM_COUNTRY_NAME"></SPAN></TD>
    </TR>
    <TR>
        <TD>출원번호/일자</TD>
        <TD><SPAN id="APP_NO"></SPAN>&nbsp;/&nbsp;<ANY:SPAN id="APP_DATE" format="date" /></TD>
        <TD>공개번호/일자</TD>
        <TD><SPAN id="PUB_NO"></SPAN>&nbsp;/&nbsp;<ANY:SPAN id="PUB_DATE" format="date" /></TD>
    </TR>
    <TR>
        <TD>공고번호/일자</TD>
        <TD><SPAN id="NOTICE_NO"></SPAN>&nbsp;/&nbsp;<ANY:SPAN id="NOTICE_DATE" format="date" /></TD>
        <TD>등록번호/일자</TD>
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
        <TD>비고</TD>
        <TD colspan="3"><SPAN id="ETC_MEMO"></SPAN></TD>
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

</BODY>
</HTML>
