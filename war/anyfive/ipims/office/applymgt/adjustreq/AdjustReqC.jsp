<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.office.common.app.OfficeApp"%><% OfficeApp app = new OfficeApp(request, response, out); %>
<%@page import="any.util.etc.NDateUtil"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>수정요청</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("REQ_MAIL_YN");
    addBind("REF_ID");
    addBind("REQ_SUBJECT");
    addBind("REQ_CONTENTS");
    addBind("REQ_FILE", "any_reqFile");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    REQ_SUBJECT.focus();
}

//저장
function fnSave(isFileUploaded)
{
    if (!cfCheckAllReqValid()) return;

    if( REQ_MAIL_YN.value == "1" ){
      메일보내는 부분 // fnMailSend();
    }
    if (isFileUploaded != true) {
        if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;
        cfFileUpload("fnSave(true);");
        return;
    }

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.office.applymgt.adjustreq.act.CreateAdjustReq.do";
    prx.addData("ds_mainInfo");
    prx.addData("ds_reqFile");

    prx.onSuccess = function()
    {
        parent.REQ_ID = this.result;
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        window.location.replace("AdjustReqRD.jsp");
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//메일발송
function fnMailSend()
{
    var win = new any.window();
    win.path = top.getRoot() + "/anyfive/ipims/share/docpaper/informmail/InformMailreq.jsp";
    win.arg.REF_ID = REF_ID.value;
    win.arg.REQ_SUBJECT = REQ_SUBJECT.value;
    win.arg.REQ_CONTENTS = REQ_CONTENTS.value;
    win.opt.width = 750;
    win.opt.height = 650;
    win.show();
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
        <TD>요청자명</TD>
        <TD>
            <%= app.userInfo.getEmpHname() %>(<%= app.userInfo.getEmpNo() %>)
        </TD>
        <TD>요청일시</TD>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD>
                        <ANY:SPAN format="date" value="<%= NDateUtil.getSysDate() %>" />
                    </TD>
                    <TD>
                        <ANY:RADIO id="REQ_MAIL_YN" codeData="/applymgt/reqMailSendYn" value="0" />
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD req="REF_ID">의뢰번호</TD>
        <TD>
            <ANY:SEARCH id="REF_ID" mode="C"><COMMENT>
                win.path = top.getRoot() + "/anyfive/ipims/office/common/popup/search/RefNoSearchListR.jsp";
                codeColumn = "REF_ID";
                nameExpr = "{#REF_NO}";
            </COMMENT></ANY:SEARCH>
        </TD>
        <TD req="REQ_SUBJECT">요청제목</TD>
        <TD>
            <INPUT type="text" id="REQ_SUBJECT" maxByte="1000" />
        </TD>
    </TR>
    <TR>
        <TD req="REQ_CONTENTS">요청내용</TD>
        <TD colspan="3"><TEXTAREA id="REQ_CONTENTS" rows="15" maxByte="4000"></TEXTAREA></TD>
    </TR>
    <TR>
        <TD>첨부화일</TD>
        <TD colspan="3">
            <ANY:FILE id="any_reqFile" mode="C" policy="office_req" />
        </TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="list"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
