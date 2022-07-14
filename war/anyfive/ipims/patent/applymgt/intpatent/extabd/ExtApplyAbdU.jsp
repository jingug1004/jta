<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="any.util.etc.NDateUtil"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>해외출원 포기</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("EXT_APP_ABD_DATE");
    addBind("EXT_APP_ABD_REASON");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    REF_NO.value = parent.REF_NO;

    EXT_APP_ABD_REASON.focus();
}

//저장
function fnSave()
{
    //필수항목 체크
    if (!cfCheckAllReqValid()) return;

    //저장 확인
    if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.intpatent.extabd.act.UpdateExtApplyAbd.do";
    prx.addParam("REF_ID", parent.REF_ID);
    prx.addData("ds_mainInfo");

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
        <COL class="conthead" width="25%">
        <COL class="contdata" width="75%">
    </COLGROUP>
    <TR>
        <TD>REF-NO</TD>
        <TD><INPUT type="text" id="REF_NO" readOnly style="border:none;"></TD>
    </TR>
    <TR>
        <TD req="EXT_APP_ABD_DATE">해외출원 포기일</TD>
        <TD><ANY:DATE id="EXT_APP_ABD_DATE" value="<%= NDateUtil.getSysDate() %>" /></TD>
    </TR>
    <TR>
        <TD>해외출원 포기 처리자</TD>
        <TD><%= app.userInfo.getEmpHname() %></TD>
    </TR>
    <TR>
        <TD req="EXT_APP_ABD_REASON">해외출원 포기 사유</TD>
        <TD><TEXTAREA id="EXT_APP_ABD_REASON" rows="10" maxByte="4000"></TEXTAREA></TD>
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
