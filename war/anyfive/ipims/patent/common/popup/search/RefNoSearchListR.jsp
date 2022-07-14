<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>REF-NO 검색</TITLE>
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
    var ldr = gr_refNoList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.common.popup.search.act.RetrieveRefNoSearchList.do";
    ldr.addParam("SEARCH_TEXT", txt_searchText.value);
    ldr.addParam("SEARCH_LIKE", chk_searchLike.value);
    ldr.addParam("RIGHT_DIV", parent.RIGHT_DIV);
    ldr.addParam("INOUT_DIV", parent.INOUT_DIV);
    ldr.addParam("ABD_YN", parent.ABD_YN);
    ldr.addParam("APP_NO_NOT_NULL", parent.APP_NO_NOT_NULL);

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
    cfPopupSearchResult(parent, gr_refNoList);
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
                        <SPAN>REF-NO/출원번호/등록번호</SPAN>
                        <INPUT type="text" id="txt_searchText" style="width:120px;">
                        <ANY:CHECK id="chk_searchLike" text="유사검색" checked />
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
            <ANY:GRID id="gr_refNoList" pagingType="1"><COMMENT>
                addColumn({ width:30 , align:"center", type:"check" , sort:false, id:"ROW_CHK"      , hide:true });
                addColumn({ width:110, align:"left"  , type:"string", sort:true , id:"REF_NO"       , name:"REF-NO" });
                addColumn({ width:200, align:"left"  , type:"string", sort:true , id:"KO_APP_TITLE" , name:"발명의명칭" });
                addColumn({ width:120, align:"left"  , type:"string", sort:true , id:"APP_NO"       , name:"출원번호" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"APP_DATE"     , name:"출원일" });
                addColumn({ width:120, align:"left"  , type:"string", sort:true , id:"REG_NO"       , name:"등록번호" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"REG_DATE"     , name:"등록일" });
                messageSpan = "spn_gridMessage";
                setFixedColumn(null, "KO_APP_TITLE");
                addSorting("APP_NO", "ASC");

                if (parent.multiCheck == true) {
                    fg.ColHidden(fg.ColIndex("ROW_CHK")) = false;
                } else {
                    addAction("REF_NO", fnConfirm);
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
