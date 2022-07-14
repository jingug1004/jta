<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>심의평가표</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo" />
<ANY:DS id="ds_consultInfo"><COMMENT>
    addBind("REVIEW_GRADE");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
var gEvalCode = "E06";
var gEvalId;
//윈도우 로딩시
window.onready = function()
{
    if(parent.CRE_USER == "<%= app.userInfo.getUserId() %>"){
        parent.isPatMode=true;
    }else{
    }
    cfShowObjects([btn_save, btn_line1], parent.isInvEditable || parent.isPatEditable);

    fnRetrieve();
}

//조회
function fnRetrieve()
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.priorjob.evaluation.act.RetrieveEvaluationE06.do";
    prx.addParam("EVAL_ID", parent.EVAL_ID);
    prx.addParam("REF_ID", parent.REF_ID);
    prx.addParam("EVAL_CODE", gEvalCode);

    prx.onSuccess = function()
    {
        gEvalId = ds_mainInfo.value(0, "EVAL_ID");
        parent.REF_ID = ds_mainInfo.value(0, "REF_ID");

        if (ds_mainInfo.value(0, "INVDEPT_EVAL_YN") == "0" && parent.isPatEditable) {
            any_invEvalList.mode = "U";
        }

        cfShowObjects([div_patDeptArea], parent.isPatMode);

        any_invEvalList.reset(ds_mainInfo.value(0, "INVDEPT_EVAL_SHEET_ID"), gEvalId);
        any_patEvalList.reset(ds_mainInfo.value(0, "PATDEPT_EVAL_SHEET_ID"), gEvalId);
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//합계점수 계산
function fnSetSumTotal()
{
    SUM_TOTAL.innerText = any_invEvalList.sumTotal + any_patEvalList.sumTotal;
}

//저장
function fnSave()
{
    //필수항목 체크
    if (!cfCheckAllReqValid()) return;

    //저장 확인
    if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;

    if (any_invEvalList.mode == "U") {
        fnSaveInv();
    } else if (any_patEvalList.mode == "U") {
        fnSavePat();
    }
}

//저장 - 발명부서
function fnSaveInv()
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.priorjob.evaluation.act.UpdateEvaluationE06.do";
    prx.addParam("EVAL_ID", gEvalId);
    prx.addParam("REF_ID", parent.REF_ID);
    prx.addParam("EVAL_KIND", "INVDEPT");
    prx.addParam("EVAL_CODE", gEvalCode);
    prx.addParam("EVAL_SHEET_ID", ds_mainInfo.value(0, "INVDEPT_EVAL_SHEET_ID"));
    prx.addParam("SUM_TOTAL", any_invEvalList.sumTotal);
    prx.addParam("INVDEPT_EVAL_END_YN", "1");
    prx.addData("ds_invEvalList", "ds_evalList");

    prx.onSuccess = function()
    {
        gEvalId = this.result;

        if (any_patEvalList.mode == "U") {
            fnSavePat();
        } else {
            top.window.returnValue = { evalId:this.result };
            alert("<%= app.message.get("msg.com.info.save").toJS() %>");
            top.window.close();
        }
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//저장 - 특허부서
function fnSavePat()
{
    var reviewGrade = REVIEW_GRADE.value;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.priorjob.evaluation.act.UpdateEvaluationE06.do";
    prx.addParam("EVAL_ID", gEvalId);
    prx.addParam("REF_ID", parent.REF_ID);
    prx.addParam("EVAL_KIND", "PATDEPT");
    prx.addParam("EVAL_CODE", gEvalCode);
    prx.addParam("EVAL_SHEET_ID", ds_mainInfo.value(0, "PATDEPT_EVAL_SHEET_ID"));
    prx.addParam("REVIEW_GRADE", reviewGrade);
    prx.addParam("SUM_TOTAL", any_invEvalList.sumTotal + any_patEvalList.sumTotal);
    prx.addParam("PATDEPT_EVAL_END_YN", "1");
    prx.addData("ds_patEvalList", "ds_evalList");

    prx.onSuccess = function()
    {
        gEvalId = this.result;

        top.window.returnValue = { evalId:this.result, reviewGrade:reviewGrade };
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



<!-- 발명부서 평가내용 준비완료시 -->
<SCRIPT language="JScript" for="any_invEvalList" event="OnReady()">
    fnSetSumTotal();
</SCRIPT>

<!-- 발명부서 평가내용 변경시 -->
<SCRIPT language="JScript" for="any_invEvalList" event="OnChange()">
    fnSetSumTotal();
</SCRIPT>

<!-- 특허부서 평가내용 준비완료시 -->
<SCRIPT language="JScript" for="any_patEvalList" event="OnReady()">
    fnSetSumTotal();

    var reviewGrade = ds_consultInfo.value(0, "REVIEW_GRADE");
    if (reviewGrade != null && reviewGrade != "") {
        REVIEW_GRADE.value = reviewGrade;
    }
</SCRIPT>

<!-- 특허부서 평가내용 변경시 -->
<SCRIPT language="JScript" for="any_patEvalList" event="OnChange()">
    fnSetSumTotal();
</SCRIPT>

</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<DIV class="title_sub" style="margin-top:0px;">심의위원 평가내용</DIV>
<ANY:EVAL id="any_invEvalList"><COMMENT>
var status =  parent.STATUS;

    if((parent.CRE_USER != "<%= app.userInfo.getUserId() %>") && (status == '1' || status == '2')){
        parent.isInvEditable = true;
        cfShowObjects([btn_save, btn_line1], true);
        REVIEW_GRADE.readOnly = false;
    }else{
        parent.isInvEditable = false;
        cfShowObjects([btn_save, btn_line1], false);
        REVIEW_GRADE.readOnly = true;
    }
    mode = (parent.isInvEditable ? "U" : "R");
</COMMENT></ANY:EVAL>

<DIV id="div_patDeptArea" style="display:none;">
<DIV class="title_sub">특허부서 평가내용</DIV>
<ANY:EVAL id="any_patEvalList"><COMMENT>
var status =  parent.STATUS;

    if((parent.CRE_USER == "<%= app.userInfo.getUserId() %>") && (status == '2' || status == '3')){
        parent.isPatEditable = true;
        cfShowObjects([btn_save, btn_line1], true);
        REVIEW_GRADE.readOnly = false;
    }else{
        parent.isPatEditable = false;
        cfShowObjects([btn_save, btn_line1], false);
        REVIEW_GRADE.readOnly = true;
    }
    mode = (parent.isPatEditable ? "U" : "R");
</COMMENT></ANY:EVAL>

<DIV class="title_sub">심의평가등급/점수</DIV>
<TABLE border="0" cellspacing="1" cellpadding="0" class="main">
    <COLGROUP>
        <COL class="conthead" width="30%">
        <COL class="contdata" width="70%">
    </COLGROUP>
    <TR>
        <TD>심의평가등급</TD>
        <TD>
            <ANY:RADIO id="REVIEW_GRADE" codeData="{INV_GRADE}"/>
        </TD>
    </TR>
    <TR>
        <TD>심의평가점수</TD>
        <TD>&nbsp;<SPAN id="SUM_TOTAL"></SPAN>&nbsp;점</TD>
    </TR>
</TABLE>
</DIV>

<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();" id="btn_save" display="none"></BUTTON>
    <BUTTON auto="line" id="btn_line1" display="none"></BUTTON>
    <BUTTON auto="close" id="btn_close"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
