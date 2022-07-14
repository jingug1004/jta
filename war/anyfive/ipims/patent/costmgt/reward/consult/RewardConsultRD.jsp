<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>보상금 품의 상세</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_APPROVAL); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("CONSULT_SUBJECT");
    addBind("CRE_USER_NAME");
    addBind("CRE_DATE");
    addBind("TOTAL_COUNT");
    addBind("TOTAL_PRICE");
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.costmgt.reward.consult.act.RetrieveRewardConsult.do";
    prx.addParam("CONSULT_ID", parent.CONSULT_ID);
    prx.checkData = ds_mainInfo;

    prx.onSuccess = function()
    {
        fnRetrieveByInv();
        fnRetrieveByDept();
        any_approval.reset();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//발명자별 Grid 조회
function fnRetrieveByInv()
{
    var ldr = gr_rewardConsultListByInv.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.costmgt.reward.consult.act.RetrieveRewardConsultByInv.do";
    ldr.addParam("CONSULT_ID", parent.CONSULT_ID);

    ldr.onSuccess = function()
    {

    }

    ldr.onFail = function()
    {
        this.error.show();
    }

    ldr.execute();
}

//사무소별 Grid 조회
function fnRetrieveByDept()
{
    var ldr = gr_rewardConsultListByDept.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.costmgt.reward.consult.act.RetrieveRewardConsultByDept.do";
    ldr.addParam("CONSULT_ID", parent.CONSULT_ID);

    ldr.onSuccess = function()
    {
    }

    ldr.onFail = function()
    {
        this.error.show();
    }

    ldr.execute();
}

//수정
function fnModify()
{
    window.location.href = "RewardConsultU.jsp";
}

//삭제
function fnDelete()
{
    if (!confirm("<%= app.message.get("msg.com.confirm.delete").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.costmgt.reward.consult.act.DeleteRewardConsult.do";
    prx.addParam("CONSULT_ID", parent.CONSULT_ID);

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
</SCRIPT>

<!-- 결재현황 로딩시 -->
<SCRIPT language="JScript" for="any_approval" event="OnLoad()">
    cfShowObjects([btn_modify, btn_delete, btn_line], ds_mainInfo.value(0, "CRE_USER") == "<%= app.userInfo.getUserId() %>" && this.avail("REQUEST"));
</SCRIPT>

<!-- 결재현황 처리성공시 -->
<SCRIPT language="JScript" for="any_approval" event="OnSuccess()">
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
        <TD>품의서 제목</TD>
        <TD colspan="3"><SPAN id="CONSULT_SUBJECT"></SPAN></TD>
    </TR>
    <TR>
        <TD>총 건수</TD>
        <TD><ANY:SPAN id="TOTAL_COUNT" /></TD>
        <TD>합계금액</TD>
        <TD><ANY:SPAN id="TOTAL_PRICE" format="number2" /></TD>
    </TR>
    <TR>
        <TD>작성자</TD>
        <TD><ANY:SPAN id="CRE_USER_NAME" /></TD>
        <TD>작성일</TD>
        <TD><ANY:SPAN id="CRE_DATE" format="date" /></TD>
    </TR>
</TABLE>

<DIV style="margin-top:10px;">
    <SPAN id="spn_gridMessage_inv"></SPAN>
</DIV>
<ANY:GRID id="gr_rewardConsultListByInv" pagingType="0" style="height:200px; margin-top:5px;"><COMMENT>
    addColumn({ width:110, align:"left"  , type:"string", sort:true , id:"REF_NO"            , name:"REF-NO" });
    addColumn({ width:50 , align:"center", type:"string", sort:true , id:"INOUT_DIV_NAME"    , name:"국내외" });
    addColumn({ width:70 , align:"center", type:"string", sort:true , id:"REWARD_DIV_NAME"   , name:"보상금구분" });
    addColumn({ width:40 , align:"center", type:"date"  , sort:true , id:"REWARD_GRADE"      , name:"등급" });
    addColumn({ width:70 , align:"center", type:"string", sort:true , id:"EMP_HNAME"         , name:"발명자" });
    addColumn({ width:70 , align:"center", type:"string", sort:true , id:"EMP_NO"            , name:"사번" });
    addColumn({ width:80 , align:"left"  , type:"string", sort:true , id:"DEPT_NAME"         , name:"부서" });
    addColumn({ width:100 , align:"center", type:"string", sort:true , id:"APP_EXT_MAN_CODE" , name:"출원인" });
    addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"APP_NO"            , name:"출원번호" });
    addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"APP_DATE"          , name:"출원일" });
    addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"REG_NO"            , name:"등록번호" });
    addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"REG_DATE"          , name:"등록일" });
    addColumn({ width:80 , align:"right" , type:"number", sort:true , id:"REWARD_PRICE"      , name:"금액" , format:"#,###"});
    messageSpan = "spn_gridMessage_inv";
    addSorting("REF_NO", "ASC");
</COMMENT></ANY:GRID>

<DIV style="margin-top:10px;">
    <SPAN id="spn_gridMessage_dept"></SPAN>
</DIV>
<ANY:GRID id="gr_rewardConsultListByDept" pagingType="0" style="height:200px; margin-top:5px;"><COMMENT>
    addHeader(["부서명", "국내", "", "", "해외", "", ""]);
    addColumn({ width:150, align:"left"  , type:"string", sort:true , id:"DEPT_NAME"        , name:"부서명" });
    addColumn({ width:120, align:"right" , type:"number", sort:true , id:"INT_PAT_PRICE"    , name:"출원보상금" , format:"#,###" });
    addColumn({ width:120, align:"right" , type:"number", sort:true , id:"INT_REG_PRICE"    , name:"등록보상금" , format:"#,###" });
    addColumn({ width:120, align:"right" , type:"number", sort:true , id:"INT_TOTAL_PRICE"  , name:"합계"       , format:"#,###" });
    addColumn({ width:120, align:"right" , type:"number", sort:true , id:"EXT_PAT_PRICE"    , name:"출원보상금" , format:"#,###" });
    addColumn({ width:120, align:"right" , type:"number", sort:true , id:"EXT_REG_PRICE"    , name:"등록보상금" , format:"#,###" });
    addColumn({ width:120, align:"right" , type:"number", sort:true , id:"EXT_TOTAL_PRICE"  , name:"합계"       , format:"#,###" });
    messageSpan = "spn_gridMessage_dept";
    addSorting("REF_NO", "ASC");
</COMMENT></ANY:GRID>

<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.modify").toHTML() %>" id="btn_modify" onClick="javascript:fnModify();" display="none"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.delete").toHTML() %>" id="btn_delete" onClick="javascript:fnDelete();" display="none"></BUTTON>
    <BUTTON auto="line" id="btn_line" display="none"></BUTTON>
    <BUTTON auto="list"></BUTTON>
</DIV>

<ANY:APPROVAL id="any_approval" code="C02"><COMMENT>
    reqUser = ds_mainInfo.value(0, "CRE_USER");
    addKey("CONSULT_ID", parent.CONSULT_ID);
</COMMENT></ANY:APPROVAL>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
