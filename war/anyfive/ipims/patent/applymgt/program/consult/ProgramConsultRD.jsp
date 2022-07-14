<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.share.workprocess.util.WorkProcessConst"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>프로그램 상세</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_WORKPROC); %>
<% app.writeHTCImport(app.HTC_APPROVAL); %>
<ANY:WORKPROC id="wp" />
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("REF_NO");
    addBind("CRE_USER_NAME");
    addBind("CRE_DATE");
    addBind("PROG_TITLE");
    addBind("RIGHT_TYPE");
    addBind("REGULAR_DIV");
    addBind("PROG_CONTENTS");
    addBind("PROG_LANG");
    addBind("JOB_MAN_NAME");
    addBind("EXAM_RESULT");
    addBind("EXAM_OPINION");
    addBind("PATTEAM_RCPT_DATE");
    addBind("APPLY_FIELD");
    addBind("MAIN_FUNCTION");
    addBind("FEATURE");
    addBind("USE_METHOD");
    addBind("SALE_DIV");
    addBind("USE_MACHINETYPE");
    addBind("USE_OS");
    addBind("USE_LANG");
    addBind("NEED_PROG");
    addBind("SCALE");
    addBind("ETC_MEMO");
    addBind("CONSUT_PROG_FILE_ID", "any_consutProgFileId");
    addBind("REQ_PROG_FILE_ID", "any_reqProgFileId");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
var gScrollBottom = false;

//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();
}

//조회
function fnRetrieve(scrollBottom)
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.program.consult.act.RetrieveProgramConsult.do";
    prx.addParam("REF_ID", parent.REF_ID);
    prx.checkData = ds_mainInfo;

    prx.onSuccess = function()
    {
        //건담당자이고, 검토결과가 입력되어 있지 않는 경우 수정화면으로 이동
        if (ds_mainInfo.value(0, "JOB_MAN") == "<%= app.userInfo.getUserId() %>" && ds_mainInfo.value(0, "EXAM_RESULT") == "") {
            window.location.replace("ProgramConsultU.jsp");
            return;
        }

        any_approval.reset();
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
    window.location.href = "ProgramConsultU.jsp";
}
</SCRIPT>

<!-- 결재현황 로딩시 -->
<SCRIPT language="JScript" for="any_approval" event="OnLoad()">
    wp.reset(parent.REF_ID);

</SCRIPT>

<!-- 업무프로세스 로딩시 -->
<SCRIPT language="JScript" for="wp" event="OnLoad()">
    var isJobMan = (ds_mainInfo.value(0, "JOB_MAN") == "<%= app.userInfo.getUserId() %>");
    var actModify = "<%= WorkProcessConst.Action.MODIFY %>";

    cfShowObjects([btn_modify, btn_line1], isJobMan && wp.avail([actModify], "PAT"));

    if (gScrollBottom == true) {
        gScrollBottom = false;
        cfSetScrollBottom();
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
        <TD>REF_NO</TD>
        <TD><SPAN id="REF_NO"></SPAN></TD>
        <TD>작성자(작성일)</TD>
        <TD><SPAN id="CRE_USER_NAME"></SPAN>(<ANY:SPAN id="CRE_DATE" format="date" />)</TD>
    </TR>
    <TR>
        <TD>프로그램 명칭</TD>
        <TD colspan="3"><SPAN id="PROG_TITLE"></SPAN></TD>
    </TR>
    <TR>
        <TD>권리유형</TD>
        <TD><ANY:RADIO id="RIGHT_TYPE" codeData="{RIGHT_TYPE}" readOnly />
        <TD>상용구분</TD>
        <TD><ANY:RADIO id="REGULAR_DIV" codeData="{REGULAR_DIV}" readOnly />
    </TR>
    <TR>
        <TD>발명자</TD>
        <TD colspan="3" >
            <ANY:INV id="any_inventorList" mode="R" />
        </TD>
    </TR>
    <TR>
        <TD>프로그램내용</TD>
        <TD colspan="3"><SPAN id="PROG_CONTENTS"></SPAN></TD>
    </TR>
    <TR>
        <TD>프로그램 언어</TD>
        <TD colspan="3"><SPAN id="PROG_LANG"></SPAN></TD>
    </TR>
    <TR>
        <TD>관련 파일</TD>
        <TD colspan="3">
            <ANY:FILE id="any_reqProgFileId" mode="R" />
        </TD>
    </TR>
    <TR>
        <TD colspan="4" class="title_table">[특허팀 추가 입력사항]</TD>
    </TR>
    <TR>
        <TD>건담당자</TD>
        <TD><SPAN id="JOB_MAN_NAME"></SPAN></TD>
        <TD>접수일</TD>
        <TD><ANY:SPAN id="PATTEAM_RCPT_DATE" format="date"/></TD>
    </TR>
    <TR>
        <TD>검토결과</TD>
        <TD colspan="3">
            <ANY:RADIO id="EXAM_RESULT" style="width:50%" codeData={EXAM_RESULT} readOnly />
        </TD>
    </TR>
    <TR>
        <TD>검토결과의견</TD>
        <TD colspan="3"><SPAN id="EXAM_OPINION"></SPAN></TD>
    </TR>

    <TR>
        <TD>적용분야</TD>
        <TD colspan="3"><SPAN id="APPLY_FIELD"></SPAN></TD>
    </TR>
    <TR>
        <TD>주요기능</TD>
        <TD colspan="3"><SPAN id="MAIN_FUNCTION"></SPAN></TD>
    </TR>
    <TR>
        <TD>특징</TD>
        <TD colspan="3"><SPAN id="FEATURE"></SPAN></TD>
    </TR>
    <TR>
        <TD>사용방법</TD>
        <TD colspan="3"><SPAN id="USE_METHOD"></SPAN></TD>
    </TR>
    <TR>
        <TD>판매구분</TD>
        <TD colspan="3"><SPAN id="SALE_DIV"></SPAN></TD>
    </TR>
    <TR>
        <TD>사용기종</TD>
        <TD colspan="3"><SPAN id="USE_MACHINETYPE"></SPAN></TD>
    </TR>
    <TR>
        <TD>사용OS</TD>
        <TD colspan="3"><SPAN id="USE_OS"></SPAN></TD>
    </TR>
    <TR>
        <TD>사용언어</TD>
        <TD colspan="3"><SPAN id=USE_LANG></SPAN></TD>
    </TR>
    <TR>
        <TD>필요한 프로그램</TD>
        <TD colspan="3"><SPAN id=NEED_PROG></SPAN></TD>
    </TR>
    <TR>
        <TD>규모</TD>
        <TD colspan="3"><SPAN id=SCALE></SPAN></TD>
    </TR>
    <TR>
        <TD>기타</TD>
        <TD colspan="3"><SPAN id=ETC_MEMO></SPAN></TD>
    </TR>
    <TR>
        <TD>관련파일</TD>
        <TD colspan="3">
            <ANY:FILE id="any_consutProgFileId" mode="R" />
        </TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.modify").toHTML() %>" onClick="javascript:fnModify();" id="btn_modify" display="none"></BUTTON>
    <BUTTON auto="line" id="btn_line1" display="none"></BUTTON>
    <BUTTON auto="list"></BUTTON>
</DIV>

<ANY:APPROVAL id="any_approval" code="G02"><COMMENT>
    reqUser = ds_mainInfo.value(0, "JOB_MAN");
    addKey("REF_ID", parent.REF_ID);
</COMMENT></ANY:APPROVAL>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
