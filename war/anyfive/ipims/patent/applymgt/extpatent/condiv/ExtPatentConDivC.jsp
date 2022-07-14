<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<%@page import="any.util.etc.NDateUtil"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>계속/분할OL</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_priorInfo"><COMMENT>
    addBind("REF_NO");
    addBind("CRE_DATE");
    addBind("COUNTRY_CODE_NAME");
    addBind("JOB_MAN_NAME");
    addBind("INT_OFFICE_NAME");
    addBind("EXAMREQ_YN_NAME");
    addBind("KO_APP_TITLE");
    addBind("FIRSTAPP_DATE");
    addBind("APP_NO");
    addBind("APP_DATE");
</COMMENT></ANY:DS>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("DIVISION_TYPE");
    addBind("ATTACH_FILE", "any_attachFile");
    addBind("EXAM_OPINION");
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.extpatent.condiv.act.RetrieveExtPatentConDivPrior.do";
    prx.addParam("DIVISION_PRIOR_REF_ID", parent.REF_ID);
    prx.checkData = ds_priorInfo;

    prx.onSuccess = function()
    {
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
     //필수항목 체크
    if (!cfCheckAllReqValid()) return;

    if (isFileUploaded != true) {
        if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;
        cfFileUpload("fnSave(true);");
        return;
    }

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.extpatent.condiv.act.CreateExtPatentConDiv.do";
    prx.addParam("DIVISION_PRIOR_REF_ID", parent.REF_ID);
    prx.addData("ds_mainInfo");
    prx.addData("ds_attachFile");

    prx.onSuccess = function()
    {
        parent.OL_ID = this.result;
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        window.location.replace("ExtPatentConDivRD.jsp");
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
        <TD colspan="4" class="title_table">[모출원 서지사항]</TD>
    </TR>
    <TR>
        <TD>REF-NO</TD>
        <TD><SPAN id="REF_NO"></SPAN></TD>
        <TD>작성일</TD>
        <TD><ANY:SPAN id="CRE_DATE" format="date" /></TD>
    </TR>
    <TR>
        <TD>출원국가</TD>
        <TD><SPAN id="COUNTRY_CODE_NAME"></SPAN></TD>
        <TD>건담당자</TD>
        <TD><SPAN id="JOB_MAN_NAME"></SPAN></TD>
    </TR>
    <TR>
        <TD>국내사무소</TD>
        <TD><SPAN id="INT_OFFICE_NAME"></SPAN></TD>
        <TD>심사청구</TD>
        <TD><SPAN id="EXAMREQ_YN_NAME"></SPAN></TD>
    </TR>
    <TR>
        <TD>발명의 명칭</TD>
        <TD colspan="3"><SPAN id="KO_APP_TITLE"></SPAN></TD>
    </TR>
    <TR>
        <TD>선출원번호</TD>
        <TD colspan="3"><ANY:PRIORAPP id="any_priorAppList" /></TD>
    </TR>
    <TR>
        <TD>선출원일자</TD>
        <TD colspan="3"><ANY:SPAN id="FIRSTAPP_DATE" format="date" /></TD>
    </TR>
    <TR>
        <TD>해외출원번호</TD>
        <TD><SPAN id="APP_NO"></SPAN></TD>
        <TD>해외출원일</TD>
        <TD><ANY:SPAN id="APP_DATE" format="date" /></TD>
    </TR>
    <TR>
        <TD colspan="4" class="title_table">[의뢰 서지사항]</TD>
    </TR>
    <TR>
        <TD req="DIVISION_TYPE">출원형태</TD>
        <TD><ANY:SELECT id="DIVISION_TYPE" codeData="{OL_DIVISION_TYPE}" /></TD>
        <TD>계속/분할 작성일</TD>
        <TD><ANY:SPAN format="date" value="<%= NDateUtil.getSysDate() %>" /></TD>
    </TR>
    <TR>
        <TD>첨부파일</TD>
        <TD colspan="3">
            <ANY:FILE id="any_attachFile" mode="C" policy="extol" />
        </TD>
    </TR>
    <TR>
        <TD>비고</TD>
        <TD colspan="3"><TEXTAREA id="EXAM_OPINION" rows="5" maxByte="4000"></TEXTAREA></TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="list"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
