<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>결재코드 목록</TITLE>
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
    var ldr = gr_apprCodeMgtList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.basecode.apprmgt.act.RetrieveApprCodeMgtList.do";
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

//작성 팝업
function fnOpenCreate()
{
    var win = new any.window();
    win.path = "ApprCodeMgtC.jsp";
    win.opt.width = 700;
    win.opt.height = 400;

    win.onReload = function()
    {
        gr_apprCodeMgtList.loader.reload();
    }

    win.show();
}

//상세 팝업
function fnOpenView(gr, fg, row, colId)
{
    var win = new any.window();
    win.path = "ApprCodeMgtUD.jsp";
    win.arg.APPR_CODE = gr.value(row, "APPR_CODE");
    win.opt.width = 700;
    win.opt.height = 400;

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
                        <BUTTON text="작성" onClick="javascript:fnOpenCreate();"></BUTTON>
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
            <ANY:GRID id="gr_apprCodeMgtList" pagingType="1"><COMMENT>
                addColumn({ width:50 , align:"center", type:"number" , sort:false, id:"ROW_NUM"             , name:"No" });
                addColumn({ width:60 , align:"center", type:"string" , sort:true , id:"APPR_CODE"           , name:"결재코드" });
                addColumn({ width:250, align:"left"  , type:"string" , sort:true , id:"APPR_NAME"           , name:"결재명" });
                addColumn({ width:120, align:"left"  , type:"string" , sort:true , id:"APPR_TABLE"          , name:"결재테이블" });
                addColumn({ width:120, align:"left"  , type:"string" , sort:true , id:"APPR_PK_COLS"        , name:"PK 컬럼명들" });
                addColumn({ width:120, align:"left"  , type:"string" , sort:true , id:"APPR_NO_COL"         , name:"결재번호 컬럼명" });
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_NUM", "APPR_NAME");
                addSorting("APPR_CODE", "ASC");
                addAction("APPR_NAME", fnOpenView);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
