<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<%@page import="any.util.etc.NDateUtil"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>국내분할/우선권 출원</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_priorInfo"><COMMENT>
    addBind("REF_NO");
    addBind("JOB_MAN_NAME");
    addBind("INT_OFFICE_NAME");
    addBind("EXAMREQ_YN_NAME");
    addBind("KO_APP_TITLE");
    addBind("APP_NO");
    addBind("APP_DATE");
    addBind("REG_NO");
    addBind("REG_DATE");
    addBind("FIRSTAPP_REF_NO");
    addBind("FIRSTAPP_DATE");
</COMMENT></ANY:DS>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("DIVISION_TYPE");
    addBind("ETC_MEMO");
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.intpatent.masterdiv.act.RetrieveIntPatentMasterDivPrior.do";
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
function fnSave()
{
     //필수항목 체크
    if (!cfCheckAllReqValid()) return;

    //저장 확인
    if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.intpatent.masterdiv.act.CreateIntPatentMasterDiv.do";
    prx.addParam("DIVISION_PRIOR_REF_ID", parent.REF_ID);
    prx.addData("ds_mainInfo");

    prx.onSuccess = function()
    {
        parent.REF_ID = this.result;
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        window.location.replace(top.getRoot() + "/anyfive/ipims/patent/applymgt/intpatent/consult/IntPatentConsultU.jsp");
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
        <TD>건담당자</TD>
        <TD><SPAN id="JOB_MAN_NAME"></SPAN></TD>
    </TR>
    <TR>
        <TD>국내사무소명</TD>
        <TD><SPAN id="INT_OFFICE_NAME"></SPAN></TD>
        <TD>심사청구</TD>
        <TD><SPAN id="EXAMREQ_YN_NAME"></SPAN></TD>
    </TR>
    <TR>
        <TD>출원의명칭</TD>
        <TD colspan="3"><SPAN id="KO_APP_TITLE"></SPAN></TD>
    </TR>
    <TR>
        <TD>출원번호</TD>
        <TD><SPAN id="APP_NO"></SPAN></TD>
        <TD>출원일자</TD>
        <TD><ANY:SPAN id="APP_DATE" format="date" /></TD>
    </TR>
    <TR>
        <TD>등록번호</TD>
        <TD><SPAN id="REG_NO"></SPAN></TD>
        <TD>등록일자</TD>
        <TD><ANY:SPAN id="REG_DATE" format="date" /></TD>
    </TR>
    <TR>
        <TD>선출원번호</TD>
        <TD><SPAN id="FIRSTAPP_REF_NO"></SPAN></TD>
        <TD>선출원일자</TD>
        <TD><ANY:SPAN id="FIRSTAPP_DATE" format="date" /></TD>
    </TR>
    <TR>
        <TD colspan="4" class="title_table">[의뢰 서지사항]</TD>
    </TR>
    <TR>
        <TD req="DIVISION_TYPE">분할구분</TD>
        <TD colspan="3"><ANY:SELECT id="DIVISION_TYPE" codeData="{INT_DIVISION_TYPE}" /></TD>
    </TR>
    <TR>
        <TD>비고</TD>
        <TD colspan="3"><TEXTAREA id="ETC_MEMO" rows="5" maxByte="4000"></TEXTAREA></TD>
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
