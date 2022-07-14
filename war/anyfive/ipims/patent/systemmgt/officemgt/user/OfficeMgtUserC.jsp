<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>사무소 사용자 등록</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("OFFICE_CODE");
    addBind("EMP_NO");
    addBind("EMP_HNAME");
    addBind("EMP_ENAME");
    addBind("EMP_CNAME");
    addBind("MAIL_ADDR");
    addBind("JUMIN_NO1");
    addBind("JUMIN_NO2");
    addBind("INPUT_DATE");
    addBind("LOGIN_ID");
    addBind("LOGIN_PW");
    addBind("OFFICE_TEL");
    addBind("OFFICE_FAX");
    addBind("MOBILE_TEL");
    addBind("DEPT_NAME");
    addBind("POSITION_NAME");
    addBind("USE_YN");
    addBind("COMMENTS");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    OFFICE_CODE.focus();
}

//저장
function fnSave()
{
    if (!cfCheckAllReqValid()) return;

    if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.officemgt.user.act.CreateOfficeMgtUser.do";
    prx.addData("ds_mainInfo");

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        parent.USER_ID = this.result;
        window.location.replace("OfficeMgtUserUD.jsp");
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}
</SCRIPT>

<!-- 주민번호1 입력시 -->
<SCRIPT language="JScript" for="JUMIN_NO1" event="onkeyup()">
    if (this.value2.length == 6) JUMIN_NO2.focus();
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
        <TD req="OFFICE_CODE">사무소</TD>
        <TD>
            <ANY:SELECT id="OFFICE_CODE" codeData="/common/officeCode" firstName="sel" />
        </TD>
        <TD req="EMP_NO">관리사번</TD>
        <TD>
            <INPUT type="text" id="EMP_NO" maxByte="9">
        </TD>
    </TR>
    <TR>
        <TD req="EMP_HNAME">성명(한글)</TD>
        <TD>
            <INPUT type="text" id="EMP_HNAME" maxByte="50">
        </TD>
        <TD>성명(영어)</TD>
        <TD>
            <INPUT type="text" id="EMP_ENAME" maxByte="50">
        </TD>
    </TR>
    <TR>
        <TD>성명(한자)</TD>
        <TD>
            <INPUT type="text" id="EMP_CNAME" maxByte="50">
        </TD>
        <TD req="MAIL_ADDR">메일주소</TD>
        <TD>
            <INPUT type="text" id="MAIL_ADDR" maxByte="50" format="email">
        </TD>
    </TR>
    <TR>
        <TD>주민등록번호</TD>
        <TD>
            <INPUT type="text" id="JUMIN_NO1" maxByte="6" format="number" style="text-align:center; width:48px;">&nbsp;-
            <INPUT type="text" id="JUMIN_NO2" maxByte="7" format="number" style="text-align:center; width:56px;">
        </TD>
        <TD>입사일</TD>
        <TD>
            <ANY:DATE id="INPUT_DATE" />
        </TD>
    </TR>
    <TR>
        <TD req="LOGIN_ID">로그인 아이디</TD>
        <TD>
            <INPUT type="text" id="LOGIN_ID" maxByte="15">
        </TD>
        <TD req="LOGIN_PW">비밀번호</TD>
        <TD>
            <INPUT type="text" id="LOGIN_PW" maxByte="10">
        </TD>
    </TR>
    <TR>
        <TD>사무실전화번호</TD>
        <TD>
            <INPUT type="text" id="OFFICE_TEL" maxByte="20">
        </TD>
        <TD>사무실팩스</TD>
        <TD>
            <INPUT type="text" id="OFFICE_FAX" maxByte="20">
        </TD>
    </TR>
    <TR>
        <TD>핸드폰번호</TD>
        <TD>
            <INPUT type="text" id="MOBILE_TEL" maxByte="20" format="cellphone">
        </TD>
        <TD>부서명</TD>
        <TD>
            <INPUT type="text" id="DEPT_NAME" maxByte="40">
        </TD>
    </TR>
    <TR>
        <TD>직위</TD>
        <TD>
            <INPUT type="text" id="POSITION_NAME" maxByte="20">
        </TD>
        <TD req="USE_YN">사용여부</TD>
        <TD>
            <ANY:RADIO id="USE_YN" codeData="{USE_YN}" value="1" />
        </TD>
    </TR>
    <TR>
        <TD>비고</TD>
        <TD colspan="3">
            <TEXTAREA id="COMMENTS" rows="3" maxByte="400"></TEXTAREA>
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
