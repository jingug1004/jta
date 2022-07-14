<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>사원 검색</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    if (parent.SEARCH_TEXT != null) {
        txt_searchText.value = parent.SEARCH_TEXT;
    }
    fnSearch();
}


//검색
function fnSearch()
{
    var ldr = gr_userList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.common.popup.search.act.RetrieveUserSearchList.do";
    ldr.addParam("SYSTEM_TYPE", parent.SYSTEM_TYPE);
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
            <ANY:GRID id="gr_userList" pagingType="1"><COMMENT>
                addColumn({ width:80 , align:"center", type:"string", sort:true , id:"EMP_NO"           , name:"사번" });
                addColumn({ width:80 , align:"center", type:"string", sort:true , id:"POSITION_NAME"    , name:"직위" });
                addColumn({ width:90 , align:"center", type:"string", sort:true , id:"EMP_HNAME"        , name:"이름" });
                if (parent.SYSTEM_TYPE == "OFFICE") {
                    addColumn({ width:150, align:"left"  , type:"string", sort:true , id:"FIRM_HNAME"   , name:"사무소" });
                    addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"TELNO"        , name:"전화번호" });
                } else {
                    addColumn({ width:150, align:"left"  , type:"string", sort:true , id:"DEPT_NAME"    , name:"부서" });
                    addColumn({ width:150, align:"left"  , type:"string", sort:true , id:"OFFICE_TEL"   , name:"전화번호" });
                    addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"MOBILE_PHONE" , name:"휴대폰번호" });
                }
                addColumn({ width:130 , align:"center", type:"string", sort:true , id:"MAIL_ADDR"       , name:"E-mail" });
                messageSpan = "spn_gridMessage";
                addSorting("EMP_HNAME", "ASC");

            </COMMENT></ANY:GRID>
        </TD>
    </TR>
    <TR>
        <TD height="5"></TD>
    </TR>
</TABLE>
<% app.writeBodyFooter(); %>
</BODY>
</HTML>
