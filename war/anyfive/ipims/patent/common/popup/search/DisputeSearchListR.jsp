<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>분쟁/소송 검색</TITLE>
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
    var ldr = gr_prschList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.common.popup.search.act.RetrieveDisputeSearchList.do";
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
    cfPopupSearchResult(parent, gr_prschList);
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
                    <TD align="right">관리/분쟁번호
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
            <ANY:GRID id="gr_prschList" pagingType="1"><COMMENT>
                addColumn({ width:30 , align:"center", type:"check" , sort:false, id:"ROW_CHK"          , hide:true });
                addColumn({ width:120, align:"left"  , type:"string", sort:true , id:"MGT_NO"           , name:"관리번호" });
                addColumn({ width:120, align:"left"  , type:"string", sort:true , id:"DISPUTE_NO"       , name:"분쟁번호" });
                addColumn({ width:200, align:"left"  , type:"string", sort:true , id:"DISPUTE_SUBJECT"  , name:"분쟁제목" });
                addColumn({ width:80 , align:"center", type:"string", sort:true , id:"DISPUTE_DIV_NAME" , name:"분쟁구분" });
                messageSpan = "spn_gridMessage";
                addSorting("DISPUTE_NO", "ASC");

                if (parent.multiCheck == true) {
                    fg.ColHidden(fg.ColIndex("ROW_CHK")) = false;
                } else {
                    addAction("DISPUTE_NO", fnConfirm);
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
