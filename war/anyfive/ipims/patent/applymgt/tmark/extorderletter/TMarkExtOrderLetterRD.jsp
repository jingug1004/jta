<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.share.workprocess.util.WorkProcessConst"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>상표해외신규OL상세</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_WORKPROC); %>
<% app.writeHTCImport(app.HTC_APPROVAL); %>
<ANY:WORKPROC id="wp" />
<ANY:DS id="ds_groupInfo"><COMMENT>
    addBind("GRP_NO");
    addBind("FIRSTAPP_DATE");
    addBind("OFFICE_NAME");
    addBind("KO_APP_TITLE");
    addBind("CORGT_YN");
    addBind("CORGT_MAN");
</COMMENT></ANY:DS>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("CRE_USER_NAME");
    addBind("CRE_DATE");
    addBind("PRIORITY_CLAIM_YN");
    addBind("PRIORITY_CLAIM_COUNTRY_NAME");
    addBind("EXAM_OPINION");
    addBind("ATTACH_FILE", "any_attachFile");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();
}

//조회
function fnRetrieve(bool)
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.tmark.extorderletter.act.RetrieveTMarkExtOrderLetter.do";
    prx.addParam("OL_ID", parent.OL_ID);
    prx.checkData = ds_mainInfo;

    prx.onSuccess = function()
    {
        if (bool != true) any_approval.reset();
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
    window.location.href = "TMarkExtOrderLetterU.jsp";
}
</SCRIPT>

<!-- 결재현황 로딩시 -->
<SCRIPT language="JScript" for="any_approval" event="OnLoad()">
    wp.reset(parent.OL_ID);
</SCRIPT>
<!-- 결재처리 성공시 -->
<SCRIPT language="JScript" for="any_approval" event="OnSuccess()">
    fnRetrieve(true);
</SCRIPT>

<!-- 업무프로세스 로딩시 -->
<SCRIPT language="JScript" for="wp" event="OnLoad()">
    var isCreUser = (ds_mainInfo.value(0, "CRE_USER") == "<%= app.userInfo.getUserId() %>");
    var actModify = "<%= WorkProcessConst.Action.MODIFY %>";

    cfShowObjects([btn_modify, btn_line], isCreUser && wp.avail([actModify]));
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
        <TD>출원품의번호</TD>
        <TD><SPAN id="GRP_NO"></SPAN></TD>
        <TD>작성자(작성일)</TD>
        <TD><SPAN id="CRE_USER_NAME"></SPAN>(<ANY:SPAN id="CRE_DATE" format="date" />)</TD>
    </TR>
    <TR>
        <TD>우선권주장여부</TD>
        <TD><ANY:RADIO id="PRIORITY_CLAIM_YN" codeData="{YES_NO}" readOnly /></TD>
        <TD>우선권주장국가</TD>
        <TD><SPAN id="PRIORITY_CLAIM_COUNTRY_NAME"></SPAN></TD>
    </TR>
    <TR>
        <TD>국내출원번호</TD>
        <TD colspan="3">
           <ANY:REFNO id="any_groupRefNoList" mode="R" />
        </TD>
    </TR>
    <TR>
        <TD>선출원일</TD>
        <TD><ANY:SPAN id="FIRSTAPP_DATE" format="date"></ANY:SPAN></TD>
        <TD>국내사무소</TD>
        <TD><SPAN id="OFFICE_NAME"></SPAN></TD>
    </TR>
    <TR>
        <TD>상표명</TD>
        <TD colspan="3"><SPAN id="KO_APP_TITLE"></SPAN></TD>
    </TR>
    <TR>
        <TD>발명자</TD>
        <TD colspan="3"><ANY:INV id="any_inventorList" mode="R" /></TD>
    </TR>
    <TR>
        <TD>공동출원여부</TD>
        <TD><ANY:RADIO id="CORGT_YN" codeData="{YES_NO}" readOnly/></TD>
        <TD>공동권리자</TD>
        <TD><SPAN id="CORGT_MAN"></SPAN></TD>
    </TR>
    <TR>
        <TD>출원국가</TD>
        <TD colspan="3">
            <ANY:OLCOUNTRY id="any_olCountryList" mode="R" />
        </TD>
    </TR>
    <TR>
        <TD>비고</TD>
        <TD colspan="3"><SPAN id="EXAM_OPINION"></SPAN></TD>
    </TR>
    <TR>
        <TD>참조파일</TD>
        <TD colspan=3>
            <ANY:FILE id="any_attachFile" mode="R" />
        </TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.modify").toHTML() %>" onClick="javascript:fnModify();" id="btn_modify" display="none"></BUTTON>
    <BUTTON auto="line" id="btn_line" display="none"></BUTTON>
    <BUTTON auto="list"></BUTTON>
</DIV>

<ANY:APPROVAL id="any_approval" code="T03"><COMMENT>
    reqUser = ds_mainInfo.value(0, "CRE_USER");
    addKey("OL_ID", parent.OL_ID);
</COMMENT></ANY:APPROVAL>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
