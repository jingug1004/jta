<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.office.common.app.OfficeApp"%><% OfficeApp app = new OfficeApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>국내출원의뢰접수</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("REF_NO");
    addBind("JOB_MAN_NAME");
    addBind("RIGHT_DIV_NAME");
    addBind("OFFICE_SEND_DATE");
    addBind("KO_APP_TITLE");
    addBind("APP_IMMED_YN");
    addBind("EXAMREQ_YN");
    addBind("APP_IMMED_REASON");
    addBind("INV_GRADE");
    addBind("UNION_REF_NO");
    addBind("PRIOR_REF_NO");
    addBind("DOC_FILE", "any_docFile");
    addBind("IMG_FILE", "any_imgFile");
    addBind("ETC_FILE", "any_etcFile");
    addBind("OFFICE_TRANS_CONTENTS");
    addBind("OFFICE_REF_NO");
    addBind("OFFICE_JOB_MAN");
    addBind("OFFICE_REF_NO_SPAN");
    addBind("OFFICE_JOB_MAN_NAME");
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
    prx.path = top.getRoot() + "/anyfive.ipims.office.reqreceipt.intapply.act.RetrieveIntApplyReceipt.do";
    prx.addParam("REF_ID", parent.REF_ID);
    prx.checkData = ds_mainInfo;

    prx.onSuccess = function()
    {
        var isEditable = (ds_mainInfo.value(0, "IS_EDITABLE") == "1");
        var isPatent = (ds_mainInfo.value(0, "RIGHT_DIV") == "10" || ds_mainInfo.value(0, "RIGHT_DIV") == "20");

        cfShowObjects([tr_invGrade], ds_mainInfo.value(0, "RIGHT_DIV") == "10" || ds_mainInfo.value(0, "RIGHT_DIV") == "20");
        cfShowObjects([tr_refNoEdit, btn_save, btn_line], isEditable);
        cfShowObjects([tr_refNoView], !isEditable);

        cfShowObjects([tr_docFile], isPatent == true);
        cfShowObjects([tr_imgFile, tr_etcFile], isPatent != true);

        switch (ds_mainInfo.value(0, "RIGHT_DIV")) {
        case "30":
            td_imgFileLabel.innerHTML = "디자인이미지";
            td_etcFileLabel.innerHTML = "6면도 및 사시도<BR>또는 의장출원품의서";
            break;
        case "40":
            td_imgFileLabel.innerHTML = "상표이미지";
            td_etcFileLabel.innerHTML = "기타자료";
            break;
        }
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//발명자 조회
function fnRetrieveInventor()
{
    var win = new any.window();
    win.path = top.getRoot() + "/anyfive/ipims/office/common/popup/viewer/InventorListR.jsp";
    win.arg.REF_ID = parent.REF_ID;
    win.opt.width = 800;
    win.opt.height = 400;
    win.show();
}

//관련파일 목록
function fnOpenRefFileList()
{
}

//저장
function fnSave()
{
    //필수항목 체크
    if (!cfCheckAllReqValid()) return;

    //저장 확인
    if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.office.reqreceipt.intapply.act.UpdateIntApplyReceipt.do";
    prx.addParam("REF_ID", parent.REF_ID);
    prx.addData("ds_mainInfo");

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        parent.goList();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}
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
        <TD>특허담당자</TD>
        <TD><SPAN id="JOB_MAN_NAME"></SPAN></TD>
    </TR>
    <TR>
        <TD>출원구분</TD>
        <TD><SPAN id="RIGHT_DIV_NAME"></SPAN></TD>
        <TD>의뢰일자</TD>
        <TD><ANY:SPAN id="OFFICE_SEND_DATE" format="date" /></TD>
    </TR>
    <TR>
        <TD>발명의 명칭</TD>
        <TD colspan="3"><SPAN id="KO_APP_TITLE"></SPAN></TD>
    </TR>
    <TR>
        <TD>출원긴급도</TD>
        <TD><ANY:RADIO id="APP_IMMED_YN" codeData="{APP_IMMED_YN}" readOnly /></TD>
        <TD>심사청구</TD>
        <TD><ANY:RADIO id="EXAMREQ_YN" codeData="{EXAMREQ_YN}" readOnly /></TD>
    </TR>
    <TR>
        <TD>출원긴급이유</TD>
        <TD colspan="3"><SPAN id="APP_IMMED_REASON"></SPAN></TD>
    </TR>
    <TR id="tr_invGrade" style="display:none;">
        <TD>출원등급</TD>
        <TD colspan="3"><ANY:RADIO id="INV_GRADE" codeData="{INV_GRADE}" readOnly /></TD>
    </TR>
    <TR>
        <TD>병합REF_NO</TD>
        <TD><SPAN id="UNION_REF_NO"></SPAN></TD>
        <TD>국내우선권번호</TD>
        <TD><SPAN id="PRIOR_REF_NO"></SPAN></TD>
    </TR>
    <TR>
        <TD>발명자<BR/><BUTTON text = "발명자 조회" onClick = "javascript:fnRetrieveInventor()"></BUTTON></TD>
        <TD colspan="3"><ANY:INV id="any_inventorList" /></TD>
    </TR>
    <TR>
        <TD>프로젝트</TD>
        <TD colspan="3">
            <ANY:PJT id="any_projectList" mode="R" />
        </TD>
    </TR>
    <TR id="tr_docFile" style="display:none;">
        <TD>직무발명신고서</TD>
        <TD colspan="3">
            <ANY:FILE id="any_docFile" mode="R" />
        </TD>
    </TR>
    <TR id="tr_imgFile" style="display:none;">
        <TD id="td_imgFileLabel"></TD>
        <TD colspan="3">
            <ANY:FILE id="any_imgFile" mode="R" imageMode="true" />
        </TD>
    </TR>
    <TR id="tr_etcFile" style="display:none;">
        <TD id="td_etcFileLabel"></TD>
        <TD colspan="3">
            <ANY:FILE id="any_etcFile" mode="R" />
        </TD>
    </TR>
    <TR>
        <TD>지적재산팀전달내용</TD>
        <TD colspan="3"><SPAN id="OFFICE_TRANS_CONTENTS"></SPAN></TD>
    </TR>
    <TR id="tr_refNoEdit" style="display:none;">
        <TD req="OFFICE_REF_NO">사무소 REF</TD>
        <TD><INPUT type="text" id="OFFICE_REF_NO" maxByte="30"></TD>
        <TD req="OFFICE_JOB_MAN">사무소담당자</TD>
        <TD><ANY:SELECT id="OFFICE_JOB_MAN" codeData="/common/officeJobMan,<%= app.userInfo.getOfficeCode() %>" firstName="sel" readOnly /></TD>
    </TR>
    <TR id="tr_refNoView" style="display:none;">
        <TD>사무소 REF</TD>
        <TD><SPAN id="OFFICE_REF_NO_SPAN"></SPAN></TD>
        <TD>사무소담당자</TD>
        <TD><SPAN id="OFFICE_JOB_MAN_NAME"></SPAN></TD>
    </TR>
</TABLE>

<DIV class="button_area">
<!--
    <BUTTON text="관련파일 목록" onClick="javascript:fnOpenRefFileList();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
-->
    <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();" id="btn_save" display="none"></BUTTON>
    <BUTTON auto="line" id="btn_line" display="none"></BUTTON>
    <BUTTON auto="list"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
