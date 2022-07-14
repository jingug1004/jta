<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%@page import="anyfive.ipims.share.common.app.ShareApp" %>
<% ShareApp app = new ShareApp(request, response, out); %>
<%@page import="any.util.etc.NDateUtil" %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
    <TITLE>&nbsp;</TITLE>
    <% app.writeHTMLHeader(); %>
    <ANY:DS id="ds_replyInfo"/>
    <ANY:DS id="ds_mainInfo">
        <COMMENT>
            addBind("SUBJECT");
            addBind("NOTICE_START");
            addBind("NOTICE_END");
            addBind("CONTENTS");
            addBind("ATTACH_FILE", "any_attachFile");
        </COMMENT>
    </ANY:DS>
    <SCRIPT language="JScript">
        var brdConfig = parent.brdConfig;
        var isReply = (parent.BRD_NO != null && parent.BRD_NO != "" && parent.RE_PARENT != null && parent.RE_PARENT != "");

        //윈도우 로딩시
        window.onready = function () {
            cfSetPageTitle(brdConfig.MENU_NAME + " - " + (isReply == true ? "답변" : "작성"));

            tr_noticePeriod.style.display = (brdConfig.NOTICE_PERIOD == "1" ? "block" : "none");
            btn_cancel.display = (isReply == true ? "" : "none");

            if (brdConfig.FILE_POLICY != null && brdConfig.FILE_POLICY != "") {
                tr_attachFile.style.display = "block";
                any_attachFile.policy = brdConfig.FILE_POLICY;
            }

            if (isReply == true) fnRetrieve();

            SUBJECT.focus();
        }

        //답변인 경우 원본글 조회
        function fnRetrieve() {
            var prx = new any.proxy();
            prx.path = top.getRoot() + "/anyfive.ipims.share.board.act.RetrieveBoardForReply.do";
            prx.addParam("BRD_ID", brdConfig.BRD_ID);
            prx.addParam("BRD_NO", parent.BRD_NO);
            prx.checkData = ds_replyInfo;

            prx.onSuccess = function () {
                SUBJECT.value = "RE: " + ds_replyInfo.value(0, "SUBJECT");
                CONTENTS.value = "\n\n\n>" + ds_replyInfo.value(0, "CONTENTS").replaceAll("\n", "\n>");
                CONTENTS.focus();
            }

            prx.onFail = function () {
                this.error.show();
            }

            prx.execute();
        }

        //저장
        function fnSave(isFileUploaded) {
            if (!cfCheckAllReqValid()) return;

            if (isFileUploaded != true) {
                if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;
                cfFileUpload("fnSave(true);");
                return;
            }

            var prx = new any.proxy();
            prx.path = top.getRoot() + "/anyfive.ipims.share.board.act.CreateBoard.do";
            prx.addParam("BRD_ID", brdConfig.BRD_ID);
            if (isReply == true) {
                prx.addParam("RE_PARENT", parent.RE_PARENT);
                prx.addParam("ORG_BRD_NO", parent.BRD_NO);
            }
            prx.addData("ds_mainInfo");
            prx.addData("ds_attachFile");

            prx.onSuccess = function () {
                alert("<%= app.message.get("msg.com.info.save").toJS() %>");
                parent.BRD_NO = this.result;
                window.location.replace("BoardRD.jsp");
            }

            prx.onFail = function () {
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
        <TD>작성자</TD>
        <TD><%= app.userInfo.getEmpHname() %>
        </TD>
        <TD>작성일</TD>
        <TD><%= NDateUtil.getSysDate("/") %>
        </TD>
    </TR>
    <TR>
        <TD req="SUBJECT">제목</TD>
        <TD colspan="3">
            <INPUT type="text" id="SUBJECT" maxByte="100">
        </TD>
    </TR>
    <TR id="tr_noticePeriod" style="display:none;">
        <TD req="NOTICE_START:공지시작일, NOTICE_END:공지종료일">공지기간</TD>
        <TD colspan="3">
            <ANY:DATE id="NOTICE_START"/>&nbsp;~
            <ANY:DATE id="NOTICE_END"/>
        </TD>
    </TR>
    <TR>
        <TD>내용</TD>
        <TD colspan="3">
            <TEXTAREA id="CONTENTS" rows="20"></TEXTAREA>
        </TD>
    </TR>
    <TR id="tr_attachFile" style="display:none;">
        <TD>첨부파일</TD>
        <TD colspan="3">
            <ANY:FILE id="any_attachFile" mode="C"/>
        </TD>
    </TR>
</TABLE>
<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.cancel").toHTML() %>" onClick="javascript:history.back();"
            id="btn_cancel" display="none"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="list"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
