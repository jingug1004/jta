<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>전표처리 상세</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("SLIP_KIND_NAME");
    addBind("SLIP_SUBJECT");
    addBind("COST_DATE");
    addBind("INVOICE_DATE");
    addBind("PAYMENT_DATE");
    addBind("SUPER_TAX");
    addBind("TOT_WON_PRICE");
    addBind("ACCOUNT_PROC_YN_NAME");
    addBind("ACCOUNT_PROC_DATE");
    addBind("ACCOUNT_PROC_USER_NAME");
    addBind("ACCOUNT_SLIP_NO");
    addBind("CRE_USER_NAME");
    addBind("CRE_DATE");
    addBind("E_MSG");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();
    fnRetrieveSlipProcCostList();
}

//조회
function fnRetrieve()
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.costmgt.slip.proc.act.RetrieveSlipProc.do";
    prx.addParam("SLIP_ID", parent.SLIP_ID);
    prx.checkData = ds_mainInfo;

    prx.onSuccess = function()
    {
        cfShowObjects([ btn_line1, btn_confirm, btn_line2], ds_mainInfo.value(0, "FLAG") == "" && ds_mainInfo.value(0, "COST_DATE") != "" && ds_mainInfo.value(0, "INVOICE_DATE") != "");

        if(ds_mainInfo.value(0, "FLAG") == "I" || ds_mainInfo.value(0, "FLAG") == "S" || ds_mainInfo.value(0, "FLAG") == "A"){
            btn_confirm.style.display = "none";

        }

        cfShowObjects([btn_modify, btn_delete, btn_line1], ds_mainInfo.value(0, "ACCOUNT_SLIP_NO") == "" );

      //  cfShowObjects([btn_sapCancel, btn_line3], ds_mainInfo.value(0, "ACCOUNT_SLIP_NO") != "0");

      cfShowObjects([btn_sapCancel, btn_line3], ds_mainInfo.value(0, "FLAG") == "I" || ds_mainInfo.value(0, "FLAG") == "A");

     // btn_sapCancel.disabled = (ACCOUNT_SLIP_NO.value == "");
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//전표 비용 목록 조회
function fnRetrieveSlipProcCostList()
{
    var ldr = gr_annualSlipCostList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.costmgt.slip.annual.act.RetrieveAnnualSlipCostList.do";
    ldr.addParam("SLIP_ID", parent.SLIP_ID);

    ldr.onSuccess = function()
    {
    }

    ldr.onFail = function()
    {
        this.error.show();
    }

    ldr.execute();
}

//수정
function fnModify()
{
    window.location.href = "AnnualSlipU.jsp";
}

//삭제
function fnDelete()
{
    if (!confirm("<%= app.message.get("msg.com.confirm.delete").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.costmgt.slip.proc.act.DeleteSlipProc.do";
    prx.addParam("SLIP_ID" , parent.SLIP_ID);

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.delete").toJS() %>");
        parent.goList();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//완료처리
function fnConfirm()
{
    if (!confirm("전표처리 하시겠습니까 ?")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.costmgt.slip.proc.act.UpdateSlipProcConfirm.do";
    prx.addParam("SLIP_ID", parent.SLIP_ID);
    prx.addParam("COST_DATE", ds_mainInfo.value(0, "COST_DATE"));
    prx.addParam("INVOICE_DATE", ds_mainInfo.value(0, "INVOICE_DATE"));
    prx.addParam("CRE_USER", ds_mainInfo.value(0, "CRE_USER"));
    prx.addParam("SLIP_KIND", ds_mainInfo.value(0, "SLIP_KIND"));


    prx.onSuccess = function()
    {
        alert("처리되었습니다.");
        window.location.reload();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//전표취소
function fnSapCancel()
{
    if (!confirm("전표취소 하시겠습니까 ?")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.costmgt.slip.proc.act.CanCelSap.do";
    prx.addParam("SLIP_ID", parent.SLIP_ID);
    prx.addParam("ACCOUNT_SLIP_NO", ds_mainInfo.value(0, "ACCOUNT_SLIP_NO"));
    prx.addParam("E_GJAHR", ds_mainInfo.value(0, "E_GJAHR"));
    prx.addParam("SLIP_KIND", ds_mainInfo.value(0, "SLIP_KIND"));

    prx.onSuccess = function()
    {
        alert("처리되었습니다.");
        window.location.reload();
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
            <TABLE border="0" cellspacing="1" cellpadding="2" class="main">
                <COLGROUP>
                    <COL class="conthead" width="15%">
                    <COL class="contdata" width="18%">
                    <COL class="conthead" width="15%">
                    <COL class="contdata" width="18%">
                    <COL class="conthead" width="15%">
                    <COL class="contdata" width="18%">
                </COLGROUP>
                <TR>
                    <TD>전표 제목</TD>
                    <TD colspan="5"><ANY:SPAN id="SLIP_SUBJECT" /></TD>
                </TR>
                <TR>
                    <TD>전표종류</TD>
                    <TD><ANY:SPAN id="SLIP_KIND_NAME" /></TD>
                    <TD>작성자</TD>
                    <TD><ANY:SPAN id="CRE_USER_NAME" /></TD>
                    <TD>작성일</TD>
                    <TD><ANY:SPAN id="CRE_DATE" format="date"/></TD>
                </TR>
                <TR>
                    <TD>전기일자</TD>
                    <TD><ANY:SPAN id="COST_DATE" format="date" /></TD>
                    <TD>증빙일자</TD>
                    <TD><ANY:SPAN id="INVOICE_DATE" format="date" /></TD>
                    <TD>만기출금일자</TD>
                    <TD><ANY:SPAN id="PAYMENT_DATE" format="date" /></TD>
                </TR>
                <TR>
                    <TD>회계전표번호</TD>
                    <TD><ANY:SPAN id="ACCOUNT_SLIP_NO"/></TD>
                    <TD>부가세</TD>
                    <TD><ANY:SPAN id="SUPER_TAX" format="number2" /></TD>
                    <TD>합계금액</TD>
                    <TD><ANY:SPAN id="TOT_WON_PRICE" format="number2"/>원</TD>
                </TR>
                <TR>
                    <TD>완료처리여부</TD>
                    <TD><ANY:SPAN id="ACCOUNT_PROC_YN_NAME" /></TD>
                    <TD>완료처리자</TD>
                    <TD><ANY:SPAN id="ACCOUNT_PROC_USER_NAME" /></TD>
                    <TD>완료처리일</TD>
                    <TD><ANY:SPAN id="ACCOUNT_PROC_DATE" format="date" /></TD>
                </TR>
                <TR>
                    <TD>전표처리메시지</TD>
                    <TD colspan="5"><ANY:SPAN id="E_MSG" /></TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD>
            <DIV class="button_area">
                <BUTTON text="<%= app.message.get("btn.com.modify").toHTML() %>" onClick="javascript:fnModify();" id="btn_modify" display="none"></BUTTON>
                <BUTTON text="<%= app.message.get("btn.com.delete").toHTML() %>" onClick="javascript:fnDelete();" id="btn_delete" display="none"></BUTTON>
                <BUTTON auto="line" id="btn_line1" display="none"></BUTTON>
                <BUTTON text="전표처리" onClick="javascript:fnConfirm();" id="btn_confirm" display="none"></BUTTON>
                <BUTTON auto="line" id="btn_line2" display="none"></BUTTON>
                <BUTTON text="전표취소" onClick="javascript:fnSapCancel();" id="btn_sapCancel" display="none"></BUTTON>
                <BUTTON auto="line" id="btn_line3" display="none"></BUTTON>
                <BUTTON auto="list"></BUTTON>
            </DIV>
        </TD>
    </TR>
    <TR>
        <TD height="10"></TD>
    </TR>
    <TR>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD class="title_sub">비용 목록</TD>
                    <TD align="right">
                        <SPAN id="spn_gridMessage"></SPAN>
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
            <ANY:GRID id="gr_annualSlipCostList" pagingType="0" minHeight="200px"><COMMENT>
                addColumn({ width:40 , align:"center", type:"number", sort:false, id:"ROW_NUM"          , name:"No" });
                addColumn({ width:120, align:"left"  , type:"string", sort:true , id:"REF_NO"           , name:"REF-NO" });
                addColumn({ width:200, align:"left"  , type:"string", sort:true , id:"KO_APP_TITLE"     , name:"발명의명칭" });
                addColumn({ width:70 , align:"center", type:"string", sort:true , id:"RIGHT_DIV_NAME"   , name:"권리구분" });
                addColumn({ width:120, align:"left"  , type:"string", sort:true , id:"OFFICE_NAME"      , name:"사무소" });
                addColumn({ width:70 , align:"center", type:"string", sort:true , id:"PAY_YEARDEG"      , name:"납부년차" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"PAY_LIMIT"        , name:"납부기한" });
                addColumn({ width:90 , align:"right" , type:"number", sort:true , id:"PRICE"            , name:"관납료"     , format:"#,##0.##" });
                addColumn({ width:90 , align:"right" , type:"number", sort:true , id:"INT_OFFICE_CHARGE", name:"수수료"     , format:"#,##0.##" });
                addColumn({ width:90 , align:"right" , type:"number", sort:true , id:"EXT_OFFICE_CHARGE", name:"송금수수료" , format:"#,##0.##" });
                addColumn({ width:90 , align:"center", type:"string", sort:true , id:"APP_NO"           , name:"출원번호" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"APP_DATE"         , name:"출원일" });
                addColumn({ width:90 , align:"center", type:"string", sort:true , id:"REG_NO"           , name:"등록번호"  });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"REG_DATE"         , name:"등록일" });
                messageSpan = "spn_gridMessage";
                addSorting("REF_NO", "ASC");
                setFixedColumn("ROW_NUM", "KO_APP_TITLE");
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
