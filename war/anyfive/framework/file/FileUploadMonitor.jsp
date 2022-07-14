<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.framework.app.FrameworkApp"%><% FrameworkApp app = new FrameworkApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML>
<HEAD>
<TITLE>File Upload</TITLE>
<% app.writeHTMLHeader(); %>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onload = function()
{
    if (window.frameElement.reloadDocument == true) {
        parent.location.reload();
    } else {
        fnInitializeFileUploadInfo();
    }
}

//윈도우 종료시
window.onunload = function()
{
    window.frameElement.reloadDocument = true;
    top.disableBlankFrameLoad = false;
}

//Upload 진행상태 초기화
function fnInitializeFileUploadInfo()
{
    td_title.innerText = (top.fileUploadMonitorTitle == null ? "" : top.fileUploadMonitorTitle);
    tbl_title.style.display = (td_title.innerText == "" ? "none" : "block");

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.framework.file.act.InitializeFileUploadInfo.do";
    prx.hideMessage = true;

    prx.onSuccess = function()
    {
        window.setTimeout("fnRetrieveFileUploadInfo()", 250);
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute(false);
}

//Upload 진행상태 조회
function fnRetrieveFileUploadInfo()
{
    td_title.innerText = (top.fileUploadMonitorTitle == null ? "" : top.fileUploadMonitorTitle);
    tbl_title.style.display = (td_title.innerText == "" ? "none" : "block");

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.framework.file.act.RetrieveFileUploadInfo.do";
    prx.hideMessage = true;

    prx.onSuccess = function()
    {
        window.setTimeout("fnRetrieveFileUploadInfo()", 250);

        var uploadInfo;

        try {
            uploadInfo = eval("(" + this.result + ")");
        } catch(ex) {
            return;
        }

        var uploadRatio = uploadInfo.totalRead / uploadInfo.totalSize * 100;

        td_message1.innerText = round(uploadRatio, 2) + " %";
        td_message2.innerText = cfGetFormatNumber(uploadInfo.totalRead) + " Byte / " + cfGetFormatNumber(uploadInfo.totalSize) + " Byte";
        td_message4.innerText = "Elapsed Time : " + cfGetFormatNumber(uploadInfo.elapsedTime) + " sec";

        div_progress.style.width = uploadRatio + "%";

        function round(val, dot)
        {
            var result = String(Math.round(val * Math.pow(10, dot)) / Math.pow(10, dot));
            if (result.indexOf(".") == -1 && dot > 0) result += ".";
            while (result.substr(result.indexOf(".")).length <= dot) {
                result = result + "0";
            }
            return result;
        }
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}
</SCRIPT>
</HEAD>

<BODY scroll="no">

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="0" cellpadding="0" width="80%" height="100%" align="center">
    <TR>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%" id="tbl_title" style="display:none;">
                <TR>
                    <TD id="td_title" style="font-weight:bold;"></TD>
                </TR>
                <TR>
                    <TD height="10px"></TD>
                </TR>
            </TABLE>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD id="td_message1" noWrap style="font-weight:bold;"></TD>
                    <TD id="td_message2" noWrap style="padding-left:10px;" align="right"></TD>
                </TR>
            </TABLE>
            <DIV style="border:#333333 1px solid; width:100%; height:25px; margin:5 0 5 0;">
                <DIV id="div_progress" style="background-color:blue; width:0px; height:100%;"></DIV>
            </DIV>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD id="td_message3" noWrap></TD>
                    <TD id="td_message4" noWrap style="padding-left:10px;" align="right"></TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
