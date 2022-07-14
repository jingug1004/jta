<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>비용결재 취소</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<ANY:DS id="ds_costCancleList" />
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();
}

//목록 조회
function fnRetrieve()
{
    var ldr = gr_costCancleList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.datahandle.costappcancle.act.RetrieveCostCancleList.do";
    ldr.addParam("CONSULT_SUBJECT" , CONSULT_SUBJECT.value);
    ldr.addParam("CRE_USER"        , CRE_USER.value);
    ldr.addParam("DATE_START"      , DATE_START.value);
    ldr.addParam("DATE_END"        , DATE_END.value);

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
    win.path = top.getRoot() + "/anyfive/ipims/patent/costmgt/cost/consult/CostConsultRD.jsp";
    win.arg.CONSULT_ID = gr.value(row, "CONSULT_ID");
    win.arg.gr = gr;
    win.arg.fg = fg;

    win.onReload = function()
    {
        gr.loader.reload();
    }

    win.show();
}

function fnAppCancle()
{
    var gr = gr_costCancleList;
    var ds = ds_costCancleList;

    ds.init();

    for(var r = gr.fg.FixedRows; r< gr.fg.Rows; r++ ){
        if(gr.checked(r,"ROW_CHK") != true)continue;
        ds.addRow();
        ds.value(ds.rowCount -1, "APPR_NO") = gr.value(r,"APPR_NO");
    }
    if(ds.rowCount == 0){
        alert("취소할 품의건을 1개이상 선택하십시요.");
        return;
    }
    if (!confirm("결재를 취소하시겠습니까?")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.datahandle.costappcancle.act.CostCancleListU.do";
    prx.addData(ds);
    prx.onSuccess = function()
    {
        alert("결재를 취소하였습니다.");
        fnRetrieve();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();

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
                    <TD>요청자</TD>
                    <TD>
                        <INPUT type="text" id="CRE_USER" >
                    </TD>

                </TR>
                <TR>
                    <TD>요청일</TD>
                    <TD colspan="3">
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
            <ANY:GRID id="gr_costCancleList" pagingType="1"><COMMENT>
                addColumn({ width:30 , align:"center", type:"check" , sort:false, id:"ROW_CHK" });
                addColumn({ width:150, align:"left"  , type:"string" , sort:true , id:"CONSULT_SUBJECT"  , name:"품의제목" });
                addColumn({ width:100 , align:"center", type:"string" , sort:true , id:"CRE_USER_NAME"    , name:"요청자" });
                addColumn({ width:100 , align:"center", type:"date"   , sort:true , id:"CRE_DATE"         , name:"요청일" });
                addColumn({ width:100, align:"center", type:"string" , sort:true , id:"APPR_STATUS_NAME" , name:"진행상태" });
                addColumn({ width:100, align:"center", type:"string" , sort:true , id:"CONSULT_ID" , name:"품의번호" , hide:true});
                addColumn({ width:100, align:"center", type:"string" , sort:true , id:"APPR_NO" , name:"결재번호" , hide:true});
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_CHK", "CONSULT_SUBJECT");
                addSorting("CONSULT_SUBJECT", "DESC");
                addAction("CONSULT_SUBJECT", fnDetail);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
    <TR>
        <TD height="1" align="right">
            <DIV class="button_area">
                <BUTTON text="결재취소" onClick="javascript:fnAppCancle();"></BUTTON>
            </DIV>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
