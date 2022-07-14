<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<% if (new anyfive.ipims.patent.approval.act.CreateSessionByApprovalMailKey().execute(request, response) != true) return; %>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out, true, false); %>
<%@page import="any.util.etc.NCommonUtil"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE></TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_apprInfo" />
<ANY:DS id="ds_apprKeys" />
<SCRIPT language="JScript">
var gApprNo = <%= (request.getParameter("APPR_NO") == null ? "parent.APPR_NO" : "\"" + request.getParameter("APPR_NO") + "\"") %>;
var gMailKey = "<%= request.getParameter("MAIL_KEY") %>";

//윈도우 로딩시
window.onready = function()
{
    cfShowObjects([tr_buttonArea], parent.gr != null && parent.fg != null);

    fnLoad();
}

//업무페이지 로드
function fnLoad()
{
    if (parent.fg != null) {
        btn_movePrev.disabled = (parent.fg.Row <= parent.fg.FixedRows);
        btn_moveNext.disabled = (parent.fg.Row >= parent.fg.Rows - 1);
    }

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.approval.act.RetrieveApprovalView.do";
    prx.addParam("APPR_NO", gApprNo);
    prx.addParam("MAIL_KEY", gMailKey);

    prx.onSuccess = function()
    {
        if (ds_apprKeys.rowCount == 0) {
            alert("해당 건을 찾을 수 없습니다.");
            parent.reloadList();
            parent.goList();
            return;
        }

        for (var c = 0; c < ds_apprKeys.colCount; c++) {
            window[ds_apprKeys.colId(c)] = ds_apprKeys.value(0, ds_apprKeys.colId(c));
        }

        td_main.innerHTML = '<IFRAME src="' + top.getRoot() + ds_apprInfo.value(0, "APPR_VIEW_PATH") + '" frameBorder="no" scrolling="no" width="100%" height="100%"></IFRAME>';
    }

    prx.onFail = function()
    {
        this.error.show();

        parent.reloadList();
        parent.goList();
    }

    prx.execute();
}

//이전/다음
function fnMoveList(dir)
{
    parent.gr.moveRowPos(dir, "APPR_TITLE");

    gApprNo = parent.gr.value(parent.fg.Row, "APPR_NO");

    fnLoad();
}
</SCRIPT>
</HEAD>

<BODY scroll="no">

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
    <TR>
        <TD align="center" id="td_main"></TD>
    </TR>
    <TR id="tr_buttonArea" style="display:none;">
        <TD height="1">
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD height="1" style="background-color:#959385;"></TD>
                </TR>
                <TR>
                    <TD height="1" style="background-color:#BFBDB0;"></TD>
                </TR>
                <TR>
                    <TD height="1" style="background-color:#D7D4C5;"></TD>
                </TR>
                <TR>
                    <TD height="1" align="right" style="background-color:#ECE9D8; padding:2px;">
                        <BUTTON text="<%= app.message.get("btn.com.refresh").toHTML() %>(R)" accessKey="R" onClick="javascript:fnMoveList(0);"></BUTTON>
                        <BUTTON auto="line"></BUTTON>
                        <BUTTON text="<%= app.message.get("btn.com.move.prev").toHTML() %>(P)" accessKey="P" onClick="javascript:fnMoveList(-1);" id="btn_movePrev" disabled></BUTTON>
                        <BUTTON text="<%= app.message.get("btn.com.move.next").toHTML() %>(N)" accessKey="N" onClick="javascript:fnMoveList(1);" id="btn_moveNext" disabled></BUTTON>
                        <BUTTON auto="line"></BUTTON>
                        <BUTTON auto="close"></BUTTON>
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
</TABLE>

</BODY>
</HTML>
