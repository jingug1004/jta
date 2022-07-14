<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>IPC분류코드 작성</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("IPC_CODE");
    addBind("IPC_HNAME");
    addBind("IPC_DESC");
    addBind("USE_YN");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    ds_mainInfo.value(0, "PRIOR_IPC_CODE") = parent.PRIOR_IPC_CODE;

    PRIOR_IPC_CODE_NAME.value = parent.PRIOR_IPC_CODE_NAME;

    IPC_CODE.focus();
}

//저장
function fnSave()
{
    if (!cfCheckAllReqValid()) return;

    if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.basecode.ipccode.act.CreateIpcCode.do";
    prx.addData("ds_mainInfo");

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
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
        <TD req="IPC_CODE">IPC분류 코드</TD>
        <TD>
            <INPUT type="text" id="IPC_CODE" maxByte="20">
        </TD>
    </TR>
    <TR>
        <TD>상위IPC분류 코드</TD>
        <TD>
            <INPUT type="text" id="PRIOR_IPC_CODE_NAME" readOnly style="border:none;">
        </TD>
    </TR>
    <TR>
        <TD req="IPC_HNAME">IPC 한글명</TD>
        <TD>
            <INPUT type="text" id="IPC_HNAME" maxByte="100">
        </TD>
    </TR>
    <TR>
        <TD>IPC 설명</TD>
        <TD>
            <TEXTAREA id="IPC_DESC" rows="10" maxByte="1000"></TEXTAREA>
        </TD>
    </TR>

    <TR>
        <TD req="USE_YN">사용 여부</TD>
        <TD>
            <ANY:RADIO id="USE_YN" codeData="{USE_YN}" value="1" />
        </TD>
    </TR>
</TABLE>
<DIV class="button_area">
    <BUTTON text="저장" onClick="javascript:fnSave();"></BUTTON>
    <BUTTON text="취소" onClick="javascript:top.window.close();"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
