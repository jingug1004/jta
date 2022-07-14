<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<%@page import="any.util.etc.NDateUtil"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>디자인해외신규OL작성</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_groupInfo"><COMMENT>
    addBind("GRP_NO");
    addBind("PRIORITY_CLAIM_YN");
    addBind("FIRSTAPP_COUNTRY", "PRIORITY_CLAIM_COUNTRY");
    addBind("FIRSTAPP_DATE");
    addBind("OFFICE_NAME");
    addBind("KO_APP_TITLE");
    addBind("CORGT_YN");
    addBind("CORGT_MAN");
    addBind("REMARK", "EXAM_OPINION");
</COMMENT></ANY:DS>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("PRIORITY_CLAIM_YN");
    addBind("PRIORITY_CLAIM_COUNTRY");
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
function fnRetrieve()
{
      var prx = new any.proxy();
      prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.design.extorderletter.act.RetrieveDesignExtOrderLetterGroup.do";
      prx.addParam("GRP_ID", parent.GRP_ID);
      prx.checkData = ds_mainInfo;

      prx.onSuccess = function()
      {
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

    //출원국가 목록 체크
    if (!any_olCountryList.valid) return;

    if (isFileUploaded != true) {
        if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;
        cfFileUpload("fnSave(true);");
        return;
    }

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.design.extorderletter.act.CreateDesignExtOrderLetter.do";
    prx.addData("ds_mainInfo");
    prx.addData("ds_olCountryList");
    prx.addData("ds_attachFile");

    prx.onSuccess = function()
    {
        parent.OL_ID = this.result;
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        window.location.replace("DesignExtOrderLetterRD.jsp");
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
    window.location.href = "DesignExtOrderLetterU.jsp";
}
</SCRIPT>

<!-- 우선권주장여부 변경시 -->
<SCRIPT language="JScript" for="PRIORITY_CLAIM_YN" event="OnChange()">
    PRIORITY_CLAIM_COUNTRY.disabled = (this.value != "1");
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
        <TD>해외품의번호</TD>
        <TD><SPAN id="GRP_NO"></SPAN></TD>
        <TD>작성일</TD>
        <TD><ANY:SPAN value="<%= NDateUtil.getSysDate() %>" format="date" /></TD>
    </TR>
    <TR>
        <TD req="PRIORITY_CLAIM_YN">우선권주장여부</TD>
        <TD><ANY:RADIO id="PRIORITY_CLAIM_YN" codeData="{YES_NO}" /></TD>
        <TD>우선권주장국가</TD>
        <TD><ANY:SELECT id="PRIORITY_CLAIM_COUNTRY" codeData="/common/countryCode" disabled /></TD>
    </TR>
    <TR>
        <TD>국내출원번호</TD>
        <TD colspan="3"><ANY:PRIORAPP id="any_priorAppList" /></TD>
    </TR>
    <TR>
        <TD>선출원일</TD>
        <TD><ANY:SPAN id="FIRSTAPP_DATE" format="date"></ANY:SPAN></TD>
        <TD>국내사무소명</TD>
        <TD><SPAN id="OFFICE_NAME"></SPAN></TD>
    </TR>
    <TR>
        <TD>디자인명</TD>
        <TD colspan="3"><SPAN id="KO_APP_TITLE"></SPAN></TD>
    </TR>
    <TR>
        <TD>발명자</TD>
        <TD colspan="3"><ANY:INV id="any_inventorList" mode="R"/></TD>
    </TR>
    <TR>
        <TD>공동출원여부</TD>
        <TD><ANY:RADIO id="CORGT_YN" codeData="{YES_NO}" readonly /></TD>
        <TD>공동권리자</TD>
        <TD><SPAN id="CORGT_MAN"></SPAN></TD>
    </TR>
    <TR>
        <TD req="any_olCountryList">출원국가</TD>
        <TD colspan="3">
            <ANY:OLCOUNTRY id="any_olCountryList" mode="C"><COMMENT>
                grpId = parent.GRP_ID;
                priorityClaimCountry = PRIORITY_CLAIM_COUNTRY;
            </COMMENT></ANY:OLCOUNTRY>
        </TD>
    </TR>
    <TR>
        <TD>비고</TD>
        <TD colspan="3"><TEXTAREA rows="3" name="EXAM_OPINION"></TEXTAREA></TD>
    </TR>
    <TR>
        <TD>첨부파일</TD>
        <TD colspan="3">
            <ANY:FILE id="any_attachFile" mode="C" policy="design_extol" />
        </TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="list"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
