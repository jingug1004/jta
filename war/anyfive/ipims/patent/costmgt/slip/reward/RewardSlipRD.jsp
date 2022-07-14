<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>전표처리 상세</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("SLIP_KIND_NAME");
    addBind("SLIP_SUBJECT");
    addBind("COST_DATE");
    addBind("INVOICE_DATE");
    addBind("PAYMENT_DATE");
    addBind("SUPER_TAX");
    addBind("TOT_WON_PRICE");
    addBind("ACCOUNT_PROC_YN_NAME");
    addBind("ACCOUNT_PROC_DATE");
    addBind("ACCOUNT_PROC_USER_NAME");
    addBind("ACCOUNT_SLIP_NO");
    addBind("CRE_USER_NAME");
    addBind("CRE_DATE");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();
    fnRetrieveByInv();
    fnRetrieveByDept();
}

//조회
function fnRetrieve()
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.costmgt.slip.proc.act.RetrieveSlipProc.do";
    prx.addParam("SLIP_ID", parent.SLIP_ID);
    prx.checkData = ds_mainInfo;

    prx.onSuccess = function()
    {
        cfShowObjects([btn_modify, btn_delete, btn_line1, btn_confirm], ds_mainInfo.value(0, "ACCOUNT_PROC_YN") == "0");
        cfShowObjects([btn_mail], ds_mainInfo.value(0, "ACCOUNT_PROC_YN") == "1");
      //  btn_confirm.disabled = (ACCOUNT_SLIP_NO.value == "");

        if(ds_mainInfo.value(0, "FLAG") == "I" || ds_mainInfo.value(0, "FLAG") == "S" || ds_mainInfo.value(0, "FLAG") == "A"){
            btn_confirm.style.display = "none";

        }

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
    var ldr = gr_slipProcCostList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.costmgt.reward.consult.act.RetrieveRewardConsultByInv.do";
    ldr.addParam("SLIP_ID", parent.SLIP_ID);

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
    ldr.addParam("SLIP_ID", parent.SLIP_ID);

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
    window.location.href = "RewardSlipU.jsp";
}

