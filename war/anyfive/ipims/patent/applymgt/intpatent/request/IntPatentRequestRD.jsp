<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.share.workprocess.util.WorkProcessConst"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>직무발명신고현황</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_WORKPROC); %>
<% app.writeHTCImport(app.HTC_APPROVAL); %>
<ANY:WORKPROC id="wp" />
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("REF_NO");
    addBind("CRE_USER_NAME");
    addBind("CRE_DATE");
    addBind("RIGHT_DIV_NAME");
    addBind("KO_APP_TITLE");
    addBind("EN_APP_TITLE");
    addBind("APP_IMMED_YN");
    addBind("APP_IMMED_REASON");
    addBind("EXT_APP_NEED_YN");
    addBind("EXT_APP_NEED_REASON");
    addBind("CORGT_YN");
    addBind("CORGT_MAN");
    addBind("INV_COMPLETION");
    addBind("INV_ABSTRACT");
    addBind("DOC_FILE", "any_docFile");
    addBind("PRSCH_FILE", "any_prschFile");
    addBind("REMARK");
    addBind("EXAM_RESULT_OPINION");
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.intpatent.request.act.RetrieveIntPatentRequest.do";
    prx.addParam("REF_ID", parent.REF_ID);
    prx.checkData = ds_mainInfo;

    prx.onSuccess = function()
    {
        if (ds_mainInfo.value(0, "CRE_USER") == "<%= app.userInfo.getUserId() %>" && ds_mainInfo.value(0, "WRITE_END_YN") != "1") {
            window.location.replace("IntPatentRequestU.jsp");
            return;
        }

        cfShowObjects([tr_examResultOpinion], ds_mainInfo.value(0, "EXAM_RESULT") == "2");

        any_approval.reset();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//재작성
function fnRewrite()
{
    if (!confirm("보완요청을 확인하시겠습니까?")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.intpatent.request.act.RewriteIntPatentRequest.do";
    prx.addParam("REF_ID", parent.REF_ID);

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        window.location.replace("IntPatentRequestU.jsp");
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
    window.location.href = "IntPatentRequestU.jsp";
}

//발명평가표 팝업
function fnOpenInvEval(isEditable)
{
    var win = new any.window();
    win.path = top.getRoot() + "/anyfive/ipims/patent/applymgt/priorjob/evaluation/EvaluationE01.jsp";
    win.arg.REF_ID = parent.REF_ID;
    win.arg.isInvEditable = isEditable;
    win.opt.width = 700;
    win.opt.height = 400;
    win.show();

    if (win.rtn == null) return;

    return "OK";
}

// 양도증 팝업
function fnInputPat(){
    if(  ds_mainInfo.value(0,"CHK_CNY") == ""){
        var win = new any.window(2);
        win.path = "IntPatentConveyPrintR.jsp";
        win.arg.REF_ID = ("REF_ID", parent.REF_ID);
        win.opt.width = 650;
        win.opt.height = 600;
        win.opt.resizable = "yes";

        win.onReload = function()
        {
            fnRetrieve();;
        }

        win.show();


    }else if( ds_mainInfo.value(0,"CHK_CNY") != 0 ){
        if (win.rtn == null) return;
        return "OK";
    }
}


</SCRIPT>

<!-- 결재현황 로딩시 -->
<SCRIPT language="JScript" for="any_approval" event="OnLoad()">
    wp.reset(parent.REF_ID);
</SCRIPT>

<!-- 업무프로세스 로딩시 -->
<SCRIPT language="JScript" for="wp" event="OnLoad()">
    var  isPatGroupUser = <%= app.userInfo.isMenuGroupUser("PAT") %>;
    var isCreUser = (ds_mainInfo.value(0, "CRE_USER") == "<%= app.userInfo.getUserId() %>" || isPatGroupUser);
    var actRewrite = "<%= WorkProcessConst.Action.REWRITE %>";
    var actModify = "<%= WorkProcessConst.Action.MODIFY %>";

    cfShowObjects([btn_rewrite, btn_line1], isCreUser && wp.avail([actRewrite]));
    cfShowObjects([btn_modify, btn_line2], isCreUser && wp.avail([actModify]));
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
        <TD>REF-NO</TD>
        <TD><SPAN id="REF_NO"></SPAN></TD>
        <TD>작성자</TD>
        <TD><SPAN id="CRE_USER_NAME"></SPAN></TD>
    </TR>
    <TR>
        <TD>권리구분</TD>
        <TD><SPAN id="RIGHT_DIV_NAME"></SPAN></TD>
        <TD>작성일</TD>
        <TD><ANY:SPAN format="date" id="CRE_DATE" /></TD>
    </TR>
    <TR>
        <TD>발명의 명칭(한)</TD>
        <TD colspan="3"><SPAN id="KO_APP_TITLE"></SPAN></TD>
    </TR>
    <TR>
        <TD>발명의 명칭(영)</TD>
        <TD colspan="3"><SPAN id="EN_APP_TITLE"></SPAN></TD>
    </TR>
    <TR>
        <TD>발명자</TD>
        <TD colspan="3">
            <ANY:INV id="any_inventorList" mode="R" />
        </TD>
    </TR>
    <TR>
        <TD>프로젝트</TD>
        <TD colspan="3">
            <ANY:PJT id="any_projectList" mode="R" />
        </TD>
    </TR>
    <TR>
        <TD>기술분류코드</TD>
        <TD>
            <ANY:MSEARCH id="any_techCodeList" mode="R"><COMMENT>
                codeColumn = "TECH_CODE";
                nameExpr = "[{#TECH_CODE}] {#TECH_PATHNAME}";
            </COMMENT></ANY:MSEARCH>
        </TD>
        <TD>관련제품코드</TD>
        <TD>
            <ANY:MSEARCH id="any_prodCodeList" mode="R"><COMMENT>
                codeColumn = "PROD_CODE";
                nameExpr = "[{#PROD_CODE}] {#PROD_NAME}";
            </COMMENT></ANY:MSEARCH>
        </TD>
    </TR>
    <TR>
        <TD>인용REF</TD>
        <TD colspan="3">
            <ANY:REFNO id="any_referRefNoList" mode="R" />
        </TD>
    </TR>
    <TR>
        <TD>출원의 완급</TD>
        <TD>
            <ANY:RADIO id="APP_IMMED_YN" codeData="{APP_IMMED_YN}" readOnly />
        </TD>
        <TD>출원긴급이유</TD>
        <TD><SPAN id="APP_IMMED_REASON"></SPAN></TD>
    </TR>
    <TR>
        <TD>해외출원필요성</TD>
        <TD>
            <ANY:RADIO id="EXT_APP_NEED_YN" codeData="{EXT_APP_NEED_YN}" readOnly />
        </TD>
        <TD>해외출원이유</TD>
        <TD><SPAN id="EXT_APP_NEED_REASON"></SPAN></TD>
    </TR>
    <TR>
        <TD>타사공동출원여부</TD>
        <TD>
            <ANY:RADIO id="CORGT_YN" codeData="{YES_NO}" readOnly />
        </TD>
        <TD>공동권리자</TD>
        <TD><SPAN id="CORGT_MAN"></SPAN></TD>
    </TR>
    <TR>
        <TD>발명의 완성도</TD>
        <TD colspan="3">
            <ANY:RADIO id="INV_COMPLETION" codeData="{INV_COMPLETION}" readOnly />
        </TD>
    </TR>
    <TR>
        <TD>초록정보</TD>
        <TD colspan="3"><SPAN id="INV_ABSTRACT"></SPAN></TD>
    </TR>
    <TR>
        <TD>직무발명신고서</TD>
        <TD colspan="3">
            <ANY:FILE id="any_docFile" mode="R" />
        </TD>
    </TR>
    <TR>
        <TD>선행기술자료</TD>
        <TD colspan="3">
            <ANY:FILE id="any_prschFile" mode="R" />
        </TD>
    </TR>
    <TR style="display:none;">
        <TD>선행조사</TD>
        <TD colspan="3">
            <ANY:PRSCH id="any_prschList" mode="R" />
        </TD>
    </TR>
    <TR>
        <TD>비고</TD>
        <TD colspan="3"><SPAN id="REMARK"></SPAN></TD>
    </TR>
    <TR id="tr_examResultOpinion" style="display:none;">
        <TD>출원전 포기<BR>검토의견</TD>
        <TD colspan="3"><SPAN id="EXAM_RESULT_OPINION"></SPAN></TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="보완요청 확인" onClick="javascript:fnRewrite();" id="btn_rewrite" display="none"></BUTTON>
    <BUTTON auto="line" id="btn_line1" display="none"></BUTTON>
    <BUTTON text="발명평가표" onClick="javascript:fnOpenInvEval();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.modify").toHTML() %>" onClick="javascript:fnModify();" id="btn_modify" display="none"></BUTTON>
    <BUTTON auto="line" id="btn_line2" display="none"></BUTTON>
    <BUTTON auto="list" list="IntPatentRequestListR.jsp"></BUTTON>
</DIV>

<ANY:APPROVAL id="any_approval" code="P01" isPat="<%= app.userInfo.isMenuGroupUser("PAT") %>"><COMMENT>
    if("<%= app.userInfo.isMenuGroupUser("PAT") %>" == "true"){
        reqUser = "<%= app.userInfo.getUserId() %>";
    }else{
        reqUser = ds_mainInfo.value(0, "CRE_USER");
    }

    reqChkCny = ds_mainInfo.value(0, "CHK_CNY");

    addKey("REF_ID", parent.REF_ID);

    check("REQUEST") = function()
    {
         if( reqChkCny == 0){
            fnInputPat(true);
         }else{
            return "OK";
         }
    }

    //승인시 발명평가 작성
    check("AGREE") = function()
    {
        return (fnOpenInvEval(true) == "OK");
    }
</COMMENT></ANY:APPROVAL>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
