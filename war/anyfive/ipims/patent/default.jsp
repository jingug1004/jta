<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out, true, false); %>
<%@page import="any.core.config.NConfig"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE><%= NConfig.getString(NConfig.DEFAULT_CONFIG + "/system-title") %></TITLE>
<% app.writeHTMLHeader(app.PAGE_TYPE_DEFAULT); %>
<% app.writeHTCImport("/anyfive/ipims/share/menu/MenuDataHTC.jsp"); %>
<% app.writeHTCImport("/anyfive/ipims/share/menu/MenuTopHTC.jsp"); %>
<% app.writeHTCImport("/anyfive/ipims/share/menu/MenuLeftHTC.jsp"); %>
<link href="<%= request.getContextPath() %>/anyfive/ipims/patent/home/newstyle.css" rel="stylesheet" type="text/css">
<ANY:MENUDATA id="any_menuData" menuTop="any_menuTop" menuLeft="any_menuLeft" />
<SCRIPT language="JScript">
//윈도우 로딩시
window.oninit = function()
{
    document.body.style.visibility = "visible";
}

//Home 숨김/표시
function fnShowHideHome(bool)
{
    var homePath;

    if (bool == true) {
        td_body.style.display = "none";
        td_home.style.display = "block";
        homePath = top.getRoot() + "/anyfive/ipims/patent/home/Home.jsp";
    } else {
        td_home.style.display = "none";
        td_body.style.display = "block";
        homePath = top.getRoot() + "/anyfive/framework/util/blank.htm";
    }

    document.frames["ifr_home"].location.replace(homePath);
}

