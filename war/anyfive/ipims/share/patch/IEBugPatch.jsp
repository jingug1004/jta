<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.framework.app.FrameworkApp"%><% FrameworkApp app = new FrameworkApp(request, response, out, true, false); %>
<% app.writeHTMLDocType(); %>
<HTML>
<HEAD>
<TITLE>IE 버그 패치하기</TITLE>
<META http-equiv="Content-Type" content="text/html; charset=utf-8">
<META http-equiv="Cache-Control" content="no-cache; no-store; no-save">
<META http-equiv="Expires" content="0">
<META http-equiv="Pragma" content="no-cache">
<STYLE type="text/css">
BODY, TD, SPAN, BUTTON {
    font-family: "Tahoma";
    font-size: 12px;
}
</STYLE>
<SCRIPT language="JScript">
//문서 키입력시
document.onkeypress = function()
{
    if (event.keyCode == 27) {
        top.window.close();
    }
}

//다운로드
function fnDownload()
{
    document.getElementById("ifr").contentWindow.location.replace("IEBugPatchDown.jsp");
}
</SCRIPT>
<BASE target="_self">
</HEAD>

<BODY bgColor="#ECE9D8" style="margin:15px;" scroll="no">

일부 화면영역에서 복사 또는 붙여넣기가 작동되지 않을 수 있습니다.<BR>
이 현상은 Internet Explorer의 버그로 알려져 있습니다.<BR>
다음 방법으로 이 문제를 해결하시기 바랍니다.<BR><BR>
1. <A href="javascript:fnDownload();">IEBugPatch.reg</A> 파일을 다운로드합니다.<BR>
2. 다운로드받은 파일을 실행하여 레지스트리 정보를 추가합니다.<BR>
3. 브라우저를 다시 시작합니다.<BR><BR>

<DIV style="text-align:right;">
    <BUTTON type="button" style="width:90px; height:24px;" onClick="javascript:top.window.close();">Close(Esc)</BUTTON>
</DIV>

<IFRAME id="ifr" style="display:none;"></IFRAME>

</BODY>
</HTML>
