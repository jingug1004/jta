<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<%@page import="any.util.etc.NDateUtil"%>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>DEFENSE 상세</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<% app.writeHTCImport(app.HTC_IPBHIST); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("MGT_NO");
    addBind("CRE_USER_NAME");
    addBind("CRE_DATE");
    addBind("ANALY_NAME");
    addBind("COMPETITOR");
    addBind("EXAM_OPINION");
    addBind("REMARK");
    addBind("RESULT_NAME");
    addBind("STATUS_NAME");
    addBind("ATTACH_FILE", "any_attachFile");
</COMMENT></ANY:DS>
<ANY:DS id="ds_ipBizHistoryList" />
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

//수정
function fnModify()
{
    window.location.href = "AnalyDefenseU.jsp";
}

//삭제
function fnDelete()
{
    if (!confirm("<%= app.message.get("msg.com.confirm.delete").toJS() %>")) return;

    //HISTORY 목록
    var gr = any_ipbHistory.gr;
    var ds = document.getElementById("ds_ipBizHistoryList");
    ds.init();
    for (var r = gr.fg.FixedRows; r < gr.fg.Rows; r++) {
        var row = ds.addRow();
        ds.value(row, "HIST_FILE") = gr.value(r, "HIST_FILE");
    }

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.ipbiz.analy.act.DeleteAnaly.do";
    prx.addParam("ANALY_ID", parent.ANALY_ID);
    prx.addParam("ANALY_DIV", ds_mainInfo.value(0, "ANALY_DIV"));
    prx.addData(ds);

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.delete").toJS() %>");
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
        <TD>관리번호</TD>
        <TD><ANY:SPAN id="MGT_NO" /></TD>
        <TD>작성자(작성일)</TD>
        <TD><ANY:SPAN id="CRE_USER_NAME" />(<ANY:SPAN id="CRE_DATE" format="date" />)</TD>
    </TR>
    <TR>
        <TD>분석자료명</TD>
        <TD><ANY:SPAN id="ANALY_NAME" /></TD>
        <TD>관련업체</TD>
        <TD><ANY:SPAN id="COMPETITOR" /></TD>
    </TR>
    <TR>
        <TD>대상구분</TD>
        <TD><ANY:SPAN id="RESULT_NAME" /></TD>
        <TD>상태</TD>
        <TD><ANY:SPAN id="STATUS_NAME" /></TD>
    </TR>
    <TR>
        <TD>검토의견</TD>
        <TD colspan="3">
            <ANY:SPAN id="EXAM_OPINION" />
        </TD>
    </TR>
    <TR>
        <TD>비고</TD>
        <TD colspan="3">
            <ANY:SPAN id="REMARK" />
        </TD>
    </TR>
    <TR>
        <TD>파일</TD>
        <TD colspan="3">
            <ANY:FILE id="any_attachFile" mode="R" />
        </TD>
    </TR>
    <TR>
        <TD colspan="4" class="title_table">상대측 정보</TD>
    </TR>
    <TR>
        <TD class="contdata" colspan="4">
            <ANY:OTHERINFO id="any_otherInfo" mode="R" />
        </TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.modify").toHTML() %>" onClick="javascript:fnModify();"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.delete").toHTML() %>" onClick="javascript:fnDelete();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="list" list="AnalyListR.jsp?analyDiv=D"></BUTTON>
</DIV>

<ANY:IPBHIST id="any_ipbHistory" style="height:250px;"><COMMENT>
    refId = parent.ANALY_ID;
</COMMENT></ANY:IPBHIST>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
