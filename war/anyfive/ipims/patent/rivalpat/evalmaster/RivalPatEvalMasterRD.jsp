<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<%@page import="any.util.etc.NDateUtil"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>경쟁사 정보 상세</TITLE>
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
    addBind("EVAL_OPINION");
    addBind("EVAL_GRADE");
    addBind("ETC_FILE", "any_etcFile");
</COMMENT></ANY:DS>
<ANY:DS id="ds_replyList" />
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();
    fnRetrieveReplyList();
}

//조회
function fnRetrieve()
{
    var prx = new any.proxy();

    prx.path = top.getRoot() + "/anyfive.ipims.patent.rivalpat.evalmaster.act.RetrieveRivalPatEvalMaster.do";
    prx.addParam("MGT_ID", parent.MGT_ID);

    prx.onSuccess = function()
    {
        cfSetPageTitle("경쟁사 정보 상세");
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//Reply 조회
function fnRetrieveReplyList()
{
    var prx = new any.proxy();

    prx.path = top.getRoot() + "/anyfive.ipims.patent.rivalpat.evalmaster.act.RetrieveRivalPatEvalReplyList.do";
    prx.addParam("MGT_ID", parent.MGT_ID);

    prx.onSuccess = function()
    {
        var ds = ds_replyList;
        var html = new Array();
        html.push('<TABLE class="main" border="0" cellspacing="1" cellpadding="2" width="100%">');
        html.push('<COLGROUP>');
        html.push('    <COL class="conthead" width="15%">');
        html.push('    <COL class="contdata" width="85%">');
        html.push('</COLGROUP>');
        for (var r = 0; r < ds.rowCount; r++) {
            html.push(' <TR>');
            html.push('     <TD>' + ds.value(r, "CRE_USER_NAME") + '</TD>');
            html.push('     <TD valign="top">');
            html.push('         <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">');
            html.push('             <TR>');
            html.push('                 <TD>' + ds.value(r, "REPLY_CONTENTS") + '</TD>');
            html.push('             </TR>');
            html.push('             <TR>');
            html.push('                 <TD align="right" style="padding-top:2px;">');
            html.push('                     <SPAN style="font-size:10px; color:#999999;">' + ds.value(r, "CRE_DATETIME") + '</SPAN>');
            if (ds.value(r, "CRE_USER") == "<%= app.userInfo.getUserId() %>") {
                html.push('                     <IMG src="' + top.getRoot() + '/anyfive/ipims/share/image/icon_delete.gif" align="absmiddle" title="삭제" style="cursor:hand;" onClick="javascript:fnDeleteReply(\''+ ds.value(r, "REPLY_SEQ") +'\');">');
            }
            html.push('                 </TD>');
            html.push('             </TR>');
            html.push('         </TABLE>');
            html.push('     </TD>');
            html.push(' </TR>');
        }
        html.push('</TABLE>');
        div_replyArea.innerHTML = html.join("\n");
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}


//수정
function fnModify()
{
    window.location.href = "RivalPatEvalMasterUD.jsp";
}

//삭제
function fnDelete()
{
    if (!confirm("<%= app.message.get("msg.com.confirm.delete").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.rivalpat.evalmaster.act.DeleteRivalPatEvalMaster.do";
    prx.addParam("MGT_ID", parent.MGT_ID);

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

//덧글 생성
function fnSaveReply()
{
    if (REPLY_CONTENTS.value == "") {
        alert("내용을 입력하세요.");
        REPLY_CONTENTS.focus();
        return;
    }

    if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.rivalpat.evalmaster.act.CreateRivalPatEvalReply.do";
    prx.addParam("MGT_ID", parent.MGT_ID);
    prx.addParam("REPLY_CONTENTS", REPLY_CONTENTS.value);

    prx.onSuccess = function()
    {
        fnRetrieveReplyList();
        REPLY_CONTENTS.value = "";
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//덧글 삭제
function fnDeleteReply(replySeq)
{
    if (!confirm("<%= app.message.get("msg.com.confirm.delete").toJS() %>")) return;
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.rivalpat.evalmaster.act.DeleteRivalPatEvalReply.do";
    prx.addParam("MGT_ID", parent.MGT_ID);
    prx.addParam("REPLY_SEQ", replySeq);

    prx.onSuccess = function()
    {
        fnRetrieveReplyList();
        alert("<%= app.message.get("msg.com.info.delete").toJS() %>");
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
        <TD colspan="3"><ANY:SPAN id="TITLE" /></TD>
    </TR>
    <TR>
        <TD>출원인대표명</TD>
        <TD colspan="3"><ANY:SPAN id="OWN_APP_MAN" /></TD>
    </TR>
    <TR>
        <TD>국가</TD>
        <TD><ANY:SPAN id="COUNTRY_CODE" /></TD>
        <TD>상태</TD>
        <TD><ANY:SPAN id="STATUS_CODE" /></TD>
    </TR>
    <TR>
        <TD>출원번호</TD>
        <TD><ANY:SPAN id="APP_NO" /></TD>
        <TD>출원일</TD>
        <TD><ANY:SPAN id="APP_DATE" /></TD>
    </TR>
    <TR>
        <TD>기술분류코드</TD>
        <TD colspan="3">
             <ANY:MSEARCH id="any_techCodeList" mode="R"><COMMENT>
                codeColumn = "TECH_CODE";
                nameExpr = "[{#TECH_CODE}] {#TECH_PATHNAME}";
                size = 6;
            </COMMENT></ANY:MSEARCH>
        </TD>
    </TR>
    <TR>
        <TD>우선권번호</TD>
        <TD><ANY:SPAN id="PRIORITY_NO" /></TD>
        <TD>우선권 주장일</TD>
        <TD><ANY:SPAN id="PRIORITY_CLAIM_DATE" format="date" /></TD>
    </TR>
    <TR>
        <TD>국제출원번호</TD>
        <TD><ANY:SPAN id="I_APP_NO" /></TD>
        <TD>국제출원일</TD>
        <TD><ANY:SPAN id="I_APP_DATE" format="date" /></TD>
    </TR>
    <TR>
        <TD>공개번호</TD>
        <TD><ANY:SPAN id="PUB_NO" /></TD>
        <TD>공개일</TD>
        <TD><ANY:SPAN id="PUB_DATE" format="date" /></TD>
    </TR>
    <TR>
        <TD>등록번호</TD>
        <TD><ANY:SPAN id="REG_NO" /></TD>
        <TD>등록일</TD>
        <TD><ANY:SPAN id="REG_DATE" format="date" /></TD>
    </TR>
    <TR>
        <TD>출원인</TD>
        <TD><ANY:SPAN id="APP_MAN" /></TD>
        <TD>출원인식별기호</TD>
        <TD><ANY:SPAN id="APP_MAN_IDENTIFY_MARK" /></TD>
    </TR>
    <TR>
        <TD>발명자</TD>
        <TD><ANY:SPAN id="INVENTOR" /></TD>
        <TD>대리인</TD>
        <TD><ANY:SPAN id="AGENT" /></TD>
    </TR>
    <TR>
        <TD>IPC분류코드</TD>
        <TD colspan="3">
             <ANY:MSEARCH id="any_ipcCodeList" mode="R"><COMMENT>
                codeColumn = "IPC_CODE";
                nameExpr = "[{#IPC_CODE}] {#IPC_PATHNAME}";
                size = 6;
            </COMMENT></ANY:MSEARCH>
        </TD>
    </TR>
    <TR>
        <TD>FI</TD>
        <TD><ANY:SPAN id="FI" /></TD>
        <TD>테마코드</TD>
        <TD><ANY:SPAN id="THEME_CODE" /></TD>
    </TR>
    <TR>
        <TD>청구범위</TD>
        <TD colspan="3"><ANY:SPAN id="REQ_RANGE" /></TD>
    </TR>
    <TR>
        <TD>첨부파일</TD>
        <TD colspan="3">
            <ANY:FILE id="any_etcFile" mode="R" />
        </TD>
    </TR>
    <TR>
        <TD>평가등급</TD>
        <TD colspan="3"><ANY:RADIO id="EVAL_GRADE" codeData="{RIVALPAT_EVAL_GRADE}" readOnly /></TD>
    </TR>
    <TR>
        <TD>평가의견</TD>
        <TD colspan="3"><ANY:SPAN id="EVAL_OPINION" /></TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.modify").toHTML() %>" onClick="javascript:fnModify();"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.delete").toHTML() %>" onClick="javascript:fnDelete();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="list"></BUTTON>
</DIV>

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" style="margin-top:5px;">
    <TR>
        <TD class="title_sub">COMMENTS</TD>
    </TR>
</TABLE>
<TABLE border="0" cellspacing="1" cellpadding="2" class="main" style="margin-top:5px;">
    <COLGROUP>
        <COL class="conthead" width="15%">
        <COL class="contdata" width="85%">
    </COLGROUP>
    <TR>
        <TD><%= app.userInfo.getEmpHname() %></TD>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD><TEXTAREA id="REPLY_CONTENTS" rows="3" maxByte="4000"></TEXTAREA></TD>
                    <TD width="1px" valign="top">
                        <BUTTON text="저장" onClick="javascript:fnSaveReply();" height="47px"></BUTTON>
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
</TABLE>

<DIV id="div_replyArea" style="margin-top:2px;"></DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
