<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>등록평가표 수정</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_APPROVAL); %>
<ANY:DS id="ds_mainInfo" />
<ANY:DS id="ds_regInfo"><COMMENT>
    addBind("EXE_DIV");
    addBind("PROD_NAME");
    addBind("FIRST_COMMERC_START");
    addBind("REF_DIVISN");
    addBind("EVAL_OPINION");
    addBind("APP_EVAL_POINT");
    addBind("PJT_TYPE");
    addBind("APP_REQCNT");
    addBind("REG_REQCNT");
    addBind("POINT");
    addBind("GRADE");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
var gEvalCode = "E02";
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.priorjob.evaluation.act.RetrieveEvaluationE02.do";
    prx.addParam("EVAL_ID", parent.EVAL_ID);
    prx.addParam("REF_ID", parent.REF_ID);
    prx.addParam("PAPER_LIST_SEQ", parent.LIST_SEQ);
    prx.addParam("EVAL_CODE", gEvalCode);

    prx.onSuccess = function()
    {
        gEvalId = ds_mainInfo.value(0, "EVAL_ID");

        parent.REF_ID = ds_mainInfo.value(0, "REF_ID");
        parent.LIST_SEQ = ds_mainInfo.value(0, "PAPER_LIST_SEQ");

        if (PJT_TYPE.index == -1) PJT_TYPE.index = 0;

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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.priorjob.evaluation.act.UpdateEvaluationE02.do";
    prx.addParam("EVAL_ID", gEvalId);
    prx.addParam("REF_ID", parent.REF_ID);
    prx.addParam("PAPER_LIST_SEQ", parent.LIST_SEQ);
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.priorjob.evaluation.act.UpdateEvaluationE02.do";
    prx.addParam("EVAL_ID", gEvalId);
    prx.addParam("REF_ID", parent.REF_ID);
    prx.addParam("PAPER_LIST_SEQ", parent.LIST_SEQ);
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

//등록평가점수 계산
function fnCalPoint()
{
    var appEvalPoint = parseFloat(APP_EVAL_POINT.value);
    var appReqcnt = parseFloat(APP_REQCNT.value);
    var regReqcnt = parseFloat(REG_REQCNT.value);

    var point = appEvalPoint * 10 * regReqcnt / appReqcnt;

    POINT.value2 = (isNaN(point) ? "" : point);
}

//상세
function fnDetail()
{
    window.location.replace("EvaluationE02.jsp");
}
</SCRIPT>

<!-- 발명부서 평가내용 준비시 -->
<SCRIPT language="JScript" for="any_invEvalList" event="OnReady()">
    if (EXE_DIV.value == "") EXE_DIV.value = this.value(0);
</SCRIPT>

<!-- 출원평가점수 변경시 -->
<SCRIPT language="JScript" for="APP_EVAL_POINT" event="OnChangeValue()">
    fnCalPoint();
</SCRIPT>

<!-- 청구항:원청구항(출원시) 변경시 -->
<SCRIPT language="JScript" for="APP_REQCNT" event="OnChangeValue()">
    fnCalPoint();
</SCRIPT>

<!-- 청구항:최종(등록시) 변경시 -->
<SCRIPT language="JScript" for="REG_REQCNT" event="OnChangeValue()">
    fnCalPoint();
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
        <TD req="EXE_DIV">실시여부</TD>
        <TD><ANY:RADIO id="EXE_DIV" codeData="{REG_EVAL_EXE_DIV}" /></TD>
    </TR>
    <TR>
        <TD>제품명</TD>
        <TD><INPUT type="text" id="PROD_NAME" maxByte="300"></TD>
    </TR>
    <TR>
        <TD>최초상업화시작</TD>
        <TD><INPUT type="text" id="FIRST_COMMERC_START" maxByte="300"></TD>
    </TR>
    <TR>
        <TD>관련사업부</TD>
        <TD><INPUT type="text" id="REF_DIVISN" maxByte="300"></TD>
    </TR>
    <TR>
        <TD>종합적 평가의견</TD>
        <TD><TEXTAREA id="EVAL_OPINION" rows="4" maxByte="4000"></TEXTAREA></TD>
    </TR>
</TABLE>
<TABLE border="0" cellspacing="1" cellpadding="2" class="main" style="margin-top:2px;">
    <COLGROUP>
        <COL class="conthead" width="25%">
        <COL class="contdata" width="25%">
        <COL class="conthead" width="25%">
        <COL class="contdata" width="25%">
    </COLGROUP>
    <TR>
        <TD colspan="4" align="center">
            <TABLE border="0" cellspacing="0" cellpadding="0">
                <TR>
                    <TD>※ 출원평가 점수 자동 입력이 안될 경우, 원천 및 개량 특허에 따라 아래와 같이 점수를 반영합니다.</TD>
                </TR>
            </TABLE>
            <TABLE border="0" cellspacing="1" cellpadding="2" style="background-color:#A5AEB5;">
                <TR>
                    <TD class="conthead">구분</TD>
                    <TD class="conthead">원천특허</TD>
                    <TD class="conthead">개량특허</TD>
                </TR>
                <TR>
                    <TD class="conthead">반영점수</TD>
                    <TD class="contdata" align="right">60</TD>
                    <TD class="contdata" align="right">30</TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD>출원평가점수</TD>
        <TD><INPUT type="text" id="APP_EVAL_POINT" format="number(3)" style="text-align:center;"></TD>
        <TD>프로젝트유형</TD>
        <TD><ANY:SELECT id="PJT_TYPE" codeData="{PROJECT_TYPE}" /></TD>
    </TR>
    <TR>
        <TD>청구항:원청구항(출원시)</TD>
        <TD><INPUT type="text" id="APP_REQCNT" format="number(3)" style="text-align:center;"></TD>
        <TD>청구항:최종(등록시)</TD>
        <TD><INPUT type="text" id="REG_REQCNT" format="number(3)" style="text-align:center;"></TD>
    </TR>
    <TR>
        <TD>등록평가등급/점수</TD>
        <TD><INPUT type="text" id="POINT" format="number2" style="text-align:center;" readOnly2></TD>
        <TD req="GRADE">등록보상등급</TD>
        <TD><ANY:RADIO type="text" id="GRADE" codeData="{REG_REWARD_GRADE}" /></TD>
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
