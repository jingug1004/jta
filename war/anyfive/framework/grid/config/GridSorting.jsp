<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.framework.app.FrameworkApp"%><% FrameworkApp app = new FrameworkApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>Grid Sorting</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<ANY:DS id="ds_sortingList" />
<SCRIPT language="JScript">
var fg1;
var fg2;

//윈도우 로딩시
window.onready = function()
{
    btn_delete.disabled = (!(parent.gr.configInfoDs.rowCount > 0 && parent.gr.configInfoDs.value(0, "SORTING_YN") == "1"))

    fg1 = parent.gr.fg;
    fg2 = gr_columnList.fg;

    fncSetColComboList();
    fnSetSortingList();
}

//문서 키입력시
document.onkeypress = function()
{
    if (event.keyCode == 27) {
        top.window.close();
    }
}

//콤보리스트 설정
function fncSetColComboList()
{
    var comboArray;

    comboArray = new Array();
    for (var i = 0; i < fg1.Cols; i++) {
        if (fg1.ColData(i).info.nouse == true) continue;
        if (fg1.ColData(i).info.sort != true) continue;
        comboArray.push("#" + fg1.ColData(i).info.id + ";" + fg1.ColData(i).info.name);
    }
    for (var i = 0; i < parent.gridSorting.length; i++) {
        if (fg1.ColIndex(parent.gridSorting[i].name) != -1) continue;
        comboArray.push("#" + parent.gridSorting[i].name + ";" + parent.gridSorting[i].name);
    }
    fg2.ColComboList(fg2.ColIndex("COL_ID")) = comboArray.join("|");

    comboArray = new Array();
    comboArray.push("#ASC;Ascending");
    comboArray.push("#DESC;Descending");
    fg2.ColComboList(fg2.ColIndex("SORT_TYPE")) = comboArray.join("|");
}

//정렬목록 셋팅
function fnSetSortingList(arr)
{
    if (arr == null) arr = parent.gridSorting;

    try {

        fg2.ReDraw = 0;
        fg2.Rows = fg2.FixedRows + arr.length;

        for (var i = 0; i < arr.length; i++) {
            fg2.TextMatrix(fg2.FixedRows + i, fg2.ColIndex("COL_ID")) = arr[i].name;
            fg2.TextMatrix(fg2.FixedRows + i, fg2.ColIndex("SORT_INDEX")) = i + 1;
            fg2.TextMatrix(fg2.FixedRows + i, fg2.ColIndex("SORT_TYPE")) = arr[i].type;
        }

    } catch(ex) {
        fg2.ReDraw = 2;
        throw ex;
    } finally {
        fg2.ReDraw = 2;
    }
}

//기본값으로
function fnSetDefault()
{
    fnSetSortingList(parent.gridSortingDefault);
}

//추가
function fnAddSorting()
{
    fg2.Rows++;
    fg2.TextMatrix(fg2.Rows - 1, fg2.ColIndex("SORT_INDEX")) = fg2.Rows - fg2.FixedRows;
    fg2.TextMatrix(fg2.Rows - 1, fg2.ColIndex("SORT_TYPE")) = "ASC";
    fg2.Select(fg2.Rows - 1, fg2.ColIndex("COL_ID"));
    fg2.EditCell();
    fg2.focus();
}

//삭제
function fnDelSorting()
{
    for (var r = fg2.SelectedRows - 1; r >= 0; r--) {
        fg2.RemoveItem(fg2.SelectedRow(r));
    }

    for (var r = fg2.FixedRows; r < fg2.Rows; r++) {
        fg2.TextMatrix(r, fg2.ColIndex("SORT_INDEX")) = r - fg2.FixedRows + 1;
    }
}

//위로/아래로
function fnMoveRow(dir)
{
    gr_columnList.moveRowData(dir);

    for (var r = fg2.FixedRows; r < fg2.Rows; r++) {
        fg2.TextMatrix(r, fg2.ColIndex("SORT_INDEX")) = r - fg2.FixedRows + 1;
    }
}

