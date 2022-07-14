<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.share.workprocess.util.WorkProcessConst"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>프로그램 마스터 상세</TITLE>
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
    addBind("JOB_MAN_NAME");
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.program.master.act.RetrieveProgramMaster.do";
    prx.addParam("REF_ID", parent.REF_ID);
    prx.checkData = ds_mainInfo;

    prx.onSuccess = function()
    {
        var isJobMan = (ds_mainInfo.value(0, "JOB_MAN") == "<%= app.userInfo.getUserId() %>");

        cfShowObjects([btn_modify, btn_line1], isJobMan);
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
    window.location.href = "ProgramMasterU.jsp";
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
        <TD colspan="3"><SPAN id="REF_NO" ></SPAN></TD>
    </TR>
    <TR>
        <TD>건담당자</TD>
        <TD><SPAN id="JOB_MAN_NAME" ></SPAN></TD>
        <TD>접수일</TD>
        <TD><ANY:SPAN id="PATTEAM_RCPT_DATE" format="date" /></TD>
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
        <TD>등록번호</TD>
        <TD><SPAN id="REG_NO" ></SPAN>
        <TD>등록일</TD>
        <TD><SPAN id="REG_DATE" ></SPAN>
    </TR>
    <TR>
        <TD>발명자</TD>
        <TD colspan="3" >
            <ANY:INV id="any_inventorList" mode="R" />
        </TD>
    </TR>
    <TR>
        <TD>프로그램내용</TD>
        <TD colspan="3">
            <SPAN id="PROG_CONTENTS" ></SPAN>
        </TD>
    </TR>
    <TR>
        <TD>프로그램 언어</TD>
        <TD colspan="3"><SPAN id="PROG_LANG" ></SPAN></TD>
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
            <ANY:FILE id="any_progFileId" mode="R" />
        </TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.modify").toHTML() %>" onClick="javascript:fnModify();" id="btn_modify" display="none"></BUTTON>
    <BUTTON auto="line" id="btn_line1" display="none"></BUTTON>
    <BUTTON auto="list"></BUTTON>
</DIV>

</BODY>
</HTML>
