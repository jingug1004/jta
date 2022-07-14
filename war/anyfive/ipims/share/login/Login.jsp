<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.share.common.app.ShareApp"%><% ShareApp app = new ShareApp(request, response, out, true, true); %>
<%@page import="any.core.config.NConfig"%>
<% app.writeHTMLHeader(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE><%= NConfig.getString(NConfig.DEFAULT_CONFIG + "/system-title") %> - Login</TITLE>
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="Descript-xion" content="설명문 입력" />
<meta http-equiv="Keywords" content="키워드 입력" />
<link rel="stylesheet" type="text/css" href="css/admin.css"  media="all" />
<style type="text/css">
body {
    height: 100%;
}
.memberlogin {background:url(<%=request.getContextPath()%>/anyfive/ipims/share/login/image/login_img.jpg) no-repeat; width:100%; height:501px;}

</style>

<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    LOGIN_ID.value = (any.getCookie("LAST_LOGIN_ID") == null ? "" : any.getCookie("LAST_LOGIN_ID"));
    LOGIN_ID.focus();

}

//로그인
function fnGoLogin()
{
    var loginId = LOGIN_ID.value;
    var loginPw = LOGIN_PW.value;
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.share.login.act.Login.do";
    prx.addParam("LOGIN_ID", loginId);
    prx.addParam("LOGIN_PW", loginPw);


    prx.onSuccess = function()
    {
        any.setCookie("LAST_LOGIN_ID", loginId, 999);

        top.location.replace(top.getRoot() + "/");
    }

    prx.onFail = function()
    {
        this.error.show();

        switch (this.error.number) {
        case 1:
            LOGIN_ID.focus();
            break;
        case 2:
            LOGIN_PW.focus();
            break;
        case 3:
            LOGIN_ID.focus();
            LOGIN_ID.select();
            break;
        case 4:
            LOGIN_PW.focus();
            LOGIN_PW.select();
            break;
        }
    }

    prx.execute();

}
</SCRIPT>

<!-- 입력박스 KeyPress시 -->
<SCRIPT language="JScript" for="LOGIN_INFO" event="onkeypress()">
    if (event.keyCode != 13) return;
    event.keyCode = 0;
    switch (this.id) {
    case "LOGIN_ID":
        LOGIN_PW.focus();
        break;
    case "LOGIN_PW":
        fnGoLogin();
        break;
    }
</SCRIPT>

<!-- 로그인 버튼 클릭시 -->
<SCRIPT language="JScript" for="img_loginButton" event="onclick()">
    fnGoLogin();
</SCRIPT>
</HEAD>

<BODY scroll="no">

<div id="indexcon">
    <div class="memberlogin">
            <!-- 로그인영역 S -->
            <div class="memberlogin" >
                <div class="login_area" >
                    <fieldset>
                    <div class="form" >
                        <dl>
                            <dt><img src="<%=request.getContextPath()%>/anyfive/ipims/share/login/image/id.jpg" alt="로그인" /></dt>
                            <dd><input type="text" name="LOGIN_INFO" id="LOGIN_ID" title="아이디" style="width:100px"/></dd>
                        </dl>
                        <dl>
                            <dt><img src="<%=request.getContextPath()%>/anyfive/ipims/share/login/image/password.jpg" alt="비밀번호" /></dt>
                            <dd><input type="password" name="LOGIN_INFO" id="LOGIN_PW" title="비밀번호를 입력해 주세요" style="width:100px""></dd>
                        </dl>
                    </div>
                    <div class="btn"><img src="<%=request.getContextPath()%>/anyfive/ipims/share/login/image/btn_login.gif" alt="로그인" style="cursor:hand;" id="img_loginButton" /></div>
                  </fieldset>
                    </div>
            </div>
            <!-- 로그인영역 E -->
    </div>
</div>
</html>