//Logout
function fnLogout()
{
    var logOutPath = "<%= NConfig.getString("/config/log-out/path") %>";

    if (logOutPath != "") {
        top.window.location.replace(logOutPath);
        return;
    }

    if (!confirm("로그아웃 하시겠습니까?")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.share.login.act.Logout.do";

    prx.onSuccess = function()
    {
        alert("로그아웃 되었습니다.");
        top.location.replace(top.getRoot() + "/anyfive/ipims/share/login/SessionOut.jsp");
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//번호검색
function fnSearchNo()
{
    var ps = new cfPopupSearch();
    ps.prx.path = top.getRoot() + "/anyfive.ipims.patent.common.popup.search.act.RetrieveUserSearchList.do";
    ps.win.path = top.getRoot() + "/anyfive/ipims/patent/common/popup/search/MainUserSearchListR.jsp";
    ps.win.opt.width = 700;
    ps.win.opt.height = 500;
    ps.searchText = txt_totalSearch;
    ps.multiCheck = true;
    ps.resultFunc = openMaster;
    ps.closePopup = true;
    ps.search(false);

    function openMaster(obj)
    {
        var win = new any.window();
        win.path = top.getRoot() + "/anyfive/ipims/patent/common/popup/search/PopMainUserSearchListR.jsp?ID=" + obj.USER_ID;
        win.opt.width = 700;
        win.opt.height = 500;
        win.show();

    }
}

</SCRIPT>

<!-- 메뉴데이터 로딩시 -->
<SCRIPT language="JScript" for="any_menuData" event="OnLoad()">
    fnShowHideHome(true);
</SCRIPT>

<!-- 상단메뉴 변경시 -->
<SCRIPT language="JScript" for="any_menuTop" event="OnChange()">
    any_menuLeft.show(this.selectedMenu.code);
    fnShowHideHome(false);
</SCRIPT>

<!-- 좌측메뉴 변경시 -->
<SCRIPT language="JScript" for="any_menuLeft" event="OnChange()">
    any_menuTop.show(this.selectedMenu.code);
    document.getElementById("ifr_body").contentWindow.location.replace(top.getRoot() + any_menuLeft.selectedMenu.path);
    fnShowHideHome(false);
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

<BODY >
<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
    <TR>
        <TD height="1px" background="<%= request.getContextPath() %>/anyfive/ipims/patent/image/top_bg.gif">
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">

                <TR>
                    <TD height="36">
                        <IMG src="<%= request.getContextPath() %>/anyfive/ipims/patent/image/ipims_logo.gif"
                            onClick="javascript:top.window.location.replace(top.window.location.pathname);"
                            alt="메인 화면으로 이동합니다."
                            style="cursor:hand;"
                        ></TD>
                    <TD align="right" style="padding-right:15px;" noWrap>
                        <%= app.userInfo.getEmpHname() %>님 반갑습니다.
                        <IMG src="<%= request.getContextPath() %>/anyfive/ipims/patent/image/btn_logout.gif" align="absmiddle" style="cursor:hand;" onClick="javascript:fnLogout();">
                        <A href="http://csr.anyfive.com" onFocus="this.blur();" target="_blank"><IMG src="<%= request.getContextPath() %>/anyfive/ipims/patent/image/btn_csr.gif" border="0" align="absmiddle"></A>
                        <img src="<%= request.getContextPath() %>/anyfive/ipims/patent/image/space.gif" alt="" align="absmiddle"><img src="<%= request.getContextPath() %>/anyfive/ipims/patent/image/user_business_search.gif" alt="" align="absmiddle">

                        <INPUT type="text" id="txt_totalSearch"
                            style="border:1px solid #B3B3B3; width:130px; height:18px; padding:2px 0px 2px 5px;margin-left:2px;margin-right:5px;color:#767676;"
                            onKeyPress="javascript:if (event.keyCode == 13) { event.keyCode = 0; fnSearchNo(); }"
                            title="사원검색"
                        > <IMG src="<%= request.getContextPath() %>/anyfive/ipims/patent/image/btn_Search.gif"
                            border="0" width="50" height="18" align="absmiddle"
                            style="cursor:hand;"
                            onClick="javascript:fnSearchNo();"
                            title="사원검색"
                        >
                    </TD>
                </TR>
            </TABLE>
            <ANY:MENUTOP id="any_menuTop" />
        </TD>
    </TR>
    <TR>
        <TD id="td_home" height="100%">
            <IFRAME id="ifr_home" frameBorder="0" scrolling="no" width="100%" height="100%"></IFRAME>
        </TD>
    </TR>
    <TR>
        <TD id="td_body" height="100%" style="display:none;">
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
                <TR>
                    <TD valign="top">
                        <ANY:MENULEFT id="any_menuLeft" style="width:204px;" />
                    </TD>
                    <TD width="100%">
                        <IFRAME id="ifr_body" frameBorder="0" scrolling="no" width="100%" height="100%"></IFRAME>
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD>
           <table width="100%" border="0" cellpadding="0" cellspacing="0"  background="<%= request.getContextPath() %>/anyfive/ipims/share/menu/image/bottom_bg.gif" >
    <tr>
      <td><img src="<%= request.getContextPath() %>/anyfive/ipims/share/menu/image/bottom.gif" ></td>
      <td><table border="0" align="right" cellpadding="0" cellspacing="0">
          <tr>
            <td class="jupos_site">지식재산관련기관<br>
              <select name = "Category4" onchange="if(this.value) window.open(this.value);">
                <option value = "">(전체)</option>
                <option value = " http://www.kipo.go.kr/kpo2/user.tdf?a=user.main.MainApp">한국특허청</option>
                <option value = " http://www.pct.go.kr/">한국특허청 PCT국제출원</option>
                <option value = " http://www.patent.go.kr/portal/Main.do">특허路</option>
                <option value = " http://www.kipi.or.kr/">한국특허정보원</option>
                <option value = " http://www.kipa.org/kipaweb/main/main.kipa">한국발명진흥회</option>
                <option value = " http://www.ipac.kr/">특허지원센타(i-PAC)</option>
                <option value = " http://www.kdia.org/">한국디스플레이산업협회(KDIA)</option>
                <option value = " http://www.kinpa.or.kr/Main.do">한국지식재산협의회(KINPA)</option>
                <option value = " http://www.kaips.or.kr/">한국지식재산서비스협회(KAIPS)</option>
                <option value = " http://www.patentmart.or.kr/">IP-Mart</option>
                <option value = " http://www.wipo.int/portal/index.html.en">세계지식재산권기구(WIPO)</option>
                <option value = " http://patents.uspto.gov/">미국특허청(USPTO)</option>
                <option value = " http://www.epo.org/">유럽특허청(EPO)</option>
                <option value = " http://www.jpo.go.jp/">일본특허청(JPO)</option>
                <option value = " http://www.sipo.gov.cn/">중국특허청(SIPO)</option>
                <option value = " http://twpat.tipo.gov.tw/">대만특허청(TIPO)</option>
                <option value = " http://www.moleg.go.kr/">법제처</option>
              </select></td>
            <td class="jupos_site">특허정보검색<br>
              <select name = "Category" onchange="if(this.value) window.open(this.value);">
                <option value = "">(전체)</option>
                <option value = " http://www.kipris.or.kr/">키프리스(KIPRIS)</option>
                <option value = " http://search.wips.co.kr/">윕스(WIPS)</option>
                <option value = " http://www.patpen.co.kr/">PATpen특허법령·판례센타</option>
                <option value = " http://www.ipac.kr/">특허지원센타(i-PAC)</option>
                <option value = " http://www.wintelips.com/">윈텔립스(WiNTELiPS)</option>
                <option value = " http://patft.uspto.gov/">미국특허청 특허검색(PatFT)</option>
               </select></td>
            <td class="jupos_site2">지식재산권교육<br>
              <select name = "Category2" onchange="if(this.value) window.open(this.value);">
                <option value = "">(전체)</option>
                <option value = " http://www.ipacademy.net/">IP아카데미</option>
                <option value = " http://www.ipcampus.kr/">IP-CAMPUS</option>

                <option value = " http://global.ipacademy.net/">온라인 국제특허교육(Global-IP아카데미)</option>
              </select></td>
          </tr>
        </table></td>
    </tr>
  </table>
        </TD>
    </TR>
</TABLE>

</BODY>
</HTML>
