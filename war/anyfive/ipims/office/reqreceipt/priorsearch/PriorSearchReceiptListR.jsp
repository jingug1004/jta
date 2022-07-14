<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.office.common.app.OfficeApp"%><% OfficeApp app = new OfficeApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>조사의뢰접수</TITLE>
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
    var ldr = gr_priorSearchReceiptList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.office.reqreceipt.priorsearch.act.RetrievePriorSearchReceiptList.do";
    ldr.addParam("PRSCH_NO", PRSCH_NO.value);
    ldr.addParam("REQ_USER", REQ_USER.value);
    ldr.addParam("PRSCH_SUBJECT", PRSCH_SUBJECT.value);
    ldr.addParam("DATE_START", DATE_START.value);
    ldr.addParam("DATE_END", DATE_END.value);
    ldr.addParam("RECEIPT_STATUS", RECEIPT_STATUS.value);
    ldr.addParam("PRSCH_DIV", PRSCH_DIV.value);

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
    if (gr.value(row, "OFFICE_RCPT_DATE") == "") {
        win.path = "PriorSearchReceiptU.jsp";
    } else if (gr.value(row, "PRSCH_RESULT_INPUT_YN") == "0") {
        win.path = "PriorSearchResultU.jsp";
    } else {
        win.path = "PriorSearchResultRD.jsp";
    }
    win.arg.PRSCH_ID = gr.value(row, "PRSCH_ID");

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
                    <COL class="conddata" width="30%">
                    <COL class="condhead" width="10%">
                    <COL class="conddata" width="20%">
                    <COL class="condhead" width="10%">
                    <COL class="conddata" width="20%">
                </COLGROUP>
                <TR>
                    <TD>의뢰번호</TD>
                    <TD>
                        <INPUT type="text" id="PRSCH_NO">
                    </TD>
                    <TD>의뢰인</TD>
                    <TD>
                        <INPUT type="text" id="REQ_USER">
                    </TD>
                    <TD>의뢰제목</TD>
                    <TD>
                        <INPUT type="text" id="PRSCH_SUBJECT">
                    </TD>
                </TR>
                <TR>
                    <TD>의뢰일</TD>
                    <TD noWrap>
                        <ANY:DATE id="DATE_START" />&nbsp;~
                        <ANY:DATE id="DATE_END" />
                    </TD>
                     <TD>진행상태</TD>
                    <TD>
                        <ANY:SELECT id="RECEIPT_STATUS" codeData="/reqreceipt/priorSearchReceiptYn" value="0" />
                    </TD>
                     <TD>조사구분</TD>
                    <TD>
                        <ANY:SELECT id="PRSCH_DIV" codeData="{PRSCH_DIV}" firstName="all" />
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
            <ANY:GRID id="gr_priorSearchReceiptList" pagingType="1"><COMMENT>
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"PRSCH_NO"             , name:"의뢰번호" });
                addColumn({ width:75 , align:"center", type:"string", sort:true , id:"REQ_USER_NAME"        , name:"의뢰자" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"PRSCH_DIV_NAME"       , name:"조사구분" });
                addColumn({ width:200, align:"left"  , type:"string", sort:true , id:"PRSCH_SUBJECT"        , name:"의뢰제목" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"REQ_DATE"             , name:"지적재산팀의뢰일" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"OFFICE_RCPT_DATE"     , name:"사무소접수일" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"INFORM_DATE"          , name:"결과답변일" });
                addColumn({ width:75 , align:"center", type:"string", sort:true , id:"JOB_MAN_NAME"         , name:"담당자" });
                useConfig = true;
                messageSpan = "spn_gridMessage";
                setFixedColumn(null, "PRSCH_SUBJECT");
                addAction("PRSCH_SUBJECT", fnDetail);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
