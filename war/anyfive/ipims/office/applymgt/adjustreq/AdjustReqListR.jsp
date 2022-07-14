<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.office.common.app.OfficeApp"%><% OfficeApp app = new OfficeApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>수정요청</TITLE>
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
    var ldr = gr_AdjustReqList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.office.applymgt.adjustreq.act.RetrieveAdjustReqList.do";
    ldr.addParam("REQ_GUBUN", REQ_GUBUN.value);
    ldr.addParam("REF_NO", REF_NO.value);
    ldr.addParam("STATUS", STATUS.value);
    ldr.addParam("JOB_MAN", JOB_MAN.value);
    ldr.addParam("DATE_START" , DATE_START.value);
    ldr.addParam("DATE_END" , DATE_END.value);

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
function fnWrite()
{
    var win = new any.viewer();
    win.path = "AdjustReqC.jsp";

    win.onReload = function()
    {
        gr_AdjustReqList.loader.reload();
    }

    win.show();
}

//상세
function fnDetail(gr, fg, row, colId)
{
    var win = new any.viewer();

    if (gr.value(row, "STATUS") == "0"){
        win.path = "AdjustReqRD.jsp";
    }else{
        win.path = "AdjustReqResultRD.jsp";
    }

    win.arg.REQ_ID = gr.value(row, "REQ_ID");

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
                    <COL class="condhead" width="10%">
                    <COL class="conddata" width="23%">
                    <COL class="condhead" width="10%">
                    <COL class="conddata" width="23%">
                    <COL class="condhead" width="10%">
                    <COL class="conddata" width="23%">
                </COLGROUP>
                <TR>
                    <TD>구분</TD>
                    <TD>
                        <ANY:SELECT id="REQ_GUBUN" codeData="{INOUT_DIV}" firstName="all" />
                    </TD>
                    <TD>의뢰번호</TD>
                    <TD>
                        <INPUT type="text" id="REF_NO">
                    </TD>
                    <TD>처리상태</TD>
                    <TD>
                        <ANY:SELECT id="STATUS" codeData="/applymgt/statusGubun" firstName="all" />
                    </TD>
                </TR>
                <TR>
                    <TD>특허담당자</TD>
                    <TD>
                        <INPUT type="text" id="JOB_MAN">
                    </TD>
                    <TD>요청일자</TD>
                    <TD colspan="3" noWrap>
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
                        <BUTTON auto="line"></BUTTON>
                        <BUTTON text="<%= app.message.get("btn.com.write").toHTML() %>" onClick="javascript:fnWrite();"></BUTTON>
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
            <ANY:GRID id="gr_AdjustReqList" pagingType="1"><COMMENT>
                addColumn({ width:75  , align:"center" , type:"date"   , sort:true , id:"REQ_DATE"           , name:"요청일시" });
                addColumn({ width:120 , align:"center" , type:"string" , sort:true , id:"REQUSER_EMPNO"      , name:"요청자(사번)" });
                addColumn({ width:200 , align:"left"   , type:"string" , sort:true , id:"REQ_SUBJECT"        , name:"제목" });
                addColumn({ width:120 , align:"left"   , type:"string" , sort:true , id:"REF_NO"             , name:"의뢰번호" });
                addColumn({ width:120 , align:"center" , type:"string" , sort:true , id:"JOBMAN_EMPNO"       , name:"담당자지정(사번)" });
                addColumn({ width:75  , align:"center" , type:"string" , sort:true , id:"REQ_GUBUN_NAME"     , name:"요청구분" });
                addColumn({ width:75  , align:"left"   , type:"string" , sort:true , id:"STATUS_NAME"        , name:"처리상태" });
                useConfig = true;
                messageSpan = "spn_gridMessage";
                addSorting("REQ_DATE", "DESC");
                addAction("REQ_SUBJECT", fnDetail);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>

