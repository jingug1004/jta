<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.office.common.app.OfficeApp"%><% OfficeApp app = new OfficeApp(request, response, out); %>
<%@page import="any.util.etc.NDateUtil"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>국내비용입력 목록</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<ANY:DS id="ds_intCostList" />
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();
}

//목록 조회
function fnRetrieve()
{
    var ldr = gr_intCostList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.office.costmgt.intcost.act.RetrieveIntCostList.do";
    ldr.addParam("SEARCH_TYPE" , SEARCH_TYPE.value);
    ldr.addParam("SEARCH_TEXT" , SEARCH_TEXT.value);
    ldr.addParam("MST_DIV"     , MST_DIV.value);
    ldr.addParam("RIGHT_DIV"   , RIGHT_DIV.value);
    ldr.addParam("DATE_GUBUN"  , DATE_GUBUN.value);
    ldr.addParam("DATE_START"  , DATE_START.value);
    ldr.addParam("DATE_END"    , DATE_END.value);

    ldr.onStart = function(gr, fg)
    {
    }

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
function fnOpenCreate()
{
    var win = new any.window();
    win.path = top.getRoot() + "/anyfive/ipims/share/cost/input/CostInputC.jsp";
    win.opt.width = 800;
    win.opt.height = 600;
    win.arg.gr = gr_intCostList;

    win.onReload = function()
    {
        gr_intCostList.loader.reload();
    }

    win.show();
}


//상세
function fnDetail(gr, fg, row, colId)
{
    var win = new any.window();
    win.path = top.getRoot() + "/anyfive/ipims/share/cost/input/CostInputRD.jsp";
    win.arg.COST_SEQ = gr.value(row, "COST_SEQ");
    win.arg.gr = gr;
    win.opt.width = 800;
    win.opt.height = 600;

    win.onReload = function()
    {
        gr_intCostList.loader.reload();
    }

    win.show();
}


//청구서 생성
function fnCreateRequest()
{
    var gr = document.getElementById("gr_intCostList");
    var ds = document.getElementById("ds_intCostList");

    ds.init();

    for (var r = gr.fg.FixedRows; r < gr.fg.Rows; r++) {
        if (gr.checked(r, "ROW_CHK") == true) ds.value(ds.addRow(), "COST_SEQ") = gr.value(r, "COST_SEQ");
    }

    if (ds.rowCount == 0) {
        alert("선택된 건이 없습니다");
        return;
    }

    if (!confirm("청구서를 생성하시겠습니까?")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.share.cost.request.act.CreateIntCostRequest.do";
    prx.addParam("OFFICE_CODE", "<%= app.userInfo.getOfficeCode() %>");
    prx.addData(ds);

    prx.onSuccess = function()
    {
        gr.loader.reload();
        alert("처리되었습니다.");

        var win = new any.window();
        win.path = top.getRoot() + "/anyfive/ipims/share/cost/request/IntCostRequestU.jsp";
        win.arg.REQ_ID = this.result;
        win.arg.gr = gr_intCostList;
        win.opt.width = 800;
        win.opt.height = 650;

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
                    <TD>검색번호</TD>
                    <TD>
                        <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                            <TR>
                                <TD>
                                    <ANY:SELECT id="SEARCH_TYPE" codeData="/costmgt/costInputSearchNoDiv" style="width:80px; margin-right:3px;" />
                                </TD>
                                <TD width="100%">
                                    <INPUT type="text" id="SEARCH_TEXT" style="text-transform:uppercase;">
                                </TD>
                            </TR>
                        </TABLE>
                    </TD>
                    <TD>구분</TD>
                    <TD>
                        <ANY:SELECT id="MST_DIV" codeData="{COST_MST_DIV}" firstName="all" />
                    </TD>
                </TR>
                <TR>
                    <TD>검색일자</TD>
                    <TD noWrap>
                        <ANY:SELECT id="DATE_GUBUN" codeData="/costmgt/costInputSearchDateDiv" firstName="none" style="width:80px; margin-right:3px;" />
                        <ANY:DATE id="DATE_START" disabled />&nbsp;~
                        <ANY:DATE id="DATE_END" disabled />
                    </TD>
                    <TD>권리구분</TD>
                    <TD>
                        <ANY:SELECT id="RIGHT_DIV" codeData="{RIGHT_DIV_ALL}" firstName="all"/>
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
                        <BUTTON text="<%= app.message.get("btn.com.write").toHTML() %>" onClick="javascript:fnOpenCreate();"></BUTTON>
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
            <ANY:GRID id="gr_intCostList" pagingType="0"><COMMENT>
                addColumn({ width:30 , align:"center", type:"check"  , sort:false, id:"ROW_CHK" });
                addColumn({ width:120, align:"left"  , type:"string" , sort:true , id:"REF_NO"         , name:"REF-NO" });
                addColumn({ width:70 , align:"center", type:"string" , sort:true , id:"MST_DIV_NAME"   , name:"구분" });
                addColumn({ width:60 , align:"center", type:"string" , sort:true , id:"RIGHT_DIV_NAME" , name:"권리구분" });
                addColumn({ width:130, align:"left"  , type:"string" , sort:true , id:"KO_APP_TITLE"   , name:"발명의 명칭" });
                addColumn({ width:115, align:"left"  , type:"string" , sort:true , id:"GRAND_NAME"     , name:"대분류" });
                addColumn({ width:80 , align:"left"  , type:"string" , sort:true , id:"DETAIL_NAME"    , name:"상세분류" });
                addColumn({ width:80 , align:"right" , type:"number" , sort:true , id:"WON_PRICE"      , name:"원화금액" , format:"#,###" });
                addColumn({ width:100, align:"left"  , type:"date"   , sort:true , id:"APP_NO"         , name:"출원번호" });
                addColumn({ width:75 , align:"center", type:"date"   , sort:true , id:"APP_DATE"       , name:"출원일" });
                addColumn({ width:100, align:"left"  , type:"string" , sort:true , id:"REG_NO"         , name:"등록번호" });
                addColumn({ width:75 , align:"center", type:"date"   , sort:true , id:"REG_DATE"       , name:"등록일" });
                addColumn({ width:70 , align:"center", type:"string" , sort:true , id:"JOB_MAN_NAME"   , name:"건담당자" });
                useConfig = true;
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_CHK", "REF_NO");
                addSorting("REF_NO", "DESC");
                addAction("REF_NO", fnDetail);

                addCheck("ROW_CHK", function(gr, fg, row, colId)
                {
                    if (element.value(row, "WON_PRICE") == "") return flexUnchecked;
                });
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
    <TR>
        <TD height="1">
            <DIV class="button_area">
                <BUTTON text="청구서작성" onClick="javascript:fnCreateRequest();"></BUTTON>
            </DIV>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
