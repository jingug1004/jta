<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>시스템 업데이트 파일 목록</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();
}

//조회
function fnRetrieve()
{
    var ldr = gr_updateFileList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.configure.update.act.RetrieveUpdateFileList.do";

    ldr.onSuccess = function(gr, fg)
    {
        btn_update.disabled = (fg.Rows <= fg.FixedRows);
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

//업로드
function fnUpload()
{
    var win = new any.window();
    win.path = "SystemUpdateFileUploadC.jsp";
    win.opt.width = 700;
    win.opt.height = 140;

    win.onReload = function()
    {
        gr_updateFileList.loader.reload();
    }

    win.show();
}

//업데이트
function fnUpdate()
{
    var win = new any.window();
    win.path = "SystemUpdateU.jsp";
    win.opt.width = 700;
    win.opt.height = 400;

    win.onReload = function()
    {
        gr_updateFileList.loader.reload();
    }

    win.show();
}

//상세
function fnDetail(gr, fg, row, colId)
{
    var win = new any.window();
    win.path = "SystemUpdateFileRD.jsp";
    win.arg.FILE_NAME = gr.value(row, "FILE_NAME");
    win.opt.width = 600;
    win.opt.height = 160;

    win.onReload = function()
    {
        gr_updateFileList.loader.reload();
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
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD><SPAN id="spn_gridMessage"></SPAN></TD>
                    <TD align="right">
                        <BUTTON auto="retrieve" onClick="javascript:fnRetrieve();"></BUTTON>
                        <BUTTON auto="line"></BUTTON>
                        <BUTTON text="업로드" onClick="javascript:fnUpload();"></BUTTON>
                        <BUTTON text="업데이트" onClick="javascript:fnUpdate();" id="btn_update" disabled></BUTTON>
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
            <ANY:GRID id="gr_updateFileList" pagingType="0"><COMMENT>
                addColumn({ width:50 , align:"center", type:"number", sort:false, id:"ROW_NUM"          , name:"<%= app.message.get("lbl.com.no").toJS() %>" });
                addColumn({ width:200, align:"left"  , type:"string", sort:false, id:"FILE_NAME"        , name:"파일이름" });
                addColumn({ width:80 , align:"center", type:"string", sort:false, id:"FILE_TYPE"        , name:"파일형태" });
                addColumn({ width:110, align:"right" , type:"number", sort:false, id:"FILE_SIZE"        , name:"파일크기(Byte)", format:"#,###" });
                addColumn({ width:130, align:"center", type:"string", sort:false, id:"FILE_DATETIME"    , name:"파일날짜" });
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_NUM", "FILE_NAME");
                addSorting("FILE_NAME", "ASC");
                addAction("FILE_NAME", fnDetail);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
