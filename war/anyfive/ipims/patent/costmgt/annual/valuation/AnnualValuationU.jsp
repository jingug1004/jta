<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>등록유지평가표 수정</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_APPROVAL); %>
<ANY:DS id="ds_mainInfo" />
<ANY:DS id="ds_regInfo"><COMMENT>
    addBind("KEEP_YN");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
var gEvalCode = "E03";
var gEvalId;

//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();
}

//조회
function fnRetrieve()
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.costmgt.annual.valuation.act.RetrieveAnnualValuation.do";
    prx.addParam("EVAL_ID", parent.EVAL_ID);
    prx.addParam("REF_ID", parent.REF_ID);
    prx.addParam("PAPER_LIST_SEQ", parent.PAY_YEARDEG);
    prx.addParam("EVAL_CODE", gEvalCode);

    prx.onSuccess = function()
    {
        gEvalId = ds_mainInfo.value(0, "EVAL_ID");

        parent.REF_ID = ds_mainInfo.value(0, "REF_ID");
        parent.PAY_YEARDEG = ds_mainInfo.value(0, "PAPER_LIST_SEQ");

        any_abstractInfo.refId = parent.REF_ID;

        INVDEPT_EVAL_USER_NAME.innerText = ds_mainInfo.value(0, "INVDEPT_EVAL_USER_NAME");
        any_invEvalList.evalId = ds_mainInfo.value(0, "EVAL_ID");

        PATDEPT_EVAL_USER_NAME.innerText = ds_mainInfo.value(0, "PATDEPT_EVAL_USER_NAME");
        any_patEvalList.evalId = ds_mainInfo.value(0, "EVAL_ID");

        any_invEvalList.reset(ds_mainInfo.value(0, "INVDEPT_EVAL_SHEET_ID"), gEvalId);

        var isInvdeptEvalUser = (ds_mainInfo.value(0, "INVDEPT_EVAL_USER") == "<%= app.userInfo.getUserId() %>");
        var isPatdeptEvalUser = (ds_mainInfo.value(0, "PATDEPT_EVAL_USER") == "<%= app.userInfo.getUserId() %>");

        any_invEvalList.mode = (isInvdeptEvalUser && parent.editMode.INV ? "U" : "R");
        cfShowObjects([btn_saveInv, btn_modifyInv, btn_line1], any_invEvalList.mode == "U");

        if (ds_mainInfo.value(0, "INVDEPT_EVAL_YN") == "1" && (isPatdeptEvalUser || "<%= app.userInfo.isPatentTeam() %>" == "true")) {
            any_patEvalList.reset(ds_mainInfo.value(0, "PATDEPT_EVAL_SHEET_ID"), gEvalId);
            any_patEvalList.mode = (isPatdeptEvalUser && parent.editMode.PAT ? "U" : "R");
            div_patDeptArea.style.display = "block";
        }
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.costmgt.annual.valuation.act.UpdateAnnualValuation.do";
    prx.addParam("EVAL_ID", gEvalId);
    prx.addParam("REF_ID", parent.REF_ID);
    prx.addParam("PAPER_LIST_SEQ", parent.PAY_YEARDEG);
    prx.addParam("EVAL_KIND", "INVDEPT");
    prx.addParam("EVAL_CODE", gEvalCode);
    prx.addParam("EVAL_SHEET_ID", ds_mainInfo.value(0, "INVDEPT_EVAL_SHEET_ID"));
    prx.addParam("SUM_TOTAL", any_invEvalList.sumTotal);
    prx.addData("ds_invEvalList", "ds_evalList");

    prx.onSuccess = function()
    {
        if (any_patEvalList.mode == "U") {
            fnSavePat();
        } else {
            top.window.returnValue = { evalId:this.result };
            alert("<%= app.message.get("msg.com.info.save").toJS() %>");
            fnDetail();
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
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.costmgt.annual.valuation.act.UpdateAnnualValuation.do";
    prx.addParam("EVAL_ID", gEvalId);
    prx.addParam("REF_ID", parent.REF_ID);
    prx.addParam("PAPER_LIST_SEQ", parent.PAY_YEARDEG);
    prx.addParam("EVAL_KIND", "PATDEPT");
    prx.addParam("EVAL_CODE", gEvalCode);
    prx.addParam("EVAL_SHEET_ID", ds_mainInfo.value(0, "PATDEPT_EVAL_SHEET_ID"));
    prx.addParam("SUM_TOTAL", any_invEvalList.sumTotal + any_patEvalList.sumTotal);
    prx.addData("ds_patEvalList", "ds_evalList");
    prx.addData("ds_regInfo");

    prx.onSuccess = function()
    {
        top.window.returnValue = { evalId:this.result };
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        fnDetail();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//상세
function fnDetail()
{
    window.location.replace("AnnualValuationR.jsp");
}
</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<ANY:ABSTRACT id="any_abstractInfo" />

<TABLE border="0" cellspacing="1" cellpadding="2" class="main" style="margin-top:2px;">
    <TR>
        <TD class="title_table">[발명부서 등록평가]</TD>
    </TR>
</TABLE>
<ANY:EVAL id="any_invEvalList" />

<DIV class="button_area">
    <SPAN>발명부서 평가자 :</SPAN>
    <SPAN id="INVDEPT_EVAL_USER_NAME"></SPAN>
    <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();" id="btn_saveInv" display="none"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.cancel").toHTML() %>" onClick="javascript:fnDetail();" id="btn_modifyInv" display="none"></BUTTON>
    <BUTTON auto="line" id="btn_line1" display="none"></BUTTON>
    <BUTTON auto="close" id="btn_close"></BUTTON>
</DIV>

<DIV id="div_patDeptArea" style="display:none;">
<TABLE border="0" cellspacing="1" cellpadding="2" class="main" style="margin-top:10px;">
    <TR>
        <TD class="title_table">[특허부서 등록평가]</TD>
    </TR>
</TABLE>
<ANY:EVAL id="any_patEvalList" />
<TABLE border="0" cellspacing="1" cellpadding="2" class="main" style="margin-top:2px;">
    <COLGROUP>
        <COL class="conthead" width="30%" style="text-align:left;">
        <COL class="contdata" width="70%">
    </COLGROUP>
    <TR>
        <TD req="KEEP_YN">유지여부</TD>
        <TD><ANY:RADIO id="KEEP_YN" codeData="{KEEP_YN}" /></TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <SPAN>특허부서 평가자 :</SPAN>
    <SPAN id="PATDEPT_EVAL_USER_NAME"></SPAN>
    <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.cancel").toHTML() %>" onClick="javascript:fnDetail();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="close" id="btn_close"></BUTTON>
</DIV>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
