<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>업무코드 검색</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    cfSetPageTitle("업무" + (parent.CODE_KIND == "S" ? "상태" : "액션") + "코드 검색");

    if (parent.searchText != null) {
        txt_searchText.value = parent.searchText;
    }

    fnSearch();
}

//검색
function fnSearch()
{
    var ldr = gr_workCodeList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.workprocess.workcode.act.RetrieveWorkCodeSearchList.do";
    ldr.addParam("CODE_KIND", parent.CODE_KIND);
    ldr.addParam("SEARCH_TEXT", txt_searchText.value);

    ldr.onSuccess = function(gr, fg)
    {
        txt_searchText.focus();
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

//추가
function fnCreate()
{
    var win = new any.window();
    win.path = "WorkCodeMgtC.jsp";
    win.arg.CODE_KIND = parent.CODE_KIND;
    win.opt.width = 600;
    win.opt.height = 300;

    win.onReload = function()
    {
        gr_workCodeList.loader.reload();
    }

    win.show();
}

//수정
function fnModify(gr, fg, row, colId)
{
    var win = new any.window();
    win.path = "WorkCodeMgtUD.jsp";
    win.arg.CODE_VALUE = gr.value(row, "CODE_VALUE");
    win.opt.width = 600;
    win.opt.height = 300;

    win.onReload = function()
    {
        gr.loader.reload();
    }

    win.show();
}

//확인
function fnConfirm(gr, fg, row, colId)
{
    top.window.returnValue = gr.rowData(gr.fg.Row);
    top.window.close();
}
</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
    <TR>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%" onEnter="javascript:fnSearch();">
                <TR>
                    <TD><SPAN id="spn_gridMessage"></SPAN></TD>
                    <TD align="right">
                        <INPUT type="text" id="txt_searchText" style="width:150px;">
                        <BUTTON auto="search" onClick="javascript:fnSearch();"></BUTTON>
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
            <ANY:GRID id="gr_workCodeList" pagingType="1"><COMMENT>
                addColumn({ width:30 , align:"center", type:"check" , sort:false, id:"ROW_CHK"      , hide:true });
                addColumn({ width:80 , align:"center", type:"string", sort:true , id:"CODE_VALUE"   , name:"코드" });
                addColumn({ width:200, align:"left"  , type:"string", sort:true , id:"CODE_NAME"    , name:"코드명" });
                addColumn({ width:60 , align:"center", type:"string", sort:false, id:"EDIT_CODE"    , name:"수정", text:"[수정]" });
                messageSpan = "spn_gridMessage";
                addSorting("CODE_VALUE", "ASC");
                addAction("CODE_NAME", fnConfirm);
                addAction("EDIT_CODE", fnModify);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
    <TR>
        <TD height="5"></TD>
    </TR>
    <TR>
        <TD align="right">
            <BUTTON text="추가" onClick="javascript:fnCreate();"></BUTTON>
            <BUTTON auto="line"></BUTTON>
            <BUTTON auto="close"></BUTTON>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
