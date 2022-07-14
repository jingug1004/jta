<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>공통코드 그룹 목록</TITLE>
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
    var ldr = gr_codeGroupList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.configure.codegroup.act.RetrieveCodeGroupList.do";
    ldr.addParam("SEARCH_TEXT", SEARCH_TEXT.value);
    ldr.addParam("USE_YN", USE_YN.value);

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
    win.path = "CodeGroupC.jsp";
    win.opt.width = 600;
    win.opt.height = 200;

    win.onReload = function()
    {
        gr_codeGroupList.loader.reload();
    }

    win.show();
}

//상세 팝업
function fnOpenView(gr, fg, row, colId)
{
    var win = new any.window();
    win.path = "CodeGroupUD.jsp";
    win.arg.CODE_GRP = gr.value(row, "CODE_GRP");
    win.opt.width = 600;
    win.opt.height = 200;

    win.onReload = function()
    {
        gr.loader.reload();
    }

    win.show();
}

//상세목록 팝업
function fnOpenList(gr, fg, row, colId)
{
    var win = new any.window();
    win.path = top.getRoot() + "/anyfive/ipims/patent/systemmgt/configure/codevalue/CodeValueListR.jsp";
    win.arg.CODE_GRP = gr.value(row, "CODE_GRP");
    win.arg.CODE_GRP_NAME = gr.value(row, "CODE_GRP_NAME");
    win.opt.width = 700;
    win.opt.height = 450;

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
                    <TD><%= app.message.get("lbl.com.keyword") %></TD>
                    <TD>
                        <INPUT type="text" id="SEARCH_TEXT">
                    </TD>
                    <TD>사용여부</TD>
                    <TD>
                        <ANY:SELECT id="USE_YN" codeData="{USE_YN}" firstName="all" />
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
            <ANY:GRID id="gr_codeGroupList" pagingType="1"><COMMENT>
                addColumn({ width:50 , align:"center", type:"number", sort:false, id:"ROW_NUM"          , name:"<%= app.message.get("lbl.com.no").toJS() %>" });
                addColumn({ width:150, align:"left"  , type:"string", sort:true , id:"CODE_GRP_ID"      , name:"그룹 ID" });
                addColumn({ width:200, align:"left"  , type:"string", sort:true , id:"CODE_GRP_NAME"    , name:"그룹 이름" });
                addColumn({ width:60 , align:"right" , type:"number", sort:true , id:"CODE_CNT"         , name:"코드 갯수" });
                addColumn({ width:60 , align:"center", type:"string", sort:true , id:"USE_YN_NAME"      , name:"사용 여부" });
                addColumn({ width:300, align:"left"  , type:"string", sort:true , id:"CODE_GRP_DESC"    , name:"그룹 설명" });
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_NUM", "CODE_GRP_ID");
                addSorting("CODE_GRP_ID", "ASC");
                addAction("CODE_GRP_ID", fnOpenView);
                addAction("CODE_CNT", fnOpenList);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
