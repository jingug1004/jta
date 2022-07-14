<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>검색식 목록</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnSearch();
}

//검색
function fnSearch()
{
    var ldr = gr_searchKeywordList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.search.keyword.act.RetrieveSearchKeywordList.do";
    ldr.addParam("SEARCH_KIND", parent.SEARCH_KIND);
    ldr.addParam("KEYWORD", txt_keyword.value);

    ldr.onSuccess = function(gr, fg)
    {
        txt_keyword.focus();
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

//입력
function fnInput(gr, fg, row, colId)
{
    top.window.returnValue = gr_searchKeywordList.value(row, "KEYWORD");
    top.window.close();
}

//수정
function fnModify(gr, fg, row, colId)
{
    var win = new any.window();
    win.path = "SearchKeywordCU.jsp";
    win.arg.SEQ_NO = gr.value(row, "SEQ_NO");
    win.opt.width = 500;
    win.opt.height = 250;

    win.onReload = function()
    {
        gr.loader.reload();
    }

    win.show();
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
                        <INPUT type="text" id="txt_keyword" style="width:200px;">
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
            <ANY:GRID id="gr_searchKeywordList" pagingType="1"><COMMENT>
                addColumn({ width:50 , align:"center", type:"number", sort:false, id:"ROW_NUM"      , name:"No" });
                addColumn({ width:200, align:"left"  , type:"string", sort:true , id:"KEYWORD"      , name:"검색식" });
                addColumn({ width:200, align:"left"  , type:"string", sort:true , id:"ADD_DESC"      , name:"검색식 부연설명" });
                addColumn({ width:130, align:"center", type:"date"  , sort:true , id:"CRE_DATETIME" , name:"생성일시" });
                addColumn({ width:130, align:"center", type:"date"  , sort:true , id:"UPD_DATETIME" , name:"수정일시" });
                addColumn({ width:50 , align:"center", type:"string", sort:false, id:"MODIFY"       , name:"수정", text:"[수정]" });
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_NUM");
                addSorting("CRE_DATETIME", "DESC");
                addAction("KEYWORD", fnInput);
                addAction("MODIFY", fnModify);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
    <TR>
        <TD>
            <DIV class="button_area">
                <BUTTON auto="close"></BUTTON>
            </DIV>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
