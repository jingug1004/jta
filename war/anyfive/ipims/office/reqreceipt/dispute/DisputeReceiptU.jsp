<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.office.common.app.OfficeApp"%><% OfficeApp app = new OfficeApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<%@page import="any.util.etc.NDateUtil"%>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>분쟁/소송의뢰접수</TITLE>
<% app.writeHTMLHeader(); %>
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
    addBind("OFFICE_SEND_DATE");
    addBind("OFFICE_RCPT_DATE");
    addBind("OFFICE_REF_NO");
    addBind("OTHER_NAME");
    addBind("OTHER_ADDR");
    addBind("OTHER_LAWYER");
    addBind("OTHER_AGENT");
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
    prx.path = top.getRoot() + "/anyfive.ipims.office.reqreceipt.dispute.act.RetrieveDisputeReceipt.do";
    prx.addParam("DISPUTE_ID", parent.DISPUTE_ID);
    prx.checkData = ds_mainInfo;

    prx.onSuccess = function()
    {
        cfShowObjects([btn_save, btn_line], ds_mainInfo.value(0, "OFFICE_RCPT_DATE") == "");
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//저장
function fnSave()
{
    //필수항목 체크
    if (!cfCheckAllReqValid()) return;

    //저장 확인
    if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.office.reqreceipt.dispute.act.UpdateDisputeReceipt.do";
    prx.addParam("DISPUTE_ID", parent.DISPUTE_ID);
    prx.addData("ds_mainInfo");

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
        <TD>사무소</TD>
        <TD><ANY:SPAN id="OFFICE_NAME" /></TD>
        <TD>변리사</TD>
        <TD><ANY:SPAN id="LAWYER" /></TD>
    </TR>
    <TR>
        <TD req="OFFICE_REF_NO">사무소 REF</TD>
        <TD colspan="3"><INPUT type="text" id="OFFICE_REF_NO" maxByte="30"></TD>
    </TR>
    <TR>
        <TD>사무소 송부일</TD>
        <TD><ANY:SPAN id="OFFICE_SEND_DATE" format="date" /></TD>
        <TD>사무소 접수일</TD>
        <TD><ANY:SPAN id="OFFICE_RCPT_DATE" format="date" /></TD>
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
    <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();" id="btn_save" display="none"></BUTTON>
    <BUTTON auto="line" id="btn_line" display="none"></BUTTON>
    <BUTTON auto="list"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
