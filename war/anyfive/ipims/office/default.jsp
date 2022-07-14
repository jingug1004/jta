<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.office.common.app.OfficeApp"%><% OfficeApp app = new OfficeApp(request, response, out, true, false); %>
<%@page import="any.core.config.NConfig"%>
<%@page import="any.util.etc.NDateUtil"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE><%= NConfig.getString(NConfig.DEFAULT_CONFIG + "/system-title") %></TITLE>
<% app.writeHTMLHeader(app.PAGE_TYPE_DEFAULT); %>
<% app.writeHTCImport("/anyfive/ipims/share/menu/MenuDataHTC.jsp"); %>
<% app.writeHTCImport("/anyfive/ipims/share/menu/MenuLeftHTC.jsp"); %>
<ANY:MENUDATA id="any_menuData" menuLeft="any_menuLeft" />
<link href="<%= request.getContextPath() %>/anyfive/ipims/office/home/style.css" rel="stylesheet" type="text/css">
<style type="text/css">
/* Top Navigation */
.top_menu_bg {background-image: url(image/top_bg_03.gif); background-attachment: fixed;}
</style>
<SCRIPT language="JScript">
//윈도우 로딩시
window.oninit = function()
{
    document.body.style.visibility = "visible";
}

//사용자정보 페이지로 이동
function fnGoUserInfo()
{
    var win = new any.window();
    win.path = top.getRoot() + "/anyfive/ipims/office/common/userinfo/UserInfoU.jsp";
    win.opt.width = 800;
    win.opt.height = 280;
    return win.show();
}

//Logout
function fnLogout()
{
    if (!confirm("로그아웃 하시겠습니까?")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.share.login.act.Logout.do";

    prx.onSuccess = function()
    {
        alert("로그아웃 되었습니다.");
        top.location.replace(top.getRoot() + "/anyfive/ipims/share/login/Login.jsp");
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}
</SCRIPT>

<!-- 좌측메뉴 변경시 -->
<SCRIPT language="JScript" for="any_menuLeft" event="OnChange()">
    document.getElementById("ifr_body").contentWindow.location.replace(top.getRoot() + any_menuLeft.selectedMenu.path);
</SCRIPT>

<% if (app.debugMode == true) { %>
<!-- Refresh -->
<SCRIPT language="JScript" for="document" event="onclick()">
    if ((event.ctrlKey && event.altKey) != true) return;
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive/framework/util/refresh.jsp";
    prx.onSuccess = function()
    {
        any.message.init();
        alert("Refresh OK");
    }
    prx.onFail = function()
    {
        this.error.show();
    }
    prx.execute();
</SCRIPT>
<% } %>
</HEAD>

<BODY scroll="no" style="visibility:hidden;">

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
<tr>
          <td height="35">
            <table width="1001" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="841">
                    <table cellspacing="0" cellpadding="0">
                    <tr>
                          <td width="20"></td>
                          <td><img src="<%= request.getContextPath() %>/anyfive/ipims/office/image/top_logo.gif"
                           onClick="javascript:top.window.location.replace(top.window.location.pathname);"
                           style="cursor:hand;"
                           ></td>
                          <td width="30"></td>
                          <td class="user_info">
                          <A href="javascript:fnGoUserInfo();" ><b><%= app.userInfo.getEmpHname() %></b>님</A> 안녕하세요&nbsp;[<%= NDateUtil.getFormatDate("yyyy/MM/dd") %>]
                          </td>
                          <td class="secondary_menu">
                          <A href="javascript:fnLogout();" onFocus="this.blur();"><IMG src="<%= request.getContextPath() %>/anyfive/ipims/office/image/btn_logout.gif" border="0" align="absmiddle"></A>
                          </td>
                          <td class="user_info">&nbsp;</td>
                    </tr>
                  </table>
                </td>
                <td width="160" align="right">
                    <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                      <td width="100" align="right"><img src="<%= request.getContextPath() %>/anyfive/ipims/office/image/bullet_red.gif" width="4" height="7" align="absmiddle">
                      <a href="#" style="cursor:hand;" onClick="javascript:pop_linkInfo.show(this);"> 관련사이트</a></td>
                    </tr>
                    <ANY:POPUP id="pop_linkInfo" popupWidth="150px"><COMMENT>
                            addItem("http://www.kipo.go.kr", "한국특허청");
                            addItem("http://www.uspto.gov", "미국특허청");
                            addItem("http://www.european-patent-office.org/index.en.php", "EP특허청");
                            addItem("http://www.kipris.or.kr", "KIPRIS");
                            addItem("http://www.kipi.or.kr", "한국특허정보원");
                            addItem("http://www.kipa.org", "한국발명진흥회");
                            addItem("http://www.ipmart.or.kr/index.jsp", "인터넷 특허기술장터");
                            addItem("http://search.wips.co.kr", "WIPS 특허온라인검색");
                            addItem("http://www.wipo.int/portal/index.html.en", "WIPO");
                    </COMMENT></ANY:POPUP>
                  </table>
                </td>
              </tr>
            </table>
          </td>
         </tr><tr align="center">
              <td colspan="4" height="3" align="center" class="bg_gray_ddded9"></td>
         </tr>
         <tr>
          <td colspan="4" height="7" valign="top" background="<%= request.getContextPath() %>/anyfive/ipims/office/image/top_menu_bg_b.gif"  ></td>
         </tr>



    <TR>
        <TD height="100%">
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
                <TR>
                    <TD valign="top">
                        <ANY:MENULEFT id="any_menuLeft" style="width:204px;" />
                    </TD>
                    <TD width="100%">
                        <IFRAME id="ifr_body" src="<%= request.getContextPath() %>/anyfive/ipims/office/home/Home.jsp" frameBorder="0" scrolling="no" width="100%" height="100%"></IFRAME>
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD height="1" style="background-color:#D0D0D0;"></TD>
    </TR>
    <TR>
        <TD style="background-color:#F3F3F3;" height="25">
            <table width="100%" height="21" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td width="140" height="21" valign="top" class="footer"><img src="<%= request.getContextPath() %>/anyfive/ipims/office/image/footer_logo.gif"></td>
                    <td valign="top" class="footer">COPYRIGHT(c) 2010 JUSUNG ENGINEERING CO.,LTD. ALL RIGHT RESERVED.</td>
                </tr>
            </table>
        </TD>
    </TR>
</TABLE>

</BODY>
</HTML>
