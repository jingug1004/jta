<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>결재코드 작성</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("APPR_CODE");
    addBind("APPR_NAME");
    addBind("APPR_TABLE");
    addBind("APPR_PK_COLS");
    addBind("APPR_NO_COL");
    addBind("APPR_TITLE_COL");
    addBind("APPR_VIEW_PATH");
    addBind("APPR_NONE_AVAIL_YN");
    addBind("APPR_CANCEL_AVAIL_YN");
    addBind("UPPER_REQ_AVAIL_YN");
    addBind("BUNDLE_APPR_AVAIL_YN");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    APPR_CODE.focus();
}

//저장
function fnSave()
{
    if (!cfCheckAllReqValid()) return;

    if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.basecode.apprmgt.act.CreateApprCodeMgt.do";
    prx.addData("ds_mainInfo");

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        top.window.close();
    }

    prx.onFail = function()
    {
        this.error.show();

        if (this.error.number == 1) {
            APPR_CODE.focus();
            APPR_CODE.select();
        }
    }

    prx.execute();
}
</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="1" cellpadding="2" class="main">
    <COLGROUP>
        <COL class="conthead" width="25%">
        <COL class="contdata" width="75%">
    </COLGROUP>
    <TR>
        <TD req="APPR_CODE">결재코드</TD>
        <TD>
            <INPUT type="text" id="APPR_CODE" maxByte="3" style="text-transform:uppercase;">
        </TD>
    </TR>
    <TR>
        <TD req="APPR_NAME">결재명</TD>
        <TD>
            <INPUT type="text" id="APPR_NAME" maxByte="50">
        </TD>
    </TR>
    <TR>
        <TD req="APPR_TABLE">결재업무 테이블</TD>
        <TD>
            <INPUT type="text" id="APPR_TABLE" maxByte="30">
        </TD>
    </TR>
    <TR>
        <TD req="APPR_PK_COLS">결재업무 테이블 PK들</TD>
        <TD>
            <INPUT type="text" id="APPR_PK_COLS" maxByte="200"><BR>
            (쉼표(,)로 구분)
        </TD>
    </TR>
    <TR>
        <TD req="APPR_NO_COL">결재번호 컬럼명</TD>
        <TD>
            <INPUT type="text" id="APPR_NO_COL" maxByte="30">
        </TD>
    </TR>
    <TR>
        <TD req="APPR_TITLE_COL">결재제목 컬럼명</TD>
        <TD>
            <INPUT type="text" id="APPR_TITLE_COL" maxByte="1000">
        </TD>
    </TR>
    <TR>
        <TD req="APPR_VIEW_PATH">결재화면 경로</TD>
        <TD>
            <INPUT type="text" id="APPR_VIEW_PATH" maxByte="500">
        </TD>
    </TR>
    <TR>
        <TD req="APPR_NONE_AVAIL_YN">결재없음 가능여부</TD>
        <TD>
            <ANY:RADIO id="APPR_NONE_AVAIL_YN" codeData="{YES_NO}" />
        </TD>
    </TR>
    <TR>
        <TD req="APPR_CANCEL_AVAIL_YN">결재취소 가능여부</TD>
        <TD>
            <ANY:RADIO id="APPR_CANCEL_AVAIL_YN" codeData="{YES_NO}" />
        </TD>
    </TR>
    <TR>
        <TD req="UPPER_REQ_AVAIL_YN">상위요청 가능여부</TD>
        <TD>
            <ANY:RADIO id="UPPER_REQ_AVAIL_YN" codeData="{YES_NO}" />
        </TD>
    </TR>
    <TR>
        <TD req="BUNDLE_APPR_AVAIL_YN">일괄결재 가능여부</TD>
        <TD>
            <ANY:RADIO id="BUNDLE_APPR_AVAIL_YN" codeData="{YES_NO}" />
        </TD>
    </TR>
</TABLE>
<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.cancel").toHTML() %>" onClick="javascript:top.window.close();"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
