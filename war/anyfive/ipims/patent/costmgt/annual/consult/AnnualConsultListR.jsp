<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>연차료 품의서 현황</TITLE>
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
    var ldr = gr_costConsultList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.costmgt.annual.consult.act.RetrieveAnnualConsultList.do";
    ldr.addParam("CONSULT_SUBJECT", CONSULT_SUBJECT.value);
    ldr.addParam("CONSULT_STATUS", CONSULT_STATUS.value);
    ldr.addParam("CRE_USER_NAME", CRE_USER_NAME.value);
    ldr.addParam("DATE_START", DATE_START.value);
    ldr.addParam("DATE_END", DATE_END.value);

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
    var win = new any.viewer();
    win.path = top.getRoot() + "/anyfive/ipims/patent/costmgt/annual/consult/AnnualConsultRD.jsp";
    win.arg.CONSULT_ID = gr.value(row, "CONSULT_ID");
    win.arg.gr = gr;
    win.arg.fg = fg;

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
                    <TD>제목</TD>
                    <TD>
                        <INPUT type="text" id="CONSULT_SUBJECT">
                    </TD>
                    <TD>진행상태</TD>
                    <TD>
                        <ANY:SELECT id="CONSULT_STATUS" codeData="/common/apprStatus" firstName="all" />
                    </TD>
                </TR>
                <TR>
                    <TD>작성자</TD>
                    <TD>
                        <INPUT type="text" id="CRE_USER_NAME">
                    </TD>
                    <TD>작성일</TD>
                    <TD>
                        <ANY:DATE id="DATE_START" />&nbsp;~
                        <ANY:DATE id="DATE_END" />
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
            <ANY:GRID id="gr_costConsultList" pagingType="1"><COMMENT>
                addColumn({ width:50 , align:"center", type:"number", sort:false, id:"ROW_NUM"          , name:"<%= app.message.get("lbl.com.no").toJS() %>" });
                addColumn({ width:200, align:"left"  , type:"string", sort:true , id:"CONSULT_SUBJECT"  , name:"품의제목" });
                addColumn({ width:90 , align:"center", type:"string", sort:true , id:"APPR_STATUS_NAME" , name:"진행상태" });
                addColumn({ width:70 , align:"center", type:"string", sort:true , id:"CRE_USER_NAME"    , name:"작성자" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"CRE_DATE"         , name:"작성일" });
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_NUM", "CONSULT_SUBJECT");
                addSorting("CONSULT_ID", "DESC");
                addAction("CONSULT_SUBJECT", fnDetail);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
