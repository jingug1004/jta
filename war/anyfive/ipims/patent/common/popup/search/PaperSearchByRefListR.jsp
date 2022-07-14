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
    cfShowObjects([btn_confirm], parent.multiCheck);

    fnSearch();
}

//검색
function fnSearch()
{
    var ldr = gr_paperList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.common.popup.search.act.RetrievePaperSearchByRefList.do";
    ldr.addParam("REF_ID", parent.REF_ID);
    ldr.addParam("PAPER_STEP", PAPER_STEP.value);
    ldr.addParam("PAPER_INPUT_AVAIL", PAPER_INPUT_AVAIL.value);
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
                        <ANY:SELECT id="PAPER_STEP" codeData="{PAPER_STEP}" firstName="(입력단계)" style="width:85px;" />
                        <ANY:SELECT id="PAPER_INPUT_AVAIL" codeData=/common/paperInputAvailGubun firstName="(입력대상)" style="width:85px; margin-left:3px;" />
                        <INPUT type="text" id="txt_searchText" style="width:150px; margin-left:3px;">
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
            <ANY:GRID id="gr_paperList" pagingType="0"><COMMENT>
                addHeader([ null, null, null, null, "입력가능여부", "", "" ]);
                addColumn({ width:40 , align:"center", type:"number", sort:false, id:"ROW_NUM"          , name:"No" });
                addColumn({ width:30 , align:"center", type:"check" , sort:false, id:"ROW_CHK"          , hide:true });
                addColumn({ width:150, align:"left"  , type:"string", sort:true , id:"PAPER_NAME"       , name:"서류명" });
                addColumn({ width:50 , align:"center", type:"string", sort:true , id:"PAPER_STEP_NAME"  , name:"입력\n단계" });
                addColumn({ width:45 , align:"center", type:"string", sort:true , id:"PATTEAM_INPUT_YN" , name:"특허팀" });
                addColumn({ width:45 , align:"center", type:"string", sort:true , id:"OFFICE_INPUT_YN"  , name:"사무소" });
                addColumn({ width:45 , align:"center", type:"string", sort:true , id:"INVENTOR_INPUT_YN", name:"발명자" });
                addColumn({ width:45 , align:"center", type:"string", sort:true , id:"OA_MGT_STEP", name:"OA구분" , hide:true });
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_NUM", "ROW_CHK");
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
