<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<%@page import="any.util.etc.NDateUtil"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>심의요청서 상세</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
addBind("MGT_NO");
addBind("CRE_USER_NAME");
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

// 조회
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


//수정
function fnModify()
{
    window.location.href = "CouncilRequestU.jsp";
}

//삭제
function fnDelete()
{
     if (!confirm("<%= app.message.get("msg.com.confirm.delete").toJS() %>")) return;

     var prx = new any.proxy();

     prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.council.act.DeleteCouncilRequest.do";
     prx.addParam("MGT_ID", parent.MGT_ID);
     prx.addData("ds_mainInfo");
     prx.addData("ds_mgtId");
     prx.addData("ds_reviewMember");
     prx.addData("ds_attachFile");

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


//심의요청완료
function fnEmail(status)
{
    var prx = new any.proxy();

    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.council.act.UpdateCouncilRequestEmail.do";

    if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;
    prx.addParam("MGT_ID", parent.MGT_ID);
    prx.addParam("STATUS", status); // 상태 1

    prx.onSuccess = function()
    {
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
<!-- 업무프로세스 로딩시 -->
<SCRIPT language="JScript" for="ds_mainInfo" event="OnLoad()">
     if(ds_mainInfo.value(0, "MEMBERSTATUS") == "1"){
         cfShowObjects([btn_rewrite,btn_line1, btn_update, btn_line2, btn_delete, btn_line3], false);
     }else{
         cfShowObjects([btn_rewrite,btn_line1, btn_update, btn_line2, btn_delete, btn_line3], true);
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
        <TD><SPAN id="CRE_USER_NAME"></span>(<ANY:SPAN format="date"  id="CRE_DATE" />)</TD>
    </TR>
    <TR>
        <TD>심의요청제목</TD>
        <TD colspan="3"><SPAN id="REQ_SUBJECT"></span></TD>
    </TR>
    <TR>
        <TD>심의기간</TD>
        <TD colspan="3">
            <ANY:SPAN format="date"  id="START_DATE" />&nbsp;~
            <ANY:SPAN format="date"  id="END_DATE" />
        </TD>
    </TR>
    <TR>
        <TD>심의대상</TD>
        <TD colspan="3">
            <ANY:RVTG id="any_mgtId" mode="R" rightDiv="10,20" />
        </TD>
    </TR>
    <TR>
        <TD>첨부파일</TD>
        <TD colspan="3"><ANY:FILE id="any_attachFile" mode="R" policy="extappreq" /></TD>
    </TR>
    <TR>
        <TD colspan="4" class="title_table">[심 의 위 원  정 보]</TD>
    </TR>
    <TR>
        <TD>심의위원</TD>
        <TD colspan="3">
            <ANY:MSEARCH id="any_reviewMember" mode="R"><COMMENT>
                nameExpr = "[{#USER_ID}] {#EMP_HNAME}";
            </COMMENT></ANY:MSEARCH>
        </TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="심의요청완료" onClick="javascript:fnEmail('1');" id="btn_rewrite"  display="none"></BUTTON>
    <BUTTON auto="line" id="btn_line1"  display="none"></BUTTON>
    <BUTTON text="수정" onClick="javascript:fnModify();" id="btn_update"  display="none"></BUTTON>
    <BUTTON auto="line" id="btn_line2"  display="none"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.delete").toHTML() %>" onClick="javascript:fnDelete();" id="btn_delete"  display="none"></BUTTON>
    <BUTTON auto="line" id="btn_line3"  display="none"></BUTTON>
    <BUTTON auto="list"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
