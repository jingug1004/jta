<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.office.common.app.OfficeApp"%><% OfficeApp app = new OfficeApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>비밀번호 수정</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("OFFICE_CODE");
    addBind("OFFICE_CODE_NAME");
    addBind("JUMIN_NO");
    addBind("LOGIN_PW");
    addBind("EMP_HNAME");
    addBind("EMP_ENAME");
    addBind("EMP_CNAME");
    addBind("MAIL_ADDR");
    addBind("OFFICE_TEL");
    addBind("OFFICE_FAX");
    addBind("MOBILE_TEL");
    addBind("DEPT_CODE_NAME");
    addBind("POSITION_NAME");
    addBind("INPUT_DATE");
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
    prx.path = top.getRoot() + "/anyfive.ipims.office.common.userinfo.act.RetrieveUserInfo.do";
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
function fnSave()
{
    //필수항목 체크
    if (!cfCheckAllReqValid()) return;

    //저장 확인
    if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.office.common.userinfo.act.UpdateUserInfo.do";
    prx.addData("ds_mainInfo");

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        parent.goList();
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
        <TD>회사코드</TD>
        <TD><SPAN id="OFFICE_CODE"></SPAN></TD>
        <TD>회사명</TD>
        <TD><SPAN id="OFFICE_CODE_NAME"></SPAN></TD>
    </TR>
    <TR>
        <TD>주민등록번호</TD>
        <TD><SPAN id="JUMIN_NO"></SPAN></TD>
        <TD req="LOGIN_PW">비밀번호</TD>
        <TD><INPUT type="text" id="LOGIN_PW"></TD>
    </TR>
    <TR>
        <TD>성명(한글)</TD>
        <TD><SPAN id="EMP_HNAME"></SPAN></TD>
        <TD>성명(영어)</TD>
        <TD><SPAN id="EMP_ENAME"></SPAN></TD>
    </TR>
    <TR>
        <TD>성명(한자)</TD>
        <TD><SPAN id="EMP_CNAME"></SPAN></TD>
        <TD>메일주소</TD>
        <TD><SPAN id="MAIL_ADDR"></SPAN></TD>
    </TR>
    <TR>
        <TD>사무실전화번호</TD>
        <TD><SPAN id="OFFICE_TEL"></SPAN></TD>
        <TD>사무실팩스</TD>
        <TD><SPAN id="OFFICE_FAX"></SPAN></TD>
    </TR>
    <TR>
        <TD>핸드폰번호</TD>
        <TD><SPAN id="MOBILE_TEL"></SPAN></TD>
        <TD>부서명</TD>
        <TD><SPAN id="DEPT_CODE_NAME"></SPAN></TD>
    </TR>
    <TR>
        <TD>직위</TD>
        <TD><SPAN id="POSITION_NAME"></SPAN></TD>
        <TD>입사일</TD>
        <TD><ANY:SPAN id="INPUT_DATE" format="date" /></TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="close"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
