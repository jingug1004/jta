<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>게시판 관리 수정</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("SYSTEM_TYPE");
    addBind("MENU_CODE");
    addBind("BRD_ID");
    addBind("WRITE_AVAIL");
    addBind("ANS_AVAIL");
    addBind("READ_CNT_DISP");
    addBind("NOTICE_PERIOD");
    addBind("FILE_POLICY");
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.boardmgt.act.RetrieveBoardMgt.do";
    prx.addParam("BRD_CODE", parent.BRD_CODE);
    prx.checkData = ds_mainInfo;

    prx.onSuccess = function()
    {
        MENU_CODE.win.arg.SYSTEM_TYPE = ds_mainInfo.value(0, "SYSTEM_TYPE");
    }

    prx.onFail = function()
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.boardmgt.act.UpdateBoardMgt.do";
    prx.addParam("BRD_CODE", parent.BRD_CODE);
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

//삭제
function fnDelete()
{
    if (!confirm("<%= app.message.get("msg.com.confirm.delete").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.boardmgt.act.DeleteBoardMgt.do";
    prx.addParam("BRD_CODE", parent.BRD_CODE);

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.delete").toJS() %>");
        top.window.close();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}
</SCRIPT>

<!-- 메뉴구분 변경시 -->
<SCRIPT language="JScript" for="SYSTEM_TYPE" event="OnChange()">
    MENU_CODE.win.arg.SYSTEM_TYPE = this.value;
    MENU_CODE.value = "";
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
        <TD req="MENU_CODE">게시판 메뉴</TD>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD width="70px">
                        <ANY:SELECT id="SYSTEM_TYPE" codeData="{SYSTEM_TYPE}" />
                    </TD>
                    <TD style="padding-left:3px;">
                        <ANY:SEARCH id="MENU_CODE" mode="U"><COMMENT>
                            win.path = top.getRoot() + "/anyfive/ipims/patent/common/popup/search/MenuCodeSearchTreeR.jsp";
                            codeColumn = "MENU_CODE";
                            nameExpr = "[{#MENU_CODE}] {#MENU_NAME}";
                        </COMMENT></ANY:SEARCH>
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD req="BRD_ID">게시판 ID</TD>
        <TD>
            <INPUT id="BRD_ID" maxByte="10" style="text-transform:uppercase;">
        </TD>
    </TR>
    <TR>
        <TD req="WRITE_AVAIL">작성 가능</TD>
        <TD>
            <ANY:RADIO id="WRITE_AVAIL" codeData="{YES_NO}" />
        </TD>
    </TR>
    <TR>
        <TD req="ANS_AVAIL">답변 가능</TD>
        <TD>
            <ANY:RADIO id="ANS_AVAIL" codeData="{YES_NO}" />
        </TD>
    </TR>
    <TR>
        <TD req="READ_CNT_DISP">조회수 표시</TD>
        <TD>
            <ANY:RADIO id="READ_CNT_DISP" codeData="{YES_NO}" />
        </TD>
    </TR>
    <TR>
        <TD req="NOTICE_PERIOD">공지기간 관리</TD>
        <TD>
            <ANY:RADIO id="NOTICE_PERIOD" codeData="{YES_NO}" />
        </TD>
    </TR>
    <TR>
        <TD>첨부파일 정책</TD>
        <TD>
            <INPUT id="FILE_POLICY" maxByte="30">
        </TD>
    </TR>
</TABLE>
<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.delete").toHTML() %>" onClick="javascript:fnDelete();"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.cancel").toHTML() %>" onClick="javascript:top.window.close();"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
