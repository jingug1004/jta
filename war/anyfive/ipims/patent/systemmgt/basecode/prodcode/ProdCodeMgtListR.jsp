<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>제품코드 관리</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<ANY:DS id="ds_prodCodeList" />
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();
}

//목록 조회
function fnRetrieve()
{
    var ldr = gr_prodCodeList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.basecode.prodcode.act.RetrieveProdCodeList.do";
    ldr.addParam("PROD_CODE", PROD_CODE.value);
    ldr.addParam("SEARCH_TEXT", SEARCH_TEXT.value);

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
    win.path = "ProdCodeMgtC.jsp";
    win.opt.width = 600;
    win.opt.height = 300;

    win.onReload = function()
    {
        gr_prodCodeList.loader.reload();
    }

    win.show();
}

//수정
function fnModify(gr, fg, row, colId)
{
    var win = new any.window();
    win.path = "ProdCodeMgtUD.jsp";
    win.arg.PROD_CODE = gr.value(row, "PROD_CODE");
    win.opt.width = 600;
    win.opt.height = 300;

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
                    <TD>제품코드</TD>
                    <TD>
                        <INPUT type="text" id="PROD_CODE">
                    </TD>
                    <TD>제품이름/설명</TD>
                    <TD>
                        <INPUT type="text" id="SEARCH_TEXT">
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
            <ANY:GRID id="gr_prodCodeList" pagingType="0"><COMMENT>
                addColumn({ width:60 , align:"center", type:"number" , sort:false, id:"ROW_NUM"         , name:"No" });
                addColumn({ width:100, align:"center", type:"string" , sort:true , id:"PROD_CODE"       , name:"제품코드" });
                addColumn({ width:200, align:"left"  , type:"string" , sort:true , id:"PROD_NAME"       , name:"제품이름" });
                addColumn({ width:250, align:"left"  , type:"string" , sort:true , id:"PROD_DESC"       , name:"제품설명" });
                addColumn({ width:90 , align:"center", type:"string" , sort:true , id:"USE_YN_NAME"     , name:"사용여부" });
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_NUM", "PROD_CODE");
                addSorting("PROD_CODE", "ASC");
                addAction("PROD_CODE", fnModify);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