//확인
function fnSave()
{
    var dupRow;

    for (var r = fg2.FixedRows; r < fg2.Rows; r++) {
        if (fg2.TextMatrix(r, fg2.ColIndex("COL_ID")) != "") continue;
        alert('정렬하려는 열을 선택하세요.');
        fg2.Select(r, fg2.ColIndex("COL_ID"), r, fg2.ColIndex("COL_ID"));
        fg2.EditCell();
        fg2.focus();
        return;
    }

    for (var r = fg2.FixedRows; r < fg2.Rows; r++) {
        dupRow = fg2.FindRow(fg2.TextMatrix(r, fg2.ColIndex("COL_ID")), r + 1, fg2.ColIndex("COL_ID"), false, true);
        if (dupRow == -1) continue;
        fg2.Select(dupRow, 0, dupRow, fg2.Cols - 1);
        alert('열 "' + fg2.Cell(flexcpTextDisplay, r, fg2.ColIndex("COL_ID")) + '" 은(는) 두 번 이상 정렬되어 있습니다.\n\n중복된 정렬조건을 제거하고 다시 시도하십시오.');
        fg2.focus();
        return;
    }

    gr_columnList.setBind(ds_sortingList);

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.framework.grid.act.UpdateGridSortingList.do";
    prx.addParam("GRID_ID", parent.gridId);
    prx.addParam("GRID_PATH", parent.gridPath);
    prx.addData("ds_sortingList");

    prx.onSuccess = function()
    {
        top.window.returnValue = "OK";
        top.window.close();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//삭제
function fnDelete()
{
    if (!confirm("<%= app.message.get("msg.com.confirm.delete").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.framework.grid.act.DeleteGridSortingList.do";
    prx.addParam("GRID_ID", parent.gridId);

    prx.onSuccess = function()
    {
        top.window.returnValue = "OK";
        top.window.close();
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

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
    <TR>
        <TD align="right">
            <BUTTON text="추가" onClick="javascript:fnAddSorting();"></BUTTON>
            <BUTTON text="삭제" onClick="javascript:fnDelSorting();"></BUTTON>
            <BUTTON auto="line"></BUTTON>
            <BUTTON text="위로" onClick="javascript:fnMoveRow(-1);"></BUTTON>
            <BUTTON text="아래로" onClick="javascript:fnMoveRow(1);"></BUTTON>
        </TD>
    </TR>
    <TR>
        <TD height="5"></TD>
    </TR>
    <TR>
        <TD height="100%">
            <ANY:GRID id="gr_columnList"><COMMENT>
                fg.Editable = flexEDKbdMouse;
                fg.SelectionMode = flexSelectionListBox;
                addColumn({ width:40 , align:"center", type:"number" , sort:false, id:"SORT_INDEX" , name:"순서" });
                addColumn({ width:120, align:"left"  , type:"string" , sort:false, id:"COL_ID"     , name:"열"   , edit:true });
                addColumn({ width:90 , align:"left"  , type:"string" , sort:false, id:"SORT_TYPE"  , name:"정렬" , edit:true });
                setFixedColumn("SORT_INDEX", null);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
    <TR>
        <TD height="5"></TD>
    </TR>
    <TR>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD>
                        <BUTTON text="기본값으로" onClick="javascript:fnSetDefault();" space="none"></BUTTON>
                        <BUTTON text="현재대로" onClick="javascript:fnSetSortingList();"></BUTTON>
                    </TD>
                    <TD align="right">
                        <BUTTON text="저장" onClick="javascript:fnSave();"></BUTTON>
                        <BUTTON text="삭제" onClick="javascript:fnDelete();" disabled id="btn_delete"></BUTTON>
                        <BUTTON text="취소" onClick="javascript:top.window.close();"></BUTTON>
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
