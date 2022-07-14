<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>보상금종류 수정</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("RIGHT_DIV_NAME");
    addBind("INOUT_DIV_NAME");
    addBind("REWARD_DIV_NAME");
    addBind("REWARD_PRICE");
    addBind("INV_GRADE");
    addBind("CRE_USER_NAME");
    addBind("CRE_DATE");
    addBind("UPD_USER_NAME");
    addBind("UPD_DATE");
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.basecode.rewardcode.act.RetrieveRewardCodeMgt.do";
    prx.addParam("RIGHT_DIV", parent.RIGHT_DIV);
    prx.addParam("INOUT_DIV", parent.INOUT_DIV);
    prx.addParam("REWARD_DIV", parent.REWARD_DIV);
    prx.addParam("INV_GRADE", parent.INV_GRADE);
    prx.checkData = ds_mainInfo;

    prx.onSuccess = function()
    {
        REWARD_PRICE.focus();
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.basecode.rewardcode.act.UpdateRewardCodeMgt.do";
    prx.addParam("RIGHT_DIV", parent.RIGHT_DIV);
    prx.addParam("INOUT_DIV", parent.INOUT_DIV);
    prx.addParam("REWARD_DIV", parent.REWARD_DIV);
    prx.addParam("INV_GRADE", parent.INV_GRADE);
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.basecode.rewardcode.act.DeleteRewardCodeMgt.do";
    prx.addParam("RIGHT_DIV", parent.RIGHT_DIV);
    prx.addParam("INOUT_DIV", parent.INOUT_DIV);
    prx.addParam("REWARD_DIV", parent.REWARD_DIV);
    prx.addParam("INV_GRADE", parent.INV_GRADE);

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
        <COL class="conthead" width="15%">
        <COL class="contdata" width="35%">
    </COLGROUP>
    <TR>
        <TD>권리구분</TD>
        <TD>
            <INPUT type="text" style="border:none;" id="RIGHT_DIV_NAME" readOnly>
        </TD>
        <TD>국가</TD>
        <TD>
            <INPUT type="text" style="border:none;" id="INOUT_DIV_NAME" readOnly>
        </TD>
    </TR>
    <TR>
        <TD>보상금구분</TD>
        <TD>
            <INPUT type="text" style="border:none;" id="REWARD_DIV_NAME" readOnly>
        </TD>
        <TD>발명등급</TD>
        <TD>
            <ANY:RADIO id="INV_GRADE" codeData="{INV_GRADE}" readOnly/>
        </TD>
    </TR>
    <TR>
        <TD req="REWARD_PRICE">보상금액</TD>
        <TD colspan="3">
            <INPUT type="text" id="REWARD_PRICE" maxByte="10" format="number2" style="text-align:left;">
        </TD>
    </TR>
    <TR>
        <TD>입력자</TD>
        <TD>
            <ANY:SPAN id="CRE_USER_NAME" />
        </TD>
        <TD>입력일</TD>
        <TD>
            <ANY:SPAN id="CRE_DATE" format="date" />
        </TD>
    </TR>
    <TR>
        <TD>수정자</TD>
        <TD>
            <ANY:SPAN id="UPD_USER_NAME" />
        </TD>
        <TD>수정일</TD>
        <TD align="left">
            <ANY:SPAN id="UPD_DATE" format="date" />
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
