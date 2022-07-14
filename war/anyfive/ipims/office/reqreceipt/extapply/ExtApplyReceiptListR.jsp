<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.office.common.app.OfficeApp"%><% OfficeApp app = new OfficeApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>해외출원의뢰접수</TITLE>
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
    var ldr = gr_extApplyReqList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.office.reqreceipt.extapply.act.RetrieveExtApplyReceiptList.do";
    ldr.addParam("RECEIPT_YN", RECEIPT_YN.value);
    ldr.addParam("GRP_NO", GRP_NO.value);
    ldr.addParam("RIGHT_DIV", RIGHT_DIV.value);
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
    var rcptDate = gr.value(row,"OFFICE_RCPT_DATE")

    if(rcptDate == null || rcptDate == ""){
        win.path = "ExtApplyReceiptU.jsp";
    }else{
        win.path = "ExtApplyReceiptR.jsp";
    }

    win.arg.OL_ID = gr.value(row, "OL_ID");
    win.arg.GRP_ID = gr.value(row, "GRP_ID");

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
                    <TD>그룹번호</TD>
                    <TD>
                        <INPUT type="text" id="GRP_NO">
                    </TD>
                    <TD>구분</TD>
                    <TD>
                        <ANY:SELECT id="RIGHT_DIV" codeData="{RIGHT_DIV}" firstName="all" />
                    </TD>
                </TR>
                <TR>
                    <TD>의뢰일</TD>
                    <TD noWrap>
                        <ANY:DATE id="DATE_START" />&nbsp;~
                        <ANY:DATE id="DATE_END" />
                    </TD>
                    <TD>상태</TD>
                    <TD>
                        <ANY:SELECT id="RECEIPT_YN" codeData="/reqreceipt/receiptYn" />
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
            <ANY:GRID id="gr_extApplyReqList" pagingType="1"><COMMENT>
                addColumn({ width:120, align:"left"  , type:"string", sort:true , id:"GRP_NO"               , name:"그룹번호" });
                addColumn({ width:75 , align:"left"  , type:"string", sort:true , id:"RIGHT_DIV_NAME"       , name:"구분" });
                addColumn({ width:150, align:"left"  , type:"string", sort:true , id:"COUNTRY_NAMES"        , name:"출원국가" });
                addColumn({ width:200, align:"left"  , type:"string", sort:true , id:"KO_APP_TITLE"         , name:"발명의 명칭" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"OFFICE_SEND_DATE"     , name:"의뢰일" });
                useConfig = true;
                messageSpan = "spn_gridMessage";
                addSorting("OFFICE_SEND_DATE", "ASC");
                addAction("KO_APP_TITLE", fnDetail);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
