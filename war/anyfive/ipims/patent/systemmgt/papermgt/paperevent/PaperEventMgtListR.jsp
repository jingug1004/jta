<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>진행서류 이벤트 목록</TITLE>
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
    var ldr = gr_paperEventList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.papermgt.paperevent.act.RetrievePaperEventList.do";
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
    win.path = "PaperEventMgtC.jsp";

    win.onReload = function()
    {
        gr_paperEventList.loader.reload();
    }

    win.show();
}

//상세
function fnDetail(gr, fg, row, colId)
{
    var win = new any.viewer();
    win.path = "PaperEventMgtUD.jsp";
    win.arg.EVENT_SEQ = gr.value(row, "EVENT_SEQ");

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
                    <COL class="conddata" width="85%">
                </COLGROUP>
                <TR>
                    <TD>검색어</TD>
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
            <ANY:GRID id="gr_paperEventList" pagingType="1"><COMMENT>
                addColumn({ width:50 , align:"center", type:"number" , sort:false, id:"ROW_NUM"             , name:"No" });
                addColumn({ width:150, align:"left"  , type:"string" , sort:true , id:"EVENT_ID"            , name:"이벤트 ID" });
                addColumn({ width:200, align:"left"  , type:"string" , sort:true , id:"EVENT_NAME"          , name:"이벤트 이름" });
                addColumn({ width:200, align:"left"  , type:"string" , sort:true , id:"EVENT_DESC"          , name:"이벤트 설명" });
                addColumn({ width:200, align:"left"  , type:"string" , sort:true , id:"NEXT_URGENT_DATE_QRY", name:"다음업무처리기한일 쿼리" });
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_NUM", "EVENT_ID");
                addSorting("EVENT_ID", "ASC");
                addAction("EVENT_ID", fnDetail);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
