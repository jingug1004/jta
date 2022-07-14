<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.office.common.app.OfficeApp"%><% OfficeApp app = new OfficeApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>비용청구현황</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<ANY:DS id="ds_costRequestList" />
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();
}

//목록 조회
function fnRetrieve()
{
    var ldr = gr_costRequestList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.office.costmgt.request.act.RetrieveCostRequestList.do";
    ldr.addParam("INOUT_DIV"   , INOUT_DIV.value);
    ldr.addParam("REQ_SUBJECT" , REQ_SUBJECT.value);
    ldr.addParam("DATE_GUBUN"  , DATE_GUBUN.value);
    ldr.addParam("DATE_START"  , DATE_START.value);
    ldr.addParam("DATE_END"    , DATE_END.value);

    ldr.onSuccess = function(gr, fg)
    {
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

//청구서상세
function fnCostRequestDetail(gr, fg, row, colId)
{
    var win = new any.window();
    if (gr.value(row, "INOUT_DIV") == "INT") {
        win.path = top.getRoot() + "/anyfive/ipims/share/cost/request/IntCostRequestRD.jsp";
    } else {
        win.path = top.getRoot() + "/anyfive/ipims/share/cost/request/ExtCostRequestRD.jsp";
    }
    win.arg.REQ_ID = gr.value(row, "REQ_ID");
    win.arg.gr = gr;
    win.opt.width = 800;
    win.opt.height = 650;

    win.onReload = function()
    {
        gr.loader.reload();
    }

    win.show();
}

</SCRIPT>

<!-- 검색일자 구분 변경시 -->
<SCRIPT language="JScript" for="DATE_GUBUN" event="OnChange()">
    DATE_START.disabled = (this.value == "");
    DATE_END.disabled = (this.value == "");
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
                    <TD>청구서명</TD>
                    <TD>
                        <INPUT type="text" id="REQ_SUBJECT">
                    </TD>
                    <TD>국가구분</TD>
                    <TD>
                        <ANY:SELECT id="INOUT_DIV" codeData="{INOUT_DIV}" firstName="sel"/>
                    </TD>
                </TR>
                <TR>
                    <TD>검색일자</TD>
                    <TD colspan="3">
                        <ANY:SELECT id="DATE_GUBUN" codeData="/costmgt/costRequestSearchDateDiv" firstName="none" style="width:80px; margin-right:3px;" />
                        <ANY:DATE id="DATE_START" disabled />&nbsp;~
                        <ANY:DATE id="DATE_END" disabled />
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
            <ANY:GRID id="gr_costRequestList" pagingType="0"><COMMENT>
                addHeader([ null, null,null, "승인현황", "", "", "청구금액", "", null, null, null, null, null ]);
                addColumn({ width:180, align:"left"  , type:"string" , sort:true , id:"REQ_SUBJECT"   , name:"청구서제목" });
                addColumn({ width:60 , align:"center", type:"string" , sort:true , id:"REQ_YN_NAME"   , name:"청구상태" });
                addColumn({ width:60 , align:"center", type:"string" , sort:true , id:"RETURN_NAME"   , name:"반려사유" });
                addColumn({ width:60 , align:"center", type:"number" , sort:true , id:"CNT_CNF_NULL"  , name:"청구건수" });
                addColumn({ width:60 , align:"center", type:"number" , sort:true , id:"CNT_CNF_YES"   , name:"승인" });
                addColumn({ width:60 , align:"center", type:"number" , sort:true , id:"CNT_CNF_NO"    , name:"반려" });
                addColumn({ width:100, align:"right" , type:"number" , sort:true , id:"REQ_WON_PRICE" , name:"원화(KRW)" , format:"#,###" });
                addColumn({ width:100, align:"right" , type:"number" , sort:true , id:"REQ_PRICE"     , name:"외화"      , format:"#,###" });
                addColumn({ width:120, align:"left"  , type:"string" , sort:true , id:"OFFICE_NAME"   , name:"사무소" });
                addColumn({ width:70 , align:"center", type:"string" , sort:true , id:"REQ_USER_NAME" , name:"청구자" });
                addColumn({ width:75 , align:"center", type:"date"   , sort:true , id:"REQ_DATE"      , name:"청구일" });
                messageSpan = "spn_gridMessage";
                setFixedColumn(null, "CNT_CNF_NO");
                addSorting("CRE_DATE", "DESC");
                addAction("REQ_SUBJECT", fnCostRequestDetail);

            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
