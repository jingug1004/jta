<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>시스템 업데이트</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<SCRIPT language="JScript">
var gStatusCol;
var gUpdateOpt;

//윈도우 로딩시
window.onready = function()
{
    gStatusCol = gr_updateFileList.fg.ColIndex("STATUS_NAME");

    fnRetrieve();
}

//조회
function fnRetrieve()
{
    var ldr = gr_updateFileList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.configure.update.act.RetrieveUpdateFileList.do";

    ldr.onSuccess = function(gr, fg)
    {
        fnInitStatusCol();
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

//상태값 초기화
function fnInitStatusCol()
{
    var fg = gr_updateFileList.fg;

    if (fg.Rows <= fg.FixedRows) return;

    fg.Cell(0, fg.FixedRows, gStatusCol, fg.Rows - 1) = "(Ready)";
    fg.Cell(7, fg.FixedRows, gStatusCol, fg.Rows - 1) = "&H999999";
}

//업데이트 시작
function fnStartUpdate()
{
    var fg = gr_updateFileList.fg;

    if (fg.Rows - fg.FixedRows == 0) {
        alert("업데이트할 파일이 없습니다.");
        return;
    }

    if (!confirm("시스템 업데이트를 시작하시겠습니까?")) return;

    gUpdateOpt = { DELETE_FILE:DELETE_FILE.value };
    DELETE_FILE.disabled = btn_confirm.disabled = true;

    fnInitStatusCol();
    fnDoUpdate(fg.FixedRows);
}

//업데이트 실행
function fnDoUpdate(row)
{
    var gr = gr_updateFileList;

    if (gr.fg.Rows <= row) {
        alert("시스템 업데이트가 완료되었습니다.");
        DELETE_FILE.disabled = btn_confirm.disabled = false;
        return;
    }

    gr.fg.Cell(0, row, gStatusCol) = "Updating...";
    gr.fg.Cell(7, row, gStatusCol) = "";
    gr.fg.RowData(row).error = null;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.configure.update.act.UpdateSystem.do";
    prx.addParam("FILE_NAME", gr.value(row, "FILE_NAME"));
    prx.addParam("DELETE_FILE", gUpdateOpt.DELETE_FILE);
    prx.hideMessage = true;

    prx.onSuccess = function()
    {
        gr.fg.Cell(0, row, gStatusCol) = "Success";
        gr.fg.Cell(7, row, gStatusCol) = "&HFF0000";
        gr.fg.RowData(row).error = null;

        fnDoUpdate(row + 1);
    }

    prx.onFail = function()
    {
        gr.fg.Cell(0, row, gStatusCol) = "Failure";
        gr.fg.Cell(7, row, gStatusCol) = "&H0000FF";
        gr.fg.RowData(row).error = this.error;

        fnDoUpdate(row + 1);
    }

    prx.execute();
}
</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
    <TR>
        <TD height="100%">
            <ANY:GRID id="gr_updateFileList" pagingType="0"><COMMENT>
                fg.attachEvent("DblClick", function()
                {
                    if (fg.MouseCol != gStatusCol) return;
                    if (fg.RowData(fg.Row) == null) return;
                    if (fg.RowData(fg.Row).error == null) return;

                    alert(fg.RowData(fg.Row).error.description);
                });

                addColumn({ width:50 , align:"center", type:"number", sort:false, id:"ROW_NUM"          , name:"<%= app.message.get("lbl.com.no").toJS() %>" });
                addColumn({ width:200, align:"left"  , type:"string", sort:false, id:"FILE_NAME"        , name:"파일이름" });
                addColumn({ width:80 , align:"center", type:"string", sort:false, id:"FILE_TYPE"        , name:"파일형태" });
                addColumn({ width:80 , align:"center", type:"string", sort:false, id:"STATUS_NAME"      , name:"상태" });
                setFixedColumn("ROW_NUM", "FILE_NAME");
                addSorting("FILE_NAME", "ASC");
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
    <TR>
        <TD>
            <DIV class="button_area">
                <ANY:CHECK id="DELETE_FILE" text="업데이트 성공 후 해당파일 삭제" checked />
                <BUTTON text="확인" onClick="javascript:fnStartUpdate();" id="btn_confirm"></BUTTON>
                <BUTTON auto="line"></BUTTON>
                <BUTTON auto="close"></BUTTON>
            </DIV>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
