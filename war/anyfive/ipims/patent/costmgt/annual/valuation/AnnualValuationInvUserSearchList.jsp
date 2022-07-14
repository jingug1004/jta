<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>발명부서 평가자 검색</TITLE>
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
    var ldr = gr_inventorList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.costmgt.annual.valuation.act.RetrieveAnnualValuationInvUserSearchList.do";
    ldr.addParam("REF_ID", parent.REF_ID);
    ldr.addParam("SEARCH_ALL", SEARCH_ALL.value);
    ldr.addParam("SEARCH_TEXT", SEARCH_TEXT.value);

    ldr.onSuccess = function(gr, fg)
    {
        fg.ColHidden(fg.ColIndex("MAIN_INVENTOR_YN_NAME")) = fg.ColHidden(fg.ColIndex("QUOTA_RATIO")) = (ldr.getParam("SEARCH_ALL") == "1");

        SEARCH_TEXT.focus();
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
                        <INPUT type="text" id="SEARCH_TEXT" style="width:120px;">
                        <ANY:CHECK id="SEARCH_ALL" text="전체 발명자" />
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
                addColumn({ width:80 , align:"center", type:"string", sort:true , id:"EMP_NO"               , name:"사번" });
                addColumn({ width:80 , align:"center", type:"string", sort:true , id:"EMP_HNAME"            , name:"이름" });
                addColumn({ width:50 , align:"center", type:"string", sort:true , id:"MAIN_INVENTOR_YN_NAME", name:"주/부" });
                addColumn({ width:60 , align:"right" , type:"number", sort:true , id:"QUOTA_RATIO"          , name:"지분율", format:"#,###%" });
                addColumn({ width:160, align:"left"  , type:"string", sort:true , id:"DEPT_NAME"            , name:"팀" });
                addColumn({ width:70 , align:"center", type:"string", sort:true , id:"HT_CODE_NAME"         , name:"휴퇴구분" });
                addColumn({ width:60 , align:"center", type:"string", sort:true , id:"INOUT_NAME"           , name:"내외" });
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_CHK", "EMP_HNAME");
                addSorting("MAIN_INVENTOR_YN_NAME", "DESC");
                addSorting("QUOTA_RATIO", "DESC");
                addSorting("EMP_HNAME", "ASC");
                addAction("EMP_HNAME", fnConfirm);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
    <TR>
        <TD height="1">
            <DIV class="button_area">
                <BUTTON auto="close"></BUTTON>
            </DIV>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
