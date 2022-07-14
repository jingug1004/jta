<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.office.common.app.OfficeApp"%><% OfficeApp app = new OfficeApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>분쟁/소송의뢰접수</TITLE>
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
    var ldr = gr_disputeReqList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.office.reqreceipt.dispute.act.RetrieveDisputeReceiptList.do";
    ldr.addParam("NUM_KIND", NUM_KIND.value);
    ldr.addParam("NUM_TEXT", NUM_TEXT.value);
    ldr.addParam("DISPUTE_SUBJECT", DISPUTE_SUBJECT.value);
    ldr.addParam("DISPUTE_DIV", DISPUTE_DIV.value);
    ldr.addParam("DATE_KIND", DATE_KIND.value);
    ldr.addParam("DATE_START", DATE_START.value);
    ldr.addParam("DATE_END", DATE_END.value);
    ldr.addParam("DISPUTE_KIND", DISPUTE_KIND.value);

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
    win.path = "DisputeReceiptU.jsp";
    win.arg.DISPUTE_ID = gr.value(row, "DISPUTE_ID");

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
                    <COL class="conddata" width="34%">
                    <COL class="condhead" width="10%">
                    <COL class="conddata" width="18%">
                    <COL class="condhead" width="10%">
                    <COL class="conddata" width="18%">
                </COLGROUP>
                <TR>
                    <TD>검색번호</TD>
                    <TD>
                        <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                            <TR>
                                <TD>
                                    <ANY:SELECT id="NUM_KIND" codeData="/reqreceipt/disputeReceiptSearchNumKind" style="width:110px; margin-right:3px;" />
                                </TD>
                                <TD width="100%">
                                    <INPUT type="text" id="NUM_TEXT" style="text-transform:uppercase;">
                                </TD>
                            </TR>
                        </TABLE>
                    </TD>
                    <TD>분쟁제목</TD>
                    <TD>
                        <INPUT type="text" id="DISPUTE_SUBJECT" style="text-transform:uppercase;">
                    </TD>
                    <TD>분쟁구분</TD>
                    <TD>
                        <ANY:SELECT id="DISPUTE_DIV" codeData="{DISPUTE_DIV}" firstName="all" />
                    </TD>
                </TR>
                <TR>
                    <TD>검색일자</TD>
                    <TD noWrap colspan="3">
                        <ANY:SELECT id="DATE_KIND" codeData="/reqreceipt/disputeReceiptSearchDateKind" style="width:110px; margin-right:3px;" />
                        <ANY:DATE id="DATE_START" />&nbsp;~
                        <ANY:DATE id="DATE_END" />
                    </TD>
                    <TD>분쟁종류</TD>
                    <TD>
                        <ANY:SELECT id="DISPUTE_KIND" codeData="{DISPUTE_KIND}" firstName="all" />
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
            <ANY:GRID id="gr_disputeReqList" pagingType="1"><COMMENT>
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"MGT_NO"               , name:"관리번호" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"DISPUTE_NO"           , name:"분쟁번호" });
                addColumn({ width:150, align:"left"  , type:"string", sort:true , id:"DISPUTE_SUBJECT"      , name:"분쟁제목" });
                addColumn({ width:80 , align:"center", type:"string", sort:true , id:"DISPUTE_DIV_NAME"     , name:"분쟁구분" });
                addColumn({ width:120, align:"center", type:"string", sort:true , id:"DISPUTE_KIND_NAME"    , name:"분쟁종류" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"OTHER_NAME"           , name:"상대명" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"REQ_DATE"             , name:"청구일" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"LAST_DISPOSAL_DATE"   , name:"최종처분일" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"CRE_DATE"             , name:"등록일" });
                useConfig = true;
                messageSpan = "spn_gridMessage";
                setFixedColumn(null, "DISPUTE_SUBJECT");
                addSorting("MGT_NO", "ASC");
                addAction("DISPUTE_SUBJECT", fnDetail);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
