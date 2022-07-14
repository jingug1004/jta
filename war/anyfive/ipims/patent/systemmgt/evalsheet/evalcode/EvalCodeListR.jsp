<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>평가코드 목록</TITLE>
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
    var ldr = gr_evalCodeList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.evalsheet.evalcode.act.RetrieveEvalCodeMgtList.do";
    ldr.addParam("EVAL_TITLE", EVAL_TITLE.value);

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
    var win = new any.window();
    win.path = "EvalCodeC.jsp";
    win.opt.width = 600;
    win.opt.height = 220;

    win.onReload = function()
    {
        gr_evalCodeList.loader.reload();
    }

    win.show();
}

//상세
function fnDetail(gr, fg, row, colId)
{
    var win = new any.window();
    win.path = "EvalCodeUD.jsp";
    win.arg.EVAL_CODE = gr.value(row, "EVAL_CODE");
    win.opt.width = 600;
    win.opt.height = 220;

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
                    <COL class="condhead" width="15%">
                    <COL class="conddata" width="85%">
                </COLGROUP>
                <TR>
                    <TD>평가 명칭</TD>
                    <TD>
                        <INPUT type="text" id="EVAL_TITLE">
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
                        <BUTTON text="작성" onClick="javascript:fnCreate();"></BUTTON>
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
            <ANY:GRID id="gr_evalCodeList" pagingType="1"><COMMENT>
                addColumn({ width:50 , align:"center", type:"number" , sort:false, id:"ROW_NUM"                 , name:"No" });
                addColumn({ width:70 , align:"center", type:"string" , sort:true , id:"EVAL_CODE"               , name:"평가코드" });
                addColumn({ width:150, align:"left"  , type:"string" , sort:true , id:"EVAL_TITLE"              , name:"평가 명칭" });
                addColumn({ width:170, align:"left"  , type:"string" , sort:true , id:"INVDEPT_EVAL_SHEET_NAME" , name:"발명부서 평가서" });
                addColumn({ width:170, align:"left"  , type:"string" , sort:true , id:"PATDEPT_EVAL_SHEET_NAME" , name:"특허부서 평가서" });
                addColumn({ width:200, align:"left"  , type:"string" , sort:true , id:"EVAL_VIEW_PATH"          , name:"평가 화면" });
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_NUM", "EVAL_TITLE");
                addSorting("EVAL_CODE", "ASC");
                addAction("EVAL_TITLE", fnDetail);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
