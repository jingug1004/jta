<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>업무단계 관리</TITLE>
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
    var ldr = gr_workStepMgtList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.workprocess.workstep.act.RetrieveWorkStepMgtList.do";
    ldr.addParam("BIZ_MGT_ID", BIZ_MGT_ID.value);
    ldr.addParam("BIZ_STEP_NAME", BIZ_STEP_NAME.value);

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
    var win = new any.viewer();
    win.path = "WorkStepMgtC.jsp";

    win.onReload = function()
    {
        gr_workStepMgtList.loader.reload();
    }

    win.show();
}

//수정
function fnModify(gr, fg, row, colId)
{
    var win = new any.viewer();
    win.path = "WorkStepMgtUD.jsp";
    win.arg.BIZ_STEP_ID = gr.value(row, "BIZ_STEP_ID");

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
                    <COL class="conddata" width="35%">
                    <COL class="condhead" width="15%">
                    <COL class="conddata" width="35%">
                </COLGROUP>
                <TR>
                    <TD>업무</TD>
                    <TD>
                        <ANY:SELECT id="BIZ_MGT_ID" codeData="/systemmgt/workMst" firstName="all" />
                    </TD>
                    <TD>업무단계 이름</TD>
                    <TD>
                        <INPUT type="text" id="BIZ_STEP_NAME">
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
            <ANY:GRID id="gr_workStepMgtList" pagingType="1"><COMMENT>
                addColumn({ width:50 , align:"center", type:"number" , sort:false, id:"ROW_NUM"         , name:"No" });
                addColumn({ width:120, align:"left"  , type:"string" , sort:true , id:"BIZ_MGT_NAME"    , name:"업무 이름" });
                addColumn({ width:100, align:"center", type:"string" , sort:true , id:"BIZ_STEP_ID"     , name:"업무단계 ID" });
                addColumn({ width:150, align:"left"  , type:"string" , sort:true , id:"BIZ_STEP_NAME"   , name:"업무단계 이름" });
                addColumn({ width:60 , align:"center", type:"string" , sort:true , id:"APPR_CODE"       , name:"결재코드" });
                addColumn({ width:80 , align:"center", type:"number" , sort:true , id:"BIZ_PROC_CNT"    , name:"프로세스 수" });
                addColumn({ width:250, align:"left"  , type:"string" , sort:true , id:"BIZ_VIEW_PATH"   , name:"업무화면 경로" });
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_NUM", "BIZ_STEP_ID");
                addSorting("BIZ_STEP_ID", "ASC");
                addAction("BIZ_STEP_ID", fnModify);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
