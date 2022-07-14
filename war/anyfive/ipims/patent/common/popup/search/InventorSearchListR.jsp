<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>발명자 검색</TITLE>
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
    var ldr = gr_inventorList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.common.popup.search.act.RetrieveInventorSearchList.do";
    ldr.addParam("SEARCH_TEXT", txt_searchText.value);
    ldr.addParam("OUT_SEARCH", chk_outSearch.value);

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
    if (!confirm("선택한 발명자가 확실합니까?")) return;

    cfPopupSearchResult(parent, gr_inventorList);
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
                        <ANY:CHECK id="chk_outSearch" text="외부발명자 포함" style="margin-right:5px;" onClick="javascript:txt_searchText.focus();" />
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
            <ANY:GRID id="gr_inventorList" pagingType="1"><COMMENT>
                addColumn({ width:30 , align:"center", type:"check" , sort:false, id:"ROW_CHK"          , hide:true });
                addColumn({ width:80 , align:"center", type:"string", sort:true , id:"EMP_NO"           , name:"사번" });
                addColumn({ width:90 , align:"center", type:"string", sort:true , id:"EMP_HNAME"        , name:"이름" });
                addColumn({ width:160, align:"left"  , type:"string", sort:true , id:"DEPT_NAME"        , name:"팀" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"POSITION_NAME"        , name:"직위" });
                addColumn({ width:70 , align:"center", type:"string", sort:true , id:"HT_CODE_NAME"     , name:"휴퇴구분" });
                addColumn({ width:70 , align:"center", type:"string", sort:true , id:"INOUT_NAME"       , name:"내외" });
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_CHK", "EMP_HNAME");
                addSorting("EMP_HNAME", "ASC");

                if (parent.multiCheck == true) {
                    fg.ColHidden(fg.ColIndex("ROW_CHK")) = false;
                } else {
                    addAction("EMP_HNAME", fnConfirm);
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
