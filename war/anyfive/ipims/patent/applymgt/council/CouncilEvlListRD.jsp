<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<%@page import="any.util.etc.NDateUtil"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>심의평가서 상세</TITLE>
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

//조회
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

//임시저장
function fnViewSave(statusz,statust, statusth ){ // 0,2,3

    var prx = new any.proxy();

    if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;

    if((ds_mainInfo.value(0, "CRE_USER") == "<%= app.userInfo.getUserId() %>")){// 작성자
        prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.council.act.UpdateCouncilEvlRreq.do";
        prx.addParam("MGT_ID", parent.MGT_ID); //
        prx.addParam("STATUSR", statusth);// REVIEW_REQ '3'
    }else{ // 심의위원
        prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.council.act.UpdateCouncilEvlMber.do";
        prx.addParam("MGT_ID", parent.MGT_ID);
        prx.addParam("STATUS", statusz);// MAPP_REVIEW_MEMBER TABLE '0'
        prx.addParam("STATUSR", statust);// REVIEW_REQ TABLE '2'
    }

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        window.location.replace("CouncilEvlListRD.jsp");
    }
    prx.onFail = function()
    {
        this.error.show();
    }
    prx.execute();
}

//심의완료
function fnCouncilSave(status, statust){

    var prx = new any.proxy();

    if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;

    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.council.act.UpdateCouncilEvlMber.do";
    prx.addParam("MGT_ID", parent.MGT_ID);
    prx.addParam("STATUS", status); //MAPP_REVIEW_MEMBER TABLE '1'
    prx.addParam("STATUSR", statust);// REVIEW_REQ TABLE '2'

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        window.location.replace("CouncilEvlListRD.jsp");
    }
    prx.onFail = function()
    {
        this.error.show();
    }
    prx.execute();
}

//평가완료
function fnCouncilEvlSave(status){

    var prx = new any.proxy();

    if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;

    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.council.act.UpdateCouncilEvlRreq.do";
    prx.addParam("MGT_ID", parent.MGT_ID);
    prx.addParam("STATUSR", status); //REVIEW_REQ TABLE '4'

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        window.location.replace("CouncilEvlListRD.jsp");
    }
    prx.onFail = function()
    {
        this.error.show();
    }
    prx.execute();
}

//평가재요청(email) 평가중인 위원에게만 메일 발송
function fnReEmail(){

    var prx = new any.proxy();

    if (!confirm("평가 재요청하시겠습니까?")) return;

    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.council.act.UpdateCouncilRequestReEmail.do";

    prx.addParam("MGT_ID", parent.MGT_ID);

    prx.onSuccess = function()
    {
        alert("평가 재요청 되었습니다.");
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
   var isCreUser = (ds_mainInfo.value(0, "CRE_USER") == "<%= app.userInfo.getUserId()%>");

   if(isCreUser){ // (작성자일경우) , 임시저장, 평가완료, 평가재요청. 상태가 완료인경우 목록버튼만 보인다.
        if(ds_mainInfo.value(0, "STATUS") == "4"){// member table 에 status를 update 하지 않는다.
            cfShowObjects([btn_reviewSave, btn_line4, btn_councilEnd, btn_line2, btn_EvlEnd, btn_line3, btn_rewrite, btn_line1], false);
        }else{
            cfShowObjects([btn_reviewSave, btn_line4,  btn_rewrite,btn_line1,btn_EvlEnd,btn_line3], isCreUser);
        }
   }else{// (심의위원일경우)임시저장, 심의완료. 상태가 심의완료인경우 목록만 보인다.
       if(ds_mainInfo.value(0, "MEMBERSTATUS") == "1"){
           cfShowObjects([btn_reviewSave, btn_line4, btn_councilEnd, btn_line2, btn_EvlEnd, btn_line3, btn_rewrite, btn_line1], false);
       }else{
           cfShowObjects([btn_reviewSave, btn_line4, btn_councilEnd,btn_line2 ], true);
       }
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
            <ANY:RVTG id="any_mgtId" mode="R1" rightDiv="10,20"   />
        </TD>
    </TR>
    <TR>
        <TD>첨부파일</TD>
        <TD colspan="3"><ANY:FILE id="any_attachFile" mode="R" /></TD>
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
    <BUTTON text="임시저장" id ="btn_reviewSave"  onClick="javascript:fnViewSave('0','2','3');"  display="none"></BUTTON>
    <BUTTON auto="line" id ="btn_line4"   display="none"></BUTTON>
    <BUTTON text="심의완료" id ="btn_councilEnd"  onClick="javascript:fnCouncilSave('1', '2');" display="none"></BUTTON>
    <BUTTON auto="line" id ="btn_line2" display="none"></BUTTON>
    <BUTTON text="평가완료" id ="btn_EvlEnd"  onClick="javascript:fnCouncilEvlSave('4');" display="none" ></BUTTON>
    <BUTTON auto="line" id ="btn_line3" display="none"></BUTTON>
    <BUTTON text="평가 재요청" id ="btn_rewrite" onClick="javascript:fnReEmail();" display="none"></BUTTON>
    <BUTTON auto="line" id="btn_line1" display="none"></BUTTON>
    <BUTTON auto="list"></BUTTON>
</DIV>
<% app.writeBodyFooter(); %>

</BODY>
</HTML>
