<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>연구소관리 수정</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("LAB_CODE");
    addBind("LAB_NAME");
    addBind("LAB_CHIEF");
    addBind("USE_YN");
    addBind("REMARK");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();
}

//목록 조회
function fnRetrieve()
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.patteam.labmgt.act.RetrieveLabMgt.do"
    prx.addParam("LAB_CODE" , parent.LAB_CODE);
    prx.checkData = ds_mainInfo;

    prx.onSuccess = function(gr, fg)
    {
    }

    prx.onFail = function(gr, fg)
    {
        this.error.show();
    }

    prx.execute();
}

//저장
function fnSave()
{
    if (!cfCheckAllReqValid()) return;

    if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.patteam.labmgt.act.UpdateLabMgt.do";
    prx.addParam("UPD_USER","<%= app.userInfo.getUserId() %>");
    prx.addData("ds_mainInfo");

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        parent.goList();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//삭제
function fnDelete()
{
    if (!confirm("<%= app.message.get("msg.com.confirm.delete").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.patteam.labmgt.act.DeleteLabMgt.do";
    prx.addParam("LAB_CODE", parent.LAB_CODE);

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.delete").toJS() %>");
        parent.goList();
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
        <COL class="conthead" width="15%">
        <COL class="contdata" width="35%">
    </COLGROUP>
    <TR>
        <TD>연구소코드</TD>
        <TD>
            <INPUT type="text" id="LAB_CODE" style="border:none;" readOnly/>
        </TD>
    </TR>
    <TR>
        <TD req="LAB_NAME">연구소명</TD>
        <TD>
            <INPUT type="text" id="LAB_NAME" maxByte="50" />
        </TD>
    </TR>
    <TR>
        <TD>연구소장</TD>
        <TD>
            <ANY:SEARCH id="LAB_CHIEF" mode="C"><COMMENT>
                win.path = top.getRoot() + "/anyfive/ipims/patent/common/popup/search/UserSearchListR.jsp";
                codeColumn = "USER_ID";
                nameExpr = "[{#EMP_NO}] {#EMP_HNAME}";
            </COMMENT></ANY:SEARCH>
        </TD>
    </TR>
    <TR>
        <TD req="USE_YN">사용유무</TD>
        <TD>
            <ANY:RADIO id="USE_YN" codeData="{USE_YN}"/>
        </TD>
    </TR>
    <TR>
        <TD>비고</TD>
        <TD>
            <TEXTAREA id="REMARK" rows="4" maxByte="2000"></TEXTAREA>
        </TD>
    </TR>
</TABLE>
<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.delete").toHTML() %>" onClick="javascript:fnDelete();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="list"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
