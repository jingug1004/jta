<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>관련제품 검색</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    if (parent.SEARCH_TEXT != null) {
        txt_searchText.value = parent.SEARCH_TEXT;
    }

    cfShowObjects([btn_confirm], parent.multiCheck);

    fnSearch();
}

//검색
function fnSearch()
{
    var ldr = gr_prodCodeList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.common.popup.search.act.RetrieveProdCodeSearchList.do";
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

//확인
function fnConfirm()
{
    cfPopupSearchResult(parent, gr_prodCodeList);
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
                    <TD align="right">검색어
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
            <ANY:GRID id="gr_prodCodeList" pagingType="1"><COMMENT>
                addColumn({ width:30 , align:"center", type:"check" , sort:false, id:"ROW_CHK"          , hide:true });
                addColumn({ width:90 , align:"center", type:"string", sort:true , id:"PROD_CODE"        , name:"제품코드" });
                addColumn({ width:200, align:"left"  , type:"string", sort:true , id:"PROD_NAME"        , name:"제품이름" });
                addColumn({ width:250, align:"left"  , type:"string", sort:true , id:"PROD_DESC"        , name:"제품설명" });
                messageSpan = "spn_gridMessage";
                addSorting("PROD_CODE", "ASC");

                if (parent.multiCheck == true) {
                    fg.ColHidden(fg.ColIndex("ROW_CHK")) = false;
                } else {
                    addAction("PROD_CODE", fnConfirm);
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
            <BUTTON auto="close" id="btn_close"></BUTTON>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
