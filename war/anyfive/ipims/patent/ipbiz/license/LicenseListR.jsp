<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>라이센스현황</TITLE>
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
    var ldr = gr_licenseList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.ipbiz.license.act.RetrieveLicenseList.do";
    ldr.addParam("MGT_NO"       , MGT_NO.value);
    ldr.addParam("UTILIZE_TITLE", UTILIZE_TITLE.value);
    ldr.addParam("TARGET_ENT"   , TARGET_ENT.value);
    ldr.addParam("LICENSE_DIV"  , LICENSE_DIV.value);
    ldr.addParam("ETC_CLS_CODE" , ETC_CLS_CODE.value);
    ldr.addParam("SEARCH_DATE"  , SEARCH_DATE.value);
    ldr.addParam("DATE_START"   , DATE_START.value);
    ldr.addParam("DATE_END"     , DATE_END.value);

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
function fnOpenCreate()
{
    var win = new any.viewer();
    win.path = "LicenseC.jsp";

    win.onReload = function()
    {
       gr.loader.reload();
    }

    win.show();
}

//상세
function fnOpenView(gr, fg, row, colId)
{
    var win = new any.viewer();
    win.path = "LicenseRD.jsp";
    win.arg.LICENSE_ID = gr.value(row, "LICENSE_ID");

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
            <TABLE border="0" width="100%" cellspacing="1" cellpadding="2" class="main" width="100%" onEnter="javascript:fnRetrieve();">
                <COLGROUP>
                    <COL class="condhead" width="15%">
                    <COL class="conddata" width="35%">
                    <COL class="condhead" width="15%">
                    <COL class="conddata" width="35%">
                </COLGROUP>
                <TR>
                    <TD>관리번호</TD>
                    <TD>
                        <INPUT type="text" id="MGT_NO" >
                    </TD>
                    <TD>실시권의 명칭</TD>
                    <TD>
                        <INPUT type="text" id="UTILIZE_TITLE" >
                    </TD>
                </TR>
                <TR>
                    <TD>대상업체</TD>
                    <TD>
                        <INPUT type="text" id="TARGET_ENT" >
                    </TD>
                    <TD>구분</TD>
                    <TD>
                        <ANY:SELECT id="LICENSE_DIV" codeData="{LICENSE_DIV}" firstName="all" />
                    </TD>
                </TR>
                <TR>
                    <TD>통신방식</TD>
                    <TD>
                        <INPUT type="text" id="ETC_CLS_CODE">
                    </TD>
                    <TD>검색일자</TD>
                    <TD noWrap>
                        <ANY:SELECT id="SEARCH_DATE" codeData="/ipbiz/licenseSearchDateType" style="width:100px; margin-right:3px;"/>
                        <ANY:DATE id="DATE_START" />&nbsp;~
                        <ANY:DATE id="DATE_END" />
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
                        <BUTTON text="<%= app.message.get("btn.com.write").toHTML() %>" onClick="javascript:fnOpenCreate();"></BUTTON>
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
            <ANY:GRID id="gr_licenseList" pagingType="1"><COMMENT>
                addHeader([ null, null, null, null, null, null, "실시료", "", null, null, null, null, null ]);
                addColumn({ width:50 , align:"center", type:"number" , sort:false, id:"ROW_NUM"              , name:"<%= app.message.get("lbl.com.no").toJS() %>" });
                addColumn({ width:100, align:"left"  , type:"string" , sort:true , id:"MGT_NO"               , name:"관리번호" });
                addColumn({ width:180, align:"left"  , type:"string" , sort:true , id:"UTILIZE_TITLE"        , name:"실시권의 명칭" });
                addColumn({ width:90 , align:"center", type:"string" , sort:true , id:"LICENSE_DIV_NAME"     , name:"구분" });
                addColumn({ width:70 , align:"left"  , type:"string" , sort:true , id:"TARGET_ENT"           , name:"대상업체" });
                addColumn({ width:130, align:"left"  , type:"string" , sort:true , id:"COUNTRY_CODE_NAME"    , name:"적용국가" });
                addColumn({ width:70 , align:"right" , type:"number" , sort:true , id:"LR_FIX_USE_PRICE"     , name:"L/R" , format:"#,###"});
                addColumn({ width:70 , align:"right" , type:"number" , sort:true , id:"RR_FIX_USE_PRICE"     , name:"R/R" , format:"#,###"});
                addColumn({ width:60 , align:"center", type:"string" , sort:true , id:"CONTRACT_STATUS_NAME" , name:"계약상태" });
                addColumn({ width:75 , align:"center", type:"date"   , sort:true , id:"CONTRACT_START_DATE"  , name:"계약시작일" });
                addColumn({ width:75 , align:"center", type:"date"   , sort:true , id:"CONTRACT_END_DATE"    , name:"계약종료일" });
                addColumn({ width:60 , align:"left"  , type:"string" , sort:true , id:"CRE_USER_NAME"        , name:"작성자" });
                addColumn({ width:75 , align:"center", type:"date"   , sort:true , id:"CRE_DATE"             , name:"작성일" });
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_NUM", "UTILIZE_TITLE");
                addSorting("MGT_NO", "ASC");
                addAction("UTILIZE_TITLE", fnOpenView);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
