<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>진행서류 작성</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("PAPER_DIV");
    addBind("INOUT_DIV");
    addBind("PAPER_NAME");
    addBind("USE_YN");
    addBind("PAPER_STEP");
    addBind("OA_MGT_STEP");
    addBind("EVAL_CODE");
    addBind("PATTEAM_INPUT_YN");
    addBind("PATTEAM_MAIL_YN");
    addBind("OFFICE_MAIL_YN");
    addBind("INVENTOR_MAIL_YN");
    addBind("OFFICE_INPUT_YN");
    addBind("INVENTOR_INPUT_YN");
    addBind("OFFICE_DISP_YN");
    addBind("INVENTOR_DISP_YN");
    addBind("MST_STATUS_YN");
    addBind("MST_ABD_YN");
    addBind("WITH_PAPER_CODE");
    addBind("WITH_PAPER_SUBCODE");
    addBind("COPE_PAPER_CODE");
    addBind("DUP_AVAIL_YN");
    addBind("BIZ_BUTTON_NAME");
    addBind("BIZ_VIEW_PATH");
    addBind("PATTEAM_COPE_BUTTON");
    addBind("PATTEAM_COPE_VIEW");
    addBind("OFFICE_COPE_BUTTON");
    addBind("OFFICE_COPE_VIEW");
    addBind("INVENTOR_COPE_BUTTON");
    addBind("INVENTOR_COPE_VIEW");
    addBind("INPUT_HELP");
    addBind("REMARK");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    PAPER_NAME.focus();
}

//저장
function fnSave()
{
    if (!cfCheckAllReqValid()) return;

    if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.papermgt.papercode.act.CreatePaperCode.do";
    prx.addData("ds_mainInfo");

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        parent.PAPER_CODE = this.result;
        window.location.replace("PaperCodeMgtUD.jsp");
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}
</SCRIPT>

