<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>기술코드 관리</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<% app.writeHTCImport(app.HTC_TREE); %>
<ANY:DS id="ds_menuCodeList" />
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieveTechTree();
}

//기술코드 트리 조회
function fnRetrieveTechTree()
{
    var ldr = gr_techCodeTree.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.basecode.techcode.act.RetrieveTechCodeTree.do";

    ldr.onSuccess = function(gr, fg)
    {
        if (gr_techCodeList.loader.executed == true) {
            gr_techCodeList.loader.reload();
        } else {
            fnRetrieveTechList(gr.value(fg.Row, "TECH_CODE"));
        }
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

//기술코드 목록 조회
function fnRetrieveTechList(priorCode)
{
    var ldr = gr_techCodeList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.basecode.techcode.act.RetrieveTechCodeList.do";
    ldr.addParam("PRIOR_TECH_CODE", priorCode);

    ldr.onSuccess = function(gr, fg)
    {
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

//작성 팝업
function fnOpenCreate()
{
    var win = new any.window();
    win.path = "TechCodeMgtC.jsp";
    win.arg.PRIOR_TECH_CODE = gr_techCodeTree.value(gr_techCodeTree.fg.Row, "TECH_CODE");
    win.arg.PRIOR_TECH_CODE_NAME = gr_techCodeTree.value(gr_techCodeTree.fg.Row, "TECH_HNAME");
    win.opt.width = 600;
    win.opt.height = 400;

    win.onReload = function()
    {
        gr_techCodeTree.loader.reload();
    }

    win.show();
}

//상세 팝업
function fnOpenView(gr, fg, row, colId)
{
    var win = new any.window();
    win.path = "TechCodeMgtUD.jsp";
    win.arg.TECH_CODE = gr.value(row, "TECH_CODE");

    win.opt.width = 600;
    win.opt.height = 400;

    win.onReload = function()
    {
        gr_techCodeTree.loader.reload();
    }

    win.show();
}

</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
    <COLGROUP>
        <COL width="30%">
        <COL style="padding-left:10px;">
    </COLGROUP>
    <TR height="1">
        <TD colspan="2">
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD><SPAN id="spn_gridMessage"></SPAN></TD>
                    <TD align="right">
                        <BUTTON text="작성" onClick="javascript:fnOpenCreate();"></BUTTON>
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD height="5" colspan="2"></TD>
    </TR>
    <TR>
        <TD>
            <ANY:TREE id="gr_techCodeTree"><COMMENT>
                parentColumn = "PRIOR_TECH_CODE";
                codeColumn   = "TECH_CODE";
                nameColumn   = "TECH_HNAME";
                expandLevel  = 1;

                addRoot(null, "ROOT", "iPIMS");

                fg.attachEvent("AfterRowColChange", function(iOldRow, iOldCol, iNewRow, iNewCol)
                {
                    if (element.loader.loading == true) return;

                    fnRetrieveTechList(element.value(iNewRow, "TECH_CODE"));
                });
            </COMMENT></ANY:TREE>
        </TD>
        <TD>
            <ANY:GRID id="gr_techCodeList" pagingType="0"><COMMENT>
                fg.SelectionMode = 3;
                addColumn({ width:75 , align:"center", type:"string" , sort:false, id:"TECH_CODE"         , name:"기술코드" });
                addColumn({ width:150, align:"left"  , type:"string" , sort:false, id:"TECH_HNAME"        , name:"기술코드명" });
                addColumn({ width:75 , align:"left"  , type:"string" , sort:false, id:"PRIOR_TECH_CODE"   , name:"상위코드" });
                addColumn({ width:75 , align:"center", type:"number" , sort:false, id:"TECH_LEVEL"        , name:"코드레벨" });
                addColumn({ width:75 , align:"center", type:"string" , sort:false, id:"USE_YN_NAME"       , name:"사용여부" });
                messageSpan = "spn_gridMessage";
                addAction("TECH_HNAME", fnOpenView);

            </COMMENT></ANY:GRID>
        </TD>
    </TR>
    <TR>
        <TD height="5" colspan="2"></TD>
    </TR>e
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
