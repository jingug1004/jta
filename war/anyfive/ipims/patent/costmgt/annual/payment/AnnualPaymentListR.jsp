<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>연차료 납부관리</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<ANY:DS id="ds_annualPaymentList" />
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();
}

//목록 조회
function fnRetrieve()
{
    var ldr = gr_annualPaymentList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.costmgt.annual.payment.act.RetrieveAnnualPaymentList.do";
    ldr.addParam("RIGHT_DIV", RIGHT_DIV.value);
    ldr.addParam("ANNUAL_DIV", ANNUAL_DIV.value);
    ldr.addParam("SEARCH_TYPE", SEARCH_TYPE.value);
    ldr.addParam("SEARCH_TEXT", SEARCH_TEXT.value);
    ldr.addParam("DATE_GUBUN", DATE_GUBUN.value);
    ldr.addParam("DATE_START", DATE_START.value);
    ldr.addParam("DATE_END", DATE_END.value);
    ldr.addParam("KO_APP_TITLE", KO_APP_TITLE.value);

    ldr.onSuccess = function(gr, fg)
    {
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

//청구비용 업로드
function fnUploadPayment()
{
    var win = new any.window();
    win.path = "AnnualPaymentC.jsp";
    win.opt.width = 800;
    win.opt.height = 600;
    win.opt.resizable = "yes";

    win.onReload = function()
    {
        fnRetrieve();
    }

    win.show();
}

//마스터
function fnMaster(gr, fg, row, colId)
{
    var win = new any.viewer();
    switch (gr.value(row, "INOUT_DIV")) {
    case "INT":
        win.path = top.getRoot() + "/anyfive/ipims/patent/applymgt/common/IntMasterTabR.jsp";
        break;
    case "EXT":
        win.path = top.getRoot() + "/anyfive/ipims/patent/applymgt/common/ExtMasterTabR.jsp";
        break;
    }
    win.arg.REF_ID = gr.value(row, "REF_ID");

    win.onReload = function()
    {
        gr.loader.reload();
    }

    win.show();
}

//품의서작성
function fnCreateConsult()
{
    var gr = document.getElementById("gr_annualPaymentList");
    var ds = document.getElementById("ds_annualPaymentList");

    ds.init();

    for (var r = gr.fg.FixedRows; r < gr.fg.Rows; r++) {
        if (gr.checked(r, "ROW_CHK") == true) ds.value(ds.addRow(), "COST_SEQ") = gr.value(r, "COST_SEQ");
    }

    if (ds.rowCount == 0) {
        alert("선택된 건이 없습니다");
        return;
    }

    if (!confirm("품의서를 작성하시겠습니까?")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.costmgt.annual.consult.act.CreateAnnualConsult.do";
    prx.addData(ds);

    prx.onSuccess = function()
    {
        gr.loader.reload();
        alert("처리되었습니다.");

        var win = new any.viewer();
        win.path = top.getRoot() + "/anyfive/ipims/patent/costmgt/annual/consult/AnnualConsultRD.jsp";
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
                    <COL class="condhead" width="10%">
                    <COL class="conddata" width="20%">
                    <COL class="condhead" width="10%">
                    <COL class="conddata" width="20%">
                    <COL class="condhead" width="10%">
                    <COL class="conddata" width="30%">
                </COLGROUP>
                <TR>
                    <TD>권리구분</TD>
                    <TD noWrap>
                        <ANY:SELECT id="RIGHT_DIV" codeData="{RIGHT_DIV}" firstName="all" />
                    </TD>
                    <TD>연차구분</TD>
                    <TD noWrap>
                        <ANY:SELECT id="ANNUAL_DIV" codeData="{ANNUAL_DIV}" firstName="all" />
                    </TD>
                    <TD>검색번호</TD>
                    <TD>
                        <TABLE border="0" cellspacing="0" cellpadding="1" width="100%">
                            <TR>
                                <TD noWrap width="80">
                                    <ANY:SELECT id="SEARCH_TYPE" codeData="/costmgt/annualSearchType" style="width:80px;" />
                                </TD>
                                <TD noWrap>
                                    <INPUT type="text" id="SEARCH_TEXT" style="text-transform:uppercase;" />
                                </TD>
                            </TR>
                        </TABLE>
                    </TD>
                </TR>
                <TR>
                    <TD>검색일자</TD>
                    <TD noWrap colspan="3">
                        <ANY:SELECT id="DATE_GUBUN" codeData="/costmgt/annualApplyDateKind" firstName="none" style="width:80px; margin-right:3px;"  />
                        <ANY:DATE id="DATE_START" disabled />&nbsp;~
                        <ANY:DATE id="DATE_END" disabled />
                    </TD>
                    <TD>발명의 명칭</TD>
                    <TD>
                        <INPUT type="text" id="KO_APP_TITLE">
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
                        <BUTTON text="청구비용업로드" onClick="javascript:fnUploadPayment();"></BUTTON>
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
            <ANY:GRID id="gr_annualPaymentList" pagingType="0"><COMMENT>
                addColumn({ width:30 , align:"center", type:"string", sort:false, id:"ROW_CHK" });
                addColumn({ width:80, align:"left"  , type:"string", sort:true , id:"COUNTRY_CODE"            , name:"국가코드" });
                addColumn({ width:120, align:"left"  , type:"string", sort:true , id:"REF_NO"                 , name:"REF-NO" });
                addColumn({ width:200, align:"left"  , type:"string", sort:true , id:"KO_APP_TITLE"           , name:"발명의명칭" });
                addColumn({ width:70 , align:"center", type:"string", sort:true , id:"RIGHT_DIV_NAME"         , name:"권리구분" });
                addColumn({ width:150 , align:"left", type:"string", sort:true , id:"APP_MAN_NAME"           , name:"출원인" });
                addColumn({ width:70 , align:"left", type:"string", sort:true , id:"COSTSHARE_OWNER_NAME"   , name:"비용주체" });
                addColumn({ width:70 , align:"center", type:"string", sort:true , id:"INDEP_CLAIM"            , name:"독립항" });
                addColumn({ width:70 , align:"center", type:"string", sort:true , id:"SUBORD_CLAIM"           , name:"종속항" });
                addColumn({ width:70 , align:"center", type:"string", sort:true , id:"TOTAL_CLAIM"            , name:"총항수" });
                addColumn({ width:120, align:"left"  , type:"string", sort:true , id:"OFFICE_NAME"            , name:"국내사무소" });
                addColumn({ width:120, align:"left"  , type:"string", sort:true , id:"EXT_OFFICE_NAME"        , name:"해외사무소" });
                addColumn({ width:70 , align:"center", type:"string", sort:true , id:"PAY_YEARDEG"            , name:"납부년차" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"PAY_LIMIT"              , name:"납부기한" });
                addColumn({ width:90 , align:"right" , type:"number", sort:true , id:"PRICE"                  , name:"관납료"     , format:"#,##0.##" });
                addColumn({ width:90 , align:"right" , type:"number", sort:true , id:"INT_OFFICE_CHARGE"      , name:"수수료"     , format:"#,##0.##" });
                addColumn({ width:90 , align:"right" , type:"number", sort:true , id:"EXT_OFFICE_CHARGE"      , name:"송금수수료" , format:"#,##0.##" });
                addColumn({ width:90 , align:"center", type:"string", sort:true , id:"APP_NO"                 , name:"출원번호" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"APP_DATE"               , name:"출원일" });
                addColumn({ width:90 , align:"center", type:"string", sort:true , id:"REG_NO"                 , name:"등록번호"  });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"REG_DATE"               , name:"등록일" });
                addColumn({ width:90 , align:"center", type:"string", sort:true , id:"DETAIL_CODE"                 , name:"세부코드"  });
                useConfig = true;
                messageSpan = "spn_gridMessage";
                setFixedColumn(null, "KO_APP_TITLE");
                addAction("KO_APP_TITLE", fnMaster);

                addCheck("ROW_CHK", function(gr, fg, row, colId)
                {
                    if (element.value(row, "COST_SEQ") != "") return flexUnchecked;
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