<!-- 진행서류 변경시 -->
<SCRIPT language="JScript" for="WITH_PAPER_CODE" event="OnChange()">
    if (this.value == "") {
        WITH_PAPER_SUBCODE.clearAll();
    } else {
        WITH_PAPER_SUBCODE.codeData = "/common/paperSubcodeAll," + this.value;
        WITH_PAPER_SUBCODE.index = 0;
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
        <TD req="PAPER_DIV">서류구분</TD>
        <TD>
            <ANY:SELECT id="PAPER_DIV" codeData="{PAPER_DIV}" firstName="sel" />
        </TD>
        <TD req="INOUT_DIV">국내외구분</TD>
        <TD>
            <ANY:SELECT id="INOUT_DIV" codeData="{PAPER_INOUT_DIV}" firstName="sel" />
        </TD>
    </TR>
    <TR>
        <TD req="PAPER_NAME">진행서류명</TD>
        <TD colspan="3">
            <INPUT type="text" id="PAPER_NAME" maxByte="300">
        </TD>
    </TR>
    <TR>
        <TD req="PAPER_STEP">진행서류 단계</TD>
        <TD>
            <ANY:SELECT id="PAPER_STEP" codeData="{PAPER_STEP}" firstName="sel" />
        </TD>
        <TD req="USE_YN">사용여부</TD>
        <TD>
            <ANY:RADIO id="USE_YN" codeData="{USE_YN}" value="1" />
        </TD>
    </TR>
    <TR>
        <TD>OA 관리단계</TD>
        <TD>
            <ANY:SELECT id="OA_MGT_STEP" codeData="{OA_MGT_STEP}" firstName="none" />
        </TD>
        <TD>평가표</TD>
        <TD>
            <ANY:SELECT id="EVAL_CODE" codeData="/systemmgt/evalCode" firstName="sel" />
        </TD>
    </TR>
    <TR>
        <TD req="PATTEAM_INPUT_YN">특허팀 입력가능</TD>
        <TD>
            <ANY:RADIO id="PATTEAM_INPUT_YN" codeData="{YES_NO}" />
        </TD>
        <TD req="PATTEAM_MAIL_YN">특허팀 메일발송</TD>
        <TD>
            <ANY:RADIO id="PATTEAM_MAIL_YN" codeData="{YES_NO}" />
        </TD>
    </TR>
    <TR>
        <TD req="OFFICE_MAIL_YN">사무소 메일발송</TD>
        <TD>
            <ANY:RADIO id="OFFICE_MAIL_YN" codeData="{YES_NO}" />
        </TD>
        <TD req="INVENTOR_MAIL_YN">발명자 메일발송</TD>
        <TD>
            <ANY:RADIO id="INVENTOR_MAIL_YN" codeData="{YES_NO}" />
        </TD>
    </TR>
    <TR>
        <TD req="OFFICE_INPUT_YN">사무소 입력가능</TD>
        <TD>
            <ANY:RADIO id="OFFICE_INPUT_YN" codeData="{YES_NO}" />
        </TD>
        <TD req="INVENTOR_INPUT_YN">발명자 입력가능</TD>
        <TD>
            <ANY:RADIO id="INVENTOR_INPUT_YN" codeData="{YES_NO}" />
        </TD>
    </TR>
    <TR>
        <TD req="OFFICE_DISP_YN">사무소 조회가능</TD>
        <TD>
            <ANY:RADIO id="OFFICE_DISP_YN" codeData="{YES_NO}" />
        </TD>
        <TD req="INVENTOR_DISP_YN">발명자 조회가능</TD>
        <TD>
            <ANY:RADIO id="INVENTOR_DISP_YN" codeData="{YES_NO}" />
        </TD>
    </TR>
    <TR>
        <TD req="MST_STATUS_YN">마스터상태 반영</TD>
        <TD>
            <ANY:RADIO id="MST_STATUS_YN" codeData="{YES_NO}" />
        </TD>
        <TD req="MST_ABD_YN">마스터포기처리</TD>
        <TD>
            <ANY:RADIO id="MST_ABD_YN" codeData="{YES_NO}" />
        </TD>
    </TR>
    <TR>
        <TD>동시진행 서류</TD>
        <TD>
            <ANY:SEARCH id="WITH_PAPER_CODE" mode="U"><COMMENT>
                win.path = top.getRoot() + "/anyfive/ipims/patent/common/popup/search/PaperSearchListR.jsp";
                win.opt.width = 600;
                codeColumn = "WITH_PAPER_CODE";
                nameExpr = "[{#WITH_PAPER_CODE}] {#WITH_PAPER_NAME}";
                setColumn("WITH_PAPER_CODE", "PAPER_CODE");
                setColumn("WITH_PAPER_NAME", "PAPER_NAME");
            </COMMENT></ANY:SEARCH>
        </TD>
        <TD>동시진행 세부서류</TD>
        <TD><ANY:SELECT id="WITH_PAPER_SUBCODE" /></TD>
    </TR>
    <TR>
        <TD>대응 진행서류</TD>
        <TD>
            <ANY:SEARCH id="COPE_PAPER_CODE" mode="U"><COMMENT>
                win.path = top.getRoot() + "/anyfive/ipims/patent/common/popup/search/PaperSearchListR.jsp";
                win.opt.width = 600;
                codeColumn = "COPE_PAPER_CODE";
                nameExpr = "[{#COPE_PAPER_CODE}] {#COPE_PAPER_NAME}";
                setColumn("COPE_PAPER_CODE", "PAPER_CODE");
                setColumn("COPE_PAPER_NAME", "PAPER_NAME");
            </COMMENT></ANY:SEARCH>
        </TD>
        <TD req="DUP_AVAIL_YN">중복 입력가능</TD>
        <TD>
            <ANY:RADIO id="DUP_AVAIL_YN" codeData="{YES_NO}" />
        </TD>
    </TR>
    <TR>
        <TD>업무버튼 이름</TD>
        <TD>
            <INPUT type="text" id="BIZ_BUTTON_NAME" maxByte="300">
        </TD>
        <TD>업무화면 경로</TD>
        <TD>
            <INPUT type="text" id="BIZ_VIEW_PATH" maxByte="500">
        </TD>
    </TR>
    <TR>
        <TD>특허팀 대응버튼</TD>
        <TD>
            <INPUT type="text" id="PATTEAM_COPE_BUTTON" maxByte="300">
        </TD>
        <TD>특허팀 대응화면</TD>
        <TD>
            <INPUT type="text" id="PATTEAM_COPE_VIEW" maxByte="500">
        </TD>
    </TR>
    <TR>
        <TD>사무소 대응버튼</TD>
        <TD>
            <INPUT type="text" id="OFFICE_COPE_BUTTON" maxByte="300">
        </TD>
        <TD>사무소 대응화면</TD>
        <TD>
            <INPUT type="text" id="OFFICE_COPE_VIEW" maxByte="500">
        </TD>
    </TR>
    <TR>
        <TD>발명자 대응버튼</TD>
        <TD>
            <INPUT type="text" id="INVENTOR_COPE_BUTTON" maxByte="300">
        </TD>
        <TD>발명자 대응화면</TD>
        <TD>
            <INPUT type="text" id="INVENTOR_COPE_VIEW" maxByte="500">
        </TD>
    </TR>
    <TR>
        <TD>입력 도움말</TD>
        <TD colspan="3">
            <TEXTAREA id="INPUT_HELP" rows="2" maxByte="4000"></TEXTAREA>
        </TD>
    </TR>
    <TR>
        <TD>비고</TD>
        <TD colspan="3">
            <TEXTAREA id="REMARK" rows="2" maxByte="4000"></TEXTAREA>
        </TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="list"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