//삭제
function fnDelete()
{
    if (!confirm("<%= app.message.get("msg.com.confirm.delete").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.costmgt.slip.proc.act.DeleteSlipProc.do";
    prx.addParam("SLIP_ID" , parent.SLIP_ID);

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

//다운로드
function fnDownload()
{
    var win = new any.window();
    win.path = "RewardSlipDownloadListR.jsp";
    win.arg.SLIP_ID = parent.SLIP_ID;
    win.opt.width = 900;
    win.opt.height = 600;
    win.opt.resizable = "yes";
    win.show();
}

//완료처리
function fnConfirm()
{
    if (!confirm("완료처리 하시겠습니까 ?")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.costmgt.slip.reward.act.UpdateSlipProcConfirm.do";
    prx.addParam("SLIP_ID", parent.SLIP_ID);

    prx.onSuccess = function()
    {
        alert("처리되었습니다.");
        window.location.reload();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//메일발송
function fnSendMail()
{
    var win = new any.window();
    win.path = "RewardInformMailC.jsp";
    win.arg.SLIP_ID = parent.SLIP_ID;
    win.opt.resizable = "yes";
    win.show();
}
</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="1" cellpadding="2" class="main">
    <COLGROUP>
        <COL class="conthead" width="15%">
        <COL class="contdata" width="18%">
        <COL class="conthead" width="15%">
        <COL class="contdata" width="18%">
        <COL class="conthead" width="15%">
        <COL class="contdata" width="18%">
    </COLGROUP>
    <TR>
        <TD>전표 제목</TD>
        <TD colspan="5"><ANY:SPAN id="SLIP_SUBJECT" /></TD>
    </TR>
    <TR>
        <TD>전표종류</TD>
        <TD><ANY:SPAN id="SLIP_KIND_NAME" /></TD>
        <TD>작성자</TD>
        <TD><ANY:SPAN id="CRE_USER_NAME" /></TD>
        <TD>작성일</TD>
        <TD><ANY:SPAN id="CRE_DATE" format="date"/></TD>
    </TR>
    <TR>
        <TD>전기일자</TD>
        <TD><ANY:SPAN id="COST_DATE" format="date" /></TD>
        <TD>증빙일자</TD>
        <TD><ANY:SPAN id="INVOICE_DATE" format="date" /></TD>
        <TD>만기출금일자</TD>
        <TD><ANY:SPAN id="PAYMENT_DATE" format="date" /></TD>
    </TR>
    <TR>
        <TD>회계전표번호</TD>
        <TD><ANY:SPAN id="ACCOUNT_SLIP_NO"/></TD>
        <TD>부가세</TD>
        <TD><ANY:SPAN id="SUPER_TAX" format="number2" /></TD>
        <TD>합계금액</TD>
        <TD><ANY:SPAN id="TOT_WON_PRICE" format="number2"/>원</TD>
    </TR>
    <TR>
        <TD>완료처리여부</TD>
        <TD><ANY:SPAN id="ACCOUNT_PROC_YN_NAME" /></TD>
        <TD>완료처리자</TD>
        <TD><ANY:SPAN id="ACCOUNT_PROC_USER_NAME" /></TD>
        <TD>완료처리일</TD>
        <TD><ANY:SPAN id="ACCOUNT_PROC_DATE" format="date" /></TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.modify").toHTML() %>" onClick="javascript:fnModify();" id="btn_modify" display="none"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.delete").toHTML() %>" onClick="javascript:fnDelete();" id="btn_delete" display="none"></BUTTON>
    <BUTTON auto="line" id="btn_line1" display="none"></BUTTON>
    <BUTTON text="다운로드" onClick="javascript:fnDownload();"></BUTTON>
    <BUTTON text="완료처리" onClick="javascript:fnConfirm();" id="btn_confirm" display="none" disabled></BUTTON>
    <BUTTON text="메일발송" onClick="javascript:fnSendMail();" id="btn_mail" display="none"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="list"></BUTTON>
</DIV>

<DIV style="margin-top:10px;">
    <SPAN id="spn_gridMessage_inv"></SPAN>
</DIV>
<ANY:GRID id="gr_slipProcCostList" pagingType="0" style="height:200px; margin-top:5px;"><COMMENT>
    addColumn({ width:120, align:"left"  , type:"string", sort:true , id:"REF_NO"           , name:"REF-NO" });
    addColumn({ width:50 , align:"center", type:"string", sort:true , id:"INOUT_DIV_NAME"   , name:"국내외" });
    addColumn({ width:70 , align:"center", type:"string", sort:true , id:"REWARD_DIV_NAME"  , name:"보상금구분" });
    addColumn({ width:40 , align:"center", type:"date"  , sort:true , id:"REWARD_GRADE"     , name:"등급" });
    addColumn({ width:70 , align:"center", type:"string", sort:true , id:"EMP_HNAME"        , name:"발명자" });
    addColumn({ width:70 , align:"center", type:"string", sort:true , id:"EMP_NO"           , name:"사번" });
    addColumn({ width:80 , align:"left"  , type:"string", sort:true , id:"DEPT_NAME"        , name:"부서" });
    addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"APP_NO"           , name:"출원번호" });
    addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"APP_DATE"         , name:"출원일" });
    addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"REG_NO"           , name:"등록번호" });
    addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"REG_DATE"         , name:"등록일" });
    addColumn({ width:80 , align:"right" , type:"number", sort:true , id:"REWARD_PRICE"     , name:"금액" , format:"#,###"});
    messageSpan = "spn_gridMessage_inv";
    addSorting("REF_NO", "ASC");
</COMMENT></ANY:GRID>

<DIV style="margin-top:10px;">
    <SPAN id="spn_gridMessage_dept"></SPAN>
</DIV>
<ANY:GRID id="gr_rewardConsultListByDept" pagingType="0" style="height:200px; margin-top:5px;"><COMMENT>
    addHeader(["부서명", "국내", "", "", "해외", "", ""]);
    addColumn({ width:150, align:"left" , type:"string" , sort:true , id:"DEPT_NAME"       , name:"부서명" });
    addColumn({ width:120, align:"right", type:"number" , sort:true , id:"INT_PAT_PRICE"   , name:"출원보상금" , format:"#,###" });
    addColumn({ width:120, align:"right", type:"number" , sort:true , id:"INT_REG_PRICE"   , name:"등록보상금" , format:"#,###" });
    addColumn({ width:120, align:"right", type:"number" , sort:true , id:"INT_TOTAL_PRICE" , name:"합계"       , format:"#,###" });
    addColumn({ width:120, align:"right", type:"number" , sort:true , id:"EXT_PAT_PRICE"   , name:"출원보상금" , format:"#,###" });
    addColumn({ width:120, align:"right", type:"number" , sort:true , id:"EXT_REG_PRICE"   , name:"등록보상금" , format:"#,###" });
    addColumn({ width:120, align:"right", type:"number" , sort:true , id:"EXT_TOTAL_PRICE" , name:"합계"       , format:"#,###" });
    messageSpan = "spn_gridMessage_dept";
    addSorting("REF_NO", "ASC");
</COMMENT></ANY:GRID>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
