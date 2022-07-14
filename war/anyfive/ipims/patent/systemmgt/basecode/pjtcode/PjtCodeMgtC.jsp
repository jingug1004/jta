<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>프로젝트코드 등록</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("PJT_CODE");
    addBind("PJT_NAME");
    addBind("PJT_CORE");
    addBind("PJT_LAB");
    addBind("PJT_NO");
    addBind("PJT_MGT");
    addBind("PJT_DEPT");
    addBind("PJT_OWNER");
    addBind("PJT_START_DATE");
    addBind("PJT_END_DATE");
    addBind("USE_YN");
    addBind("BUDJET");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    PJT_CODE.focus();
}

//저장
function fnSave()
{
    if (!cfCheckAllReqValid()) return;

    if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.basecode.pjtcode.act.CreatePjtCode.do";
    prx.addData("ds_mainInfo");

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        top.window.close();
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
        <COL class="conthead" width="17%">
        <COL class="contdata" width="33%">
        <COL class="conthead" width="17%">
        <COL class="contdata" width="33%">
    </COLGROUP>
    <TR>
        <TD req="PJT_CODE">프로젝트코드</TD>
        <TD colspan="3">
            <INPUT type="text" id="PJT_CODE" maxByte="30" style="text-transform:uppercase;">
        </TD>
    </TR>
    <TR>
        <TD req="PJT_NAME">프로젝트이름</TD>
        <TD colspan="3">
            <INPUT type="text" id="PJT_NAME" maxByte="200">
        </TD>
    </TR>
    <TR>
        <TD>연구사업</TD>
        <TD colspan="3">
            <INPUT type="text" id="PJT_CORE" maxByte="2000">
        </TD>
    </TR>
    <TR>
        <TD>연구과제</TD>
        <TD colspan="3">
            <INPUT type="text" id="PJT_LAB" maxByte="2000">
        </TD>
    </TR>
    <TR>
        <TD>고유번호</TD>
        <TD>
            <INPUT type="text" id="PJT_NO" maxByte="30">
        </TD>
        <TD>부처명</TD>
        <TD>
            <INPUT type="text" id="PJT_DEPT" maxByte="100">
        </TD>
    </TR>
    <TR>
        <TD>연구관리기관</TD>
        <TD>
            <INPUT type="text" id="PJT_MGT" maxByte="100">
        </TD>
         <TD>주관기관</TD>
        <TD>
            <INPUT type="text" id="PJT_OWNER" maxByte="100">
        </TD>
    </TR>
    <TR>
        <TD>수행시작일</TD>
        <TD>
            <ANY:DATE id="PJT_START_DATE" />
        </TD>
         <TD>수행종료일</TD>
        <TD>
            <ANY:DATE id="PJT_END_DATE" />
        </TD>
    </TR>
    <TR>
        <TD>예산금액</TD>
        <TD colspan="3">
            <INPUT type="text" id="BUDJET" format="number2(-16)">
        </TD>
    </TR>
    <TR>
        <TD>사용여부</TD>
        <TD colspan="3">
            <ANY:RADIO id="USE_YN" codeData="{USE_YN}" value="1" />
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
