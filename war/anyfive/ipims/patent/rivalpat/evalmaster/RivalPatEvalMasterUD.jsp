<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<%@page import="any.util.etc.NDateUtil"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>경쟁사 정보 수정</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("OWN_APP_MAN");
    addBind("COUNTRY_CODE");
    addBind("STATUS_CODE");
    addBind("APP_NO");
    addBind("APP_DATE");
    addBind("TITLE");
    addBind("PRIORITY_NO");
    addBind("PRIORITY_CLAIM_DATE");
    addBind("I_APP_NO");
    addBind("I_APP_DATE");
    addBind("PUB_NO");
    addBind("PUB_DATE");
    addBind("REG_NO");
    addBind("REG_DATE");
    addBind("APP_MAN");
    addBind("APP_MAN_IDENTIFY_MARK");
    addBind("INVENTOR");
    addBind("AGENT");
    //addBind("OWN_IPC");
    //addBind("IPC");
    addBind("FI");
    addBind("THEME_CODE");
    addBind("REQ_RANGE");
    addBind("EVAL_GRADE");
    addBind("EVAL_OPINION");
    addBind("ETC_FILE", "any_etcFile");
</COMMENT></ANY:DS>
<ANY:DS id="ds_evalInfo"><COMMENT>
    addBind("EVAL_GRADE");
    addBind("EVAL_OPINION");
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

    prx.path = top.getRoot() + "/anyfive.ipims.patent.rivalpat.evalmaster.act.RetrieveRivalPatEvalMaster.do";
    prx.addParam("MGT_ID", parent.MGT_ID);
    prx.checkData = ds_mainInfo;

    prx.onSuccess = function()
    {
        cfSetPageTitle("경쟁사 정보 수정 (" + ds_mainInfo.value(0, "WIPS_KEY") + ")");
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

    if (isFileUploaded != true) {
        if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;
        cfFileUpload("fnSave(true);");
        return;
    }

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.rivalpat.evalmaster.act.UpdateRivalPatEvalMaster.do";
    prx.addParam("MGT_ID", parent.MGT_ID);
    prx.addData("ds_mainInfo");
    prx.addData("ds_evalInfo");
    prx.addData("ds_techCodeList");
    prx.addData("ds_ipcCodeList");
    prx.addData("ds_etcFile");

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        window.location.replace("RivalPatEvalMasterRD.jsp");
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
        <TD>발명의명칭</TD>
        <TD colspan="3"><INPUT type="text" id="TITLE" maxByte="4000" /></TD>
    </TR>
    <TR>
        <TD>출원인대표명</TD>
        <TD colspan="3"><INPUT type="text" id="OWN_APP_MAN" maxByte="2000" /></TD>
    </TR>
    <TR>
        <TD>국가</TD>
        <TD><ANY:SELECT id="COUNTRY_CODE" codeData="/common/countryCode" firstName="sel" /></TD>
        <TD>상태</TD>
        <TD><INPUT type="text" id="STATUS_CODE" maxByte="2" /></TD>
    </TR>
    <TR>
        <TD>출원번호</TD>
        <TD><INPUT type="text" id="APP_NO" maxByte="30" /></TD>
        <TD>출원일</TD>
        <TD><ANY:DATE id="APP_DATE" /></TD>
    </TR>
    <TR>
        <TD>기술분류코드</TD>
        <TD colspan="3">
             <ANY:MSEARCH id="any_techCodeList" mode="U"><COMMENT>
                win.path = top.getRoot() + "/anyfive/ipims/patent/common/popup/search/TechCodeSearchTreeR.jsp";
                codeColumn = "TECH_CODE";
                nameExpr = "[{#TECH_CODE}] {#TECH_PATHNAME}";
                size = 6;
            </COMMENT></ANY:MSEARCH>
        </TD>
    </TR>
    <TR>
        <TD>우선권번호</TD>
        <TD><INPUT type="text" id="PRIORITY_NO" maxByte="30" /></TD>
        <TD>우선권 주장일</TD>
        <TD><ANY:DATE id="PRIORITY_CLAIM_DATE" /></TD>
    </TR>
    <TR>
        <TD>국제출원번호</TD>
        <TD><INPUT type="text" id="I_APP_NO" maxByte="30" /></TD>
        <TD>국제출원일</TD>
        <TD><ANY:DATE id="I_APP_DATE" /></TD>
    </TR>
    <TR>
        <TD>공개번호</TD>
        <TD><INPUT type="text" id="PUB_NO" maxByte="30" /></TD>
        <TD>공개일</TD>
        <TD><ANY:DATE id="PUB_DATE" /></TD>
    </TR>
    <TR>
        <TD>등록번호</TD>
        <TD><INPUT type="text" id="REG_NO" maxByte="30" /></TD>
        <TD>등록일</TD>
        <TD><ANY:DATE id="REG_DATE" /></TD>
    </TR>
    <TR>
        <TD>출원인</TD>
        <TD><INPUT type="text" id="APP_MAN" maxByte="4000" /></TD>
        <TD>출원인식별기호</TD>
        <TD><INPUT type="text" id="APP_MAN_IDENTIFY_MARK" maxByte="100" /></TD>
    </TR>
    <TR>
        <TD>발명자</TD>
        <TD><INPUT type="text" id="INVENTOR" maxByte="4000" /></TD>
        <TD>대리인</TD>
        <TD><INPUT type="text" id="AGENT" maxByte="2000" /></TD>
    </TR>
    <TR>
        <TD>IPC분류코드</TD>
        <TD colspan="3">
            <ANY:MSEARCH id="any_ipcCodeList" mode="U"><COMMENT>
                win.path = top.getRoot() + "/anyfive/ipims/patent/common/popup/search/IpcCodeSearchTreeR.jsp";
                codeColumn = "IPC_CODE";
                nameExpr = "[{#IPC_CODE}] {#IPC_PATHNAME}";
                size = 6;
            </COMMENT></ANY:MSEARCH>
        </TD>
    </TR>
    <TR>
        <TD>FI</TD>
        <TD><INPUT type="text" id="FI" maxByte="1000" /></TD>
        <TD>테마코드</TD>
        <TD><INPUT type="text" id="THEME_CODE" maxByte="10" /></TD>
    </TR>
    <TR>
        <TD>청구범위</TD>
        <TD colspan="3"><TEXTAREA id="REQ_RANGE" rows="5" maxByte="4000" ></TEXTAREA></TD>
    </TR>
    <TR>
        <TD>첨부파일</TD>
        <TD colspan="3">
            <ANY:FILE id="any_etcFile" mode="C" policy="paper"/>
        </TD>
    </TR>
    <TR>
        <TD>평가등급</TD>
        <TD colspan="3"><ANY:RADIO id="EVAL_GRADE" codeData="{RIVALPAT_EVAL_GRADE}" /></TD>
    </TR>
    <TR>
        <TD>평가의견</TD>
        <TD colspan="3"><TEXTAREA id="EVAL_OPINION" rows="5" maxByte="4000" /></TEXTAREA></TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.cancel").toHTML() %>" onClick="javascript:history.back();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="list"></BUTTON>
</DIV>
<% app.writeBodyFooter(); %>

</BODY>
</HTML>
