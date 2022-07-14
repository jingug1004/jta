<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<%@page import="any.util.etc.NDateUtil"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>사용자 로그</TITLE>
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
    var ldr = gr_mailList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.log.user.act.RetrieveUserLogList.do";
    ldr.addParam("SYSTEM_TYPE", SYSTEM_TYPE.value);
    ldr.addParam("LOG_TYPE", LOG_TYPE.value);
    ldr.addParam("DATE_START", DATE_START.value);
    ldr.addParam("DATE_END", DATE_END.value);
    ldr.addParam("EMP_HNAME", EMP_HNAME.value);

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
    win.path = "UserLogR.jsp";
    win.arg.LOG_SEQ = gr.value(row, "LOG_SEQ");
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
                    <TD>시스템</TD>
                    <TD>
                        <ANY:SELECT id="SYSTEM_TYPE" codeData="{SYSTEM_TYPE}" firstName="all" />
                    </TD>
                    <TD>로그종류</TD>
                    <TD>
                        <ANY:SELECT id="LOG_TYPE" codeData="/systemmgt/userLogType" firstName="all" />
                    </TD>
                </TR>
                <TR>
                    <TD>로그일자</TD>
                    <TD>
                        <ANY:DATE id="DATE_START" />&nbsp;~
                        <ANY:DATE id="DATE_END" />
                    </TD>
                    <TD>사용자명</TD>
                    <TD>
                        <INPUT type="text" id="EMP_HNAME">
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
            <ANY:GRID id="gr_mailList" pagingType="1"><COMMENT>
                addColumn({ width:90 , align:"center", type:"number", sort:true , id:"LOG_SEQ"          , name:"로그번호" });
                addColumn({ width:60 , align:"center", type:"string", sort:true , id:"SYSTEM_TYPE_NAME" , name:"시스템" });
                addColumn({ width:60 , align:"center", type:"string", sort:true , id:"LOG_TYPE_NAME"    , name:"로그종류" });
                addColumn({ width:80 , align:"center", type:"string", sort:true , id:"EMP_HNAME"        , name:"사용자명" });
                addColumn({ width:140, align:"center", type:"string", sort:true , id:"LOG_DATETIME"     , name:"로그일시" });
                addColumn({ width:110, align:"center", type:"string", sort:true , id:"CLIENT_IP"        , name:"사용자IP" });
                addColumn({ width:110, align:"center", type:"string", sort:true , id:"SERVER_IP"        , name:"서버IP" });
                addColumn({ width:350, align:"left"  , type:"string", sort:true , id:"SERVLET_PATH"     , name:"서블릿경로" });
                addColumn({ width:70 , align:"center", type:"string", sort:true , id:"ERROR_YN_NAME"    , name:"성공여부" });
                messageSpan = "spn_gridMessage";
                setFixedColumn(null, "EMP_HNAME");
                addSorting("LOG_SEQ", "DESC");
                addAction("EMP_HNAME", fnDetail);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
