<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>연구소관리</TITLE>
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
    var ldr = gr_labMgtList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.patteam.labmgt.act.RetrieveLabMgtList.do"
    ldr.addParam("LAB_CODE" , LAB_CODE.value);
    ldr.addParam("LAB_NAME" , LAB_NAME.value);

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
    win.path = "LabMgtC.jsp";
    win.opt.width = 600;
    win.opt.height = 300;

    win.onReload = function()
    {
        gr.loader.reload();
    }

    win.show();
}

//상세 팝업
function fnOpenView(gr, fg, row, colId)
{
    var win = new any.window();
    win.path = "LabMgtUD.jsp";
    win.arg.LAB_CODE = gr.value(row, "LAB_CODE");
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
            <TABLE border="0" width="100%" cellspacing="1" cellpadding="2" class="main" width="100%">
                <COLGROUP>
                    <COL class="condhead" width="15%">
                    <COL class="conddata" width="35%">
                    <COL class="condhead" width="15%">
                    <COL class="conddata" width="35%">
                </COLGROUP>
                <TR>
                    <TD>연구소코드</TD>
                    <TD>
                        <INPUT type="text" id="LAB_CODE">
                    </TD>
                    <TD>연구소명</TD>
                    <TD style="padding-left:2px;">
                        <INPUT type="text" id="LAB_NAME">
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
            <ANY:GRID id="gr_labMgtList" pagingType="1"><COMMENT>
                addColumn({ width:50 , align:"center", type:"number", sort:false, id:"ROW_NUM"       , name:"<%= app.message.get("lbl.com.no").toJS() %>" });
                addColumn({ width:90 , align:"center", type:"string", sort:true , id:"LAB_CODE"      , name:"연구소코드" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"LAB_NAME"      , name:"연구소" });
                addColumn({ width:90 , align:"center", type:"string", sort:true , id:"LAB_CHIEF_NAME", name:"연구소장" });
                addColumn({ width:70 , align:"center", type:"string", sort:true , id:"USE_YN_NAME"   , name:"사용구분" });
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_NUM", "LAB_CODE");
                addSorting("LAB_CODE", "ASC");
                addAction("LAB_CODE", fnOpenView);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
