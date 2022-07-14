<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>그룹 작성</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("GROUP_CODE");
    addBind("GROUP_NAME");
    addBind("USE_YN");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    SYSTEM_TYPE.value = parent.SYSTEM_TYPE;
    GROUP_CODE.focus();
}

//저장
function fnSave()
{
    if (!cfCheckAllReqValid()) return;

    if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.menugroup.groupcode.act.CreateGroupCode.do";
    prx.addParam("SYSTEM_TYPE", SYSTEM_TYPE.value);
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
        <TD req="SYSTEM_TYPE">구분</TD>
        <TD>
            <ANY:SELECT id="SYSTEM_TYPE" codeData="{SYSTEM_TYPE}" />
        </TD>
    </TR>
    <TR>
        <TD req="GROUP_CODE">그룹코드</TD>
        <TD>
            <INPUT type="text" id="GROUP_CODE" maxByte="3" style="text-transform:uppercase;">
        </TD>
    </TR>
    <TR>
        <TD req="GROUP_NAME">그룹명</TD>
        <TD>
            <INPUT type="text" id="GROUP_NAME" maxByte="100">
        </TD>
    </TR>
    <TR>
        <TD req="USE_YN">사용여부</TD>
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
