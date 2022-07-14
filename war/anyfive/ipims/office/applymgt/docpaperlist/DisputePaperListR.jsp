<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.office.common.app.OfficeApp"%><% OfficeApp app = new OfficeApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>분쟁/소송 진행서류현황</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
}

//목록 조회
function fnRetrieve()
{
    var ldr = gr_disputePaperList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.office.applymgt.docpaperlist.act.RetrieveDisputePaperList.do";
    ldr.addParam("NUM_KIND", NUM_KIND.value);
    ldr.addParam("NUM_TEXT", NUM_TEXT.value);
    ldr.addParam("NUM_ONLY", NUM_ONLY.value);
    ldr.addParam("COUNTRY_CODE", COUNTRY_CODE.value);
    ldr.addParam("OTHER_NAME", OTHER_NAME.value);
    ldr.addParam("OFFICE_CODE", OFFICE_CODE.value);
    ldr.addParam("PAPER_CODE", PAPER_CODE.value);
    ldr.addParam("DATE_KIND", DATE_KIND.value);
    ldr.addParam("DATE_START", DATE_START.value);
    ldr.addParam("DATE_END", DATE_END.value);
    ldr.addParam("DISPUTE_DIV", DISPUTE_DIV.value);

    ldr.onSuccess = function(gr, fg)
    {
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

//상세
function fnDetail(gr, fg, row, colId)
{
    var win = new any.viewer();
    win.path = top.getRoot() + "/anyfive/ipims/share/docpaper/docpaper/DocPaperM.jsp";
    win.arg.REF_ID = gr.value(row, "REF_ID");
    win.arg.LIST_SEQ = gr.value(row, "LIST_SEQ");

    win.onReload = function()
    {
        gr.loader.reload();
    }

    win.show();
}
</SCRIPT>

<!-- 검색일자 구분 변경시 -->
<SCRIPT language="JScript" for="DATE_KIND" event="OnChange()">
    DATE_START.disabled = (this.value == "");
    DATE_END.disabled = (this.value == "");
</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
    <TR>
        <TD>
            <TABLE border="0" cellspacing="1" cellpadding="2" class="main" onEnter="javascript:fnRetrieve();">
                <COLGROUP>
                    <COL class="condhead" width="10%">
                    <COL class="conddata" width="23%">
                    <COL class="condhead" width="10%">
                    <COL class="conddata" width="23%">
                    <COL class="condhead" width="10%">
                    <COL class="conddata" width="23%">
                </COLGROUP>
                <TR>
                    <TD>검색번호</TD>
                    <TD colspan="3">
                        <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                            <TR>
                                <TD>
                                    <ANY:SELECT id="NUM_KIND" codeData="/ipbiz/disputePaperSearchNumKind" style="width:100px; margin-right:3px;" />
                                </TD>
                                <TD width="100%">
                                    <INPUT type="text" id="NUM_TEXT" style="text-transform:uppercase;">
                                </TD>
                                <TD noWrap>
                                    <ANY:CHECK id="NUM_ONLY" text="번호만 검색" />
                                </TD>
                            </TR>
                        </TABLE>
                    </TD>
                    <TD>국가</TD>
                    <TD>
                        <ANY:SELECT id="COUNTRY_CODE" codeData="/common/countryCode" firstName="all" />
                    </TD>
                </TR>
                <TR>
                    <TD>상대회사</TD>
                    <TD>
                        <INPUT type="text" id="OTHER_NAME">
                    </TD>
                    <TD>국내사무소</TD>
                    <TD>
                        <ANY:SELECT id="OFFICE_CODE" codeData="/common/intOfficeCode" firstName="all" />
                    </TD>
                    <TD>진행서류</TD>
                    <TD>
                        <ANY:SELECT id="PAPER_CODE" codeData="/common/paperCodeByPaperInoutDiv,80,COM" firstName="all" />
                    </TD>
                </TR>
                <TR>
                    <TD>검색일자</TD>
                    <TD colspan="3" noWrap>
                        <ANY:SELECT id="DATE_KIND" codeData="/ipbiz/disputePaperSearchDateKind" firstName="none" style="width:100px; margin-right:3px;" />
                        <ANY:DATE id="DATE_START" disabled />&nbsp;~
                        <ANY:DATE id="DATE_END" disabled />
                    </TD>
                    <TD>구분</TD>
                    <TD>
                        <ANY:SELECT id="DISPUTE_DIV" codeData="{DISPUTE_DIV}" firstName="all" />
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
            <ANY:GRID id="gr_disputePaperList" pagingType="1"><COMMENT>
                addColumn({ width:120, align:"left"  , type:"string", sort:true , id:"MGT_NO"               , name:"분쟁REF" });
                addColumn({ width:120, align:"left"  , type:"string", sort:true , id:"DISPUTE_NO"           , name:"분쟁(소송)번호" });
                addColumn({ width:120, align:"left"  , type:"string", sort:true , id:"PAPER_NAME"           , name:"진행서류명" });
                addColumn({ width:150, align:"left"  , type:"string", sort:true , id:"DISPUTE_SUBJECT"      , name:"분쟁제목" });
                addColumn({ width:120, align:"left"  , type:"string", sort:true , id:"OTHER_NAME"           , name:"상대명" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"COUNTRY_NAME"         , name:"분쟁국가" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"PAPER_DATE"           , name:"서류일자" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"STATUS_NAME"          , name:"진행상태" });
                useConfig = true;
                messageSpan = "spn_gridMessage";
                setFixedColumn(null, "PAPER_NAME");
                addSorting("PAPER_DATE", "DESC");
                addAction("PAPER_NAME", fnDetail);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>

