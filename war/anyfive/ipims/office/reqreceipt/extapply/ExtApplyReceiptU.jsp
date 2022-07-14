<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.office.common.app.OfficeApp"%><% OfficeApp app = new OfficeApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>해외출원의뢰접수</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("CRE_DATE");
    addBind("JOB_MAN_NAME");
    addBind("FIRSTAPP_DATE");
    addBind("PRIORITY_CLAIM_YN");
    addBind("PRIORITY_CLAIM_COUNTRY");
    addBind("CORGT_YN");
    addBind("CORGT_MAN");
    addBind("KO_APP_TITLE");
    addBind("REMARK");
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
    prx.path = top.getRoot() + "/anyfive.ipims.office.reqreceipt.extapply.act.RetrieveExtApplyReceipt.do";
    prx.addParam("OL_ID", parent.OL_ID);
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

//관련파일 목록
function fnOpenRefFileList()
{
}

//저장
function fnSave()
{
    //필수항목 체크
    if (!cfCheckAllReqValid()) return;

    // 유효성 체크
    if (!any_olCountryList.valid) return;

    //저장 확인
    if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.office.reqreceipt.extapply.act.UpdateExtApplyReceipt.do";
    prx.addParam("OL_ID", parent.OL_ID);
    prx.addData("ds_mainInfo");
    prx.addData("ds_olCountryList");

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        parent.goList();
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
        <TD>작성일</TD>
        <TD><ANY:SPAN id="CRE_DATE"  format="date" /></TD>
        <TD>건담당자</TD>
        <TD><SPAN id="JOB_MAN_NAME"></SPAN></TD>
    </TR>
    <TR>
        <TD>선출원번호정보</TD>
        <TD><ANY:PRIORAPP id="any_priorAppList" /></TD>
        <TD>선출원일자</TD>
        <TD><ANY:SPAN id="FIRSTAPP_DATE" format="date" /></TD>
    </TR>
    <TR>
        <TD>우선권 주장여부</TD>
        <TD><ANY:RADIO id="PRIORITY_CLAIM_YN" codeData="{YES_NO}" readOnly></ANY:RADIO></TD>
        <TD>우선권 주장국가</TD>
        <TD><SPAN id="PRIORITY_CLAIM_COUNTRY"></SPAN></TD>
    </TR>
    <TR>
        <TD>공동권리여부</TD>
        <TD><ANY:RADIO id="CORGT_YN" codeData="{YES_NO}"  readOnly></ANY:RADIO></TD>
        <TD>공동권리자</TD>
        <TD><SPAN id="CORGT_MAN"></SPAN></TD>
    </TR>
    <TR>
        <TD>발명의 명칭</TD>
        <TD colspan="3"><SPAN id="KO_APP_TITLE"></SPAN></TD>
    </TR>
    <TR>
        <TD>발명자</TD>
        <TD colspan="3"><ANY:INV id="any_inventorList" mode="R" /></TD>
    </TR>
    <TR>
        <TD>오더레터</TD>
        <TD colspan="3">
            <ANY:OLCOUNTRY id="any_olCountryList" mode="U" />
        </TD>
    </TR>
    <TR>
        <TD>비고</TD>
        <TD colspan="3"><SPAN id="REMARK"></SPAN></TD>
    </TR>
    <TR>
        <TD>국내출원서화일</TD>
        <TD colspan=3>
            <ANY:FILE id="any_appdocFile" mode="R" />
        </TD>
    </TR>
    <TR>
        <TD>참조파일</TD>
        <TD colspan=3>
            <ANY:FILE id="any_attachFile" mode="R" />
        </TD>
    </TR>
</TABLE>

<DIV class="button_area">
<!--
    <BUTTON text="관련파일 목록" onClick="javascript:fnOpenRefFileList();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
-->
    <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();" id="btn_save" ></BUTTON>
    <BUTTON auto="line" id="btn_line" display="none"></BUTTON>
    <BUTTON auto="list"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
