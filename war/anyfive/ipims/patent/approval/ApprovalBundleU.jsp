<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>일괄결재 처리</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<ANY:DS id="ds_apprAnsSave" />
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    parent.reloadList();

    fnInitList();
    fnSave();
}

//목록 초기화
function fnInitList()
{
    var gr = gr_bundleList;

    gr.fg.Rows = parent.bundleList.length + gr.fg.FixedRows;

    for (var i = 0; i < parent.bundleList.length; i++) {
        gr.value(i + gr.fg.FixedRows, "ROW_NUM") = null;
        gr.value(i + gr.fg.FixedRows, "APPR_NUM") = parent.bundleList[i].APPR_NO + "-" + parent.bundleList[i].REQ_SEQ;
        gr.value(i + gr.fg.FixedRows, "MESSAGE") = "(Wait)";
    }

    gr.addAction("MESSAGE", fnShowMessage);
}

//저장
function fnSave()
{
    var gr = gr_bundleList;

    if (gr.fg.Row >= gr.fg.Rows - 1) return;

    if (gr.fg.Row < gr.fg.FixedRows) {
        gr.fg.Row = gr.fg.FixedRows;
    } else {
        gr.fg.Row++;
    }

    var row = gr.fg.Row;
    var idx = row - gr.fg.FixedRows;

    gr.fg.Select(row, 0, row, gr.fg.Cols - 1);
    gr.fg.ShowCell(row, gr.fg.Col);

    ds_apprAnsSave.init();
    ds_apprAnsSave.addRow();
    ds_apprAnsSave.value(0, "ANS_STATUS") = parent.ansStatus;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.common.approval.act.ExecuteApproval.do";
    prx.addParam("APPR_CODE", parent.bundleList[idx].APPR_CODE);
    prx.addParam("APPR_NO", parent.bundleList[idx].APPR_NO);
    prx.addParam("REQ_SEQ", parent.bundleList[idx].REQ_SEQ);
    prx.addParam("ANS_ORD", parent.bundleList[idx].ANS_ORD);
    prx.addParam("APPR_EVENT", parent.apprEvent);
    prx.addData("ds_apprAnsSave");
    prx.hideMessage = true;

    prx.onStart = function()
    {
        gr.value(row, "MESSAGE") = "Working...";
    }

    prx.onSuccess = function()
    {
        gr.value(row, "RESULT") = "SUCCESS";
        gr.value(row, "MESSAGE") = "OK";

        fnSave();
    }

    prx.onFail = function()
    {
        gr.value(row, "RESULT") = "FAILURE";
        gr.value(row, "MESSAGE") = this.error.description;

        if (!confirm("다음과 같은 에러가 발생했습니다.\n\n" + this.error.description + "\n\n계속 진행하시겠습니까?")) return;

        fnSave();
    }

    prx.execute();
}

//결과메세지 표시
function fnShowMessage(gr, fg, row, colId)
{
    if (gr.value(row, "RESULT") != "FAILURE") return;

    alert(gr.value(row, "MESSAGE"));
}
</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
    <TR>
        <TD height="100%">
            <ANY:GRID id="gr_bundleList" pagingType="0"><COMMENT>
                fg.SelectionMode = flexSelectionListBox;
                addColumn({ width:50 , align:"center", type:"number" , sort:false, id:"ROW_NUM"         , name:"No" });
                addColumn({ width:120, align:"center", type:"string" , sort:false, id:"APPR_NUM"        , name:"결재번호" });
                addColumn({ width:200, align:"left"  , type:"string" , sort:false, id:"MESSAGE"         , name:"처리결과" });
                setFixedColumn("ROW_NUM", "APPR_NUM");
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
    <TR>
        <TD height="5"></TD>
    </TR>
    <TR>
        <TD height="1" align="right">
            <BUTTON auto="close"></BUTTON>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
