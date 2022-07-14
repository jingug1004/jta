<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>업무프로세스</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("CURR_STATUS");
    addBind("BIZ_ACT");
    addBind("NEXT_STATUS");
    addBind("ACT_OWNER");
    addBind("ACT_COND_NO");
    addBind("ACT_COND_QRY");
    addBind("NEXT_STEP_ID");
    addBind("TODO_DISP_YN");
    addBind("URGENT_DATE_QRY");
    addBind("DUE_DATE_QRY");
    addBind("PAPER_CODE");
    addBind("PAPER_SUBCODE");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    NEXT_STEP_ID.codeData = "/systemmgt/bizStep," + parent.BIZ_STEP_ID;

    if (parent.BIZ_PROC_SEQ == null) {
        CURR_STATUS.doSearch();
    } else {
        btn_delete.style.display = "inline";
        fnRetrieve();
    }
}

//조회
function fnRetrieve()
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.workprocess.workproc.act.RetrieveWorkProcMgt.do";
    prx.addParam("BIZ_STEP_ID", parent.BIZ_STEP_ID);
    prx.addParam("BIZ_PROC_SEQ", parent.BIZ_PROC_SEQ);

    prx.onSuccess = function()
    {
        if (ds_mainInfo.value(0, "PAPER_CODE") != "") {
            PAPER_SUBCODE.codeData = "/common/paperSubcode," + ds_mainInfo.value(0, "PAPER_CODE");
        }
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
    if (parent.BIZ_PROC_SEQ == null) {
        prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.workprocess.workproc.act.CreateWorkProcMgt.do";
    } else {
        prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.workprocess.workproc.act.UpdateWorkProcMgt.do";
        prx.addParam("BIZ_PROC_SEQ", parent.BIZ_PROC_SEQ);
    }
    prx.addParam("BIZ_STEP_ID", parent.BIZ_STEP_ID);
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.workprocess.workproc.act.DeleteWorkProcMgt.do";
    prx.addParam("BIZ_STEP_ID", parent.BIZ_STEP_ID);
    prx.addParam("BIZ_PROC_SEQ", parent.BIZ_PROC_SEQ);

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

<!-- 진행서류 변경시 -->
<SCRIPT language="JScript" for="PAPER_CODE" event="OnChange()">
    if (this.value == "") {
        PAPER_SUBCODE.clearAll();
    } else {
        PAPER_SUBCODE.codeData = "/common/paperSubcode," + this.value;
        PAPER_SUBCODE.index = 0;
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
        <TD req="CURR_STATUS">현재 상태</TD>
        <TD>
            <ANY:SEARCH id="CURR_STATUS" mode="C"><COMMENT>
                win.path = top.getRoot() + "/anyfive/ipims/patent/systemmgt/workprocess/workcode/WorkCodeSearchListR.jsp";
                win.arg.CODE_KIND = "S";
                codeColumn = "CURR_STATUS";
                nameExpr = "[{#CURR_STATUS}] {#CURR_STATUS_NAME}";
                setColumn("CURR_STATUS", "CODE_VALUE");
                setColumn("CURR_STATUS_NAME", "CODE_NAME");
            </COMMENT></ANY:SEARCH>
        </TD>
    </TR>
    <TR>
        <TD req="BIZ_ACT">업무 액션</TD>
        <TD>
            <ANY:SEARCH id="BIZ_ACT" mode="C"><COMMENT>
                win.path = top.getRoot() + "/anyfive/ipims/patent/systemmgt/workprocess/workcode/WorkCodeSearchListR.jsp";
                win.arg.CODE_KIND = "A";
                codeColumn = "BIZ_ACT";
                nameExpr = "[{#BIZ_ACT}] {#BIZ_ACT_NAME}";
                setColumn("BIZ_ACT", "CODE_VALUE");
                setColumn("BIZ_ACT_NAME", "CODE_NAME");
            </COMMENT></ANY:SEARCH>
        </TD>
    </TR>
    <TR>
        <TD req="NEXT_STATUS">다음 상태</TD>
        <TD>
            <ANY:SEARCH id="NEXT_STATUS" mode="C"><COMMENT>
                win.path = top.getRoot() + "/anyfive/ipims/patent/systemmgt/workprocess/workcode/WorkCodeSearchListR.jsp";
                win.arg.CODE_KIND = "S";
                codeColumn = "NEXT_STATUS";
                nameExpr = "[{#NEXT_STATUS}] {#NEXT_STATUS_NAME}";
                setColumn("NEXT_STATUS", "CODE_VALUE");
                setColumn("NEXT_STATUS_NAME", "CODE_NAME");
            </COMMENT></ANY:SEARCH>
        </TD>
    </TR>
    <TR>
        <TD req="ACT_OWNER">액션 주체</TD>
        <TD>
            <ANY:SELECT id="ACT_OWNER" codeData="/systemmgt/bizActOwner" firstName="sel" />
        </TD>
    </TR>
    <TR>
        <TD req="ACT_COND_NO">액션조건 번호</TD>
        <TD>
            <INPUT type="text" id="ACT_COND_NO" value="00" maxByte="2" onFocus="this.select();">
        </TD>
    </TR>
    <TR>
        <TD>액션조건 쿼리</TD>
        <TD>
            <TEXTAREA id="ACT_COND_QRY" rows="3" maxByte="4000"></TEXTAREA>
        </TD>
    </TR>
    <TR>
        <TD>다음 업무단계</TD>
        <TD>
            <ANY:SELECT id="NEXT_STEP_ID" firstName="" />
        </TD>
    </TR>
    <TR>
        <TD req="TODO_DISP_YN">TO-DO 표시여부</TD>
        <TD>
            <ANY:RADIO id="TODO_DISP_YN" codeData="{YES_NO}" value="0" />
        </TD>
    </TR>
    <TR>
        <TD>업무기한일 쿼리</TD>
        <TD>
            <TEXTAREA id="URGENT_DATE_QRY" rows="3" maxByte="4000"></TEXTAREA>
        </TD>
    </TR>
    <TR>
        <TD>법정기한일 쿼리</TD>
        <TD>
            <TEXTAREA id="DUE_DATE_QRY" rows="3" maxByte="4000"></TEXTAREA>
        </TD>
    </TR>
    <TR>
        <TD>진행서류</TD>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD width="50%">
                        <ANY:SEARCH id="PAPER_CODE" mode="C"><COMMENT>
                            win.path = top.getRoot() + "/anyfive/ipims/patent/common/popup/search/PaperSearchListR.jsp";
                            win.opt.width = 600;
                            codeColumn = "PAPER_CODE";
                            nameExpr = "[{#PAPER_CODE}] {#PAPER_NAME}";
                        </COMMENT></ANY:SEARCH>
                    </TD>
                    <TD><IMG src="<%= request.getContextPath() %>/anyfive/framework/img/blank.gif" width="5" height="1"></TD>
                    <TD width="50%">
                        <ANY:SELECT id="PAPER_SUBCODE" />
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
</TABLE>
<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.delete").toHTML() %>" onClick="javascript:fnDelete();" id="btn_delete" display="none"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="list"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
