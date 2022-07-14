<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<%@page import="any.core.config.NConfig"%>
<HTML XMLNS:ANY>
<HEAD>
<TITLE><%= app.message.get("tit.systemmgt.basecode.message.list") %></TITLE>
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
    var ldr = gr_messageList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.configure.message.act.RetrieveMessageList.do";
    ldr.addParam("LANG_CODE", LANG_CODE.value);
    ldr.addParam("SEARCH_TEXT", SEARCH_TEXT.value);

    ldr.onStart = function(gr, fg)
    {
        gr.headerName("MSG_TEXT") = LANG_CODE.text;
    }

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
function fnOpenWrite()
{
    var win = new any.window();
    win.path = "MessageC.jsp";
    win.opt.width = 700;
    win.opt.height = 400;

    win.onReload = function()
    {
        gr_messageList.loader.reload();
    }

    win.show();
}

//상세 팝업
function fnOpenView(gr, fg, row, colId)
{
    var win = new any.window();
    win.path = "MessageUD.jsp";
    win.arg.MSG_ID = gr.value(row, "MSG_ID");
    win.opt.width = 700;
    win.opt.height = 400;

    win.onReload = function()
    {
        gr.loader.reload();
    }

    win.show();
}

//엑셀 Import
function fnImportExcel()
{
    var ldr = new any.excelImporter();
    ldr.templateFile = "/excel/MessageList.xls";
    ldr.saveAction = top.getRoot() + "/anyfive.ipims.patent.systemmgt.configure.message.act.UploadMessage.do";
    if (ldr.execute() == "OK") {
        fnRetrieve();
    }
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
                    <TD><%= app.message.get("lbl.com.langcode") %></TD>
                    <TD>
                        <ANY:SELECT id="LANG_CODE" codeData="{LANG_CODE}" value="<%= NConfig.getString(NConfig.DEFAULT_CONFIG + "/default-lang-code") %>" />
                    </TD>
                    <TD><%= app.message.get("lbl.com.keyword") %></TD>
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
                        <BUTTON text="<%= app.message.get("btn.com.write").toHTML() %>" onClick="javascript:fnOpenWrite();"></BUTTON>
                        <BUTTON text="Excel Import" onClick="javascript:fnImportExcel();"></BUTTON>
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
            <ANY:GRID id="gr_messageList" pagingType="1"><COMMENT>
                addColumn({ width:50 , align:"center", type:"number", sort:false, id:"ROW_NUM"  , name:"No" });
                addColumn({ width:300, align:"left"  , type:"string", sort:true , id:"MSG_ID"   , name:"Message ID" });
                addColumn({ width:400, align:"left"  , type:"string", sort:true , id:"MSG_TEXT" , name:"" });
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_NUM", "MSG_ID");
                addSorting("MSG_ID", "ASC");
                addAction("MSG_ID", fnOpenView);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
