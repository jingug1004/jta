<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>사무소평가표 수정</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_APPROVAL); %>
<ANY:DS id="ds_mainInfo" />
<ANY:DS id="ds_regInfo"><COMMENT>

</COMMENT></ANY:DS>
<SCRIPT language="JScript">
var gEvalCode = "E05";
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

      any_abstractInfo.refId = parent.REF_ID;

      PATDEPT_EVAL_USER_NAME.innerText = ds_mainInfo.value(0, "PATDEPT_EVAL_USER_NAME");
      any_invEvalList.evalId = ds_mainInfo.value(0, "EVAL_ID");

      any_invEvalList.reset(ds_mainInfo.value(0, "INVDEPT_EVAL_SHEET_ID"), gEvalId);

      var isInvdeptEvalUser = (ds_mainInfo.value(0, "PATDEPT_EVAL_USER") == "<%= app.userInfo.getUserId() %>");

      any_invEvalList.mode = (isInvdeptEvalUser && parent.editMode.PAT ? "U" : "R");
      cfShowObjects([btn_saveInv, btn_modifyInv, btn_line1], any_invEvalList.mode == "U");

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
  }
}

//저장 - 발명부서
function fnSaveInv()
{
  var prx = new any.proxy();
  prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.priorjob.evaluation.act.UpdateEvaluationE03.do";
  prx.addParam("EVAL_ID", gEvalId);
  prx.addParam("REF_ID", parent.REF_ID);
  prx.addParam("PAPER_LIST_SEQ", parent.LIST_SEQ);
  prx.addParam("EVAL_KIND", "PATDEPT");
  prx.addParam("EVAL_CODE", gEvalCode);
  prx.addParam("EVAL_SHEET_ID", ds_mainInfo.value(0, "INVDEPT_EVAL_SHEET_ID"));
  prx.addParam("SUM_TOTAL", any_invEvalList.sumTotal);
  prx.addData("ds_invEvalList", "ds_evalList");
  prx.addData("ds_mainInfo");
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
    window.location.replace("EvaluationE04.jsp");
}
</SCRIPT>

</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<ANY:ABSTRACT id="any_abstractInfo" />

<TABLE border="0" cellspacing="1" cellpadding="2" class="main" style="margin-top:2px;">
    <TR>
        <TD class="title_table">[특허부서 사무소평가]</TD>
    </TR>
</TABLE>
<ANY:EVAL id="any_invEvalList" />
<TABLE border="0" cellspacing="1" cellpadding="2" class="main" style="margin-top:2px;">
    <COLGROUP>
        <COL class="conthead" width="30%" style="text-align:left;">
        <COL class="contdata" width="70%">
    </COLGROUP>
    <TR>
        <TD req="EVAL_OPINION">종합적 평가의견</TD>
        <TD><TEXTAREA id="EVAL_OPINION" rows="4" maxByte="4000"  bind="ds_mainInfo" ></TEXTAREA></TD>
    </TR>
</TABLE>
<DIV class="button_area">
    <SPAN>특허부서 평가자 :</SPAN>
    <SPAN id="PATDEPT_EVAL_USER_NAME"></SPAN>
    <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();" id="btn_saveInv" display="none"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.cancel").toHTML() %>" onClick="javascript:fnDetail();" id="btn_modifyInv" display="none"></BUTTON>
    <BUTTON auto="line" id="btn_line1" display="none"></BUTTON>
    <BUTTON auto="close" id="btn_close"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
