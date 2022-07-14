<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<%@page import="any.core.config.NConfig"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>KIPRIS DB 검색</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
}

//검색
function fnSearch()
{
    if (QUERY.value == "") {
        alert("검색식을 입력하세요.");
        QUERY.focus();
        return;
    }

    var ldr = gr_searchList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.search.outsearch.act.RetrieveKiprisSearchList.do";
    ldr.addParam("QUERY", QUERY.value);

    ldr.onSuccess = function(gr, fg)
    {
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

//대표도면 일괄보기
function fnRImageView()
{
    var gr = gr_searchList;
    var anList = [];

    for (var i = gr.fg.FixedRows; i < gr.fg.Rows; i++) {
        if (gr.checked(i, "ROW_CHK") != true) continue;
        anList.push(gr.value(i, "AN"));
    }

    if (anList.length == 0) {
        alert("선택된 건이 없습니다.");
        return;
    }

    var win = new any.window(2);
    win.path = "RImgViewR.jsp";
    win.arg.anList = anList;
    win.opt.resizable = "yes";
    win.show();
}

//상세
function fnGoView(gr, fg, row, colId)
{
    window.open("<%= NConfig.getString("/config/kipris/fulldoc-url") %>?APPLNO=" + gr.value(row, "AN"));
}

//상세
function fnKiprisTemp()
{
  window.open('<%= request.getContextPath() %>/anyfive/ipims/patent/image/kipris.jpg','','menu=no,status=no,width=1000,height=700');
}
</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
    <TR>
        <TD>
            <TABLE border="0" cellspacing="1" cellpadding="2" class="main" onEnter="javascript:fnSearch();">
                <COLGROUP>
                    <COL class="condhead" width="15%">
                    <COL class="conddata" width="85%">
                </COLGROUP>
                <TR>
                    <TD>검색식</TD>
                    <TD>
                        <INPUT type="text" id="QUERY">
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
                        <a href="#" onclick="javascript:fnKiprisTemp();">검색식 예제보기</a>
                        <BUTTON auto="search" onClick="javascript:fnSearch();"></BUTTON>
                        <BUTTON auto="line"></BUTTON>
                        <BUTTON text="대표도면 일괄보기" onClick="javascript:fnRImageView();"></BUTTON>
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
            <ANY:GRID id="gr_searchList" pagingType="2"><COMMENT>
                addColumn({ width:50 , align:"center", type:"number", sort:false, id:"NO"           , name:"No" });
                addColumn({ width:30 , align:"center", type:"check" , sort:false, id:"ROW_CHK" });
                addColumn({ width:110, align:"center", type:"string", sort:false, id:"AN"           , name:"출원번호" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:false, id:"AD"           , name:"출원일" });
                addColumn({ width:300, align:"left"  , type:"string", sort:false, id:"TL"           , name:"발명의 명칭" });
                messageSpan = "spn_gridMessage";
                setFixedColumn("NO", "AN");
                addAction("AN", fnGoView);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
