<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<%@page import="any.util.etc.NDateUtil"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>OFFENSE 작성</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.ipbiz.analy.act.CreateAnaly.do";
    prx.addParam("ANALY_DIV", "O");
    prx.addData("ds_mainInfo");
    prx.addData("ds_groupRefNoList");
    prx.addData("ds_attachFile");

    prx.onSuccess = function()
    {
        parent.ANALY_ID = this.result;
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        window.location.replace("AnalyOffenseRD.jsp");
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
        <TD disabled>(<%= app.message.get("msg.com.autocreate") %>)</TD>
        <TD>작성자(작성일)</TD>
        <TD><%= app.userInfo.getEmpHname() %>(<%= NDateUtil.getFormatDate("yyyy/MM/dd") %>)</TD>
    </TR>
    <TR>
        <TD req="ANALY_NAME">분석자료명</TD>
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
            <ANY:FILE id="any_attachFile" mode="C" policy="ipbiz_analy" />
        </TD>
    </TR>
    <TR>
        <TD colspan="4" class="title_table">당사 정보 (출원 및 등록번호)</TD>
    </TR>
    <TR>
        <TD colspan="4" class="contdata">
            <ANY:OURINFO id="any_groupRefNoList" mode="C" />
        </TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="list" list="AnalyListR.jsp?analyDiv=O"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
