<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>메일 상세</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("CRE_DATE_TIME");
    addBind("SUBJECT");
    addBind("FROM_NAME");
    addBind("FROM_ADDR");
    addBind("STATUS_NAME");
</COMMENT></ANY:DS>
<ANY:DS id="ds_recvList" />
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    MAIL_ID.innerText = parent.MAIL_ID;

    fnRetrieve();
    fnRetrieveLogList();
}

//조회
function fnRetrieve()
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.log.mail.act.RetrieveMailLog.do";
    prx.addParam("MAIL_ID", parent.MAIL_ID);
    prx.checkData = ds_mainInfo;

    prx.onSuccess = function()
    {
        btn_reLog.disabled = (ds_mainInfo.value(0, "STATUS") == "0");
        fnCreateRecvList();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//수신자 목록 생성
function fnCreateRecvList()
{
    var tr, td;

    for (var i = tbd_recvList.rows.length - 1; i >= 0; i--) {
        tbd_recvList.deleteRow(i);
    }

    for (var i = 0; i < ds_recvList.rowCount; i++) {
        tr = document.createElement('<TR>');
        tbd_recvList.appendChild(tr);

        td = document.createElement('<TD align="right">');
        td.innerHTML = ds_recvList.value(i, "RECV_SEQ") + '.&nbsp;';
        tr.appendChild(td);

        td = document.createElement('<TD align="right">');
        td.innerHTML = ds_recvList.value(i, "RECV_TYPE") + '&nbsp;:&nbsp;';
        tr.appendChild(td);

        td = document.createElement('<TD>');
        td.innerHTML = ds_recvList.value(i, "RECV_NAME") + '(' + ds_recvList.value(i, "RECV_ADDR") + ')';
        tr.appendChild(td);
    }
}

//발송로그 목록 조회
function fnRetrieveLogList()
{
    var ldr = gr_mailLogList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.log.mail.act.RetrieveMailSendLogList.do";
    ldr.addParam("MAIL_ID", parent.MAIL_ID);

    ldr.onSuccess = function(gr, fg)
    {
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

//새로고침
function fnRefresh()
{
    fnRetrieve();
    fnRetrieveLogList();
    parent.reloadList();
}

//재발송하기
function fnCreateLog()
{
    if (!confirm("재발송 처리하시겠습니까?")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.log.mail.act.CreateMailSendLog.do";
    prx.addParam("MAIL_ID", parent.MAIL_ID);

    prx.onSuccess = function()
    {
        fnRefresh();
        alert("재발송 처리되었습니다.");
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//메일내용 보기
function fnViewBody()
{
    window.location.href = "MailLogBodyR.jsp";
}
</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
    <TR>
        <TD>
            <TABLE border="0" cellspacing="1" cellpadding="2" class="main">
                <COLGROUP>
                    <COL class="conthead" width="15%">
                    <COL class="contdata" width="35%">
                    <COL class="conthead" width="15%">
                    <COL class="contdata" width="35%">
                </COLGROUP>
                <TR>
                    <TD>메일 ID</TD>
                    <TD><SPAN id="MAIL_ID"></SPAN></TD>
                    <TD>작성시간</TD>
                    <TD><SPAN id="CRE_DATE_TIME"></SPAN></TD>
                </TR>
                <TR>
                    <TD>메일 제목</TD>
                    <TD colspan="3"><SPAN id="SUBJECT"></SPAN></TD>
                </TR>
                <TR>
                    <TD>발송자</TD>
                    <TD><SPAN id="FROM_NAME"></SPAN>(<SPAN id="FROM_ADDR"></SPAN>)</TD>
                    <TD>최종상태</TD>
                    <TD><SPAN id="STATUS_NAME"></SPAN></TD>
                </TR>
                <TR>
                    <TD>수신자</TD>
                    <TD colspan="3">
                        <TABLE border="0" cellspacing="0" cellpadding="0">
                            <TBODY id="tbd_recvList"></TBODY>
                        </TABLE>
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD height="5"></TD>
    </TR>
    <TR>
        <TD align="right">
            <BUTTON text="새로고침" onClick="javascript:fnRefresh();"></BUTTON>
            <BUTTON auto="line"></BUTTON>
            <BUTTON text="재발송하기" onClick="javascript:fnCreateLog();" id="btn_reLog" disabled></BUTTON>
            <BUTTON text="메일내용 보기" onClick="javascript:fnViewBody();"></BUTTON>
            <BUTTON auto="line"></BUTTON>
            <BUTTON auto="list"></BUTTON>
        </TD>
    </TR>
    <TR>
        <TD height="5"></TD>
    </TR>
    <TR>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD class="title_sub">메일 발송로그 목록</TD>
                    <TD align="right"><SPAN id="spn_gridMessage"></SPAN></TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD height="5"></TD>
    </TR>
    <TR>
        <TD height="100%">
            <ANY:GRID id="gr_mailLogList" pagingType="0"><COMMENT>
                addColumn({ width:50 , align:"center", type:"number", sort:true , id:"LOG_SEQ"       , name:"Seq" });
                addColumn({ width:70 , align:"center", type:"string", sort:true , id:"STATUS_NAME"   , name:"상태" });
                addColumn({ width:130, align:"center", type:"string", sort:true , id:"SND_DATE_TIME" , name:"발송시간" });
                addColumn({ width:300, align:"left"  , type:"string", sort:true , id:"SND_RESULT"    , name:"발송결과" });
                messageSpan = "spn_gridMessage";
                setFixedColumn("LOG_SEQ", null);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
