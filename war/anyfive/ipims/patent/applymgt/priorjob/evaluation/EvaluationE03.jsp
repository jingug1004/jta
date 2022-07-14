<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>사무소평가표</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_APPROVAL); %>
<ANY:DS id="ds_mainInfo" />
<ANY:DS id="ds_regInfo"><COMMENT>

    //addBind("EVAL_OPINION");

</COMMENT></ANY:DS>
<SCRIPT language="JScript">
var gEvalCode = "E04";
var gEvalId;

parent.editMode = {};

//윈도우 로딩시
window.onready = function()
{
    INVDEPT_EVAL_USER.codeData = "/applymgt/evalUser," + parent.REF_ID;

    fnRetrieve();


}


function fnButtonCntrol()
{
    var isInvdeptEvalUser = (ds_mainInfo.value(0, "INVDEPT_EVAL_USER") == "<%= app.userInfo.getUserId() %>");
    // 수정
    if (isInvdeptEvalUser == true)
    {
        cfShowObjects([btn_modifyInv, btn_line2], true);
    }
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

        cfShowObjects([INVDEPT_EVAL_USER, ico_evalUser, btn_evalUser, btn_line1], ds_mainInfo.value(0, "INVDEPT_EVAL_USER") == "");
        cfShowObjects([INVDEPT_EVAL_USER_NAME], ds_mainInfo.value(0, "INVDEPT_EVAL_USER") != "");

        INVDEPT_EVAL_USER_NAME.innerText = ds_mainInfo.value(0, "INVDEPT_EVAL_USER_NAME");
        any_invEvalList.evalId = ds_mainInfo.value(0, "EVAL_ID");

        any_invEvalList.reset(ds_mainInfo.value(0, "INVDEPT_EVAL_SHEET_ID"), gEvalId);

        //cfShowObjects([any_approvalInv], ds_mainInfo.value(0, "INVDEPT_EVAL_YN") == "1");

        //any_approvalInv.reset();
        fnButtonCntrol();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}



//평가자 검색
function fnSearchEvalUser()
{
    var win = new any.window();
    win.path = top.getRoot() + "/anyfive/ipims/patent/common/popup/search/UserSearchListR.jsp";
    win.opt.width = 600;
    win.opt.height = 500;
    win.show();

    if (win.rtn == null) return;

    if (INVDEPT_EVAL_USER.valueRow(win.rtn.USER_ID) == -1) {
        INVDEPT_EVAL_USER.addItem(win.rtn.USER_ID, win.rtn.EMP_HNAME);
    }

    INVDEPT_EVAL_USER.value = win.rtn.USER_ID;
}

//평가자 지정
function fnSaveEvalUser()
{
    if (INVDEPT_EVAL_USER.value == "") {
        alert("평가자를 선택하세요.");
        INVDEPT_EVAL_USER.focus();
        return;
    }

    //저장 확인
    if (!confirm('발명부서 평가자를 "' + INVDEPT_EVAL_USER.text + '" 님으로 지정하시겠습니까?')) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.priorjob.evaluation.act.CreateEvaluationInvDeptUser.do";
    prx.addParam("REF_ID", parent.REF_ID);
    prx.addParam("PAPER_LIST_SEQ", parent.LIST_SEQ);
    prx.addParam("EVAL_CODE", gEvalCode);
    prx.addParam("INVDEPT_EVAL_USER", INVDEPT_EVAL_USER.value);

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        fnRetrieve();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//수정
function fnModify(mode)
{
    parent.editMode = {};
    parent.editMode[mode] = true;

    window.location.href = "EvaluationE03U.jsp";
}
</SCRIPT>



</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<ANY:ABSTRACT id="any_abstractInfo" />

<TABLE border="0" cellspacing="1" cellpadding="2" class="main" style="margin-top:2px;">
    <TR>
        <TD class="title_table">[발명부서 사무소평가]</TD>
    </TR>
</TABLE>
<ANY:EVAL id="any_invEvalList" />
<TABLE border="0" cellspacing="1" cellpadding="2" class="main" style="margin-top:2px;">
    <COLGROUP>
        <COL class="conthead" width="30%" style="text-align:left;">
        <COL class="contdata" width="70%">
    </COLGROUP>
    <TR>
        <TD>종합적 평가의견</TD>
        <TD><TEXTAREA id="EVAL_OPINION" rows="4"  bind="ds_mainInfo" readOnly2></TEXTAREA></TD>
    </TR>
</TABLE>
<DIV class="button_area">
    <SPAN>발명부서 평가자 :</SPAN>
    <SPAN id="INVDEPT_EVAL_USER_NAME" style="display:none;"></SPAN>
    <ANY:SELECT id="INVDEPT_EVAL_USER" style="width:80px; display:none;" />
    <BUTTON icon="<%= request.getContextPath() %>/anyfive/ipims/share/image/icon_search.gif" width="25px" space="left:2" onClick="javascript:fnSearchEvalUser();" id="ico_evalUser" display="none"></BUTTON>
    <BUTTON text="평가자 지정" onClick="javascript:fnSaveEvalUser();" id="btn_evalUser" display="none"></BUTTON>
    <BUTTON auto="line" id="btn_line1" display="none"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.modify").toHTML() %>" onClick="javascript:fnModify('INV');" id="btn_modifyInv" display="none"></BUTTON>
    <BUTTON auto="line" id="btn_line2" display="none"></BUTTON>
    <BUTTON auto="close" id="btn_close"></BUTTON>
</DIV>


<% app.writeBodyFooter(); %>

</BODY>
</HTML>
