<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>프로그램 수정</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_APPROVAL); %>
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
//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();
}

//조회
function fnRetrieve()
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.program.consult.act.RetrieveProgramConsult.do";
    prx.addParam("REF_ID", parent.REF_ID);
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.program.consult.act.UpdateProgramConsult.do";
    prx.addParam("REF_ID", parent.REF_ID);
    prx.addData("ds_mainInfo");
    prx.addData("ds_consutProgFileId");

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        window.location.replace("ProgramConsultRD.jsp");
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
        <TD>관련파일</TD>
        <TD colspan="3">
            <ANY:FILE id="any_reqProgFileId" mode="R" />
        </TD>
    </TR>
    <TR>
        <TD colspan="4" class="title_table">[특허팀 추가 입력사항]</TD>
    </TR>
    <TR>
        <TD>건 담당자</TD>
        <TD><SPAN id="JOB_MAN_NAME"></SPAN></TD>
        <TD>접수일</TD>
        <TD><ANY:SPAN id="PATTEAM_RCPT_DATE" format="date" /></TD>
    </TR>
    <TR>
        <TD req="EXAM_RESULT" >검토결과</TD>
        <TD colspan="3">
            <ANY:RADIO id="EXAM_RESULT" codeData="{PROG_EXAM_RESULT}" style="width:50%" />
        </TD>
    </TR>
    <TR>
        <TD>검토결과의견</TD>
        <TD colspan="3">
            <TEXTAREA id="EXAM_OPINION" rows="3" maxByte="4000"></TEXTAREA>
        </TD>
    </TR>
    <TR>
        <TD>적용분야</TD>
        <TD colspan="3">
            <TEXTAREA id="APPLY_FIELD" rows="2" maxByte="2000"></TEXTAREA>
        </TD>
    </TR>
    <TR>
        <TD>주요기능</TD>
        <TD colspan="3">
            <TEXTAREA id="MAIN_FUNCTION" rows="2" maxByte="2000"></TEXTAREA>
        </TD>
    </TR>
    <TR>
        <TD>특징</TD>
        <TD colspan="3">
            <TEXTAREA id="FEATURE" rows="2" maxByte="2000"></TEXTAREA>
        </TD>
    </TR>
    <TR>
        <TD>사용방법</TD>
        <TD colspan="3">
            <TEXTAREA id="USE_METHOD" rows="2" maxByte="2000"></TEXTAREA>
        </TD>
    </TR>
    <TR>
        <TD>판매구분</TD>
        <TD colspan="3">
            <INPUT type="text" id="SALE_DIV" maxByte="1000">
        </TD>
    </TR>
    <TR>
        <TD>사용기종</TD>
        <TD colspan="3">
            <INPUT type="text" id="USE_MACHINETYPE" maxByte="1000">
        </TD>
    </TR>
    <TR>
        <TD>사용OS</TD>
        <TD colspan="3">
            <INPUT type="text" id="USE_OS" maxByte="1000">
        </TD>
    </TR>
    <TR>
        <TD>사용언어</TD>
        <TD colspan="3">
            <INPUT type="text" id="USE_LANG" maxByte="1000">
        </TD>
    </TR>
    <TR>
        <TD>필요한 프로그램</TD>
        <TD colspan="3">
            <TEXTAREA id="NEED_PROG" rows="2" maxByte="2000"></TEXTAREA>
        </TD>
    </TR>
    <TR>
        <TD>규모</TD>
        <TD colspan="3">
            <INPUT type="text" id="SCALE" maxByte="1000">
        </TD>
    </TR>
    <TR>
        <TD>기타</TD>
        <TD colspan="3">
            <TEXTAREA id="ETC_MEMO" rows="3" maxByte="4000"></TEXTAREA>
        </TD>
    </TR>
    <TR>
        <TD>관련파일</TD>
        <TD colspan="3">
            <ANY:FILE id="any_consutProgFileId" mode="U" policy="program_file" />
        </TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.cancel").toHTML() %>" onClick="javascript:history.back();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="list"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
