<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>진행서류 목록</TITLE>
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
    var ldr = gr_paperCodeList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.papermgt.papercode.act.RetrievePaperCodeList.do";
    ldr.addParam("SEARCH_TEXT", SEARCH_TEXT.value);
    ldr.addParam("PAPER_DIV", PAPER_DIV.value);
    ldr.addParam("INOUT_DIV", INOUT_DIV.value);
    ldr.addParam("OA_MGT_STEP", OA_MGT_STEP.value);
    ldr.addParam("PAPER_STEP", PAPER_STEP.value);

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
    win.path = "PaperCodeMgtC.jsp";

    win.onReload = function()
    {
        gr_paperCodeList.loader.reload();
    }

    win.show();
}

//상세
function fnDetail(gr, fg, row, colId)
{
    var win = new any.viewer();
    win.path = "PaperCodeMgtUD.jsp";
    win.arg.PAPER_CODE = gr.value(row, "PAPER_CODE");

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
                    <TD>서류구분</TD>
                    <TD>
                        <ANY:SELECT id="PAPER_DIV" codeData="{PAPER_DIV}" firstName="all" />
                    </TD>
                    <TD>국내외구분</TD>
                    <TD>
                        <ANY:SELECT id="INOUT_DIV" codeData="{PAPER_INOUT_DIV}" firstName="all" />
                    </TD>
                    <TD>진행단계</TD>
                    <TD>
                        <ANY:SELECT id="PAPER_STEP" codeData="{PAPER_STEP}" firstName="all" />
                    </TD>
                </TR>
                <TR>
                    <TD>OA 관리단계</TD>
                    <TD>
                        <ANY:SELECT id="OA_MGT_STEP" codeData="{OA_MGT_STEP}" firstName="all" />
                    </TD>
                    <TD>코드/이름</TD>
                    <TD colspan="3">
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
            <ANY:GRID id="gr_paperCodeList" pagingType="1"><COMMENT>
                addColumn({ width:50 , align:"center", type:"number" , sort:false, id:"ROW_NUM"             , name:"No" });
                addColumn({ width:90 , align:"center", type:"string" , sort:true , id:"PAPER_CODE"          , name:"코드" });
                addColumn({ width:200, align:"left"  , type:"string" , sort:true , id:"PAPER_NAME"          , name:"진행서류명" });
                addColumn({ width:100, align:"center", type:"string" , sort:true , id:"PAPER_DIV_NAME"      , name:"서류구분" });
                addColumn({ width:70 , align:"center", type:"string" , sort:true , id:"INOUT_DIV_NAME"      , name:"국내외구분" });
                addColumn({ width:70 , align:"center", type:"string" , sort:true , id:"OA_MGT_STEP_NAME"    , name:"OA관리단계" });
                addColumn({ width:70 , align:"center", type:"string" , sort:true , id:"PAPER_STEP_NAME"     , name:"진행단계" });
                addColumn({ width:70 , align:"center", type:"string" , sort:true , id:"MST_STATUS_YN_NAME"  , name:"마스터상태 반영" });
                addColumn({ width:70 , align:"center", type:"string" , sort:true , id:"MST_ABD_YN_NAME"     , name:"마스터포기처리" });
                addColumn({ width:60 , align:"center", type:"string" , sort:true , id:"USE_YN_NAME"         , name:"사용여부" });
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_NUM", "PAPER_NAME");
                addSorting("PAPER_CODE", "ASC");
                addAction("PAPER_NAME", fnDetail);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
