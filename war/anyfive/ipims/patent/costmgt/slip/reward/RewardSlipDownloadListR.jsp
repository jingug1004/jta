<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<%@page import="any.util.etc.NDateUtil"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>보상금전표 다운로드</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<ANY:DS id="ds_costSlipList" />
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();
}

//목록 조회
function fnRetrieve()
{
    var ldr = gr_slipProcDownloadList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.costmgt.slip.reward.act.RetrieveRewardSlipDownloadList.do";
    ldr.addParam("SLIP_ID", parent.SLIP_ID);

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
    gr_slipProcDownloadList.loader.download();
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
                        <BUTTON text="다운로드" onClick="javascript:fnDownload();"></BUTTON>
                        <BUTTON auto="line"></BUTTON>
                        <BUTTON auto="list"></BUTTON>
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
            <ANY:GRID id="gr_slipProcDownloadList" pagingType="0"><COMMENT>
                addHeader([ "구분", "", "Document Header", "", "", "", "", "", "Document Line Item", "", "", "", "", "", "", "", "", "", "" ]);
                addColumn({ width:60 , align:"center", type:"center" , sort:false , id:"HEADER_DIV"     , name:"H/D" });
                addColumn({ width:60 , align:"center", type:"center" , sort:false , id:"LINE"           , name:"LINE" });
                addColumn({ width:75 , align:"center", type:"string" , sort:false , id:"DOC_DATE"       , name:"Doc.date" });
                addColumn({ width:60 , align:"center", type:"string" , sort:false , id:"DOC_TYPE"       , name:"Doc.type" });
                addColumn({ width:75 , align:"center", type:"string" , sort:false , id:"POSTING_DATE"   , name:"Posting Date" });
                addColumn({ width:60 , align:"center", type:"string" , sort:false , id:"CURRENCY"       , name:"Currency" });
                addColumn({ width:100, align:"left"  , type:"string" , sort:false , id:"REFERENCE"      , name:"Reference" });
                addColumn({ width:120, align:"left"  , type:"string" , sort:false , id:"HEADER_TEXT"    , name:"Header Text" });
                addColumn({ width:60 , align:"right" , type:"string" , sort:false , id:"POSTING_KEY"    , name:"Posting Key" });
                addColumn({ width:80 , align:"left"  , type:"string" , sort:false , id:"ACCOUNT"        , name:"Account" });
                addColumn({ width:60 , align:"center", type:"string" , sort:false , id:"SPECIAL_GL"     , name:"Special G/L" });
                addColumn({ width:80 , align:"right" , type:"number" , sort:false , id:"AMOUNT"         , name:"Amount" });
                addColumn({ width:60 , align:"center", type:"string" , sort:false , id:"TAX_CODE"       , name:"Tax code" });
                addColumn({ width:60 , align:"center", type:"string" , sort:false , id:"BUSINESS_PLACE" , name:"Business Place" });
                addColumn({ width:100, align:"left"  , type:"string" , sort:false , id:"ASSIGNMENT"     , name:"Assignment" });
                addColumn({ width:150, align:"left"  , type:"string" , sort:false , id:"TEXT"           , name:"Text" });
                addColumn({ width:75 , align:"center", type:"string" , sort:false , id:"DUE_ON_DATE"    , name:"Due on Date" });
                addColumn({ width:100, align:"center", type:"string" , sort:false , id:"COST_CENTER"    , name:"Cost Center" });
                addColumn({ width:80 , align:"center", type:"string" , sort:false , id:"ORDER"          , name:"Order" });
                messageSpan = "spn_gridMessage";

            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>
<% app.writeBodyFooter(); %>

</BODY>
</HTML>
