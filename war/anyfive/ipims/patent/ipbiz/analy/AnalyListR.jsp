<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>OFFENSE 현황</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<%
   String analyDiv = request.getParameter("analyDiv");
%>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();
    if("<%=analyDiv%>" == "O"){
        cfSetPageTitle("OFFENSE 현황");
    } else {
        cfSetPageTitle("DEFENSE 현황");
    }
}

//목록 조회
function fnRetrieve()
{
    var ldr = gr_analyList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.ipbiz.analy.act.RetrieveAnalyList.do";
    ldr.addParam("ANALY_DIV"   , "<%=analyDiv%>");
    ldr.addParam("MGT_NO"      , MGT_NO.value);
    ldr.addParam("ANALY_NAME"  , ANALY_NAME.value);
    ldr.addParam("COMPETITOR"  , COMPETITOR.value);
    ldr.addParam("DATE_START"  , DATE_START.value);
    ldr.addParam("DATE_END"    , DATE_END.value);

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
function fnOpenCreate()
{
    var win = new any.viewer();
    if("<%=analyDiv%>" == "O"){
        win.path = "AnalyOffenseC.jsp";
    } else {
        win.path = "AnalyDefenseC.jsp";
    }

    win.onReload = function()
    {
        gr_analyList.loader.reload();
    }

    win.show();
}

//상세
function fnDetail(gr, fg, row, colId)
{
    var win = new any.viewer();
    if("<%=analyDiv%>" == "O"){
        win.path = "AnalyOffenseRD.jsp";
    } else {
        win.path = "AnalyDefenseRD.jsp";
    }
    win.arg.ANALY_ID = gr.value(row, "ANALY_ID");

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
                    <COL class="condhead" width="15%">
                    <COL class="conddata" width="35%">
                    <COL class="condhead" width="15%">
                    <COL class="conddata" width="35%">
                </COLGROUP>
                <TR>
                    <TD>관리번호</TD>
                    <TD>
                        <INPUT type="text" id="MGT_NO" />
                    </TD>
                    <TD>분쟁제목</TD>
                    <TD>
                        <INPUT type="text" id="ANALY_NAME" />
                    </TD>
                </TR>
                <TR>
                    <TD>작성일</TD>
                    <TD noWrap>
                        <ANY:DATE id="DATE_START" />&nbsp;~
                        <ANY:DATE id="DATE_END" />
                    </TD>
                    <TD>관련업체</TD>
                    <TD>
                        <INPUT type="text" id="COMPETITOR" />
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
            <ANY:GRID id="gr_analyList" pagingType="1"><COMMENT>
                addColumn({ width:50 , align:"center", type:"number" , sort:false, id:"ROW_NUM"       , name:"<%= app.message.get("lbl.com.no").toJS() %>" });
                addColumn({ width:120, align:"left"  , type:"string" , sort:true , id:"MGT_NO"        , name:"관리번호" });
                addColumn({ width:180, align:"left"  , type:"string" , sort:true , id:"ANALY_NAME"    , name:"분석자료명" });
                addColumn({ width:120, align:"left"  , type:"string" , sort:true , id:"COMPETITOR"    , name:"관련업체" });
                addColumn({ width:80 , align:"center", type:"string" , sort:true , id:"RESULT_NAME"   , name:"대상구분" });
                addColumn({ width:80 , align:"center", type:"string" , sort:true , id:"STATUS_NAME"   , name:"상태" });
                addColumn({ width:90 , align:"center", type:"string" , sort:true , id:"CRE_USER_NAME" , name:"작성자" });
                addColumn({ width:75 , align:"center", type:"date"   , sort:true , id:"CRE_DATE"      , name:"작성일" });
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_NUM", "MGT_NO");
                addSorting("MGT_NO", "DESC");
                addAction("MGT_NO", fnDetail);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
