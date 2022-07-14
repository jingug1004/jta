<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>프로젝트 관리</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<ANY:DS id="ds_pjtCodeList" />
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();
}

//목록 조회
function fnRetrieve()
{
    var ldr = gr_pjtCodeList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.basecode.pjtcode.act.RetrievePjtCodeList.do";
    ldr.addParam("PJT_CODE", PJT_CODE.value);
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
    win.path = "PjtCodeMgtC.jsp";
    win.opt.width = 600;
    win.opt.height = 320;

    win.onReload = function()
    {
        gr_pjtCodeList.loader.reload();
    }

    win.show();
}

//수정
function fnModify(gr, fg, row, colId)
{
    var win = new any.window();
    win.path = "PjtCodeMgtUD.jsp";
    win.arg.PJT_CODE = gr.value(row, "PJT_CODE");
    win.opt.width = 600;
    win.opt.height = 320;

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
                    <TD>프로젝트코드</TD>
                    <TD>
                        <INPUT type="text" id="PJT_CODE">
                    </TD>
                    <TD>프로젝트이름/설명</TD>
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
            <ANY:GRID id="gr_pjtCodeList" pagingType="0"><COMMENT>
                addColumn({ width:60 , align:"center", type:"number" , sort:false, id:"ROW_NUM"         , name:"No" });
                addColumn({ width:100, align:"center", type:"string" , sort:true , id:"PJT_CODE"       , name:"프로젝트코드" });
                addColumn({ width:210, align:"left"  , type:"string" , sort:true , id:"PJT_NAME"       , name:"프로젝트이름" });
                addColumn({ width:230, align:"left"  , type:"string" , sort:true , id:"PJT_CORE"       , name:"연구사업" });
                addColumn({ width:230, align:"left"  , type:"string" , sort:true , id:"PJT_LAB"        , name:"연구과제" });
                addColumn({ width:80 , align:"right" , type:"number", sort:true , id:"BUDJET"        , name:"예산금액" , format:"#,###" });
                addColumn({ width:60 , align:"center", type:"string" , sort:true , id:"USE_YN_NAME"     , name:"사용여부" });
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_NUM", "PJT_CODE");
                addSorting("PJT_CODE", "ASC");
                addAction("PJT_CODE", fnModify);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
