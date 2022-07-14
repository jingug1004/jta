<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.share.workprocess.util.WorkProcessConst"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>EP/PCT</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_WORKPROC); %>
<% app.writeHTCImport(app.HTC_APPROVAL); %>
<ANY:WORKPROC id="wp" />
<ANY:DS id="ds_priorInfo"><COMMENT>
    addBind("REF_NO");
    addBind("CRE_DATE");
    addBind("COUNTRY_CODE_NAME");
    addBind("JOB_MAN_NAME");
    addBind("INT_OFFICE_NAME");
    addBind("EXAMREQ_YN_NAME");
    addBind("KO_APP_TITLE");
    addBind("FIRSTAPP_DATE");
    addBind("APP_NO");
    addBind("APP_DATE");
</COMMENT></ANY:DS>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("EXAM_OPINION");
    addBind("ATTACH_FILE", "any_attachFile");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();
}

//조회
function fnRetrieve(bool)
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.extpatent.eppct.act.RetrieveExtPatentEpPct.do";
    prx.addParam("OL_ID", parent.OL_ID);
    prx.checkData = ds_mainInfo;

    prx.onSuccess = function()
    {
        if (bool != true) any_approval.reset();
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
    window.location.href = "ExtPatentEpPctU.jsp";
}
</SCRIPT>

<!-- 결재현황 로딩시 -->
<SCRIPT language="JScript" for="any_approval" event="OnLoad()">
    wp.reset(parent.OL_ID);
</SCRIPT>
<!-- 결재처리 성공시 -->
<SCRIPT language="JScript" for="any_approval" event="OnComplete()">
    fnRetrieve(true);
</SCRIPT>

<!-- 업무프로세스 로딩시 -->
<SCRIPT language="JScript" for="wp" event="OnLoad()">
    var isCreUser = (ds_mainInfo.value(0, "CRE_USER") == "<%= app.userInfo.getUserId() %>");
    var actModify = "<%= WorkProcessConst.Action.MODIFY %>";

    cfShowObjects([btn_modify, btn_line], isCreUser && wp.avail([actModify]));
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
        <TD colspan="4" class="title_table">[모출원 서지사항]</TD>
    </TR>
    <TR>
        <TD>REF-NO</TD>
        <TD><SPAN id="REF_NO"></SPAN></TD>
        <TD>작성일</TD>
        <TD><ANY:SPAN id="CRE_DATE" format="date" /></TD>
    </TR>
    <TR>
        <TD>출원국가</TD>
        <TD><SPAN id="COUNTRY_CODE_NAME"></SPAN></TD>
        <TD>건담당자</TD>
        <TD><SPAN id="JOB_MAN_NAME"></SPAN></TD>
    </TR>
    <TR>
        <TD>국내사무소</TD>
        <TD><SPAN id="INT_OFFICE_NAME"></SPAN></TD>
        <TD>심사청구</TD>
        <TD><SPAN id="EXAMREQ_YN_NAME"></SPAN></TD>
    </TR>
    <TR>
        <TD>발명의 명칭</TD>
        <TD colspan="3"><SPAN id="KO_APP_TITLE"></SPAN></TD>
    </TR>
    <TR>
        <TD>선출원번호</TD>
        <TD colspan="3"><ANY:PRIORAPP id="any_priorAppList" /></TD>
    </TR>
    <TR>
        <TD>선출원일자</TD>
        <TD colspan="3"><ANY:SPAN id="FIRSTAPP_DATE" format="date" /></TD>
    </TR>
    <TR>
        <TD>해외출원번호</TD>
        <TD><SPAN id="APP_NO"></SPAN></TD>
        <TD>해외출원일</TD>
        <TD><ANY:SPAN id="APP_DATE" format="date" /></TD>
    </TR>
    <TR>
        <TD colspan="4" class="title_table">[EP/PCT 출원사항]</TD>
    </TR>
    <TR>
        <TD>출원국가</TD>
        <TD colspan="3">
            <ANY:OLCOUNTRY id="any_olCountryList" mode="R" />
        </TD>
    </TR>
    <TR>
        <TD>검토의견</TD>
        <td colspan=3><SPAN id="EXAM_OPINION"></SPAN></TD>
    </TR>
    <TR>
        <TD>참조파일</TD>
        <TD colspan=3>
            <ANY:FILE id="any_attachFile" mode="R" />
        </TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.modify").toHTML() %>" onClick="javascript:fnModify();" id="btn_modify" display="none"></BUTTON>
    <BUTTON auto="line" id="btn_line" display="none"></BUTTON>
    <BUTTON auto="list"></BUTTON>
</DIV>

<ANY:APPROVAL id="any_approval" code="P05"><COMMENT>
    reqUser = ds_mainInfo.value(0, "CRE_USER");
    addKey("OL_ID", parent.OL_ID);
</COMMENT></ANY:APPROVAL>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
