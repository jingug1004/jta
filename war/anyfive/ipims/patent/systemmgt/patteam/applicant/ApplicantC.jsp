<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>출원인 등록</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    //addBind("APP_MAN_CODE");
    addBind("APP_MAN_NAME");
    addBind("ADDRESS");
    addBind("REMARK");
    addBind("USE_YN");
</COMMENT></ANY:DS>
</head>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    APP_MAN_CODE.focus();
}

//저장
function fnSave()
{
    if (!cfCheckAllReqValid()) return;

    if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.patteam.applicant.act.CreateApplicant.do";
    prx.addData("ds_mainInfo");

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        parent.APP_MAN_CODE = this.result;
        window.location.replace("ApplicantU.jsp");
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}
</SCRIPT>
<body>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="1" cellpadding="2" class="main">
    <COLGROUP>
        <COL class="conthead" width="15%">
        <COL class="contdata" width="35%">
        <COL class="conthead" width="15%">
        <COL class="contdata" width="35%">
    </COLGROUP>
    <TR>
        <TD>츨원인 코드</TD>
        <TD disabled>(<%= app.message.get("msg.com.autocreate") %>)</TD>
        <TD req="APP_MAN_NAME">출원인</TD>
        <TD>
            <INPUT type="text" id="APP_MAN_NAME" maxByte="200">
        </TD>
    </TR>
    <TR>
        <TD req="ADDRESS">주소</TD>
        <TD colspan="3">
            <INPUT type="text" id="ADDRESS" maxByte="50">
        </TD>
    </TR>
    <TR>
        <TD>비고</TD>
        <TD colspan="3">
            <TEXTAREA id="REMARK" rows="3" maxByte="400"></TEXTAREA>
        </TD>
    </TR>
    <TR>
        <TD req="USE_YN">사용여부</TD>
        <TD colspan="3">
            <ANY:RADIO id="USE_YN" codeData="{USE_YN}" value="1" />
        </TD>
    </TR>
</TABLE>
<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="list"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</body>
</html>
