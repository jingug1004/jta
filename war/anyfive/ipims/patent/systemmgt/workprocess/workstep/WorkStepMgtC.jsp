<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>업무단계 등록</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("BIZ_MGT_ID");
    addBind("BIZ_STEP_ID");
    addBind("BIZ_STEP_NAME");
    addBind("APPR_CODE");
    addBind("BIZ_TBL_NAME");
    addBind("BIZ_ID_COL_NAME");
    addBind("BIZ_VIEW_PATH");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    BIZ_STEP_ID.focus();
}

//저장
function fnSave()
{
    if (!cfCheckAllReqValid()) return;

    if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.workprocess.workstep.act.CreateWorkStepMgt.do";
    prx.addData("ds_mainInfo");

    prx.onSuccess = function()
    {
        parent.BIZ_STEP_ID = BIZ_STEP_ID.value;
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        window.location.replace("WorkStepMgtUD.jsp");
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}
</SCRIPT>

<!-- 업무 ID 변경시 -->
<SCRIPT language="JScript" for="BIZ_MGT_ID" event="OnChange()">
    BIZ_STEP_ID.value = "WP_" + BIZ_MGT_ID.value + "_";
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
        <TD req="BIZ_MGT_ID">업무 ID</TD>
        <TD>
            <ANY:SELECT id="BIZ_MGT_ID" codeData="/systemmgt/workMst" firstName="sel" />
        </TD>
        <TD req="BIZ_STEP_ID">업무단계 ID</TD>
        <TD>
            <INPUT type="text" id="BIZ_STEP_ID" maxByte="10" style="text-transform:uppercase;">
        </TD>
    </TR>
    <TR>
        <TD req="BIZ_STEP_NAME">업무단계 이름</TD>
        <TD>
            <INPUT type="text" id="BIZ_STEP_NAME" maxByte="500">
        </TD>
        <TD>결재코드</TD>
        <TD>
            <ANY:SELECT id="APPR_CODE" codeData="/systemmgt/apprCode" firstName="sel" />
        </TD>
    </TR>
    <TR>
        <TD req="BIZ_TBL_NAME">업무테이블명</TD>
        <TD>
            <INPUT type="text" id="BIZ_TBL_NAME" maxByte="30">
        </TD>
        <TD req="BIZ_ID_COL_NAME">업무ID컬럼명</TD>
        <TD>
            <INPUT type="text" id="BIZ_ID_COL_NAME" maxByte="30">
        </TD>
    </TR>
    <TR>
        <TD>업무화면 경로</TD>
        <TD colspan="3">
            <INPUT type="text" id="BIZ_VIEW_PATH" maxByte="500">
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
