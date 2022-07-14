<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.office.common.app.OfficeApp"%><% OfficeApp app = new OfficeApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>신규요청목록</TITLE>
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
    var ldr = gr_recentDocPaperList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.office.applymgt.docpaperlist.act.RetrieveRecentDocPaperList.do";
    ldr.addParam("REF_NO", REF_NO.value);
    ldr.addParam("INOUT_DIV", INOUT_DIV.value);
    ldr.addParam("RIGHT_DIV" , RIGHT_DIV.value);

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
function fnWrite(gr, fg, row, colId)
{
    fnDetail(gr, fg, row, colId, true);
}

//상세
function fnDetail(gr, fg, row, colId, isWrite)
{
    var win = new any.viewer();
    win.path = top.getRoot() + "/anyfive/ipims/share/docpaper/docpaper/DocPaperM.jsp";
    win.arg.REF_ID = gr.value(row, "REF_ID");

    if (isWrite != true) {
        win.arg.LIST_SEQ = gr.value(row, "LIST_SEQ");
    }

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
                    <COL class="condhead" width="10%">
                    <COL class="conddata" width="23%">
                    <COL class="condhead" width="10%">
                    <COL class="conddata" width="23%">
                    <COL class="condhead" width="10%">
                    <COL class="conddata" width="23%">
                </COLGROUP>
                <TR>
                    <TD>REF-NO</TD>
                    <TD>
                        <INPUT type="text" id="REF_NO" style="text-transform:uppercase;">
                    </TD>
                    <TD>국가구분</TD>
                    <TD>
                        <ANY:SELECT id="INOUT_DIV" codeData="{INOUT_DIV}" firstName="all" />
                    </TD>
                    <TD>권리구분</TD>
                    <TD>
                        <ANY:SELECT id="RIGHT_DIV" codeData="{RIGHT_DIV}" firstName="all" />
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
            <ANY:GRID id="gr_recentDocPaperList" pagingType="1"><COMMENT>
                addColumn({ width:120 , align:"left"   , type:"string", sort:true , id:"REF_NO"             , name:"REF_NO" });
                addColumn({ width:110 , align:"left"   , type:"string", sort:true , id:"APP_NO"             , name:"출원번호" });
                addColumn({ width:115 , align:"left"   , type:"string", sort:true , id:"PAPER_NAME"         , name:"진행서류명" });
                addColumn({ width:130 , align:"left"   , type:"string", sort:true , id:"COMMENTS"           , name:"기타사항" });
                addColumn({ width:115 , align:"left"   , type:"string", sort:true , id:"KO_APP_TITLE"       , name:"발명의 명칭" });
                addColumn({ width:100 , align:"left"   , type:"string", sort:true , id:"INVENTOR_NAMES"     , name:"발명자" });
                addColumn({ width:75  , align:"center" , type:"date"  , sort:true , id:"PAPER_DATE"         , name:"서류일자" });
                addColumn({ width:75  , align:"center" , type:"date"  , sort:true , id:"DUE_DATE"           , name:"법정기한" });
                addColumn({ width:110 , align:"left"   , type:"string", sort:true , id:"OFFICE_CODE_NAME"   , name:"사무소" });
                addColumn({ width:60  , align:"center" , type:"string", sort:true , id:"JOB_MAN_NAME"       , name:"건담당자" });
                addColumn({ width:100 , align:"left"   , type:"string", sort:true , id:"STATUS_NAME"        , name:"진행상태" });
                useConfig = true;
                messageSpan = "spn_gridMessage";
                setFixedColumn(null, "PAPER_NAME");
                addSorting("PAPER_DATE", "DESC");
                addAction("REF_NO", fnWrite);
                addAction("PAPER_NAME", fnDetail);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>

