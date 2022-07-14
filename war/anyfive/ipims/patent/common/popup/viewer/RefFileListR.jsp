<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>관련파일 목록</TITLE>
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
    var ldr = gr_refFileList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.common.popup.viewer.act.RetrieveRefFileList.do";
    ldr.addParam("REF_ID", parent.REF_ID);

    ldr.onSuccess = function(gr, fg)
    {
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

//다운로드
function fnDownload()
{
    var gr = gr_refFileList;

    if (gr.fg.Row < gr.fg.FixedRows) {
        alert("다운로드할 파일을 선택하세요.");
        return;
    }

    cfFileDownload(gr.value(gr.fg.Row, "DOWNLOAD_KEY"));
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
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD height="5"></TD>
    </TR>
    <TR>
        <TD height="100%">
            <ANY:GRID id="gr_refFileList" pagingType="0"><COMMENT>
                fg.SelectionMode = 1;
                fg.AllowSelection = false;
                addColumn({ width:40 , align:"center", type:"number" , sort:false, id:"ROW_NUM"         , name:"No" });
                addColumn({ width:250, align:"left"  , type:"string" , sort:true , id:"FILE_NAME_ORG"   , name:"파일명" });
                addColumn({ width:200, align:"left"  , type:"string" , sort:true , id:"FILE_KIND"       , name:"관련파일종류" });
                addColumn({ width:75 , align:"center", type:"date"   , sort:true , id:"CRE_DATE"        , name:"첨부일자" });
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_NUM", "FILE_NAME_ORG");
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
    <TR>
        <TD height="5"></TD>
    </TR>
    <TR>
        <TD align="right">
            <BUTTON text="다운로드" onClick="javascript:fnDownload();"></BUTTON>
            <BUTTON auto="line"></BUTTON>
            <BUTTON auto="close" id="btn_close"></BUTTON>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
