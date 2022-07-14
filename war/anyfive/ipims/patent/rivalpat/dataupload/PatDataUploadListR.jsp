<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>자사Data업로드</TITLE>
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
    var ldr = gr_dataUploadList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.rivalpat.dataupload.act.PatDataUploadList.do";
    ldr.addParam("PAT_APP_NO", PAT_APP_NO.value);
    ldr.addParam("KO_APP_TITLE", KO_APP_TITLE.value);
    ldr.addParam("IPC_CLS_CODE", IPC_CLS_CODE.value);


    ldr.onSuccess = function(gr, fg)
    {
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

//엑셀 Import
function fnImportExcel()
{
    var ldr = new any.excelImporter();
    ldr.templateFile = "/excel/PatantList.xls";
    ldr.saveAction = top.getRoot() + "/anyfive.ipims.patent.rivalpat.dataupload.act.UploadInExcel.do";
    if (ldr.execute() == "OK") {
        fnRetrieve();
    }
}

// PAT_APP_NO kiplus 연동
function fnPatAppno(gr, fg, row, colId)
{
    var addr = gr.value(row,"PAT_APP_NO");
    window.open("http://192.168.1.17:8081/fullText.do?execute=fullTextCheckPT&applno="+addr+"" );
}

// 마스터 연동
function fnTitle(gr, fg, row, colId)
{
    var win = new any.window();
    win.path = top.getRoot() + "/anyfive/ipims/patent/applymgt/intpatent/master/IntPatentMasterRD.jsp";
    win.arg.REF_ID = gr.value(row, "REF_ID");
    win.opt.width = 850;
    win.opt.height = 700;
    win.opt.resizable = "yes";

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
            <TABLE border="0" width="100%" cellspacing="1" cellpadding="2" class="main" width="100%" onEnter="javascript:fnRetrieve();">
                <COLGROUP>
                    <COL class="condhead" width="13%">
                    <COL class="conddata" width="20%">
                    <COL class="condhead" width="13%">
                    <COL class="conddata" width="20%">
                    <COL class="condhead" width="13%">
                    <COL class="conddata" width="20%">
                </COLGROUP>
                <TR>
                    <TD>출원번호</TD>
                    <TD><INPUT type="text" id="PAT_APP_NO"></TD>
                    <TD>명칭</TD>
                    <TD><INPUT type="text" id="KO_APP_TITLE"></TD>
                    <TD>IPC분류코드</TD>
                    <TD><INPUT type="text" id="IPC_CLS_CODE"></TD>
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
            <ANY:GRID id="gr_dataUploadList" pagingType="1"><COMMENT>
                addColumn({ width:50 , align:"center", type:"number", sort:false, id:"ROW_NUM"                  , name:"<%= app.message.get("lbl.com.no").toJS() %>" });
                addColumn({ width:140, align:"left"  , type:"string", sort:true , id:"PAT_APP_NO"               , name:"출원번호" });
                addColumn({ width:200, align:"left"  , type:"string", sort:true , id:"KO_APP_TITLE"             , name:"명 칭" });
                addColumn({ width:180, align:"left"  , type:"string", sort:true , id:"IPC_CLS_CODE"             , name:"IPC분류코드" });
                addColumn({ width:180, align:"left"  , type:"string", sort:true , id:"REF_ID"                   , name:"REF_ID" , hide:true });
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_NUM", "WIPS_KEY");
                addAction("PAT_APP_NO", fnPatAppno);
                addAction("KO_APP_TITLE",fnTitle);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
