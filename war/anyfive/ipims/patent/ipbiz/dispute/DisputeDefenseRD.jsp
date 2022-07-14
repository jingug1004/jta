<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<%@page import="any.util.etc.NDateUtil"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>DEFENSE 상세</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<% app.writeHTCImport(app.HTC_IPBHIST); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("MGT_NO");
    addBind("DISPUTE_KIND_NAME");
    addBind("COUNTRY_NAME");
    addBind("EXAM_USER");
    addBind("REQ_MAN");
    addBind("REQ_DATE");
    addBind("DISPUTE_SUBJECT");
    addBind("DISPUTE_NO");
    addBind("JUDGE_MAN");
    addBind("LAST_DISPOSAL_DATE");
    addBind("LAST_RESULT_NAME");
    addBind("DISPUTE_REASON");
    addBind("REMARK");
    addBind("OFFICE_NAME");
    addBind("LAWYER");
    addBind("OTHER_NAME");
    addBind("OTHER_ADDR");
    addBind("OTHER_LAWYER");
    addBind("OTHER_AGENT");
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.ipbiz.dispute.act.RetrieveDispute.do";
    prx.addParam("DISPUTE_ID", parent.DISPUTE_ID);
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

//수정
function fnModify()
{
    window.location.href = "DisputeDefenseU.jsp";
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.ipbiz.dispute.act.DeleteDispute.do";
    prx.addParam("DISPUTE_ID", parent.DISPUTE_ID);
    prx.addParam("DISPUTE_DIV", ds_mainInfo.value(0, "DISPUTE_DIV"));
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
        <TD>분쟁(소송)관리번호</TD>
        <TD><ANY:SPAN id="MGT_NO" /></TD>
        <TD>분쟁(소송)종류</TD>
        <TD><ANY:SPAN id="DISPUTE_KIND_NAME" /></TD>
    </TR>
    <TR>
        <TD>국가</TD>
        <TD><ANY:SPAN id="COUNTRY_NAME" /></TD>
        <TD>검토자</TD>
        <TD><ANY:SPAN id="EXAM_USER" /></TD>
    </TR>
    <TR>
        <TD>청구인</TD>
        <TD><ANY:SPAN id="REQ_MAN" /></TD>
        <TD>청구일자</TD>
        <TD><ANY:SPAN id="REQ_DATE" format="date"/></TD>
    </TR>
    <TR>
        <TD>분쟁(소송)제목</TD>
        <TD colspan="3"><ANY:SPAN id="DISPUTE_SUBJECT" /></TD>
    </TR>
    <TR>
        <TD>분쟁(소송)번호</TD>
        <TD><ANY:SPAN id="DISPUTE_NO" /></TD>
        <TD>심판관(판사)</TD>
        <TD><ANY:SPAN id="JUDGE_MAN" /></TD>
    </TR>
    <TR>
        <TD>최종처분일</TD>
        <TD><ANY:SPAN id="LAST_DISPOSAL_DATE" format="date"/></TD>
        <TD>최종처분결과</TD>
        <TD><ANY:SPAN id="LAST_RESULT_NAME" /></TD>
    </TR>
    <TR>
        <TD>분쟁(소송)사유</TD>
        <TD colspan="3">
            <ANY:SPAN id="DISPUTE_REASON" />
        </TD>
    </TR>
    <TR>
        <TD>비고</TD>
        <TD colspan="3">
            <ANY:SPAN id="REMARK" />
        </TD>
    </TR>
    <TR>
        <TD>분석자료 링크</TD>
        <TD colspan="3">
            <ANY:ANALY id="any_analyList" mode="R" />
        </TD>
    </TR>
    <TR>
        <TD>사무소</TD>
        <TD><ANY:SPAN id="OFFICE_NAME" /></TD>
        <TD>변리사</TD>
        <TD><ANY:SPAN id="LAWYER" /></TD>
    </TR>
    <TR>
        <TD colspan="4" class="title_table">상대측 정보</TD>
    </TR>
    <TR>
        <TD>상대명</TD>
        <TD><ANY:SPAN id="OTHER_NAME" /></TD>
        <TD>상대주소</TD>
        <TD><ANY:SPAN id="OTHER_ADDR" /></TD>
    </TR>
    <TR>
        <TD>상대측 변리사</TD>
        <TD><ANY:SPAN id="OTHER_LAWYER" /></TD>
        <TD>상대측 대리인</TD>
        <TD><ANY:SPAN id="OTHER_AGENT" /></TD>
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
    <BUTTON auto="list" list="DisputeListR.jsp?disputeDiv=D"></BUTTON>
</DIV>

<ANY:IPBHIST id="any_ipbHistory" style="height:250px;"><COMMENT>
    refId = parent.DISPUTE_ID;
</COMMENT></ANY:IPBHIST>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
