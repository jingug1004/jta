<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>외부발명자 수정</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("EMP_NO");
    addBind("EMP_HNAME");
    addBind("EMP_ENAME");
    addBind("EMP_CNAME");
    addBind("JUMIN_NO1");
    addBind("JUMIN_NO2");
    addBind("PASSPORT_NO");
    addBind("LOGIN_ID");
    addBind("LOGIN_PW");
    addBind("COUNTRY_CODE");
    addBind("COMPANY_NAME");
    addBind("DEPT_NAME");
    addBind("POSITION_NAME");
    addBind("OFFICE_TEL");
    addBind("OFFICE_FAX");
    addBind("MOBILE_TEL");
    addBind("MAIL_ADDR");
    addBind("HOME_TEL");
    addBind("HOME_ADDR");
    addBind("REMARK");
    addBind("USE_YN");
    addBind("APP_MAN_CODE");
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.patteam.outinventor.act.RetrieveOutInventor.do";
    prx.addParam("USER_ID", parent.USER_ID);

    prx.onSuccess = function()
    {
        EMP_NO.focus();
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
    if (!cfCheckAllReqValid()) return;

    if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.patteam.outinventor.act.UpdateOutInventor.do";
    prx.addParam("USER_ID", parent.USER_ID);
    prx.addData("ds_mainInfo");

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
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
        <TD req="EMP_NO">관리번호</TD>
        <TD>
            <INPUT type="text" id="EMP_NO" maxByte="9">
        </TD>
        <TD req="EMP_HNAME">성명(한글)</TD>
        <TD>
            <INPUT type="text" id="EMP_HNAME" maxByte="50">
        </TD>
    </TR>
    <TR>
        <TD>성명(영어)</TD>
        <TD>
            <INPUT type="text" id="EMP_ENAME" maxByte="50">
        </TD>
        <TD>성명(한자)</TD>
        <TD>
            <INPUT type="text" id="EMP_CNAME" maxByte="50">
        </TD>
    </TR>
    <TR>
        <TD>주민등록번호</TD>
        <TD>
            <INPUT type="text" id="JUMIN_NO1" maxByte="6" format="number" style="text-align:center; width:48px;">&nbsp;-
            <INPUT type="text" id="JUMIN_NO2" maxByte="7" format="number" style="text-align:center; width:56px;">
        </TD>
        <TD>여권번호</TD>
        <TD>
            <INPUT type="text" id="PASSPORT_NO" maxByte="13">
        </TD>
    </TR>
    <TR>
        <TD req="LOGIN_ID">로그인 아이디</TD>
        <TD>
            <INPUT type="text" id="LOGIN_ID" maxByte="15">
        </TD>
        <TD req="LOGIN_PW">로그인 암호</TD>
        <TD>
            <INPUT type="text" id="LOGIN_PW" maxByte="15">
        </TD>
    </TR>
    <TR>
        <TD>자회사</TD>
        <TD colspan="3">
            <ANY:SELECT id="APP_MAN_CODE" codeData="/common/inAppManCode" firstName="all" style="width:460"/>
        </TD>
    </TR>
    <TR>
        <TD>국가</TD>
        <TD>
            <ANY:SELECT id="COUNTRY_CODE" codeData="/common/countryCode" firstName="sel" />
        </TD>
        <TD>회사명</TD>
        <TD>
            <INPUT type="text" id="COMPANY_NAME" maxByte="100">
        </TD>
    </TR>
    <TR>
        <TD>부서명</TD>
        <TD>
            <INPUT type="text" id="DEPT_NAME" maxByte="100">
        </TD>
        <TD>직위명</TD>
        <TD>
            <INPUT type="text" id="POSITION_NAME" maxByte="100">
        </TD>
    </TR>
    <TR>
        <TD>사무실 전화</TD>
        <TD>
            <INPUT type="text" id="OFFICE_TEL" maxByte="20">
        </TD>
        <TD>사무실 팩스</TD>
        <TD>
            <INPUT type="text" id="OFFICE_FAX" maxByte="20">
        </TD>
    </TR>
    <TR>
        <TD>휴대전화</TD>
        <TD>
            <INPUT type="text" id="MOBILE_TEL" maxByte="20">
        </TD>
        <TD>메일주소</TD>
        <TD>
            <INPUT type="text" id="MAIL_ADDR" maxByte="50" format="email">
        </TD>
    </TR>
    <TR>
        <TD>집 전화</TD>
        <TD>
            <INPUT type="text" id="HOME_TEL" maxByte="20">
        </TD>
        <TD>집 주소</TD>
        <TD>
            <INPUT type="text" id="HOME_ADDR" maxByte="1000">
        </TD>
    </TR>
    <TR>
        <TD>비고</TD>
        <TD colspan="3">
            <TEXTAREA id="REMARK" rows="5" maxByte="4000"></TEXTAREA>
        </TD>
    </TR>
    <TR>
        <TD req="USE_YN">사용여부</TD>
        <TD colspan="3">
            <ANY:RADIO id="USE_YN" codeData="{USE_YN}" value="1" cols="4" />
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
