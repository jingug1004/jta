<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>To Do List - 신규접수</TITLE>
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
    var ldr = gr_toDoEvalList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.home.act.RetrieveToDoNewList.do";

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
    var win = new any.window();
    if(gr.value(row, "RIGHT_DIV") == "10" || gr.value(row, "RIGHT_DIV") == "20"){
        if(gr.value(row, "REF_NO").substr(0,1) == "S"){
            win.path = top.getRoot() + "/anyfive/ipims/patent/applymgt/priorsearch/request/PriorSearchRequestRD.jsp";
        }else{
            win.path = top.getRoot() + "/anyfive/ipims/patent/applymgt/intpatent/request/IntPatentRequestRD.jsp";
        }
    }else if(gr.value(row, "RIGHT_DIV") == "30"){
        if(gr.value(row, "REF_NO").substr(0,1) == "S"){
            win.path = top.getRoot() + "/anyfive/ipims/patent/applymgt/priorsearch/request/PriorSearchRequestRD.jsp";
        }else{
            win.path = top.getRoot() + "/anyfive/ipims/patent/applymgt/design/intrequest/DesignIntRequestRD.jsp";
        }
    }else if(gr.value(row, "RIGHT_DIV") == "40"){
        if(gr.value(row, "REF_NO").substr(0,1) == "S"){
            win.path = top.getRoot() + "/anyfive/ipims/patent/applymgt/priorsearch/request/PriorSearchRequestRD.jsp";
        }else{
            win.path = top.getRoot() + "/anyfive/ipims/patent/applymgt/tmark/intrequest/TMarkIntRequestRD.jsp";
        }
    }

    if(gr.value(row, "REF_NO").substr(0,1) == "S"){
        win.arg.PRSCH_ID = gr.value(row, "REF_ID");
    }else{
        win.arg.REF_ID = gr.value(row, "REF_ID");
    }
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
            <ANY:GRID id="gr_toDoEvalList" pagingType="1"><COMMENT>
                addColumn({ width:40 , align:"center", type:"number", sort:false, id:"ROW_NUM"                  , name:"No" });
                addColumn({ width:110, align:"left"  , type:"string", sort:true , id:"REF_NO"                   , name:"REF_NO" });
                addColumn({ width:200, align:"left"  , type:"string", sort:true , id:"KO_APP_TITLE"             , name:"발명의 명칭" });
                addColumn({ width:110, align:"left"  , type:"string", sort:true , id:"INVENTOR_NAMES"           , name:"발명자" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"CRE_DATE"                 , name:"작성일" });
                addColumn({ width:75 , align:"center", type:"string", sort:true , id:"CRE_USER_NAME"            , name:"작성자" });
                addColumn({ width:110, align:"left"  , type:"string", sort:true , id:"STATUS_NAME"              , name:"진행상태" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"PATTEAM_RCPT_DATE"        , name:"지적재산팀접수일" });
                addColumn({ width:110, align:"left"  , type:"string", sort:true , id:"EXAM_RESULT_NAME"         , name:"검토결과" });
                addColumn({ width:75 , align:"center", type:"string", sort:true , id:"JOB_MAN_NAME"             , name:"지적재산팀담당자" });
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_NUM", "KO_APP_TITLE");
                addSorting("REF_NO", "DESC");
                addAction("KO_APP_TITLE", fnDetail);
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
