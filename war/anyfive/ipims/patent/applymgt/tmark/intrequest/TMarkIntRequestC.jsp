<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<%@page import="any.util.etc.NDateUtil"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>상표출원의뢰현황 작성</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
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
    USER_NAME.innerText = "<%= app.userInfo.getEmpHname() %>";
    CRE_DATE.value = "<%= NDateUtil.getSysDate() %>";

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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.tmark.intrequest.act.CreateTMarkIntRequest.do";
    prx.addData("ds_mainInfo");
    prx.addData("ds_inventorList");
    prx.addData("ds_prschList");
    prx.addData("ds_tmarkImgFile");
    prx.addData("ds_etcFile");

    prx.onSuccess = function()
    {
        parent.REF_ID = this.result;

        alert("<%= app.message.get("msg.com.info.save").toJS() %>");

        if (isWriteEnd == true) {
            window.location.replace("TMarkIntRequestRD.jsp");
        } else {
            window.location.replace("TMarkIntRequestU.jsp");
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
        <TD><SPAN id="USER_NAME"></SPAN>(<ANY:SPAN id="CRE_DATE" format="date" />)</TD>
    </TR>
    <TR>
        <TD req="KO_APP_TITLE">상표명(한)</TD>
        <TD colspan="3"><INPUT type="text" id="KO_APP_TITLE"></TD>
    </TR>
    <TR>
        <TD>상표명(영)</TD>
        <TD colspan="3"><INPUT type="text" id="EN_APP_TITLE"></TD>
    </TR>
    <TR>
        <TD req="any_inventorList">창작자</TD>
        <TD colspan="3">
            <ANY:INV id="any_inventorList" mode="C1" />
        </TD>
    </TR>
    <TR>
        <TD>상표이미지</TD>
        <TD colspan="3">
            <ANY:FILE id="any_tmarkImgFile" mode="C" policy="tmark_image" imageMode="true" />
        </TD>
    </TR>
    <TR>
        <TD>출시예정시기</TD>
        <TD><ANY:DATE id="OUT_PLAN_DATE" /></TD>
        <TD>적용모델</TD>
        <TD><INPUT type="text" id="APPLY_MODEL_NAME"></TD>
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
        <TD>상표신고서</TD>
        <TD colspan="3">
            <ANY:FILE id="any_etcFile" mode="C" policy="tmark_etc" />
        </TD>
    </TR>
    <TR>
        <TD>선행조사</TD>
        <TD colspan="3">
            <ANY:PRSCH id="any_prschList" mode="C" />
        </TD>
    </TR>
    <TR>
        <TD>발명자 의뢰내용</TD>
        <TD colspan="3"><TEXTAREA id="REQ_CONTENTS" rows="5" maxByte="500"></TEXTAREA></TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.savetemp").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.saveend").toHTML() %>" onClick="javascript:fnSave(true);"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="list" list="TMarkIntRequestListR.jsp"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
