<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>해외 거절이유 검토서</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_APPROVAL); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("INVENTOR_NAMES");
    addBind("JOB_MAN_NAME");
    addBind("SEND_DATE");
    addBind("DUE_DATE");
    addBind("APP_NO");
    addBind("APP_DATE");
    addBind("OFFICE_NAME");
    addBind("KO_APP_TITLE");
    addBind("COPE_PLAN");
    addBind("US_APP_YN");
    addBind("IDS_OFFER_YN");
    addBind("ATTACH_FILE", "any_attachFile");
    addBind("EXAM_RESULT");
    addBind("EXAM_DATE");
</COMMENT></ANY:DS>
<ANY:DS id="ds_passList" />
<ANY:DS id="ds_intRefList" />
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.docpaper.extrejectexam.act.RetrieveExtRejectExam.do";
    prx.addParam("REF_ID", parent.REF_ID);
    prx.addParam("OA_SEQ", parent.OA_SEQ);
    prx.addParam("PAPER_CODE", parent.PAPER_CODE);
    prx.addParam("LIST_SEQ", parent.LIST_SEQ);

    prx.onSuccess = function()
    {
        if (ds_mainInfo.rowCount == 0) {
            alert('"' + document.title + '" 를 작성할 수 있는 OA가 존재하지 않습니다.');
            parent.goList();
            return;
        }

        if (ds_mainInfo.value(0, "EXAM_OA_SEQ") == "" && ds_mainInfo.value(0, "JOB_MAN") == "<%= app.userInfo.getUserId() %>") {
            fnModify();
        } else {
            document.body.style.visibility = "";
            any_approval.reset();
        }

        fnSetPassList();
        fnSetIntRefList();
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
    window.location.replace("ExtRejectExamCU.jsp");
}

//진행서류 경과목록 표시
function fnSetPassList()
{
    var html = new Array();
    for (var i = 0; i < ds_passList.rowCount; i++) {
        html.push('<A href="javascript:fnOpenPassPaper(' + i + ');">[' + ds_passList.value(i, "PAPER_DATE") + '] ' + ds_passList.value(i, "PAPER_NAME") + '</A>');
    }
    spn_passList.innerHTML = html.join("<BR>\n");
}

//경과 진행서류 팝업
function fnOpenPassPaper(idx)
{
    var win = new any.window();
    win.path = top.getRoot() + "/anyfive/ipims/share/docpaper/docpaper/DocPaperM.jsp";
    win.arg.REF_ID = parent.REF_ID;
    win.arg.LIST_SEQ = ds_passList.value(idx, "LIST_SEQ");
    win.show();
}

//관련국내REF-NO 목록 표시
function fnSetIntRefList()
{
    var html = new Array();
    for (var i = 0; i < ds_intRefList.rowCount; i++) {
        html.push('<A href="javascript:fnOpenIntMaster(' + i + ');">' + ds_intRefList.value(i, "REF_NO") + '</A>');
    }
    spn_intRefList.innerHTML = html.join(", ");
}

//관련국내REF-NO 팝업
function fnOpenIntMaster(idx)
{
    var win = new any.window();
    win.path = top.getRoot() + "/anyfive/ipims/patent/applymgt/common/IntMasterTabR.jsp";
    win.arg.REF_ID = ds_intRefList.value(idx, "REF_ID");
    win.show();
}
</SCRIPT>

<!-- 결재현황 로딩시 -->
<SCRIPT language="JScript" for="any_approval" event="OnLoad()">
    var isCreUser = (ds_mainInfo.value(0, "CRE_USER") == "<%= app.userInfo.getUserId() %>");
    cfShowObjects([btn_modify, btn_line], isCreUser && this.avail("REQUEST"));
</SCRIPT>
</HEAD>

<BODY style="visibility:hidden;">

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="1" cellpadding="2" class="main">
    <COLGROUP>
        <COL class="conthead" width="15%">
        <COL class="contdata" width="35%">
        <COL class="conthead" width="15%">
        <COL class="contdata" width="35%">
    </COLGROUP>
    <TR>
        <TD>발명자</TD>
        <TD><SPAN id="INVENTOR_NAMES"></SPAN></TD>
        <TD>담당자</TD>
        <TD><SPAN id="JOB_MAN_NAME"></SPAN></TD>
    </TR>
    <TR>
        <TD>발송일</TD>
        <TD><ANY:SPAN id="SEND_DATE" format="date"></ANY:SPAN></TD>
        <TD>DUE-DATE</TD>
        <TD><ANY:SPAN id="DUE_DATE" format="date"></ANY:SPAN></TD>
    </TR>
    <TR>
        <TD>선출원번호</TD>
        <TD><SPAN id="APP_NO"></SPAN></TD>
        <TD>선출원일</TD>
        <TD><ANY:SPAN id="APP_DATE" format="date"></ANY:SPAN></TD>
    </TR>
    <TR>
        <TD>국내사무소</TD>
        <TD colspan="3"><SPAN id="OFFICE_NAME"></SPAN></TD>
    </TR>
    <TR>
        <TD>발명의 명칭</TD>
        <TD colspan="3"><SPAN id="KO_APP_TITLE"></SPAN></TD>
    </TR>
    <TR>
        <TD>경과</TD>
        <TD colspan="3">
            <SPAN id="spn_passList"></SPAN>
        </TD>
    </TR>
    <TR>
        <TD>대응방안</TD>
        <TD colspan="3"><SPAN id="COPE_PLAN"></SPAN></TD>
    </TR>
    <TR>
        <TD>미국출원여부</TD>
        <TD><ANY:RADIO id="US_APP_YN" codeData="{YES_NO}" readOnly /></TD>
        <TD>IDS 제출지시</TD>
        <TD><ANY:RADIO id="IDS_OFFER_YN" codeData="{YES_NO}" readOnly /></TD>
    </TR>
    <TR>
        <TD>관련 국내 REF-NO</TD>
        <TD colspan="3">
            <SPAN id="spn_intRefList"></SPAN>
        </TD>
    </TR>
    <TR>
        <TD>첨부파일</TD>
        <TD colspan="3">
            <ANY:FILE id="any_attachFile" mode="R" />
        </TD>
    </TR>
    <TR>
        <TD>검토결과</TD>
        <TD><ANY:RADIO id="EXAM_RESULT" codeData="{REJECT_REASON_EXAM_RESULT}" readOnly /></TD>
        <TD>검토일</TD>
        <TD><ANY:SPAN id="EXAM_DATE" format="date"></ANY:SPAN></TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.modify").toHTML() %>" onClick="javascript:fnModify();" id="btn_modify" display="none"></BUTTON>
    <BUTTON auto="line" id="btn_line" display="none"></BUTTON>
    <BUTTON auto="close"></BUTTON>
</DIV>

<ANY:APPROVAL id="any_approval" code="O03"><COMMENT>
    reqUser = ds_mainInfo.value(0, "CRE_USER");
    addKey("REF_ID", parent.REF_ID);
    addKey("OA_SEQ", ds_mainInfo.value(0, "OA_SEQ"));
</COMMENT></ANY:APPROVAL>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
