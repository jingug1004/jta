<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<%@page import="any.util.etc.NDateUtil"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>감정서 작성</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("COUNTRY_CODE");
    addBind("RIGHT_DIV");
    addBind("REQ_MAN");
    addBind("EXPOPIN_ORGAN");
    addBind("EXPOPIN_MAN");
    addBind("EXPOPIN_CLS");
    addBind("EXPOPIN_DATE");
    addBind("EXPOPIN_FEATURE");
    addBind("EXPOPIN_TARGET");
    addBind("EXPOPIN_OPINION");
    addBind("ATTACH_FILE", "any_attachFile");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
}

//저장
function fnSave(isFileUploaded)
{
    if (!cfCheckAllReqValid()) return;

    if (isFileUploaded != true) {
        if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;
        cfFileUpload("fnSave(true);");
        return;
    }

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.ipbiz.expopin.act.CreateExpOpinion.do";
    prx.addParam("CRE_USER","<%= app.userInfo.getUserId() %>");
    prx.addData("ds_mainInfo");
    prx.addData("ds_attachFile");

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        parent.EXPOPIN_ID = this.result;
        window.location.replace("ExpOpinionUD.jsp");
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
        <TD>관리번호</TD>
        <TD disabled>(<%= app.message.get("msg.com.autocreate") %>)</TD>
        <TD req="COUNTRY_CODE">국가</TD>
        <TD>
           <ANY:SELECT id="COUNTRY_CODE" codeData="/common/countryCode" firstName="sel" />
        </TD>
    </TR>
    <TR>
        <TD req="RIGHT_DIV">권리구분</TD>
        <TD>
            <ANY:SELECT id="RIGHT_DIV" codeData="{RIGHT_DIV}" firstName="sel" />
        </TD>
        <TD req="REQ_MAN">감정의뢰인</TD>
        <TD>
            <INPUT type="text" id="REQ_MAN" maxByte="100" />
        </TD>
    </TR>
    <TR>
        <TD req="EXPOPIN_ORGAN">감정의뢰기관</TD>
        <TD>
            <INPUT type="text" id="EXPOPIN_ORGAN" maxByte="100" />
        </TD>
        <TD req="EXPOPIN_MAN">감정인</TD>
        <TD>
            <INPUT type="text" id="EXPOPIN_MAN" maxByte="100" />
        </TD>
    </TR>
    <TR>
        <TD>감정의 분류</TD>
        <TD>
            <ANY:SELECT id="EXPOPIN_CLS" firstName="sel" />
        </TD>
        <TD>감정일</TD>
        <TD>
            <ANY:DATE id="EXPOPIN_DATE" />
        </TD>
    </TR>
    <TR>
        <TD req="EXPOPIN_FEATURE">감정의 특징</TD>
        <TD colspan="3">
            <INPUT type="text" id="EXPOPIN_FEATURE" maxByte="1000" />
        </TD>
    </TR>
    <TR>
        <TD req="EXPOPIN_TARGET">감정의대상</TD>
        <TD colspan="3">
            <INPUT type="text" id="EXPOPIN_TARGET" maxByte="1000" />
        </TD>
    </TR>
    <TR>
        <TD>감정의견</TD>
        <TD colspan="3">
            <TEXTAREA id="EXPOPIN_OPINION" rows="4" maxByte="1000"></TEXTAREA>
        </TD>
    </TR>
    <TR>
        <TD req="any_attachFile">첨부파일</TD>
        <TD colspan="3">
            <ANY:FILE id="any_attachFile" mode="C" policy="ipbiz_expopin" />
        </TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="list" list="ExpOpinionListR.jsp"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
