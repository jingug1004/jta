<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<%@page import="any.util.etc.NDateUtil"%>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>분쟁/소송 작성</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("DISPUTE_KIND");
    addBind("COUNTRY_CODE");
    addBind("EXAM_USER");
    addBind("REQ_MAN");
    addBind("REQ_DATE");
    addBind("DISPUTE_SUBJECT");
    addBind("DISPUTE_NO");
    addBind("INS_DER_GERICHTE");
    addBind("JUDGE_MAN");
    addBind("LAST_DISPOSAL_DATE");
    addBind("LAST_DISPOSAL_RESULT");
    addBind("DISPUTE_REASON");
    addBind("REMARK");
    addBind("OFFICE_CODE");
    addBind("OTHER_NAME");
    addBind("OFFICE_AGENT");
    addBind("OTHER_AGENT");
    addBind("DEFAULTS");
    addBind("OTHER_LAWYER");
    addBind("DISPUTE_DIV");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
}

//저장
function fnSave()
{
    if (!cfCheckAllReqValid()) return;

    if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.ipbiz.dispute.act.CreateDispute.do";
    prx.addParam("DISPUTE_DIV", "O");
    prx.addData("ds_mainInfo");
    prx.addData("ds_analyList");
    prx.addData("ds_groupRefNoList");
    prx.addData("ds_otherInfo");

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        parent.DISPUTE_ID = this.result;
        window.location.replace("DisputeOffenseRD.jsp");
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}
</SCRIPT>

<!-- 국가 변경시 -->
<SCRIPT language="JScript" for="COUNTRY_CODE" event="OnChange()">
       OFFICE_CODE.codeData="/ipbiz/countryCode," + this.value;
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
        <TD disabled>(<%= app.message.get("msg.com.autocreate") %>)</TD>
        <TD req="DISPUTE_KIND">분쟁(소송)종류</TD>
        <TD><ANY:SELECT id="DISPUTE_KIND" codeData="{DISPUTE_KIND}" firstName="sel" /></TD>
    </TR>
    <TR>
        <TD req="COUNTRY_CODE">국가</TD>
        <TD><ANY:SELECT id="COUNTRY_CODE" codeData="/common/countryCode" firstName="sel" /></TD>
        <TD>검토자</TD>
        <TD><INPUT type="text" id="EXAM_USER" maxByte="300"></TD>
    </TR>
    <TR>
        <TD req="REQ_MAN">청구인</TD>
        <TD><INPUT type="text" id="REQ_MAN" maxByte="300"></TD>
        <TD req="REQ_DATE">청구일자</TD>
        <TD><ANY:DATE id="REQ_DATE" /></TD>
    </TR>
    <TR>
        <TD req="DISPUTE_SUBJECT">분쟁(소송)제목</TD>
        <TD colspan="3"><INPUT type="text" id="DISPUTE_SUBJECT" maxByte="2000"></TD>
    </TR>
    <TR>
        <TD req="DISPUTE_NO">분쟁(소송)번호</TD>
        <TD><INPUT type="text" id="DISPUTE_NO"></TD>
        <TD req="DISPUTE_DIV">분쟁/소송성격</TD>
        <TD><ANY:SELECT id="DISPUTE_DIV" codeData="{LAWSUIT}" /></TD>
    </TR>
    <TR>
        <TD>심판관(판사)</TD>
        <TD><INPUT type="text" id="JUDGE_MAN" maxByte="300"></TD>
        <TD>심급구분</TD>
        <TD><ANY:SELECT id="INS_DER_GERICHTE" codeData={INS_DER_GERICHTE} firstName="sel" /></TD>
    </TR>
    <TR>
        <TD>최종처분일</TD>
        <TD><ANY:DATE id="LAST_DISPOSAL_DATE" /></TD>
        <TD>최종처분결과</TD>
        <TD><ANY:SELECT id="LAST_DISPOSAL_RESULT" codeData="{LAST_DISPOSAL_RESULT}" firstName="sel" /></TD>
    </TR>
    <TR>
        <TD>분쟁(소송)사유</TD>
        <TD colspan="3">
            <TEXTAREA id="DISPUTE_REASON" rows="5" maxByte="4000"></TEXTAREA>
        </TD>
    </TR>
    <TR>
        <TD>비고</TD>
        <TD colspan="3">
            <TEXTAREA id="REMARK" rows="5" maxByte="4000"></TEXTAREA>
        </TD>
    </TR>
    <TR>
        <TD>분석자료 링크</TD>
        <TD colspan="3">
            <ANY:ANALY id="any_analyList" mode="C" />
        </TD>
    </TR>
    <TR>
        <TD req="OFFICE_CODE">당사 사무소</TD>
        <TD><ANY:SELECT id="OFFICE_CODE" codeData="/ipbiz/extOfficeCode" firstName="sel" /></TD>
        <TD req="OTHER_NAME">상대명(회사)</TD>
        <TD><INPUT type="text" id="OTHER_NAME" maxByte="300"></TD>
    </TR>
    <TR>
        <TD>당사 대리인</TD>
        <TD><INPUT type="text" id="OFFICE_AGENT" maxByte="300"></TD>
        <TD>상대 대리인</TD>
        <TD><INPUT type="text" id="OTHER_AGENT" maxByte="300"></TD>
    </TR>
    <TR>
        <TD>관할법원</TD>
        <TD><INPUT type="text" id="DEFAULTS" maxByte="300"></TD>
        <TD>상대 변리사</TD>
        <TD><INPUT type="text" id="OTHER_LAWYER" maxByte="300"></TD>
    </TR>
    <TR>
        <TD colspan="4" class="title_table">계쟁 특허 정보(당사 특허)</TD>
    </TR>
    <TR>
        <TD colspan="4" class="contdata">
            <ANY:OURINFO id="any_groupRefNoList" mode="C" />
        </TD>
    </TR>
    <TR>
        <TD colspan="4"  height="10">&nbsp;</TD>
    </TR>
     <TR>
        <TD colspan="4" class="title_table">계정 특허 정보(상대 특허)</TD>
    </TR>
    <TR>
        <TD class="contdata" colspan="4">
            <ANY:OTHERINFO id="any_otherInfo" mode="C" />
        </TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="list" list="DisputeListR.jsp?disputeDiv=O"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
