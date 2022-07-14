<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>시스템 업데이트 파일 업로드</TITLE>
<% app.writeHTMLHeader(); %>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
}

//업로드
function fnUpload()
{
    if (!cfCheckAllReqValid()) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.configure.update.act.CheckUpdateKey.do";
    prx.addParam("UPDATE_KEY", frm1.UPDATE_KEY.value);

    prx.onSuccess = function()
    {
        if (prx.result != "OK") {
            alert("업데이트 인증키가 올바르지 않습니다.");
            frm1.UPDATE_KEY.focus();
            frm1.UPDATE_KEY.select();
            return;
        }

        if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;

        cfShowFileUploadMonitor();

        frm1.action = top.getRoot() + "/anyfive.ipims.patent.systemmgt.configure.update.act.UploadUpdateFile.do";
        frm1.method = "post";
        frm1.target = "ifr1";
        frm1.encoding = "multipart/form-data";
        frm1.submit();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//업로드 성공시 - UploadUpdateFile.do 에서 호출됨
function fnUpload_OnSuccess()
{
    cfHideFileUploadMonitor();

    alert("업데이트 파일을 성공적으로 업로드하였습니다.");
    parent.reloadList();
    top.window.close();
}

//업로드 실패시 - UploadUpdateFile.do 에서 호출됨
function fnUpload_OnFail(errorMessage)
{
    cfHideFileUploadMonitor();

    alert(errorMessage);
}
</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<FORM name="frm1">
<TABLE border="0" cellspacing="1" cellpadding="2" class="main">
    <COLGROUP>
        <COL class="conthead" width="20%">
        <COL class="contdata" width="80%">
    </COLGROUP>
    <TR>
        <TD req="UPDATE_FILE">업데이트 파일</TD>
        <TD><INPUT type="file" name="UPDATE_FILE"></TD>
    </TR>
    <TR>
        <TD req="UPDATE_KEY">업데이트 인증키</TD>
        <TD><INPUT type="text" name="UPDATE_KEY"></TD>
    </TR>
</TABLE>
</FORM>

<DIV class="button_area">
    <BUTTON text="업로드" onClick="javascript:fnUpload();" id="btn_upload"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="close"></BUTTON>
</DIV>

<IFRAME name="ifr1" style="display:none;"></IFRAME>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
