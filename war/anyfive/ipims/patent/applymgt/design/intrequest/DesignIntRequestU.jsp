<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>디자인출원의뢰현황 수정</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_APPROVAL); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("REF_NO");
    addBind("KO_APP_TITLE");
    addBind("EN_APP_TITLE");
    addBind("APP_IMMED_YN");
    addBind("APP_IMMED_REASON");
    addBind("DESIGN_IMG_FILE", "any_designImgFile");
    addBind("OUT_MODEL_NAME");
    addBind("PROD_PLAN_DATE");
    addBind("ETC_FILE", "any_etcFile");
    addBind("DESIGN_DESC");
    addBind("DESIGN_CREATE_CONTENTS");
    addBind("USER_NAME");
    addBind("CRE_DATE");
    addBind("DOC_FILE", "any_docFile");
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.design.intrequest.act.RetrieveDesignIntRequest.do";
    prx.addParam("REF_ID", parent.REF_ID);
    prx.checkData = ds_mainInfo;

    prx.onSuccess = function()
    {
        cfShowObjects([btn_saveTemp], ds_mainInfo.value(0, "WRITE_END_YN") == "0");

        KO_APP_TITLE.focus();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//저장
function fnSave(isWriteEnd, isFileUploaded)
{
    if (isWriteEnd == true) {
        if (!cfCheckAllReqValid()) return;
        if (!any_inventorList.valid) return;
    }

    if (isFileUploaded != true) {
        if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;
        cfFileUpload("fnSave(" + isWriteEnd + ", true);");
        return;
    }

    ds_mainInfo.value(0, "WRITE_END_YN") = (isWriteEnd ? "1" : "0");

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.design.intrequest.act.UpdateDesignIntRequest.do";
    prx.addParam("REF_ID", parent.REF_ID);
    prx.addData("ds_mainInfo");
    prx.addData("ds_inventorList");
    prx.addData("ds_countryList");
    prx.addData("ds_designImgFile");
    prx.addData("ds_etcFile");
    prx.addData("ds_docFile");

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");

        if (isWriteEnd == true) {
            window.location.replace("DesignIntRequestRD.jsp");
        } else {
            fnRetrieve();
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
        <TD><SPAN id="USER_NAME"></SPAN>(<ANY:SPAN id="CRE_DATE" format="date" />)</TD>
    </TR>
    <TR>
        <TD req="KO_APP_TITLE">디자인명(한)</TD>
        <TD colspan="3"><INPUT type="text" id="KO_APP_TITLE"></TD>
    </TR>
    <TR>
        <TD>디자인명(영)</TD>
        <TD colspan="3"><INPUT type="text" id="EN_APP_TITLE"></TD>
    </TR>
    <TR>
        <TD req="any_inventorList">발명자</TD>
        <TD colspan="3">
            <ANY:INV id="any_inventorList" mode="U" />
        </TD>
    </TR>
    <TR>
        <TD>출원예상국가</TD>
        <TD colspan="3">
            <ANY:MSEARCH id="any_countryList" mode="U"><COMMENT>
                win.path = top.getRoot() + "/anyfive/ipims/patent/common/popup/search/CountrySearchListR.jsp";
                codeColumn = "COUNTRY_CODE";
                nameExpr = "[{#COUNTRY_CODE}] {#COUNTRY_NAME}";
                size = 6;
            </COMMENT></ANY:MSEARCH>
        </TD>
    </TR>
    <TR>
        <TD>디자인이미지</TD>
        <TD colspan="3">
            <ANY:FILE id="any_designImgFile" mode="U" policy="design_image" imageMode="true" />
        </TD>
    </TR>
    <TR>
        <TD>6면도 및 사시도<BR>또는 의장출원품의서</TD>
        <TD colspan="3">
            <ANY:FILE id="any_etcFile" mode="U" policy="design_etc" />
        </TD>
    </TR>
    <TR>
        <TD>출시모델명</TD>
        <TD><INPUT type="text" id="OUT_MODEL_NAME"></TD>
        <TD>양산계획일</TD>
        <TD><ANY:DATE id="PROD_PLAN_DATE" /></TD>
    </TR>
    <TR>
        <TD req="APP_IMMED_YN">출원의 완급</TD>
        <TD>
            <ANY:RADIO id="APP_IMMED_YN" codeData="{APP_IMMED_YN}" reqTd="td_appImmedReason" />
        </TD>
        <TD id="td_appImmedReason" req="APP_IMMED_REASON" reqEnable="false">출원긴급이유</TD>
        <TD><INPUT type="text" id="APP_IMMED_REASON"></TD>
    </TR>
    <TR>
        <TD>디자인 설명</TD>
        <TD colspan="3">
            <TEXTAREA id="DESIGN_DESC" rows="5" maxByte="500"></TEXTAREA>
        </TD>
    </TR>
    <TR>
        <TD>디자인 창작내용</TD>
        <TD colspan="3">
            <TEXTAREA id="DESIGN_CREATE_CONTENTS" rows="5" maxByte="500"></TEXTAREA>
        </TD>
    </TR>
    <TR>
        <TD>디자인 신고서</TD>
        <TD colspan="3">
            <ANY:FILE id="any_docFile" mode="U" policy="design_doc"/>
        </TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.savetemp").toHTML() %>" onClick="javascript:fnSave();" id="btn_saveTemp" display="none"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.saveend").toHTML() %>" onClick="javascript:fnSave(true);"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.cancel").toHTML() %>" onClick="javascript:history.back();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="list" list="DesignIntRequestListR.jsp"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
