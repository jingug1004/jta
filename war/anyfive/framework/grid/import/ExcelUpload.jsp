<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.framework.app.FrameworkApp"%><% FrameworkApp app = new FrameworkApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>Excel File Upload</TITLE>
<% app.writeHTMLHeader(); %>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
}

//Template Download
function fnDownloadTemplate()
{
    cfTemplateDownload(parent.templateFile);
}

//Upload
function fnUpload()
{
    if (!cfCheckAllReqValid()) return;

    var ifr = document.getElementById("ifr_upload");
    var fileName = frm1.file.value.trim();

    if (fileName.indexOf(".") == -1 || fileName.substr(fileName.lastIndexOf(".")).toLowerCase() != ".xls") {
        alert("엑셀형식의 파일만 업로드할 수 있습니다.");
        frm1.file.focus();
        return;
    }

    if (isNaN(frm1.sheetNo.value)) {
        alert("시트번호는 숫자만 입력이 가능합니다.");
        frm1.sheetNo.focus();
        frm1.sheetNo.select();
        return;
    }

    ifr.style.display = "block";

    frm1.encoding = "multipart/form-data";
    frm1.method = "post";
    frm1.target = ifr.name;
    frm1.action = top.getRoot() + "/anyfive.framework.grid.act.CreateExcelFileUpload.do";

    bfShowBodyMessage();

    try {
        frm1.submit();
    } catch(ex) {
        bfHideBodyMessage();
        alert("파일을 업로드할 수 없습니다.\n\n파일정보가 정확하게 입력되어 있는지 확인하시기 바랍니다.");
    }
}

//Show Error
function fnShowError(message)
{
    document.getElementById("ifr_upload").style.display = "none";
    bfHideBodyMessage();
    alert(message);
}
</SCRIPT>
</HEAD>

<BODY>

<IFRAME name="ifr_upload" frameBorder="no" width="100%" height="100%" style="position:absolute; left:0px; top:0px; display:none;"></IFRAME>

<% app.writeBodyHeader(); %>

<FORM id="frm1">
<TABLE border="0" cellspacing="1" cellpadding="2" class="main" onEnter="javascript:fnRetrieve();">
    <COLGROUP>
        <COL class="conthead" width="15%">
        <COL class="contdata" width="35%">
        <COL class="conthead" width="15%">
        <COL class="contdata" width="35%">
    </COLGROUP>
    <TR>
        <TD req="file">Upload File</TD>
        <TD colspan="3">
            <INPUT type="file" name="file">
        </TD>
    </TR>
    <TR>
        <TD req="sheetNo">Sheet No</TD>
        <TD>
            <INPUT type="text" name="sheetNo" value="1" onFocus="this.select();">
        </TD>
        <TD>Title Row</TD>
        <TD>
            <LABEL for="firstRowTitle" style="cursor:hand;">
            <INPUT type="checkbox" name="firstRowTitle" id="firstRowTitle" value="1" onFocus="this.blur();" checked>첫행은 제목으로
            </LABEL>
        </TD>
    </TR>
</TABLE>
</FORM>
<DIV class="button_area">
    <BUTTON text="Template Download" onClick="javascript:fnDownloadTemplate();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON text="Upload" onClick="javascript:fnUpload();"></BUTTON>
    <BUTTON text="Cancel" onClick="javascript:top.window.close();"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
