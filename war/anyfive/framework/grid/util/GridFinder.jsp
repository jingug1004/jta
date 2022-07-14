<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
<HEAD>
<TITLE>Grid Finder</TITLE>
<META http-equiv="Content-Type" content="text/html; charset=utf-8">
<META http-equiv="Cache-Control" content="no-cache; no-store; no-save">
<META http-equiv="Expires" content="0">
<META http-equiv="Pragma" content="no-cache">
<STYLE type="text/css">
BODY, TD, BUTTON, SELECT, INPUT {
    font-family: "Tahoma";
    font-size: 12px;
}

BUTTON {
    width: 90px;
}
</STYLE>
<SCRIPT language="JScript">
var gr = top.window.dialogArguments.arg.gr;

//윈도우 로딩시
window.onload = function()
{
    gr.fg.attachEvent("AfterRowColChange", function(iOldRow, iOldCol, iNewRow, iNewCol)
    {
        try {
            sel_findColumn.value = gr.fg.ColKey(gr.fg.Col);
            if (sel_findColumn.options.selectedIndex == -1) {
                sel_findColumn.options.selectedIndex = 0;
            }
        } catch(ex) {
        }
    });

    move();
}

//문서 키입력시
document.onkeypress = function()
{
    if (event.keyCode == 27) {
        top.window.close();
    }
}

//페이지 이동 - 중복팝업 방지
function move()
{
    fnSetFindColumn();
    top.window.focus();
    txt_findString.focus();
}

//찾을 컬럼명 설정
function fnSetFindColumn()
{
    sel_findColumn.options.length = 0;

    for (var c = 0; c < gr.fg.Cols; c++) {
        if (gr.fg.ColHidden(c) == true) continue;
        if (gr.fg.ColKey(c) == "ROW_NUM") continue;
        if (gr.fg.ColData(c) == null) continue;
        if (gr.fg.ColData(c).info == null) continue;
        if (gr.fg.ColData(c).info.type == "boolean") continue;
        if (gr.fg.ColData(c).info.type == "image") continue;
        sel_findColumn.options.add(new Option(gr.fg.ColData(c).info.name, gr.fg.ColKey(c)));
    }

    if (gr.fg.Col != -1) {
        sel_findColumn.value = gr.fg.ColKey(gr.fg.Col);
    }

    if (sel_findColumn.options.selectedIndex == -1) {
        sel_findColumn.options.selectedIndex = 0;
    }

    if (gr.fg.Row == -1 && gr.fg.Rows > gr.fg.FixedRows) {
        gr.fg.Row = gr.fg.FixedRows;
    }

    gr.fg.Col = gr.fg.ColIndex(sel_findColumn.value);
}

//찾기
function fnFind(dir)
{
    var findColumn = gr.fg.ColIndex(sel_findColumn.value);
    var findString = txt_findString.value;

    if (sel_findColumn.value == "" || findColumn == -1) {
        alert("찾을 컬럼명을 선택하세요.");
        sel_findColumn.focus();
        return;
    }

    if (findString == "") {
        alert("찾을 문자열을 입력하세요.");
        txt_findString.focus();
        return;
    }

    if (dir == -1) {
        for (var r = gr.fg.Row - 1; r >= gr.fg.FixedRows; r--) {
            if (checkText(r) == true) return;
        }
        for (var r = gr.fg.Rows - 1; r >= gr.fg.Row; r--) {
            if (checkText(r) == true) return;
        }
    } else {
        for (var r = gr.fg.Row + 1; r < gr.fg.Rows; r++) {
            if (checkText(r) == true) return;
        }
        for (var r = gr.fg.FixedRows; r <= gr.fg.Row; r++) {
            if (checkText(r) == true) return;
        }
    }

    alert("찾는 문자열이 없습니다.");
    txt_findString.focus();
    txt_findString.select();

    function checkText(row)
    {
        if (gr.fg.RowHidden(row) == true) return false;

        var cellText = gr.text(row, gr.fg.ColKey(findColumn));
        var findText = findString;

        if (chk_caseSensitive.checked != true) {
            cellText = cellText.toUpperCase();
            findText = findText.toUpperCase();
        }

        if (chk_fullMatch.checked == true) {
            if (cellText != findText) return false;
        } else {
            if (cellText.indexOf(findText) == -1) return false;
        }

        gr.fg.Select(row, findColumn);
        gr.fg.ShowCell(row, findColumn);
        txt_findString.focus();

        return true;
    }
}
</SCRIPT>

<!-- 찾을 컬럼명 변경시 -->
<SCRIPT language="JScript" for="sel_findColumn" event="onchange()">
    try {
        gr.fg.Col = gr.fg.ColIndex(this.value);
    } catch(ex) {
    }
    txt_findString.focus();
</SCRIPT>
</HEAD>

<BODY bgColor="#ECE9D8" style="margin:15px;">

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
    <TR>
        <TD noWrap><LABEL for="sel_findColumn" accessKey="S">찾을 컬럼명(<U>S</U>) :&nbsp;</LABEL></TD>
        <TD width="100%">
            <SELECT id="sel_findColumn" style="width:100%;">
            </SELECT>
        </TD>
    </TR>
    <TR>
        <TD noWrap><LABEL for="txt_findString" accessKey="F">찾을 문자열(<U>F</U>) :&nbsp;</LABEL></TD>
        <TD width="100%">
            <INPUT type="text" id="txt_findString" style="width:100%;">
        </TD>
    </TR>
    <TR>
        <TD></TD>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%" style="margin-top:3px;">
                <TR>
                    <TD noWrap>
                        <LABEL for="chk_fullMatch" accessKey="W" style="cursor:hand;">
                        <INPUT type="checkbox" id="chk_fullMatch" onFocus="this.blur();">셀 단위로(<U>W</U>)
                        </LABEL>
                    </TD>
                    <TD noWrap>
                        <LABEL for="chk_caseSensitive" accessKey="C" style="cursor:hand;">
                        <INPUT type="checkbox" id="chk_caseSensitive" onFocus="this.blur();">대/소문자 구분(<U>C</U>)
                        </LABEL>
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
</TABLE>
<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" style="margin-top:7px;">
    <TR>
        <TD align="right">
            <BUTTON accessKey="P" onClick="javascript:fnFind(-1);">이전(<U>P</U>)</BUTTON>
            <BUTTON accessKey="N" onClick="javascript:fnFind(1);" type="submit">다음(<U>N</U>)</BUTTON>
        </TD>
    </TR>
</TABLE>

</BODY>
</HTML>
