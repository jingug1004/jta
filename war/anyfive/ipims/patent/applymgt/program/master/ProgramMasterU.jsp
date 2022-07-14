<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>프로그램 마스터 수정</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("REF_NO");
    addBind("PROG_TITLE");
    addBind("RIGHT_TYPE");
    addBind("REGULAR_DIV");
    addBind("REG_NO");
    addBind("REG_DATE");
    addBind("PROG_CONTENTS");
    addBind("PROG_LANG");
    addBind("JOB_MAN");
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
    addBind("PROG_FILE_ID", "any_progFileId");
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.program.master.act.RetrieveProgramMaster.do";
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.program.master.act.UpdateProgramMaster.do";
    prx.addParam("REF_ID", parent.REF_ID);
    prx.addData("ds_mainInfo");
    prx.addData("ds_inventorList");
    prx.addData("ds_progFileId");

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        window.location.replace("ProgramMasterRD.jsp");
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
        <TD >REF_NO</TD>
        <TD colspan="3"><SPAN id="REF_NO"></SPAN></TD>
    </TR>
    <TR>
        <TD req="JOB_MAN">건 담당자</TD>
        <TD><ANY:SELECT id="JOB_MAN" codeData="/common/jobMan,PAT" firstName="sel" /></TD>
        <TD req="PATTEAM_RCPT_DATE">접수일</TD>
        <TD><ANY:DATE id="PATTEAM_RCPT_DATE" /></TD>
    </TR>
    <TR>
        <TD req="PROG_TITLE">프로그램 명칭</TD>
        <TD colspan="3"><INPUT type="text" id="PROG_TITLE" maxByte="2000"></TD>
    </TR>
    <TR>
        <TD>권리유형</TD>
        <TD><ANY:RADIO id="RIGHT_TYPE" codeData="{RIGHT_TYPE}" />
        <TD>상용구분</TD>
        <TD><ANY:RADIO id="REGULAR_DIV" codeData="{REGULAR_DIV}" />
    </TR>
    <TR>
        <TD>등록번호</TD>
        <TD><INPUT type="text" id="REG_NO" maxByte="100"></TD>
        <TD>등록일</TD>
        <TD><ANY:DATE id="REG_DATE" /></TD>
    </TR>
    <TR>
        <TD req="any_inventorList">발명자</TD>
        <TD colspan="3">
            <ANY:INV id="any_inventorList" mode="C1" />
        </TD>
    </TR>
    <TR>
        <TD>프로그램내용</TD>
        <TD colspan="3">
            <TEXTAREA id="PROG_CONTENTS" ROWS = "5" maxByte ="4000"></TEXTAREA>
        </TD>
    </TR>
    <TR>
        <TD>프로그램 언어</TD>
        <TD colspan="3"><INPUT type="text" id="PROG_LANG" maxByte="1000"></TD>
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
            <ANY:FILE id="any_progFileId" mode="U" policy="program_file" />
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
