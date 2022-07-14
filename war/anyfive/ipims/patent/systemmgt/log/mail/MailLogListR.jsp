<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<%@page import="any.util.etc.NDateUtil"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>메일 목록</TITLE>
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
    var ldr = gr_mailList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.log.mail.act.RetrieveMailLogList.do";
    ldr.addParam("SEARCH_KIND", SEARCH_KIND.value);
    ldr.addParam("SEARCH_TEXT", SEARCH_TEXT.value);
    ldr.addParam("DATE_START", DATE_START.value);
    ldr.addParam("DATE_END", DATE_END.value);
    ldr.addParam("LAST_STATUS", LAST_STATUS.value);
    ldr.addParam("NO_RECV", NO_RECV.value);

    ldr.onSuccess = function(gr, fg)
    {
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

//메일발송 실행
function fnExecMailSend()
{
    //실행 확인
    if (!confirm("메일발송을 실행하시겠습니까?")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.log.mail.act.ExecuteMailSend.do";

    prx.onSuccess = function()
    {
        gr_mailList.loader.reload();
        alert("처리되었습니다.");
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//상세
function fnDetail(gr, fg, row, colId)
{
    var win = new any.viewer();
    win.path = "MailLogR.jsp";
    win.arg.MAIL_ID = gr.value(row, "MAIL_ID");

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
                    <TD>검색어</TD>
                    <TD>
                        <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                            <TR>
                                <TD width="90px">
                                    <ANY:SELECT id="SEARCH_KIND" codeData="/systemmgt/mailListSearchKind" value="SUBJECT" />
                                </TD>
                                <TD style="padding-left:2px;">
                                    <INPUT type="text" id="SEARCH_TEXT">
                                </TD>
                            </TR>
                        </TABLE>
                    </TD>
                    <TD>작성일자</TD>
                    <TD>
                        <ANY:DATE id="DATE_START" />&nbsp;~
                        <ANY:DATE id="DATE_END" />
                    </TD>
                </TR>
                <TR>
                    <TD>최종상태</TD>
                    <TD>
                        <ANY:SELECT id="LAST_STATUS" codeData="/systemmgt/mailStatus" firstName="all" />
                    </TD>
                    <TD>기타</TD>
                    <TD>
                        <ANY:CHECK id="NO_RECV" text="수신자 없는 건 포함" />
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
                        <BUTTON text="메일발송 실행" onClick="javascript:fnExecMailSend();"></BUTTON>
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
                addColumn({ width:50 , align:"center", type:"number", sort:false, id:"ROW_NUM"          , name:"No" });
                addColumn({ width:80 , align:"center", type:"string", sort:true , id:"MAIL_ID"          , name:"메일 ID" });
                addColumn({ width:300, align:"left"  , type:"string", sort:true , id:"SUBJECT"          , name:"메일 제목" });
                addColumn({ width:70 , align:"center", type:"string", sort:true , id:"FROM_NAME"        , name:"발송자" });
                addColumn({ width:70 , align:"center", type:"number", sort:true , id:"RECV_CNT"         , name:"수신자수" });
                addColumn({ width:70 , align:"center", type:"string", sort:true , id:"LAST_STATUS_NAME" , name:"최종상태" });
                addColumn({ width:130, align:"center", type:"string", sort:true , id:"CRE_DATE_TIME"    , name:"작성시간" });
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_NUM", "MAIL_ID");
                addSorting("MAIL_ID", "DESC");
                addAction("SUBJECT", fnDetail);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
