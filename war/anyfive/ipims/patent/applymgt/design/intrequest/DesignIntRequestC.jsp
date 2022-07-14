<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<%@page import="any.util.etc.NDateUtil"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>디자인출원의뢰현황 작성</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("KO_APP_TITLE");
    addBind("EN_APP_TITLE");
    addBind("DESIGN_IMG_FILE", "any_designImgFile");
    addBind("ETC_FILE", "any_etcFile");
    addBind("OUT_MODEL_NAME");
    addBind("PROD_PLAN_DATE");
    addBind("APP_IMMED_YN");
    addBind("APP_IMMED_REASON");
    addBind("DESIGN_DESC");
    addBind("DESIGN_CREATE_CONTENTS");
    addBind("DOC_FILE", "any_docFile");
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.design.intrequest.act.CreateDesignIntRequest.do";
    prx.addData("ds_mainInfo");
    prx.addData("ds_inventorList");
    prx.addData("ds_countryList");
    prx.addData("ds_designImgFile");
    prx.addData("ds_etcFile");
    prx.addData("ds_docFile");


    prx.onSuccess = function()
    {
        parent.REF_ID = this.result;

        alert("<%= app.message.get("msg.com.info.save").toJS() %>");

        if (isWriteEnd == true) {
            window.location.replace("DesignIntRequestRD.jsp");
        } else {
            window.location.replace("DesignIntRequestU.jsp");
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
        <TD disabled>(<%= app.message.get("msg.com.autocreate") %>)</TD>
        <TD>작성자(작성일)</TD>
        <TD><%= app.userInfo.getEmpHname() %>(<ANY:SPAN id="CRE_DATE" value="<%= NDateUtil.getSysDate() %>" format="date" />)</TD>
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
            <ANY:INV id="any_inventorList" mode="C1" />
        </TD>
    </TR>
    <TR>
        <TD>출원예상국가</TD>
        <TD colspan="3">
            <ANY:MSEARCH id="any_countryList" mode="C"><COMMENT>
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
            <ANY:FILE id="any_designImgFile" mode="C" policy="design_image" imageMode="true" />
        </TD>
    </TR>
    <TR>
        <TD>6면도 및 사시도<BR>또는 의장출원품의서</TD>
        <TD colspan="3">
            <ANY:FILE id="any_etcFile" mode="C" policy="design_etc" />
        </TD>
    </TR>
    <TR>
        <TD>출시모델명</TD>
        <TD><INPUT type="text" id="OUT_MODEL_NAME" maxByte="30"></TD>
        <TD>양산계획일</TD>
        <TD><ANY:DATE id="PROD_PLAN_DATE" /></TD>
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
        <TD>디자인설명</TD>
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
            <ANY:FILE id="any_docFile" mode="C" policy="design_doc"/>
        </TD>
    </TR>
    <TR>
        <TD colspan="4" align="center">
            <첨부파일 Uploade시 요청사항><BR>
            3D에서 2D로 전환시킨 의장 도면을 첨부하실때, 3D의 3면이 보이는 입체도를 2D도면에서 추가로 삽입하신 dwg파일을 첨부해 주십시오.<br>
                                대다수의 2D도면에 기본 6면도는 있으나, 사시도가 누락되어 의장 출원 준비작업이 많이 소요되오니 협조 부탁드립니다.
        </TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.savetemp").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.saveend").toHTML() %>" onClick="javascript:fnSave(true);"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="list" list="<%= request.getContextPath() %>/anyfive/ipims/patent/applymgt/design/intrequest/DesignIntRequestListR.jsp"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
