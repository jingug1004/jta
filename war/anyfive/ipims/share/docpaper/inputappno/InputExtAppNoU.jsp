<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.share.common.app.ShareApp"%><% ShareApp app = new ShareApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<%@page import="any.util.etc.NDateUtil"%>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>해외출원정보 입력</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("REF_NO");
    addBind("APP_NO");
    addBind("APP_DATE");
    addBind("PAPER_DATE");
    addBind("EN_APP_TITLE");
    addBind("EXAMREQ_DATE");
    addBind("REMARK");
    addBind("APPDOC_FILE", "any_appdocFile");
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
    prx.path = top.getRoot() + "/anyfive.ipims.share.docpaper.inputappno.act.RetrieveInputAppNo.do";
    prx.addParam("REF_ID", parent.REF_ID);
    prx.addParam("PAPER_CODE", parent.PAPER_CODE);

    prx.onSuccess = function()
    {
        cfShowObjects(["tr_patOnly"], ds_mainInfo.value(0, "RIGHT_DIV") == "10" || ds_mainInfo.value(0, "RIGHT_DIV") == "20");
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//저장
function fnSave(isFileUploaded)
{
    //필수항목 체크
    if (!cfCheckAllReqValid()) return;

    if (isFileUploaded != true) {
        if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;
        cfFileUpload("fnSave(true);");
        return;
    }

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.share.docpaper.inputappno.act.UpdateInputAppNo.do";
    prx.addParam("REF_ID", parent.REF_ID);
    prx.addParam("PAPER_CODE", parent.PAPER_CODE);
    prx.addParam("PAPER_SUBCODE", parent.PAPER_SUBCODE);
    prx.addData("ds_mainInfo");
    prx.addData("ds_ipcCodeList");
    prx.addData("ds_appdocFile");

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        top.window.returnValue = "OK";
        top.window.close();
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
        <COL class="conthead" width="20%">
        <COL class="contdata" width="80%">
    </COLGROUP>
    <TR>
        <TD>REF-NO</TD>
        <TD><SPAN id="REF_NO"></SPAN></TD>
    </TR>
    <TR>
        <TD req="PAPER_DATE">서류일자</TD>
        <TD><ANY:DATE id="PAPER_DATE" /></TD>
    </TR>
    <TR>
        <TD req="APP_NO">출원번호</TD>
        <TD>
            <INPUT type="text" id="APP_NO" maxByte="30">
        </TD>
    </TR>
    <TR>
        <TD req="APP_DATE">출원일자</TD>
        <TD><ANY:DATE id="APP_DATE" /></TD>
    </TR>
    <TR>
        <TD req="EN_APP_TITLE">출원의 명칭(영)</TD>
        <TD><INPUT type="text" id="EN_APP_TITLE" maxByte="1000"></TD>
    </TR>
    <TR id="tr_patOnly" style="display:none;">
        <TD>심사청구일자</TD>
        <TD><ANY:DATE id="EXAMREQ_DATE" /></TD>
    </TR>
    <TR>
        <TD>IPC분류코드</TD>
        <TD>
            <ANY:MSEARCH id="any_ipcCodeList" mode="C"><COMMENT>
                win.path = top.getRoot() + "/anyfive/ipims/patent/common/popup/search/IpcCodeSearchTreeR.jsp";
                codeColumn = "IPC_CODE";
                nameExpr = "[{#IPC_CODE}] {#IPC_PATHNAME}";
                size = 6;
            </COMMENT></ANY:MSEARCH>
        </TD>
    </TR>
    <TR>
        <TD>비고</TD>
        <TD><TEXTAREA id="REMARK" rows="3" maxByte="4000"></TEXTAREA></TD>
    </TR>
    <TR>
        <TD req="any_appdocFile">출원명세서</TD>
        <TD>
            <ANY:FILE id="any_appdocFile" mode="U" policy="appdoc_ext" />
        </TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="close"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
