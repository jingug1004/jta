<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<%@page import="anyfive.ipims.share.workprocess.util.WorkProcessConst"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>상표출원의뢰현황 상세</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_WORKPROC); %>
<% app.writeHTCImport(app.HTC_APPROVAL); %>
<ANY:WORKPROC id="wp" />
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("REF_NO");
    addBind("KO_APP_TITLE");
    addBind("EN_APP_TITLE");
    addBind("APP_IMMED_YN");
    addBind("APP_IMMED_REASON");
    addBind("TMARK_IMG_FILE", "any_tmarkImgFile");
    addBind("OUT_PLAN_DATE");
    addBind("APPLY_MODEL_NAME");
    addBind("ETC_FILE", "any_etcFile");
    addBind("REQ_CONTENTS");
    addBind("USER_NAME");
    addBind("CRE_DATE");
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.tmark.intrequest.act.RetrieveTMarkIntRequest.do";
    prx.addParam("REF_ID", parent.REF_ID);
    prx.checkData = ds_mainInfo;

    prx.onSuccess = function()
    {
        if (ds_mainInfo.value(0, "CRE_USER") == "<%= app.userInfo.getUserId() %>" && ds_mainInfo.value(0, "WRITE_END_YN") != "1") {
            window.location.replace("TMarkIntRequestU.jsp");
            return;
        }

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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.tmark.intrequest.act.RewriteTMarkIntRequest.do";
    prx.addParam("REF_ID", parent.REF_ID);

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        window.location.replace("TMarkIntRequestU.jsp");
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
    window.location.href = "TMarkIntRequestU.jsp";
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
        <TD>작성자(작성일)</TD>
        <TD><SPAN id="USER_NAME"></SPAN>(<ANY:SPAN id="CRE_DATE" format="date"></ANY:SPAN>)</TD>
    </TR>
    <TR>
        <TD>상표명(한)</TD>
        <TD colspan="3"><SPAN id="KO_APP_TITLE"></SPAN></TD>
    </TR>
    <TR>
        <TD>상표명(영)</TD>
        <TD colspan="3"><SPAN id="EN_APP_TITLE"></SPAN></TD>
    </TR>
    <TR>
        <TD>창작자</TD>
        <TD colspan="3">
            <ANY:INV id="any_inventorList" mode="R" />
        </TD>
    </TR>
    <TR>
        <TD>상표이미지</TD>
        <TD colspan="3">
            <ANY:FILE id="any_tmarkImgFile" mode="R" imageMode="true" />
        </TD>
    </TR>
    <TR>
        <TD>출시예정시기</TD>
        <TD><ANY:SPAN id="OUT_PLAN_DATE" format="date" /></TD>
        <TD>적용모델</TD>
        <TD><SPAN id="APPLY_MODEL_NAME"></SPAN></TD>
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
        <TD>상표신고서</TD>
        <TD colspan="3">
            <ANY:FILE id="any_etcFile" mode="R" />
        </TD>
    </TR>
    <TR>
        <TD>선행조사</TD>
        <TD colspan="3">
            <ANY:PRSCH id="any_prschList" mode="R" />
        </TD>
    </TR>
    <TR>
        <TD>창작자 의뢰내용</TD>
        <TD colspan="3"><SPAN id="REQ_CONTENTS"></SPAN></TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="보완요청 확인" onClick="javascript:fnRewrite();" id="btn_rewrite" display="none"></BUTTON>
    <BUTTON auto="line" id="btn_line1" display="none"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.modify").toHTML() %>" onClick="javascript:fnModify();" id="btn_modify" display="none"></BUTTON>
    <BUTTON auto="line" id="btn_line2" display="none"></BUTTON>
    <BUTTON auto="list" list="TMarkIntRequestListR.jsp"></BUTTON>
</DIV>

<ANY:APPROVAL id="any_approval" code="T01" isPat="<%= app.userInfo.isMenuGroupUser("PAT") %>"><COMMENT>
    if("<%= app.userInfo.isMenuGroupUser("PAT") %>" == "true"){
        reqUser = "<%= app.userInfo.getUserId() %>";
    }else{
        reqUser = ds_mainInfo.value(0, "CRE_USER");
    }

    addKey("REF_ID", parent.REF_ID);
</COMMENT></ANY:APPROVAL>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
