<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>사무소 관리</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();
}

//목록 조회
function fnRetrieve()
{
    var ldr = gr_officeMainList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.officemgt.main.act.RetrieveOfficeMgtMainList.do";
    ldr.addParam("COUNTRY_CODE", COUNTRY_CODE.value);
    ldr.addParam("SEARCH_TEXT", SEARCH_TEXT.value);

    ldr.onSuccess = function(gr, fg)
    {
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

//작성
function fnCreate()
{
    var win = new any.viewer();
    win.path = "OfficeMgtMainC.jsp";

    win.onReload = function()
    {
        gr_officeMainList.loader.reload();
    }

    win.show();
}

//수정
function fnModify(gr, fg, row, colId)
{
    var win = new any.viewer();
    win.path = "OfficeMgtMainUD.jsp";
    win.arg.OFFICE_CODE = gr.value(row, "OFFICE_CODE");

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
            <TABLE border="0" cellspacing="1" cellpadding="2" class="main" onEnter="javascript:fnRetrieve();">
                <COLGROUP>
                    <COL class="condhead" width="15%">
                    <COL class="conddata" width="35%">
                    <COL class="condhead" width="15%">
                    <COL class="conddata" width="35%">
                </COLGROUP>
                <TR>
                    <TD>국가</TD>
                    <TD>
                        <ANY:SELECT id="COUNTRY_CODE" codeData="/common/countryCode" firstName="all" />
                    </TD>
                    <TD>회사명</TD>
                    <TD>
                        <INPUT type="text" id="SEARCH_TEXT">
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD height="5"></TD>
    </TR>
    <TR>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD><SPAN id="spn_gridMessage"></SPAN></TD>
                    <TD align="right">
                        <BUTTON auto="retrieve" onClick="javascript:fnRetrieve();"></BUTTON>
                        <BUTTON auto="line"></BUTTON>
                        <BUTTON text="작성" onClick="javascript:fnCreate();"></BUTTON>
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
            <ANY:GRID id="gr_officeMainList" pagingType="1"><COMMENT>
                addColumn({ width:50 , align:"center", type:"number" , sort:false, id:"ROW_NUM"         , name:"No" });
                addColumn({ width:200, align:"left"  , type:"string" , sort:true , id:"FIRM_HNAME"      , name:"회사명(한)" });
                addColumn({ width:150, align:"left"  , type:"string" , sort:true , id:"FIRM_ENAME"      , name:"회사명(영)" });
                addColumn({ width:50 , align:"center", type:"string" , sort:true , id:"COUNTRY_CODE"    , name:"국가코드" });
                addColumn({ width:70 , align:"left"  , type:"string" , sort:true , id:"PRESIDENT_NAME"  , name:"대표자명" });
                addColumn({ width:100, align:"left"  , type:"string" , sort:true , id:"TELNO"           , name:"전화번호" });
                addColumn({ width:120, align:"left"  , type:"string" , sort:true , id:"BUSINESS_NO"     , name:"사업자번호" });
                addColumn({ width:60 , align:"center", type:"number" , sort:true , id:"DISP_ORD"        , name:"표시순서" });
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_NUM", "FIRM_HNAME");
                addSorting("DISP_ORD", "ASC");
                addSorting("FIRM_HNAME", "ASC");
                addAction("FIRM_HNAME", fnModify);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
