<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<%@page import="any.util.etc.NDateUtil"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>심의요청서 수정</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
addBind("MGT_NO");
addBind("CRE_USER");
addBind("CRE_DATE");
addBind("REQ_SUBJECT");
addBind("START_DATE");
addBind("END_DATE");
addBind("ATTACH_FILE", "any_attachFile");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnSearch();
}


//상세
function fnSearch(){
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.council.act.RetrieveCouncilRequestRD.do";
    prx.addParam("MGT_ID", parent.MGT_ID);
    prx.checkData = ds_mainInfo;

    prx.onSuccess = function()
    {
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}
// 수정
function fnSave(isFileUploaded)
{
    var prx = new any.proxy();

    //필수항목 체크
    if (!cfCheckAllReqValid()) return;

    if (isFileUploaded != true) {
        if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;
        cfFileUpload("fnSave(true);");
        return;
    }

    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.council.act.UpdateCouncilRequest.do";
    prx.addParam("MGT_ID", parent.MGT_ID);
    prx.addData("ds_mainInfo");
    prx.addData("ds_mgtId");
    prx.addData("ds_reviewMember");
    prx.addData("ds_attachFile");

    prx.onSuccess = function()
    {
        parent.REF_ID = this.result;
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        window.location.replace("CouncilRequestRD.jsp");
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
        <TD>심의요청번호</TD>
        <TD><SPAN id="MGT_NO"></SPAN></TD>
        <TD>작성자(작성일)</TD>
        <TD><SPAN id="CRE_USER"></span>(<ANY:SPAN format="date"  id="CRE_DATE" />)</TD>
    </TR>
    <TR>
        <TD req="REQ_SUBJECT">심의요청제목</TD>
        <TD colspan="3"><INPUT TYPE="TEXT" ID="REQ_SUBJECT" ></TD>
    </TR>
    <TR>
        <TD req="START_DATE">심의기간</TD>
        <TD colspan="3">
            <ANY:DATE id="START_DATE" />&nbsp;~
            <ANY:DATE id="END_DATE" />
        </TD>
    </TR>
    <TR>
        <TD req="any_mgtId">심의대상</TD>
        <TD colspan="3">
            <ANY:RVTG id="any_mgtId" mode="C" rightDiv="10,20" />
        </TD>
    </TR>
    <TR>
        <TD>첨부파일</TD>
        <TD colspan="3"><ANY:FILE id="any_attachFile" mode="U" policy="reviewreq" /></TD>
    </TR>
    <TR>
        <TD colspan="4" class="title_table">[심 의 위 원  정 보]</TD>
    </TR>
    <TR>
        <TD req="any_reviewMember">심의위원</TD>
        <TD colspan="3">
            <ANY:MSEARCH id="any_reviewMember" mode="C"><COMMENT>
                win.path = top.getRoot() + "/anyfive/ipims/patent/common/popup/search/UserSearchListR.jsp";
                codeColumn = "USER_ID";
               nameExpr = "[{#USER_ID}] {#EMP_HNAME}";

                size = 6;
            </COMMENT></ANY:MSEARCH>
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
