<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>진행서류 검색</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    if (parent.SEARCH_TEXT != null) {
        txt_searchText.value = parent.SEARCH_TEXT;
    }
    if (parent.PAPER_DIV != null) {
        PAPER_DIV.value = parent.PAPER_DIV;
    }
    if (parent.INOUT_DIV != null) {
        INOUT_DIV.value = parent.INOUT_DIV;
    }

    PAPER_DIV.style.display = (parent.paperDivDisplay == null ? "" : parent.paperDivDisplay);
    INOUT_DIV.style.display = (parent.inoutDivDisplay == null ? "" : parent.inoutDivDisplay);

    cfShowObjects([btn_confirm], parent.multiCheck);

    fnSearch();
}

//검색
function fnSearch()
{
    var ldr = gr_paperList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.common.popup.search.act.RetrievePaperSearchList.do";
    ldr.addParam("SEARCH_TEXT", txt_searchText.value);
    ldr.addParam("PAPER_DIV", PAPER_DIV.value);
    ldr.addParam("INOUT_DIV", INOUT_DIV.value);

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

//확인
function fnConfirm()
{
    cfPopupSearchResult(parent, gr_paperList);
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
                        <ANY:SELECT id="PAPER_DIV" codeData="{PAPER_DIV}" firstName="all" style="display:none; width:105px;" />
                        <ANY:SELECT id="INOUT_DIV" codeData="{PAPER_INOUT_DIV}" firstName="all" style="display:none; width:60px; margin-left:3px;" />
                        <INPUT type="text" id="txt_searchText" style="width:120px; margin-left:3px;">
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
            <ANY:GRID id="gr_paperList" pagingType="1"><COMMENT>
                addColumn({ width:40 , align:"center", type:"number", sort:false, id:"ROW_NUM"          , name:"No" });
                addColumn({ width:30 , align:"center", type:"check" , sort:false, id:"ROW_CHK"          , hide:true });
                addColumn({ width:100, align:"center", type:"string", sort:true , id:"PAPER_DIV_NAME"   , name:"서류구분" });
                addColumn({ width:80 , align:"center", type:"string", sort:true , id:"INOUT_DIV_NAME"   , name:"국내외구분" });
                addColumn({ width:150, align:"left"  , type:"string", sort:true , id:"PAPER_NAME"       , name:"서류명" });
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_NUM", "ROW_CHK");
                addSorting("PAPER_DIV_NAME", "DESC");
                addSorting("PAPER_NAME", "ASC");

                if (parent.multiCheck == true) {
                    fg.ColHidden(fg.ColIndex("ROW_CHK")) = false;
                } else {
                    addAction("PAPER_NAME", fnConfirm);
                }
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
    <TR>
        <TD height="5"></TD>
    </TR>
    <TR>
        <TD align="right">
            <BUTTON text="확인" onClick="javascript:fnConfirm();" id="btn_confirm" display="none"></BUTTON>
            <BUTTON auto="close"></BUTTON>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
