<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>DEFENSE 수정</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("MGT_NO");
    addBind("CRE_USER_NAME");
    addBind("CRE_DATE");
    addBind("ANALY_NAME");
    addBind("COMPETITOR");
    addBind("EXAM_OPINION");
    addBind("REMARK");
    addBind("RESULT");
    addBind("STATUS");
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.ipbiz.analy.act.RetrieveAnaly.do";
    prx.addParam("ANALY_ID", parent.ANALY_ID);
    prx.checkData = ds_mainInfo;

    prx.onSuccess = function(gr, fg)
    {
    }

    prx.onFail = function(gr, fg)
    {
        this.error.show();
    }

    prx.execute();
}

//저장
function fnSave(isFileUploaded)
{
    if (!cfCheckAllReqValid()) return;

    if (isFileUploaded != true) {
        if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;
        cfFileUpload("fnSave(true);");
        return;
    }

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.ipbiz.analy.act.UpdateAnaly.do";
    prx.addParam("ANALY_ID", parent.ANALY_ID);
    prx.addParam("ANALY_DIV", ds_mainInfo.value(0, "ANALY_DIV"));
    prx.addData("ds_mainInfo");
    prx.addData("ds_otherInfo");
    prx.addData("ds_attachFile");

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        window.location.replace("AnalyDefenseRD.jsp");
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
        <TD>관리번호</TD>
        <TD><ANY:SPAN id="MGT_NO" /></TD>
        <TD>작성자(작성일)</TD>
        <TD><ANY:SPAN id="CRE_USER_NAME" />(<ANY:SPAN id="CRE_DATE" format="date" />)</TD>
    </TR>
    <TR>
        <TD>분석자료명</TD>
        <TD><INPUT type="text" id="ANALY_NAME" maxByte="2000" /></TD>
        <TD>관련업체</TD>
        <TD><INPUT type="text" id="COMPETITOR" maxByte="1000"></TD>
    </TR>
    <TR>
        <TD>대상구분</TD>
        <TD><ANY:RADIO id="RESULT" codeData="{RESULT}" /></TD>
        <TD>상태</TD>
        <TD><ANY:RADIO id="STATUS" codeData="{STATUS}" /></TD>
    </TR>
    <TR>
        <TD>검토의견</TD>
        <TD colspan="3">
            <TEXTAREA id="EXAM_OPINION" rows="5" maxByte="4000"></TEXTAREA>
        </TD>
    </TR>
    <TR>
        <TD>비고</TD>
        <TD colspan="3">
            <TEXTAREA id="REMARK" rows="5" maxByte="4000"></TEXTAREA>
        </TD>
    </TR>
    <TR>
        <TD>파일</TD>
        <TD colspan="3">
            <ANY:FILE id="any_attachFile" mode="U" policy="ipbiz_analy" />
        </TD>
    </TR>
    <TR>
        <TD colspan="4" class="title_table">상대측 정보</TD>
    </TR>
    <TR>
        <TD class="contdata" colspan="4">
            <ANY:OTHERINFO id="any_otherInfo" mode="U" />
        </TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.cancel").toHTML() %>" onClick="javascript:history.back();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="list" list="AnalyListR.jsp?analyDiv=D"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
