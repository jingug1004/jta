<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>To Do List - 평가</TITLE>
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
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.home.act.RetrieveToDoEvalList.do";

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
    win.path = top.getRoot() + gr.value(row, "EVAL_VIEW_PATH");
    win.arg.REF_ID = gr.value(row, "REF_ID");
    win.arg.LIST_SEQ = gr.value(row, "PAPER_LIST_SEQ");
    win.arg.PAY_YEARDEG = gr.value(row, "PAPER_LIST_SEQ");
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
                addColumn({ width:120, align:"left"  , type:"string", sort:true , id:"REF_NO"                   , name:"REF-NO" });
                addColumn({ width:200, align:"left"  , type:"string", sort:true , id:"KO_APP_TITLE"             , name:"발명의 명칭" });
                addColumn({ width:120, align:"left"  , type:"string", sort:true , id:"EVAL_TITLE"               , name:"평가명칭" });
                addColumn({ width:70 , align:"center", type:"string", sort:true , id:"JOB_MAN_NAME"             , name:"건담당자" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"INVDEPT_EVAL_USER_NAME"   , name:"발명부서 평가자" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"INVDEPT_EVAL_DATE"        , name:"발명부서 평가일" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"PATDEPT_EVAL_USER_NAME"   , name:"특허부서 평가자" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"PATDEPT_EVAL_DATE"        , name:"특허부서 평가일" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"STATUS_NAME"              , name:"진행상태" });
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_NUM", "REF_NO");
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
