<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>등급정보</TITLE>
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
    var ldr = gr_inventorList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.common.popup.viewer.act.RetrieveLevelList.do";
    ldr.addParam("EVAL_GRADE", parent.EVAL_GRADE);

    ldr.onSuccess = function(gr, fg)
    {
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

function fnAppNo(gr, fg, row, colId)
{
    var addr = gr.value(row,"APP_NO");
    window.open("http://192.168.1.17:8081/fullText.do?execute=fullTextCheckPT&applno="+addr+"" );
}

function fnDetail(gr, fg, row, colId)
{
    var win = new any.window();
    win.path = top.getRoot() + "/anyfive/ipims/patent/rivalpat/evalmaster/RivalPatEvalMasterRD.jsp";
    win.arg.MGT_ID = gr.value(row, "MGT_ID");
    win.opt.width = 850;
    win.opt.height = 700;
    win.opt.resizable = "yes";
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
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD height="5"></TD>
    </TR>
    <TR>
        <TD height="100%">
            <ANY:GRID id="gr_inventorList" pagingType="0"><COMMENT>
                addColumn({ width:50 , align:"center", type:"number", sort:false, id:"ROW_NUM"          , name:"<%= app.message.get("lbl.com.no").toJS() %>" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"APP_NO"           , name:"출원번호"});
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"APP_DATE"         , name:"출원일"});
                addColumn({ width:150, align:"left"  , type:"string", sort:true , id:"TITLE"            , name:"발명의 명칭"});
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"INVENTOR"         , name:"발명자" });
                addColumn({ width:90 , align:"left"  , type:"string", sort:true , id:"APP_MAN"          , name:"출원인" });
                addColumn({ width:130, align:"left"  , type:"string", sort:true , id:"WIPS_KEY"         , name:"WIPS키"  , hide:true });
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"TECH_NAMES"       , name:"기술분류" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"IPC_NAMES"       , name:"IPC분류" });
                addColumn({ width:90 , align:"left"  , type:"string", sort:true , id:"OWN_APP_MAN"      , name:"대표출원인" });
                addColumn({ width:50 , align:"center", type:"string", sort:true , id:"COUNTRY_CODE"     , name:"국가" });
                addColumn({ width:70 , align:"center", type:"string", sort:true , id:"PAT_DIV"          , name:"특/실구분" });
                addColumn({ width:70 , align:"center", type:"string", sort:true , id:"EVAL_GRADE"       , name:"평가등급" });
                useConfig = true;
                messageSpan = "spn_gridMessage";
                addAction("APP_NO",fnAppNo);
                addAction("TITLE", fnDetail);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
    <TR>
        <TD height="5"></TD>
    </TR>
    <TR>
        <TD align="right">
            <BUTTON auto="close" id="btn_close"></BUTTON>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
