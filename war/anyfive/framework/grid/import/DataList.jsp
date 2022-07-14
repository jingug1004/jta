<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.framework.app.FrameworkApp"%><% FrameworkApp app = new FrameworkApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>Data Import List</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<ANY:DS id="ds" />
<SCRIPT language="JScript">
var gJobStatus = {
        R : { name:"Ready"    , color:"#CCCCCC", color2:"&HCCCCCC" },
        S : { name:"Success"  , color:"#0000FF", color2:"&HFF0000" },
        C : { name:"Created"  , color:"#0000FF", color2:"&HFF0000" },
        U : { name:"Updated"  , color:"#0000FF", color2:"&HFF0000" },
        D : { name:"Deleted"  , color:"#0000FF", color2:"&HFF0000" },
        F : { name:"Failure"  , color:"#FF0000", color2:"&H0000FF" },
        W : { name:"Working"  , color:"#000000", color2:"&H000000" }
    };

var gParams = { load:null, save:null };
var fg;

//윈도우 로딩시
window.onready = function()
{
    fg = gr_excelList.fg;

    fg.Editable = 2;
    fg.AutoSizeMode = 0;

    fnCreateFilterDropDown();
    fnSetGridMessage();

    if (parent.isExcel == true) {
        var html = new Array();
        html.push('<BUTTON auto="line"></BUTTON>');
        html.push('<BUTTON text="Template Download" onClick="javascript:fnDownloadTemplate();"></BUTTON>');
        html.push('<BUTTON auto="line"></BUTTON>');
        html.push('<BUTTON text="Upload" onClick="javascript:fnUpload();"></BUTTON>');
        html.push('<BUTTON text="Reset" onClick="javascript:fnReset();"></BUTTON>');
        spn_excelButtons.innerHTML = html.join("\n");
        fnUpload();
    } else {
        spn_excelButtons.innerHTML = '';
        fnLoad();
    }
}

//상태값 필터 드롭다운 생성
function fnCreateFilterDropDown()
{
    var opt;

    sel_status.options.add(new Option("(ALL)"));

    for (var item in gJobStatus) {
        if (gJobStatus[item].noSelect == true) continue;
        opt = new Option(gJobStatus[item].name, item);
        opt.style.color = gJobStatus[item].color;
        sel_status.options.add(opt);
    }
}

//그리드 메세지 표시
function fnSetGridMessage(val)
{
    if (typeof(val) == "string") {
        spn_gridMessage.innerText = val;
    } else {
        spn_gridMessage.innerText = (typeof(val) == "number" ? val : fg.Rows - fg.FixedRows) + " Rows / " + (fg.Cols - fg.FixedCols) + " Cols";
    }
}

//Template Download
function fnDownloadTemplate()
{
    cfTemplateDownload(parent.templateFile);
}

