<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<%@page import="any.util.etc.NDateUtil"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>직무발명신고현황 작성</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("RIGHT_DIV");
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
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    KO_APP_TITLE.focus();
}

//저장
function fnSave(isWriteEnd, isFileUploaded)
{
    if (!cfCheckAllReqValid()) return;
    if (!any_inventorList.valid) return;

    if (isFileUploaded != true) {
        if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;
        cfFileUpload("fnSave(" + isWriteEnd + ", true);");
        return;
    }

    ds_mainInfo.value(0, "WRITE_END_YN") = (isWriteEnd ? "1" : "0");

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.intpatent.request.act.CreateIntPatentRequest.do";
    prx.addData("ds_mainInfo");
    prx.addData("ds_inventorList");
    prx.addData("ds_projectList");
    prx.addData("ds_techCodeList");
    prx.addData("ds_prodCodeList");
    prx.addData("ds_referRefNoList");
    prx.addData("ds_prschList");
    prx.addData("ds_docFile");
    prx.addData("ds_prschFile");

    prx.onSuccess = function()
    {
        parent.REF_ID = this.result;

        alert("<%= app.message.get("msg.com.info.save").toJS() %>");

        if (isWriteEnd == true) {
            window.location.replace("IntPatentRequestRD.jsp");
        } else {
            window.location.replace("IntPatentRequestU.jsp");
        }
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//필수여부 설정
function fnSetReqEnable(obj, enable)
{
    var td = document.getElementById(obj.reqTd);

    td.reqEnable = enable;

    for (var i = 0; i < td.req.length; i++) {
        document.getElementById(td.req[i].ctrl).disabled = !enable;
    }
}
</SCRIPT>

<!-- 출원의 완급 변경시 -->
<SCRIPT language="JScript" for="APP_IMMED_YN" event="OnChange()">
    fnSetReqEnable(this, this.value == "1");
</SCRIPT>

<!-- 해외출원필요성 변경시 -->
<SCRIPT language="JScript" for="EXT_APP_NEED_YN" event="OnChange()">
    EXT_APP_NEED_REASON.disabled = (this.value != "1");
</SCRIPT>

<!-- 타사공동출원여부 변경시 -->
<SCRIPT language="JScript" for="CORGT_YN" event="OnChange()">
    fnSetReqEnable(this, this.value == "1");
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
        <TD disabled>(<%= app.message.get("msg.com.autocreate") %>)</TD>
        <TD>작성자</TD>
        <TD><%= app.userInfo.getEmpHname() %></TD>
    </TR>
    <TR>
        <TD req="RIGHT_DIV">권리구분</TD>
        <TD>
            <ANY:SELECT id="RIGHT_DIV" codeData="{RIGHT_DIV_PAT}" style="width:100%;" />
        </TD>
        <TD>작성일</TD>
        <TD><ANY:SPAN format="date" value="<%= NDateUtil.getSysDate() %>" /></TD>
    </TR>
    <TR>
        <TD req="KO_APP_TITLE">발명의 명칭(한)</TD>
        <TD colspan="3"><INPUT type="text" id="KO_APP_TITLE" maxByte="1000"></TD>
    </TR>
    <TR>
        <TD>발명의 명칭(영)</TD>
        <TD colspan="3"><INPUT type="text" id="EN_APP_TITLE" maxByte="1000"></TD>
    </TR>
    <TR>
        <TD req="any_inventorList">발명자</TD>
        <TD colspan="3">
            <ANY:INV id="any_inventorList" mode="C1" />
        </TD>
    </TR>
    <TR>
        <TD>프로젝트</TD>
        <TD colspan="3">
            <ANY:PJT id="any_projectList" mode="C" />
        </TD>
    </TR>
    <TR>
        <TD req ="any_techCodeList">기술분류코드</TD>
        <TD>
            <ANY:MSEARCH id="any_techCodeList" mode="C"><COMMENT>
                win.path = top.getRoot() + "/anyfive/ipims/patent/common/popup/search/TechCodeSearchTreeR.jsp";
                codeColumn = "TECH_CODE";
                nameExpr = "[{#TECH_CODE}] {#TECH_PATHNAME}";
                size = 6;
            </COMMENT></ANY:MSEARCH>
        </TD>
        <TD>관련제품코드</TD>
        <TD>
            <ANY:MSEARCH id="any_prodCodeList" mode="C"><COMMENT>
                win.path = top.getRoot() + "/anyfive/ipims/patent/common/popup/search/ProdCodeSearchListR.jsp";
                win.opt.width = 650;
                codeColumn = "PROD_CODE";
                nameExpr = "[{#PROD_CODE}] {#PROD_NAME}";
                size = 6;
            </COMMENT></ANY:MSEARCH>
        </TD>
    </TR>
    <TR>
        <TD>인용REF</TD>
        <TD colspan="3">
            <ANY:REFNO id="any_referRefNoList" mode="C" rightDiv="10,20" />
        </TD>
    </TR>
    <TR>
        <TD req="APP_IMMED_YN">출원의 완급</TD>
        <TD>
            <ANY:RADIO id="APP_IMMED_YN" codeData="{APP_IMMED_YN}" reqTd="td_appImmedReason" />
        </TD>
        <TD id="td_appImmedReason" req="APP_IMMED_REASON" reqEnable="false">출원긴급이유</TD>
        <TD><INPUT type="text" id="APP_IMMED_REASON" maxByte="1000" disabled></TD>
    </TR>
    <TR>
        <TD req="EXT_APP_NEED_YN">해외출원필요성</TD>
        <TD>
            <ANY:RADIO id="EXT_APP_NEED_YN" codeData="{EXT_APP_NEED_YN}" />
        </TD>
        <TD>해외출원이유</TD>
        <TD><INPUT type="text" id="EXT_APP_NEED_REASON" maxByte="100" disabled></TD>
    </TR>
    <TR>
        <TD req="CORGT_YN">타사공동출원여부</TD>
        <TD>
            <ANY:RADIO id="CORGT_YN" codeData="{YES_NO}" reqTd="td_corgtMan" />
        </TD>
        <TD id="td_corgtMan" req="CORGT_MAN" reqEnable="false">공동권리자</TD>
        <TD><INPUT type="text" id="CORGT_MAN" maxByte="100" disabled></TD>
    </TR>
    <TR>
        <TD req="INV_COMPLETION">발명의 완성도</TD>
        <TD colspan="3">
            <ANY:RADIO id="INV_COMPLETION" codeData="{INV_COMPLETION}" />
        </TD>
    </TR>
    <TR>
        <TD>초록정보</TD>
        <TD colspan="3"><TEXTAREA id="INV_ABSTRACT" rows="5" maxByte="4000"></TEXTAREA></TD>
    </TR>
    <TR>
        <TD req="any_docFile">직무발명신고서</TD>
        <TD colspan="3">
            <ANY:FILE id="any_docFile" mode="C" policy="invdoc" />
        </TD>
    </TR>
    <TR>
        <TD>선행기술자료</TD>
        <TD colspan="3">
            <ANY:FILE id="any_prschFile" mode="C" policy="prsch" />
        </TD>
    </TR>
    <TR style="display:none;">
        <TD>선행조사</TD>
        <TD colspan="3">
            <ANY:PRSCH id="any_prschList" mode="C" />
        </TD>
    </TR>
    <TR>
        <TD>비고</TD>
        <TD colspan="3"><TEXTAREA id="REMARK" rows="5" maxByte="4000"></TEXTAREA></TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.savetemp").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.saveend").toHTML() %>" onClick="javascript:fnSave(true);"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="list" list="IntPatentRequestListR.jsp"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
