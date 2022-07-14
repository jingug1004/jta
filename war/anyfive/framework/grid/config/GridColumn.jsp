<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.framework.app.FrameworkApp"%><% FrameworkApp app = new FrameworkApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>Grid Column</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<ANY:DS id="ds_columnList" />
<SCRIPT language="JScript">
var fg1;
var fg2;

//윈도우 로딩시
window.onready = function()
{
    btn_delete.disabled = (!(parent.gr.configInfoDs.rowCount > 0 && parent.gr.configInfoDs.value(0, "COLUMN_YN") == "1"))

    fg1 = parent.gr.fg;
    fg2 = gr_columnList.fg;

    fnSetColumnList();
}

//문서 키입력시
document.onkeypress = function()
{
    if (event.keyCode == 27) {
        top.window.close();
    }
}

//컬럼목록 셋팅
function fnSetColumnList()
{
    try {

        fg2.ReDraw = 0;
        fg2.Rows = fg2.FixedRows;

        for (var i = 0; i < fg1.Cols; i++) {
            if (fg1.ColData(i).info.nouse == true) continue;
            fg2.Rows++;
            fg2.TextMatrix(fg2.Rows - 1, fg2.ColIndex("COL_ID")) = fg1.ColData(i).info.id;
            fg2.TextMatrix(fg2.Rows - 1, fg2.ColIndex("COL_INDEX")) = i + 1;
            fg2.TextMatrix(fg2.Rows - 1, fg2.ColIndex("COL_SHOW")) = (fg1.ColHidden(i) == true ? 0 : 1);
            fg2.TextMatrix(fg2.Rows - 1, fg2.ColIndex("COL_FROZEN")) = (fg1.FrozenCols - 1 + fg1.FixedCols == i ? 1 : 0);
            fg2.TextMatrix(fg2.Rows - 1, fg2.ColIndex("COL_NAME")) = fg1.ColData(i).info.name;
            fg2.TextMatrix(fg2.Rows - 1, fg2.ColIndex("COL_WIDTH")) = fg1.ColWidth(i) / 15;
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
    try {

        fg2.ReDraw = 0;
        fg2.Rows = fg2.FixedRows;

        for (var i = 0; i < fg1.Cols; i++) {
            if (fg1.ColData(i).info.nouse == true) continue;
            fg2.Rows++;
            fg2.TextMatrix(fg2.Rows - 1, fg2.ColIndex("COL_ID")) = fg1.ColData(i).info.id;
            fg2.TextMatrix(fg2.Rows - 1, fg2.ColIndex("COL_INDEX")) = fg1.ColData(i).info.index + 1;
            fg2.TextMatrix(fg2.Rows - 1, fg2.ColIndex("COL_SHOW")) = (fg1.ColData(i).info.hide == true ? 0 : 1);
            fg2.TextMatrix(fg2.Rows - 1, fg2.ColIndex("COL_FROZEN")) = (fg1.ColData(i).info.id == parent.fixedColumns.frozenColId ? 1 : 0);
            fg2.TextMatrix(fg2.Rows - 1, fg2.ColIndex("COL_NAME")) = fg1.ColData(i).info.name;
            fg2.TextMatrix(fg2.Rows - 1, fg2.ColIndex("COL_WIDTH")) = fg1.ColData(i).info.width;
        }

        fg2.Col = fg2.ColIndex("COL_INDEX");
        fg2.Sort = flexSortGenericAscending;

    } catch(ex) {
        fg2.ReDraw = 2;
        throw ex;
    } finally {
        fg2.ReDraw = 2;
    }
}

//위로/아래로
function fnMoveRow(dir)
{
    gr_columnList.moveRowData(dir);

    for (var r = fg2.FixedRows; r < fg2.Rows; r++) {
        fg2.TextMatrix(r, fg2.ColIndex("COL_INDEX")) = r - fg2.FixedRows + 1;
    }
}

//저장
function fnSave()
{
    gr_columnList.setBind(ds_columnList);

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.framework.grid.act.UpdateGridColumnList.do";
    prx.addParam("GRID_ID", parent.gridId);
    prx.addParam("GRID_PATH", parent.gridPath);
    prx.addData("ds_columnList");

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
    prx.path = top.getRoot() + "/anyfive.framework.grid.act.DeleteGridColumnList.do";
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
                addColumn({ width:0  , align:"left"  , type:"string", sort:false, id:"COL_ID"     , name:"" , hide:true });
                addColumn({ width:40 , align:"center", type:"number", sort:false, id:"COL_INDEX"  , name:"No" });
                addColumn({ width:40 , align:"center", type:"check" , sort:false, id:"COL_SHOW"   , name:"표시" });
                addColumn({ width:40 , align:"center", type:"check" , sort:false, id:"COL_FROZEN" , name:"고정" });
                addColumn({ width:120, align:"left"  , type:"string", sort:false, id:"COL_NAME"   , name:"이름" });
                addColumn({ width:50 , align:"right" , type:"number", sort:false, id:"COL_WIDTH"  , name:"넓이" , edit:true, editMask:"9999" });
                setFixedColumn("COL_INDEX", null);
                beforeCheck = function(row, colId)
                {
                    if (colId == "COL_SHOW") {
                        fg.TextMatrix(row, fg.ColIndex("COL_SHOW")) = 1;
                        if (fg.TextMatrix(row, fg.ColIndex("COL_ID")) == "ROW_CHK") {
                            alert('"' + fg.TextMatrix(row, fg.ColIndex("COL_NAME")) + '" 필드는 기본 체크박스로 설정되어 숨길 수 없습니다.');
                            return false;
                        }
                        if (parent.gr.getAction(fg.TextMatrix(row, fg.ColIndex("COL_ID"))) != null) {
                            alert('"' + fg.TextMatrix(row, fg.ColIndex("COL_NAME")) + '" 필드는 링크가 설정되어 숨길 수 없습니다.');
                            return false;
                        }
                        return true;
                    }

                    if (colId == "COL_FROZEN") {
                        fg.Cell(0, fg.FixedRows, fg.ColIndex(colId), fg.Rows - 1, fg.ColIndex(colId)) = 0;
                        return true;
                    }
                }
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
                        <BUTTON text="현재대로" onClick="javascript:fnSetColumnList();"></BUTTON>
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