//Load
function fnLoad()
{
    if (parent.loadParams == null) {
        gParams.load = new Array();
    } else {
        gParams.load = parent.loadParams();
        if (gParams.load == null) return;
    }

    var ldr = gr_excelList.loader;

    ldr.init();
    ldr.path = parent.loadAction;
    for (var item in gParams.load) {
        ldr.addParam(item, gParams.load[item]);
    }

    ldr.onSuccess = function(gr, fg)
    {
        try {
            fg.ReDraw = 0;
            fnSetGridMessage();
            fnSetCommonColumns(true);
        } catch(ex) {
            fg.ReDraw = 2;
            throw(ex);
        } finally {
            fg.ReDraw = 2;
        }
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

//Upload
function fnUpload()
{
    var win = new any.window();
    win.path = "ExcelUpload.jsp";
    win.arg.templateFile = parent.templateFile;
    win.opt.width = 600;
    win.opt.height = 140;
    win.show();

    if (win.rtn == null) return;
    if (win.rtn.rows == 0) return;

    sel_status.selectedIndex = 0;

    try {

        fg.ReDraw = 0;

        fg.Rows = fg.Cols = 0;

        fg.Rows = win.rtn.rows;
        fg.Cols = win.rtn.cols;

        if (win.rtn.firstRowTitle == true) {
            fg.FixedRows = 1;
            fg.ExplorerBar = 5;
            fg.RowHeight(0) = 350;
        } else {
            fg.FixedRows = 0;
            fg.ExplorerBar = 0;
        }

        for (var r = 0; r < win.rtn.rows; r++) {
            for (var c = 0; c < win.rtn.cols; c++) {
                fg.TextMatrix(r, c + fg.FixedCols) = win.rtn.data[r + 1][c + 1];
            }
        }

        for (var c = fg.FixedCols; c < fg.Cols; c++) {
            fg.AutoSize(c);
            fg.ColWidth(c) = Math.min(5000, fg.ColWidth(c));
        }

        fnSetGridMessage();
        fnSetCommonColumns(win.rtn.firstRowTitle);

    } catch(ex) {
        fg.ReDraw = 2;
        throw(ex);
    } finally {
        fg.ReDraw = 2;
    }
}

//공통컬럼 설정
function fnSetCommonColumns(firstRowTitle)
{
    fg.Cols += 3;

    for (var c = fg.Cols - 3; c < fg.Cols; c++) {
        fg.ColPosition(c) = 0;
    }

    for (var r = fg.FixedRows; r < fg.Rows; r++) {
        fg.TextMatrix(r, 0) = r - fg.FixedRows + 1;
        fg.RowData(r) = { result:"R" };
    }

    fg.Cell(flexcpForeColor, 0, 0, fg.Rows - 1, fg.Cols - 1) = "&H000000";
    fg.ColAlignment(0) = flexAlignCenterCenter;
    fg.ColAlignment(1) = flexAlignCenterCenter;
    fg.ColHidden(2) = true;
    fg.ColWidth(0) = 800;
    fg.FixedCols = 3;

    if (fg.Rows > fg.FixedRows) {
        fg.Cell(flexcpAlignment, fg.FixedRows, fg.FixedCols, fg.Rows - 1, fg.Cols - 1) = flexAlignLeftCenter;
        fg.Cell(flexcpForeColor, fg.FixedRows, 1, fg.Rows - 1, 1) = gJobStatus.R.color2;
        fg.Cell(flexcpText, fg.FixedRows, 1, fg.Rows - 1, 1) = gJobStatus.R.name;
    }

    if (firstRowTitle != true) return;

    fg.Cell(flexcpAlignment, 0, 0, fg.FixedRows - 1, fg.Cols - 1) = flexAlignCenterCenter;
    fg.TextMatrix(0, 0) = "No";
    fg.TextMatrix(0, 1) = "Status";
}

//Reset
function fnReset()
{
    if (fg.Rows > 0) {
        if (!confirm("현재 업로드되어 있는 데이터를 초기화하시겠습니까?")) return;
    }

    fg.Rows = 0;
    fg.Cols = 0;

    fnSetGridMessage();
}

//저장
function fnSave()
{
    if (parent.saveParams == null) {
        gParams.save = new Array();
    } else {
        gParams.save = parent.saveParams();
        if (gParams.save == null) return;
    }

    if (fg.Rows - fg.FixedRows == 0) {
        alert("저장할 데이터가 없습니다.");
        return;
    }

    if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;

    top.window.returnValue = "OK";

    try {
        fg.ReDraw = 0;
        for (var r = fg.FixedRows; r < fg.Rows; r++) {
            if (fg.RowHidden(r) == true) continue;
            fg.Cell(7, r, 1) = gJobStatus.R.color2;
            fg.Cell(0, r, 1) = gJobStatus.R.name;
            fg.Cell(0, r, 2) = "";
            fg.RowData(r) = { result:"R" };
        }
    } catch(ex) {
        fg.ReDraw = 2;
        throw(ex);
    } finally {
        fg.ReDraw = 2;
    }

    var win = new any.window();
    win.path = "DataSave.jsp";
    win.arg.gr = gr_excelList;
    win.arg.saveFunc = fnDoSave;
    win.opt.width = 500;
    win.opt.height = 160;
    win.show();
}

//저장 실행
function fnDoSave(resultFunc, moveRow)
{
    if (moveRow == true) fg.Row++;

    if (fg.RowHidden(fg.Row) == true) {
        fnDoSave(resultFunc, true);
        return;
    }

    fg.Cell(7, fg.Row, 1) = gJobStatus.W.color2;
    fg.Cell(0, fg.Row, 1) = gJobStatus.W.name;
    fg.Select(fg.Row, 0, fg.Row, fg.Cols - 1);
    fg.ShowCell(fg.Row, fg.Col);

    ds.init();
    ds.addRow();

    for (var c = fg.FixedCols; c < fg.Cols; c++) {
        ds.addCol(fg.FixedRows == 0 ? "col" + (c - fg.FixedCols + 1) : fg.TextMatrix(fg.FixedRows - 1, c));
        ds.value(0, c - fg.FixedCols) = fg.TextMatrix(fg.Row, c);
    }

    var prx = new any.proxy();
    prx.path = parent.saveAction;
    for (var item in gParams.save) {
        prx.addParam(item, gParams.save[item]);
    }
    prx.addData(ds);
    prx.hideMessage = true;

    prx.onStart = function()
    {
    }

    prx.onSuccess = function()
    {
        fg.RowData(fg.Row).result = (this.result == null || this.result == "" ? "S" : this.result);
        fnResult(resultFunc, true);
    }

    prx.onFail = function()
    {
        fg.RowData(fg.Row).result = "F";
        fg.RowData(fg.Row).errMsg = (this.error.description == null ? "시스템 에러가 발생했습니다." : this.error.description);
        fnResult(resultFunc, false);
    }

    prx.execute();
}

//결과처리
function fnResult(resultFunc, isSuccess)
{
    fg.Cell(7, fg.Row, 1) = gJobStatus[fg.RowData(fg.Row).result].color2;
    fg.Cell(0, fg.Row, 1) = gJobStatus[fg.RowData(fg.Row).result].name;

    try {
        resultFunc(isSuccess);
    } catch(ex) {
    }
}
</SCRIPT>

<!-- 상태 드롭다운 변경시 -->
<SCRIPT language="JScript" for="sel_status" event="onchange()">
    var totCnt = 0;

    if (fg.Cols == 0) return;

    try {
        fg.ReDraw = 0;
        for (var r = fg.FixedRows; r < fg.Rows; r++) {
            fg.RowHidden(r) = (this.value != "" && fg.RowData(r).result != this.value);
            if (fg.RowHidden(r) != true) totCnt++;
        }
        fnSetGridMessage(totCnt);
    } catch(ex) {
        alert("Error in sel_status.onchange() : " + ex.description);
    } finally {
        fg.ReDraw = 2;
    }
</SCRIPT>
</HEAD>

<BODY scroll="no">

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
    <TR>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD><SPAN id="spn_gridMessage" style="white-space:nowrap; margin-right:5px;"></SPAN></TD>
                    <TD align="right">
                        <SELECT id="sel_status">
                        </SELECT><SPAN id="spn_excelButtons"></SPAN>
                        <BUTTON auto="line"></BUTTON>
                        <BUTTON text="Save" onClick="javascript:fnSave();"></BUTTON>
                        <BUTTON auto="close"></BUTTON>
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD height="5"></TD>
    </TR>
    <TR>
        <TD height="100%">
            <ANY:GRID id="gr_excelList" pagingType="0"><COMMENT>
                fg.attachEvent("DblClick", function()
                {
                    if (fg.MouseCol != 1) return;

                    if (fg.RowData(fg.Row) == null) fg.RowData(fg.Row) = {};

                    if (fg.RowData(fg.Row).errMsg != null) {
                        alert(fg.RowData(fg.Row).errMsg);
                    }
                });
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(true); %>

</BODY>
</HTML>
