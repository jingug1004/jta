<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>DUE-DATE</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    cfSetPageTitle("DUE-DATE (" + cfGetFormatDate(parent.DUE_DATE) + ")");

    fnRetrieve();
}

//조회
function fnRetrieve()
{
    var ldr = gr_bizFlowList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.home.act.RetrieveDueDateList.do";
    ldr.addParam("DUE_DATE", parent.DUE_DATE);

    ldr.onSuccess = function(gr, fg)
    {
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

//상세
function fnDetail(gr, fg, row, colId)
{
    parent.opener.window.open(top.getRoot() + "/anyfive/ipims/patent/applymgt/common/MasterView.jsp?ID=" + gr.value(row, "REF_ID") + "&TAB=paper", "_blank", "width=1000,height=800,resizable=yes");
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
            <ANY:GRID id="gr_bizFlowList" pagingType="1"><COMMENT>
                addColumn({ width:40 , align:"center", type:"number", sort:false, id:"ROW_NUM"          , name:"No" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"REF_NO"           , name:"REF-NO" });
                addColumn({ width:70 , align:"center", type:"string", sort:true , id:"RIGHT_DIV_NAME"   , name:"권리구분" });
                addColumn({ width:150, align:"left"  , type:"string", sort:true , id:"PAPER_NAME"       , name:"진행서류명" });
                addColumn({ width:200, align:"left"  , type:"string", sort:true , id:"KO_APP_TITLE"     , name:"발명의 명칭" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"DUE_DATE"         , name:"DUE-DATE" });
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_NUM", "REF_NO");
                addAction("PAPER_NAME", fnDetail);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
    <TR>
        <TD height="5"></TD>
    </TR>
    <TR>
        <TD align="right">
            <BUTTON auto="close"></BUTTON>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
