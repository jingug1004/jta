<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>거절검토서</TITLE>
<% app.writeHTMLHeader(); %>
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
        cfShowObjects([btn_cancel], ds_mainInfo.value(0, "EXAM_OA_SEQ") != "");

        fnSetPassList();
        fnSetIntRefList();
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

    if (isFileUploaded != true) {
        if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;
        cfFileUpload("fnSave(true);");
        return;
    }

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.docpaper.extrejectexam.act.UpdateExtRejectExam.do";
    prx.addParam("REF_ID", parent.REF_ID);
    prx.addParam("OA_SEQ", ds_mainInfo.value(0, "OA_SEQ"));
    prx.addData("ds_mainInfo");
    prx.addData("ds_attachFile");

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        fnDetail();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//상세
function fnDetail()
{
    window.location.replace("ExtRejectExamR.jsp");
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
        <TD req="COPE_PLAN">대응방안</TD>
        <TD colspan="3">
            <TEXTAREA id="COPE_PLAN" rows="5" maxByte="4000"></TEXTAREA>
        </TD>
    </TR>
    <TR>
        <TD>미국출원여부</TD>
        <TD><ANY:RADIO id="US_APP_YN" codeData="{YES_NO}" /></TD>
        <TD req="IDS_OFFER_YN">IDS 제출지시</TD>
        <TD><ANY:RADIO id="IDS_OFFER_YN" codeData="{YES_NO}" /></TD>
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
            <ANY:FILE id="any_attachFile" mode="C" policy="paper" />
        </TD>
    </TR>
    <TR>
        <TD req="EXAM_RESULT">검토결과</TD>
        <TD><ANY:RADIO id="EXAM_RESULT" codeData="{REJECT_REASON_EXAM_RESULT}" /></TD>
        <TD>검토일</TD>
        <TD><ANY:SPAN id="EXAM_DATE" format="date"></ANY:SPAN></TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.cancel").toHTML() %>" onClick="javascript:fnDetail();" id="btn_cancel" display="none"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="close"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
