<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>IPC분류코드 관리</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<% app.writeHTCImport(app.HTC_TREE); %>
<ANY:DS id="ds_menuCodeList" />
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieveTechTree();
}

//IPC코드 트리 조회
function fnRetrieveTechTree()
{
    var ldr = gr_ipcCodeTree.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.basecode.ipccode.act.RetrieveIpcCodeTree.do";

    ldr.onSuccess = function(gr, fg)
    {
        if (gr_ipcCodeList.loader.executed == true) {
            gr_ipcCodeList.loader.reload();
        } else {
            fnRetrieveIpcList(gr.value(fg.Row, "IPC_CODE"));
        }
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

//기술코드 목록 조회
function fnRetrieveIpcList(priorCode)
{
    var ldr = gr_ipcCodeList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.basecode.ipccode.act.RetrieveIpcCodeList.do";
    ldr.addParam("PRIOR_IPC_CODE", priorCode);

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
    win.path = "IpcCodeMgtC.jsp";
    win.arg.PRIOR_IPC_CODE = gr_ipcCodeTree.value(gr_ipcCodeTree.fg.Row, "IPC_CODE");
    win.arg.PRIOR_IPC_CODE_NAME = gr_ipcCodeTree.value(gr_ipcCodeTree.fg.Row, "IPC_HNAME");
    win.opt.width = 600;
    win.opt.height = 400;

    win.onReload = function()
    {
        gr_ipcCodeTree.loader.reload();
    }

    win.show();
}

//상세 팝업
function fnOpenView(gr, fg, row, colId)
{
    var win = new any.window();
    win.path = "IpcCodeMgtUD.jsp";
    win.arg.IPC_CODE = gr.value(row, "IPC_CODE");

    win.opt.width = 600;
    win.opt.height = 400;

    win.onReload = function()
    {
        gr_ipcCodeTree.loader.reload();
    }

    win.show();
}

</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
    <COLGROUP>
        <COL width="30%">
        <COL style="padding-left:10px;">
    </COLGROUP>
    <TR height="1">
        <TD colspan="2">
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD><SPAN id="spn_gridMessage"></SPAN></TD>
                    <TD align="right">
                        <BUTTON text="작성" onClick="javascript:fnOpenCreate();"></BUTTON>
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD height="5" colspan="2"></TD>
    </TR>
    <TR>
        <TD>
            <ANY:TREE id="gr_ipcCodeTree"><COMMENT>
                parentColumn = "PRIOR_IPC_CODE";
                codeColumn   = "IPC_CODE";
                nameColumn   = "IPC_HNAME";
                expandLevel  = 1;

                addRoot(null, "ROOT", "iPIMS");

                fg.attachEvent("AfterRowColChange", function(iOldRow, iOldCol, iNewRow, iNewCol)
                {
                    if (element.loader.loading == true) return;

                    fnRetrieveIpcList(element.value(iNewRow, "IPC_CODE"));
                });
            </COMMENT></ANY:TREE>
        </TD>
        <TD>
            <ANY:GRID id="gr_ipcCodeList" pagingType="0"><COMMENT>
                fg.SelectionMode = 3;
                addColumn({ width:75 , align:"center", type:"string" , sort:false, id:"IPC_CODE"         , name:"IPC코드" });
                addColumn({ width:150, align:"left"  , type:"string" , sort:false, id:"IPC_HNAME"        , name:"IPC코드명" });
                addColumn({ width:75 , align:"left"  , type:"string" , sort:false, id:"PRIOR_IPC_CODE"   , name:"상위코드" });
                addColumn({ width:75 , align:"center", type:"number" , sort:false, id:"IPC_LEVEL"        , name:"코드레벨" });
                addColumn({ width:75 , align:"center", type:"string" , sort:false, id:"USE_YN_NAME"       , name:"사용여부" });
                messageSpan = "spn_gridMessage";
                addAction("IPC_HNAME", fnOpenView);

            </COMMENT></ANY:GRID>
        </TD>
    </TR>
    <TR>
        <TD height="5" colspan="2"></TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
