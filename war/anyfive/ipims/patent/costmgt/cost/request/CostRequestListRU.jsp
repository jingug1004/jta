<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
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
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.costmgt.cost.request.act.RetrieveCostRequestList.do";
    ldr.addParam("INOUT_DIV"   , INOUT_DIV.value);
    ldr.addParam("REQ_SUBJECT" , REQ_SUBJECT.value);
    ldr.addParam("DATE_GUBUN"  , DATE_GUBUN.value);
    ldr.addParam("DATE_START"  , DATE_START.value);
    ldr.addParam("DATE_END"    , DATE_END.value);
    ldr.addParam("OFFICE_CODE" , OFFICE_CODE.value);

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

//청구서 품의
function fnCreateConsult()
{
    var gr = document.getElementById("gr_costRequestList");
    var ds = document.getElementById("ds_costRequestList");

    ds.init();

    for (var r = gr.fg.FixedRows; r < gr.fg.Rows; r++) {
        if (gr.checked(r, "ROW_CHK") != true) continue;
        if (gr.value(r, "CNT_CNF_NULL") != "0" || gr.value(r, "CNT_CNF_NO") != "0") {
            alert("모든 비용이 승인된 청구서만 품의서작성이 가능합니다.");
            return ;
        }
        ds.value(ds.addRow(), "REQ_ID") = gr.value(r, "REQ_ID");
    }

    if (ds.rowCount == 0) {
        alert("선택된 건이 없습니다");
        return;
    }

    if (!confirm("품의서를 작성하시겠습니까?")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.costmgt.cost.consult.act.CreateCostConsult.do";
    prx.addData(ds);

    prx.onSuccess = function()
    {
        gr.loader.reload();
        alert("처리되었습니다.");

        var win = new any.viewer();
        win.path = top.getRoot() + "/anyfive/ipims/patent/costmgt/cost/consult/CostConsultRD.jsp";
        win.arg.CONSULT_ID = this.result;

        win.onReload = function()
        {
            gr.loader.reload();
        }

        win.show();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
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
                    <TD>
                        <ANY:SELECT id="DATE_GUBUN" codeData="/costmgt/costRequestSearchDateDiv" firstName="none" style="width:80px; margin-right:3px;" />
                        <ANY:DATE id="DATE_START" disabled />&nbsp;~
                        <ANY:DATE id="DATE_END" disabled />
                    </TD>
                    <TD>사무소</TD>
                    <TD>
                        <ANY:SELECT id="OFFICE_CODE" codeData="/common/intOfficeCode" firstName="all" />
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
                addHeader([ null, null, "승인현황", "", "", "청구금액", "","", null, null, null, null, null ]);
                addColumn({ width:30 , align:"center", type:"string" , sort:false, id:"ROW_CHK" });
                addColumn({ width:150, align:"left"  , type:"string" , sort:true , id:"REQ_SUBJECT"   , name:"청구서제목" });
                addColumn({ width:60 , align:"center", type:"number" , sort:true , id:"CNT_CNF_NULL"  , name:"청구건수" });
                addColumn({ width:60 , align:"center", type:"number" , sort:true , id:"CNT_CNF_YES"   , name:"승인" });
                addColumn({ width:60 , align:"center", type:"number" , sort:true , id:"CNT_CNF_NO"    , name:"반려" });
                addColumn({ width:120, align:"right" , type:"number" , sort:true , id:"REQ_WON_PRICE" , name:"원화(KRW)" , format:"#,###" });
                addColumn({ width:120, align:"right" , type:"number" , sort:true , id:"SUPER_TAX"     , name:"부가세(KRW)" , format:"#,###" });
                addColumn({ width:120, align:"right" , type:"number" , sort:true , id:"REQ_PRICE"     , name:"외화"      , format:"#,##0.##" });
                addColumn({ width:80 , align:"left"  , type:"string" , sort:true , id:"INVOICE_NO"    , name:"INVOICE번호" });
                addColumn({ width:120, align:"left"  , type:"string" , sort:true , id:"OFFICE_NAME"   , name:"사무소" });
                addColumn({ width:70 , align:"center", type:"string" , sort:true , id:"REQ_USER_NAME" , name:"청구자" });
                addColumn({ width:75 , align:"center", type:"date"   , sort:true , id:"REQ_DATE"      , name:"청구일" });
                messageSpan = "spn_gridMessage";
                setFixedColumn(null, "CNT_CNF_NO");
                addSorting("REQ_DATE", "DESC");
                addAction("REQ_SUBJECT", fnCostRequestDetail);

                addCheck("ROW_CHK", function(gr, fg, row, colId)
                {
                    if (element.value(row, "CNT_CNF_NULL") != "0") return;
                    if (element.value(row, "CNT_CNF_NO") != "0") return;
                    if (element.value(row, "REQ_YN") != "1") return;
                    if (element.value(row, "INVOICE_NO") == "") return;
                  //  alert("CNT_CNF_NULL>>>>>"+element.value(row, "CNT_CNF_NULL"));
                  //  alert("CNT_CNF_NO>>>>>"+element.value(row, "CNT_CNF_NO"));
                  //  alert("REQ_YN>>>>>"+element.value(row, "REQ_YN"));
                  //  alert("INVOICE_NO>>>>>"+element.value(row, "INVOICE_NO"));

                    return flexUnchecked;
                });
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
    <TR>
        <TD height="1">
            <DIV class="button_area">
                <BUTTON text="품의서작성" onClick="javascript:fnCreateConsult();"></BUTTON>
            </DIV>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
