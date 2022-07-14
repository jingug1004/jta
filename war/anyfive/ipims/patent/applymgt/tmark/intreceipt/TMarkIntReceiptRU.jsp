<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>상표출원의뢰접수 상세</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_APPROVAL); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("REF_NO");
    addBind("KO_APP_TITLE");
    addBind("EN_APP_TITLE");
    addBind("APP_IMMED_YN");
    addBind("APP_IMMED_REASON");
    addBind("TMARK_IMG_FILE", "any_tmarkImgFile");
    addBind("OUT_PLAN_DATE");
    addBind("APPLY_MODEL_NAME");
    addBind("ETC_FILE", "any_etcFile");
    addBind("REQ_CONTENTS");
    addBind("USER_NAME");
    addBind("CRE_DATE");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    REF_NO.innerText = parent.REF_NO;

    fnRetrieve();
}

//조회
function fnRetrieve()
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.tmark.intreceipt.act.RetrieveTMarkIntReceipt.do";
    prx.addParam("REF_ID", parent.REF_ID);

    prx.checkData = ds_mainInfo;

    prx.onSuccess = function()
    {
        any_approval.reset();
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
    if (JOB_MAN.value == "") {
        alert("건담당자를 선택하세요.");
        JOB_MAN.focus();
        return;
    }

    //저장 확인
    if (!confirm(any.message.get("msg.com.jobman.save", JOB_MAN.text))) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.tmark.intreceipt.act.UpdateTMarkIntReceipt.do";
    prx.addParam("JOB_MAN", JOB_MAN.value);
    prx.addParam("REF_ID", parent.REF_ID);

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.jobman.info").toJS() %>");
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
        <TD>REF-NO</TD>
        <TD><SPAN id="REF_NO"></SPAN></TD>
        <TD>작성자(작성일)</TD>
        <TD><SPAN id="USER_NAME"></SPAN>(<ANY:SPAN id="CRE_DATE" format="date"></ANY:SPAN>)</TD>
    </TR>
    <TR>
        <TD>상표명(한)</TD>
        <TD colspan="3"><SPAN id="KO_APP_TITLE"></SPAN></TD>
    </TR>
    <TR>
        <TD>상표명(영)</TD>
        <TD colspan="3"><SPAN id="EN_APP_TITLE"></SPAN></TD>
    </TR>
    <TR>
        <TD>창작자</TD>
        <TD colspan="3">
            <ANY:INV id="any_inventorList" mode="R" />
        </TD>
    </TR>
    <TR>
        <TD>상표이미지</TD>
        <TD colspan="3">
            <ANY:FILE id="any_tmarkImgFile" mode="R" imageMode="true" />
        </TD>
    </TR>
    <TR>
        <TD>출시예정시기</TD>
        <TD><ANY:SPAN id="OUT_PLAN_DATE" format="date" /></TD>
        <TD>적용모델</TD>
        <TD><SPAN id="APPLY_MODEL_NAME"></SPAN></TD>
    </TR>
    <TR>
        <TD>출원의 완급</TD>
        <TD>
            <ANY:RADIO id="APP_IMMED_YN" codeData="{APP_IMMED_YN}" readOnly />
        </TD>
        <TD>출원긴급이유</TD>
        <TD><SPAN id="APP_IMMED_REASON"></SPAN></TD>
    </TR>
    <TR>
        <TD>기타자료</TD>
        <TD colspan="3">
            <ANY:FILE id="any_etcFile" mode="R" />
        </TD>
    </TR>
    <TR>
        <TD>창작자 의뢰내용</TD>
        <TD colspan="3"><SPAN id="REQ_CONTENTS"></SPAN></TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <ANY:SELECT id="JOB_MAN" codeData="/common/jobMan,TRA" value="<%= app.userInfo.getUserId() %>" style="width:100px;" />
    <BUTTON text="<%= app.message.get("btn.com.jobman").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>
    <BUTTON auto="none" id="btn_line"></BUTTON>
    <BUTTON auto="list"></BUTTON>
</DIV>

<ANY:APPROVAL id="any_approval" code="T01"><COMMENT>
    addKey("REF_ID", parent.REF_ID);
</COMMENT></ANY:APPROVAL>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
