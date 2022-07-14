<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>조사의뢰 결과 입력</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("PRSCH_RESULT");
    addBind("RESULT_FILE", "any_resultFile");
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.priorsearch.result.act.RetrievePriorSearchResult.do";
    prx.addParam("PRSCH_ID", parent.PRSCH_ID);

    prx.onSuccess = function()
    {
        PRSCH_RESULT.focus();
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.priorsearch.result.act.UpdatePriorSearchResult.do";
    prx.addParam("PRSCH_ID", parent.PRSCH_ID);
    prx.addData("ds_mainInfo");
    prx.addData("ds_resultFile");

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
</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="1" cellpadding="2" class="main">
    <COLGROUP>
        <COL class="conthead" width="15%">
        <COL class="contdata" width="85%">
    </COLGROUP>
    <TR>
        <TD req="PRSCH_RESULT">조사결과내역</TD>
        <TD>
            <TEXTAREA id="PRSCH_RESULT" rows="15" maxByte="4000"></TEXTAREA>
        </TD>
    </TR>
    <TR>
        <TD>조사결과<BR>첨부파일</TD>
        <TD>
            <ANY:FILE id="any_resultFile" mode="U" policy="prior_search" />
        </TD>
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
