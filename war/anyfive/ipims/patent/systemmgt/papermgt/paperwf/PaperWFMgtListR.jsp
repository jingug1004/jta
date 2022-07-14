<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>진행서류 워크플로우관리 목록</TITLE>
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
    var ldr = gr_paperWFList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.papermgt.paperwf.act.RetrievePaperWFList.do";
    ldr.addParam("WF_KIND", WF_KIND.value);
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
    win.path = "PaperWFMgtC.jsp";

    win.onReload = function()
    {
        gr_paperWFList.loader.reload();
    }

    win.show();
}

//상세
function fnDetail(gr, fg, row, colId)
{
    var win = new any.viewer();
    win.path = "PaperWFMgtUD.jsp";
    win.arg.WF_CODE = gr.value(row, "WF_CODE");

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
                    <TD>W/F 종류</TD>
                    <TD>
                        <ANY:SELECT id="WF_KIND" firstName="all" codeData="/systemmgt/wfKind" />
                    </TD>
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
            <ANY:GRID id="gr_paperWFList" pagingType="1"><COMMENT>
                addColumn({ width:50 , align:"center", type:"number" , sort:false, id:"ROW_NUM"             , name:"No" });
                addColumn({ width:120, align:"center", type:"string" , sort:true , id:"WF_ID"               , name:"W/F 아이디" });
                addColumn({ width:120, align:"left"  , type:"string" , sort:true , id:"WF_KIND_NAME"        , name:"W/F 종류" });
                addColumn({ width:200, align:"left"  , type:"string" , sort:true , id:"WF_NAME"             , name:"W/F 이름" });
                addColumn({ width:250, align:"left"  , type:"string" , sort:true , id:"WF_DESC"             , name:"W/F 설명" });
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_NUM", "WF_ID");
                addSorting("WF_ID", "ASC");
                addAction("WF_ID", fnDetail);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
