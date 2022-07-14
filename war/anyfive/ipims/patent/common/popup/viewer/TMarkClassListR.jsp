<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>상품류 목록</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnInitList();
}

//목록 초기화
function fnInitList()
{
    var gr = gr_tmarkClsList;
    var fg = gr.fg;

    fg.Rows = fg.FixedRows + 34;

    for (var i = fg.FixedRows; i < fg.Rows; i++) {
        gr.value(i, "TMARK_CLS_CODE") = (i - fg.FixedRows + 1);
        gr.checked(i, "ROW_CHK") = (parent.ds.valueRow(["TMARK_CLS_CODE", gr.value(i, "TMARK_CLS_CODE")]) != -1);
        gr.value(i, "TMARK_CLS_NAME") = (i - fg.FixedRows + 1) + "류";
    }
}

//확인
function fnConfirm()
{
    cfPopupSearchResult({ multiCheck:true }, gr_tmarkClsList);
}
</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
    <TR>
        <TD height="100%">
            <ANY:GRID id="gr_tmarkClsList" pagingType="0"><COMMENT>
                addColumn({ width:50 , align:"center", type:"number", sort:false, id:"TMARK_CLS_CODE"   , name:"No" });
                addColumn({ width:50 , align:"center", type:"check" , sort:false, id:"ROW_CHK" });
                addColumn({ width:100, align:"left"  , type:"string", sort:false, id:"TMARK_CLS_NAME"   , name:"상품류" });
                setFixedColumn("TMARK_CLS_CODE", "ROW_CHK");
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
    <TR>
        <TD height="5"></TD>
    </TR>
    <TR>
        <TD align="right">
            <BUTTON text="확인" onClick="javascript:fnConfirm();"></BUTTON>
            <BUTTON auto="line"></BUTTON>
            <BUTTON auto="close" id="btn_close"></BUTTON>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
