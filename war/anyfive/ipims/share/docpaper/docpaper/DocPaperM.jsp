<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.share.common.app.ShareApp"%><% ShareApp app = new ShareApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>진행서류</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<SCRIPT language="JScript">
var REF_ID = parent.REF_ID;
var LIST_SEQ;

var gPageMode;
var gRetrieveDetail;
var gMasterInfo = {};

//윈도우 로딩시
window.onready = function()
{

}

//LIST_SEQ 초기값 설정
function fnInitListSeq()
{
    try {

        LIST_SEQ = parent.parent.LIST_SEQ;
        parent.parent.LIST_SEQ = null;

        if (LIST_SEQ == null) {
            LIST_SEQ = parent.LIST_SEQ;
            parent.LIST_SEQ = null;
        }

    } catch(ex) {
    }
}

//조회
function fnRetrieve()
{
    var ldr = gr_docPaperList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.share.docpaper.docpaper.act.RetrieveDocPaperDetailList.do";
    ldr.addParam("REF_ID", parent.REF_ID);

    ldr.onSuccess = function(gr, fg)
    {
        for (var i = fg.FixedRows; i < fg.Rows; i++) {
            if (gr.value(i, "LIST_SEQ") != LIST_SEQ) continue;
            fnMovePage(i);
            break;
        }
        fnMovePage();
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

//Reload
function fnReload()
{
    any_abstractInfo.refresh();
    gr_docPaperList.loader.reload();
}

//페이지 이동
function fnMovePage(row)
{
    var gr = gr_docPaperList;

    if (row != null) {
        gr.fg.Row = row;
        if (gr.fg.Rows > gr.fg.FixedRows) {
            gr.fg.Cell(flexcpBackColor, gr.fg.FixedRows, 0, gr.fg.Rows - 1, 0) = "";
            gr.fg.Cell(flexcpForeColor, gr.fg.FixedRows, 0, gr.fg.Rows - 1, 0) = "";
            if (row >= gr.fg.FixedRows) {
                gr.fg.Cell(flexcpBackColor, row, 0) = "&HFF0000";
                gr.fg.Cell(flexcpForeColor, row, 0) = "&HFFFFFF";
            }
        }
    }

    if (gr.fg.Row < gr.fg.FixedRows) {
        LIST_SEQ = null;
        if (gPageMode == "C") return;
        gPageMode = "C";
    } else {
        if (row == null && LIST_SEQ == gr.value(gr.fg.Row, "LIST_SEQ")) return;
        LIST_SEQ = gr.value(gr.fg.Row, "LIST_SEQ");
        if (gPageMode == "R") {
            try {
                gRetrieveDetail();
                return;
            } catch(ex) {
            }
        }
        gPageMode = "R";
    }

    ifr_main.location.replace(gPageMode == "C" ? "DocPaperC.jsp" : "DocPaperRD.jsp");
}

//상세
function fnDetail(gr, fg, row, colId)
{
    fnMovePage(row);
}
</SCRIPT>

<!-- 서지정보 로딩시 -->
<SCRIPT language="JScript" for="any_abstractInfo" event="OnLoad()">
    gMasterInfo.MST_DIV = this.value("MST_DIV");
    gMasterInfo.RIGHT_DIV = this.value("RIGHT_DIV");
    gMasterInfo.INOUT_DIV = this.value("INOUT_DIV");
    fnInitListSeq();
    fnRetrieve();

</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>
<ANY:ABSTRACT id="any_abstractInfo"><COMMENT>
    refId = parent.REF_ID;
    grpId = parent.GRP_ID;
</COMMENT></ANY:ABSTRACT>

<IFRAME name="ifr_main" frameborder="0" scrolling="no" style="width:100%; margin-top:2px;" pageType="tabframe" fullSize="true"></IFRAME>

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" style="margin-top:10px;">
    <TR>
        <TD class="title_sub">진행서류 목록</TD>
        <TD align="right"><SPAN id="spn_gridMessage"></SPAN></TD>
    </TR>
</TABLE>
<ANY:GRID id="gr_docPaperList" pagingType="0" rowNumDir="DESC" style="margin-top:5px; height:250px;"><COMMENT>
    addColumn({ width:40 , align:"center", type:"number", sort:false, id:"ROW_NUM"              , name:"No" });
    addColumn({ width:180, align:"left"  , type:"string", sort:false, id:"PAPER_FULL_NAME"      , name:"진행서류-세부서류" });
    addColumn({ width:130, align:"left"  , type:"string", sort:false, id:"PAPER_REF_NO"         , name:"관련번호" });
    addColumn({ width:150, align:"left"  , type:"string", sort:false, id:"COMMENTS"             , name:"참고사항" });
    addColumn({ width:75 , align:"center", type:"date"  , sort:false, id:"PAPER_DATE"           , name:"서류일" });
    addColumn({ width:60 , align:"center", type:"date"  , sort:false, id:"INPUT_OWNER_NAME"     , name:"입력구분" });
    addColumn({ width:75 , align:"center", type:"date"  , sort:false, id:"URGENT_DATE"          , name:"업무기한" });
    addColumn({ width:75 , align:"center", type:"date"  , sort:false, id:"DUE_DATE"             , name:"법정기한" });
    addColumn({ width:75 , align:"center", type:"date"  , sort:false, id:"CRE_DATE"             , name:"입력일" });
    addColumn({ width:75 , align:"center", type:"date"  , sort:false, id:"CONFIRM_DATE2"        , name:"확인일" });
    useConfig = true;
    messageSpan = "spn_gridMessage";
    setFixedColumn("ROW_NUM", "PAPER_FULL_NAME");
    addAction("PAPER_FULL_NAME", fnDetail, 1);
</COMMENT></ANY:GRID>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
