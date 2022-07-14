<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>전체통계현황</TITLE>
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
    var ldr = gr_allStatisticList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.statistic.statistic.act.RetrieveAllStatisticCount.do";
    ldr.addParam("DATE_START", DATE_START.value);
    ldr.addParam("DATE_END", DATE_END.value);

    ldr.onSuccess = function(gr, fg)
    {
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
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
                    <COL class="conddata" width="85%">
                </COLGROUP>
                <TR>
                    <TD>검색일자</TD>
                    <TD noWrap>
                        <ANY:DATE id="DATE_START" />&nbsp;~
                        <ANY:DATE id="DATE_END" />
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
            <ANY:GRID id="gr_allStatisticList" pagingType="0"><COMMENT>
                addColumn({ width:90 , align:"center", type:"string", sort:false, id:"DIV_NAME"             , name:"구분" });
                addColumn({ width:85 , align:"right" , type:"number", sort:false, id:"INT_PAT_CNT"          , name:"국내특허", format:"#,###" });
                addColumn({ width:85 , align:"right" , type:"number", sort:false, id:"EXT_PAT_CNT"          , name:"해외특허", format:"#,###" });
                addColumn({ width:85 , align:"right" , type:"number", sort:false, id:"INT_UTIL_CNT"         , name:"국내실용신안", format:"#,###" });
                addColumn({ width:85 , align:"right" , type:"number", sort:false, id:"EXT_UTIL_CNT"         , name:"해외실용신안", format:"#,###" });
                addColumn({ width:85 , align:"right" , type:"number", sort:false, id:"INT_DESIGN_CNT"       , name:"국내디자인", format:"#,###" });
                addColumn({ width:85 , align:"right" , type:"number", sort:false, id:"EXT_DESIGN_CNT"       , name:"해외디자인", format:"#,###" });
                addColumn({ width:85 , align:"right" , type:"number", sort:false, id:"INT_TMARK_CNT"        , name:"국내상표", format:"#,###" });
                addColumn({ width:85 , align:"right" , type:"number", sort:false, id:"EXT_TMARK_CNT"        , name:"해외상표", format:"#,###" });
                messageSpan = "spn_gridMessage";
                setFixedColumn(null, "DIV_NAME");

             </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
