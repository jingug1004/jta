<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>해외출원마스터</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("GRP_NO");
    addBind("FIRSTAPP_DATE");
    addBind("REF_NO");
    addBind("RIGHT_DIV_NAME");
    addBind("COUNTRY_CODE_NAME");
    addBind("JOB_MAN_NAME");
    addBind("EXAMREQ_YN");
    addBind("KO_APP_TITLE");
    addBind("EN_APP_TITLE");
    addBind("CORGT_YN");
    addBind("CORGT_MAN");
    addBind("COSTSHARE_YN");
    addBind("COSTSHARE_RATIO");
    addBind("DIVISION_PRIOR_REF_NO");
    addBind("DIVISION_TYPE_NAME");
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
    addBind("IPC_CLS_CODE");
    addBind("ABD_YN");
    addBind("ABD_DATE");
    addBind("ABD_MEMO");
    addBind("ETC_MEMO");
    addBind("AB_ABSTRACT");
    addBind("AB_CLAIM");
    addBind("SALE_YN");
    addBind("SALE_PLACE");
    addBind("SALE_DATE");
    addBind("PAT_APP_NO");
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.extpatent.master.act.RetrieveExtPatentMaster.do";
    prx.addParam("REF_ID", parent.REF_ID);
    prx.checkData = ds_mainInfo;

    prx.onSuccess = function()
    {
        <% if (app.userInfo.isMenuGroupUser("PAT") == true) { %>
        cfShowObjects([btn_epPctOL], (ds_mainInfo.value(0, "COUNTRY_CODE") == "EP" || ds_mainInfo.value(0, "COUNTRY_CODE") == "PC"));
        cfShowObjects([btn_line1], btn_epPctOL.display != "none");
        <% } %>
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
    window.location.href = "ExtPatentMasterU.jsp";
}

//계속/분할
function fnConDivOL()
{
    var path = top.getRoot() + "/anyfive/ipims/patent/applymgt/extpatent/condiv/ExtPatentConDivC.jsp";

    if (any.docPageType == "tabframe") {
        parent.location.href = path;
    } else {
        window.location.href = path;
    }
}

//EP/PCT 지정
function fnEpPctOL()
{
    var path = top.getRoot() + "/anyfive/ipims/patent/applymgt/extpatent/eppct/ExtPatentEpPctC.jsp";

    if (any.docPageType == "tabframe") {
        parent.location.href = path;
    } else {
        window.location.href = path;
    }
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
        <TD colspan="4" class="title_table">[해외 출원품의 정보]</TD>
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
        <TD colspan="4" class="title_table">[해외 마스터 정보]</TD>
    </TR>
    <TR>
        <TD>REF-NO</TD>
        <TD colspan="3"><SPAN id="REF_NO"></SPAN></TD>
    </TR>
    <TR>
        <TD>권리구분</TD>
        <TD><SPAN id="RIGHT_DIV_NAME"></SPAN></TD>
        <TD>출원국가</TD>
        <TD><SPAN id="COUNTRY_CODE_NAME"></SPAN></TD>
    </TR>
    <TR>
        <TD>건담당자</TD>
        <TD><SPAN id="JOB_MAN_NAME"></SPAN></TD>
        <TD>심사청구</TD>
        <TD><ANY:RADIO id="EXAMREQ_YN" codeData="{EXAMREQ_YN}" readOnly/></TD>
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
        <TD>부서</TD>
        <TD colspan="3"><SPAN id="DEPT_NAME"></SPAN></TD>
    </TR>
    <TR>
        <TD>공동권리여부</TD>
        <TD><ANY:RADIO id="CORGT_YN" codeData="{YES_NO}" readOnly /></TD>
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
        <TD>모출원정보</TD>
        <TD><SPAN id="DIVISION_PRIOR_REF_NO"></SPAN></TD>
        <TD>분할구분</TD>
        <TD><SPAN id="DIVISION_TYPE_NAME"></SPAN></TD>
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
        <TD>매각구분</TD>
        <TD><ANY:RADIO id="SALE_YN" codeData="{YES_NO}" readOnly /></TD>
        <TD>매각처/매각일</TD>
        <TD><SPAN id="SALE_PLACE"></SPAN>&nbsp;/&nbsp;<ANY:SPAN id="SALE_DATE" format="date" /></TD>
    </TR>
    <TR>
        <TD>우선권주장여부</TD>
        <TD><ANY:RADIO id="PRIORITY_CLAIM_YN" codeData="{YES_NO}" readOnly/></TD>
        <TD>우선권주장국가</TD>
        <TD><SPAN id="PRIORITY_CLAIM_COUNTRY_NAME"></SPAN></TD>
    </TR>
    <TR>
        <TD>출원번호/일자</TD>
        <TD><SPAN id="APP_NO"></SPAN>&nbsp;(<SPAN id="PAT_APP_NO"></SPAN>)&nbsp;/&nbsp;<ANY:SPAN id="APP_DATE" format="date" /></TD>
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
        <TD>IPC 분류 코드</TD>
        <TD colspan="3"><SPAN id="IPC_CLS_CODE"></SPAN></TD>
     </TR>
     <TR>
        <TD>비용분담주체</TD>
        <TD><SPAN id="COSTSHARE_OWNER_NAME" ></SPAN></TD>
        <TD>출원인</TD>
        <TD >
            <ANY:MSEARCH id="any_appExpManCodeList" mode="R"><COMMENT>
                nameExpr = "[{#APP_MAN_CODE}] {#APP_MAN_NAME}";
            </COMMENT></ANY:MSEARCH>
        </TD>

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
</TABLE>

<DIV class="button_area">
    <% if (app.userInfo.isMenuGroupUser("PAT") == true) { %>
    <BUTTON text="계속/분할" onClick="javascript:fnConDivOL();"></BUTTON>
    <BUTTON text="EP/PCT 지정" onClick="javascript:fnEpPctOL();" id="btn_epPctOL" display="none"></BUTTON>
    <BUTTON auto="line" id="btn_line1" display="none"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.modify").toHTML() %>" onClick="javascript:fnModify();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <% } %>
    <BUTTON auto="list"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
