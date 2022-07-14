<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.framework.app.FrameworkApp"%><% FrameworkApp app = new FrameworkApp(request, response, out); %>
<%@page import="java.util.Enumeration"%>
<HTML>
<HEAD>
<TITLE>Print</TITLE>
<META http-equiv="Content-Type" content="text/html; charset=utf-8">
<META http-equiv="Cache-Control" content="no-cache; no-store; no-save">
<META http-equiv="Expires" content="0">
<META http-equiv="Pragma" content="no-cache">
<LINK rel="StyleSheet" type="text/css" href="<%= request.getContextPath() %>/anyfive/framework/css/style.css">
<SCRIPT language="JScript" src="<%= request.getContextPath() %>/anyfive/framework/js/anyworks.js"></SCRIPT>
<SCRIPT language="JScript" src="<%= request.getContextPath() %>/anyfive/framework/js/behavior.js"></SCRIPT>
<SCRIPT language="JScript" src="<%= request.getContextPath() %>/anyfive/framework/js/common.js"></SCRIPT>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onload = function()
{
    <%
    if (request.getMethod().equals("POST")) {
        out.print("fnPrint();");
    } else {
        out.print("fnReload();");
    }
    %>
}

//로드
function fnReload()
{
    if (parent.printData == null) return;

    var frm;
    var hdn;

    frm = document.createElement('<FORM style="display:none;">');
    document.body.appendChild(frm);

    for (var item in parent.printData) {
        hdn = document.createElement('<INPUT type="hidden">');
        hdn.name = item;
        hdn.value = parent.printData[item];
        frm.appendChild(hdn);
    }

    frm.method = "post";
    frm.submit();
}

//인쇄
function fnPrint()
{
    var btns = document.getElementsByTagName("BUTTON");
    var imgs = document.getElementsByTagName("IMG");

    for (var i = 0; i < btns.length; i++) {
        btns[i].style.display = btns[i].display = "none";
    }

    for (var i = 0; i < imgs.length; i++) {
        if (String(imgs[i].isButtonLine) != "true") continue;
        imgs[i].style.display = "none";
    }

    factory.printing.header = ""; // 머릿말 설정
    factory.printing.footer = ""; // 꼬릿말 설정
    factory.printing.portrait = (parent.portrait == null ? true : parent.portrait); // 출력방향 설정 : false 면 가로인쇄, true 면 세로 인쇄
    factory.printing.leftMargin = 10.0; // 왼쪽 여백 설정
    factory.printing.topMargin = 10.0; // 위 여백 설정
    factory.printing.rightMargin = 10.0; // 오른쪽 여백 설정
    factory.printing.bottomMargin = 10.0; // 아래 여백 설정
    factory.printing.Print(true, window); // print with prompt
}

//인쇄 시작시
window.onbeforeprint = function()
{
    tr_buttons.style.display = "none";
}

//인쇄 종료시
window.onafterprint = function()
{
    tr_buttons.style.display = "block";
}
</SCRIPT>
<OBJECT id="factory" VIEWASTEXT style="display:none"
 classid="CLSID:1663ED61-23EB-11D2-B92F-008048FDD814"
 codebase="<%= request.getContextPath() %>/anyfive/framework/util/scriptx/smsx.cab#Version=6,3,436,14">
</OBJECT>
</HEAD>

<BODY style="margin:10px;" scroll="auto">

<% if (request.getMethod().equals("POST")) { %>
<TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
    <% if (request.getParameter("title") != null) { %>
    <TR>
        <TD style="padding-bottom:10px;">
            <SPAN id="__PAGE_TITLE_SPAN__" class="title_main"><%= app.getEncodingParameter("title") %></SPAN>
        </TD>
    </TR>
    <% } %>
    <TR>
        <TD valign="top" height="100%">
            <%
            String html = app.getEncodingParameter("html");
            String head = "<ANY:APPROVAL id=";

            for (Enumeration<?> enumeration = request.getParameterNames(); enumeration.hasMoreElements();) {
                String key = (String)enumeration.nextElement();
                if (key.equals("title") || key.equals("html")) continue;
                html = html.replaceAll(head + key, app.getEncodingParameter(key) + "\n" + head + key);
            }

            out.print(html);
            %>
        </TD>
    </TR>
    <TR id="tr_buttons">
        <TD align="right" style="padding-top:5px;">
            <INPUT type="button" value="Print"
                style="border:#BFBFBF 1px solid; width:60px; height:22px; cursor:hand;"
                onClick="javascript:window.print();"
            >
            <INPUT type="button" value="Close"
                style="border:#BFBFBF 1px solid; width:60px; height:22px; cursor:hand;"
                onClick="javascript:top.window.close();"
            >
        </TD>
    </TR>
</TABLE>
<% } %>

</BODY>
</HTML>
