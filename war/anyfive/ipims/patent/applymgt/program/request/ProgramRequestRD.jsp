<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="any.util.etc.NDateUtil"%>
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.program.request.act.RetrieveProgramRequest.do";
    prx.addParam("REF_ID", parent.REF_ID);

    prx.checkData = ds_mainInfo;

    prx.onSuccess = function()
    {
        any_approval.reset();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//재작성
function fnRewrite()
{
    if (!confirm("보완요청을 확인하시겠습니까?")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.program.request.act.RewriteProgramRequest.do";
    prx.addParam("REF_ID", parent.REF_ID);

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        window.location.replace("ProgramRequestU.jsp");
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
    window.location.href = "ProgramRequestU.jsp";
}
</SCRIPT>

<!-- 결재현황 로딩시 -->
<SCRIPT language="JScript" for="any_approval" event="OnLoad()">
    wp.reset(parent.REF_ID);
</SCRIPT>

<!-- 업무프로세스 로딩시 -->
<SCRIPT language="JScript" for="wp" event="OnLoad()">
    var isCreUser = (ds_mainInfo.value(0, "CRE_USER") == "<%= app.userInfo.getUserId() %>");
    var actRewrite = "<%= WorkProcessConst.Action.REWRITE %>";
    var actModify = "<%= WorkProcessConst.Action.MODIFY %>";

    cfShowObjects([btn_rewrite, btn_line1], isCreUser && wp.avail([actRewrite]));
    cfShowObjects([btn_modify, btn_line2], isCreUser && wp.avail([actModify]));
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
            <ANY:FILE id="any_progFileId" mode="R" />
        </TD>
    </TR>
</TABLE>
<DIV class="button_area">
    <BUTTON text="보완요청 확인" onClick="javascript:fnRewrite();" id="btn_rewrite" display="none"></BUTTON>
    <BUTTON auto="line" id="btn_line1" display="none"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.modify").toHTML() %>" onClick="javascript:fnModify();" id="btn_modify" display="none"></BUTTON>
    <BUTTON auto="line" id="btn_line2" display="none"></BUTTON>
    <BUTTON auto="list"></BUTTON>
</DIV>

<ANY:APPROVAL id="any_approval" code="G01"><COMMENT>
    reqUser = ds_mainInfo.value(0, "CRE_USER");
    addKey("REF_ID", parent.REF_ID);
</COMMENT></ANY:APPROVAL>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
