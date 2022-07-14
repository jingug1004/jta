<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<%@page import="any.util.etc.NDateUtil"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>연구소별 실적통계</TITLE>
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
    var ldr = gr_actualByLabList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.statistic.statistic.act.RetrieveActualByLabList.do";
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

//작성
function fnCreate()
{
}

//상세
function fnDetail(gr, fg, row, colId)
{
    var win = new any.window();
    win.path = "ActualByLabList.jsp";
    win.arg.DATE_START   = DATE_START.value;
    win.arg.DATE_END     = DATE_END.value;
    win.arg.SEARCH_GUBUN = colId.substring(4,7);
    win.arg.INOUT_DIV    = colId.substring(0,3);
    win.arg.LAB_CODE     = gr.value(row,"LAB_CODE");

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
                    <COL class="condhead" width="20%">
                    <COL class="conddata" width="80%">
                </COLGROUP>
                <TR>
                    <TD>검색일</TD>
                    <TD colspan="3" noWrap>
                        <ANY:DATE id="DATE_START" value="<%= NDateUtil.getSysDate().substring(0,4) %>0101" />&nbsp;~
                        <ANY:DATE id="DATE_END" value="<%= NDateUtil.getSysDate() %>" />
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
            <ANY:GRID id="gr_actualByLabList" pagingType="1"><COMMENT>
                addHeader(["연구소", "국내", "", "", "해외", "" ]);
                addColumn({ width:150, align:"left"  , type:"string" , sort:true , id:"LAB_NAME"    , name:"연구소" });
                addColumn({ width:80 , align:"right" , type:"string" , sort:true , id:"INT_CRE_CNT" , name:"제안건" });
                addColumn({ width:80 , align:"right" , type:"string" , sort:true , id:"INT_APP_CNT" , name:"출원건" });
                addColumn({ width:80 , align:"right" , type:"string" , sort:true , id:"INT_REG_CNT" , name:"등록건" });
                addColumn({ width:80 , align:"right" , type:"string" , sort:true , id:"EXT_APP_CNT" , name:"출원건" });
                addColumn({ width:80 , align:"right" , type:"string" , sort:true , id:"EXT_REG_CNT" , name:"등록건" });
                messageSpan = "spn_gridMessage";

                addAction("INT_CRE_CNT", fnDetail);
                addAction("INT_APP_CNT", fnDetail);
                addAction("INT_REG_CNT", fnDetail);
                addAction("EXT_APP_CNT", fnDetail);
                addAction("EXT_REG_CNT", fnDetail);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
