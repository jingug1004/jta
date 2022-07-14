<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>사원정보 수정</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("EMP_HNAME");
    addBind("EMP_ENAME");
    addBind("EMP_CNAME");
    addBind("HT_CODE_NAME");
    addBind("JUMIN_NO1");
    addBind("JUMIN_NO2");
    addBind("MAIL_ADDR");
    addBind("LOGIN_ID");
    addBind("LOGIN_PW");
    addBind("DIVISN_NAME");
    addBind("DEPT_NAME");
    addBind("POSITION_NAME");
    addBind("LAB_NAME");
    addBind("MOBILE_PHONE");
    addBind("OFFICE_TEL");
    addBind("HOME_ZIPCODE");
    addBind("HOME_ADDR");
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.patteam.user.act.RetrievePatTeamUser.do";
    prx.addParam("USER_ID", parent.USER_ID);

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
    if (!cfCheckAllReqValid()) return;

    if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.patteam.user.act.UpdatePatTeamUser.do";
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
        <TD>성명(한글)</TD>
        <TD>
            <ANY:SPAN id="EMP_HNAME" />
        </TD>
        <TD>성명(영어)</TD>
        <TD>
            <ANY:SPAN id="EMP_ENAME" />
        </TD>
    </TR>
    <TR>
        <TD>성명(한문)</TD>
        <TD>
            <ANY:SPAN id="EMP_CNAME" />
        </TD>
        <TD>현재상태</TD>
        <TD>
            <ANY:SPAN id="HT_CODE_NAME" />
        </TD>
    </TR>
    <TR>
        <TD req="LOGIN_ID">Login ID</TD>
        <TD>
            <INPUT type="text" id="LOGIN_ID" maxByte="6" />
        </TD>
        <TD req="LOGIN_PW">Password</TD>
        <TD>
            <INPUT type="password" id="LOGIN_PW" maxByte="6" />
        </TD>
    </TR>
    <TR>
        <TD>주민번호</TD>
        <TD>
            <ANY:SPAN id="JUMIN_NO1" />-<ANY:SPAN id="JUMIN_NO2"/>
        </TD>
        <TD>메일ID</TD>
        <TD>
            <ANY:SPAN id="MAIL_ADDR" />
        </TD>
    </TR>
    <TR>
        <TD>부서</TD>
        <TD>
            <ANY:SPAN id="DIVISN_NAME" />
        </TD>
        <TD>팀</TD>
        <TD>
            <ANY:SPAN id="DEPT_NAME" />
        </TD>
    </TR>
    <TR>
        <TD>직위</TD>
        <TD>
            <ANY:SPAN id="POSITION_NAME" />
        </TD>
        <TD>연구소</TD>
        <TD>
            <ANY:SPAN id="LAB_NAME" />
        </TD>
    </TR>
    <TR>
        <TD>사내전화번호</TD>
        <TD>
            <ANY:SPAN id="OFFICE_TEL" />
        </TD>
        <TD>전화번호(핸드폰)</TD>
        <TD>
            <ANY:SPAN id="MOBILE_PHONE" />
        </TD>
    </TR>
    <TR>
        <TD>우편번호</TD>
        <TD>
            <ANY:SPAN id="HOME_ZIPCODE" />
        </TD>
        <TD>주소</TD>
        <TD>
            <ANY:SPAN id="HOME_ADDR" />
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
