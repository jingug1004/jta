<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>자본적 지출 확정</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<ANY:DS id="ds_capitalMgtList" />
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
}

//목록 조회
function fnRetrieve()
{
    var ldr = gr_capitalMgtList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.costmgt.capital.confirm.act.RetrieveCapitalMgtList.do";
    ldr.addParam("ASSET_STATUS", ASSET_STATUS.value);
    ldr.addParam("SEARCH_TYPE", SEARCH_TYPE.value);
    ldr.addParam("SEARCH_TEXT", SEARCH_TEXT.value);
    ldr.addParam("INOUT_DIV", INOUT_DIV.value);
    ldr.addParam("OFFICE_CODE", OFFICE_CODE.value);
    ldr.addParam("DATE_GUBUN", DATE_GUBUN.value);
    ldr.addParam("DATE_START", DATE_START.value);
    ldr.addParam("DATE_END", DATE_END.value);

    ldr.onStart = function(gr, fg)
    {
        cfShowObjects([btn_confirm], ldr.getParam("ASSET_STATUS") == "0");
        cfShowObjects([btn_createConsult, btn_cancelConfirm], ldr.getParam("ASSET_STATUS") == "1");
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

//상세
function fnDetailMaster(gr, fg, row, colId)
{
    var win = new any.viewer();
    if( gr.value(row, "INOUT_DIV") == "INT") {
        win.path = top.getRoot() + "/anyfive/ipims/patent/applymgt/common/IntMasterTabR.jsp";
    } else {
        win.path = top.getRoot() + "/anyfive/ipims/patent/applymgt/common/ExtMasterTabR.jsp";
    }
    win.arg.REF_ID = gr.value(row, "REF_ID");
    win.arg.gr = gr;
    win.arg.fg = fg;

    win.onReload = function()
    {
        gr.loader.reload();
    }

    win.show();
}

//자본적 지출 확정
function fnConfirm()
{
    var gr = document.getElementById("gr_capitalMgtList");
    var ds = document.getElementById("ds_capitalMgtList");

    ds.init();

    for (var r = gr.fg.FixedRows; r < gr.fg.Rows; r++) {
        if (gr.checked(r, "ROW_CHK") != true) continue;

        ds.addRow();
        ds.value(ds.rowCount - 1, "REF_ID") = gr.value(r, "REF_ID");
        ds.value(ds.rowCount - 1, "ASSET_PRICE") = gr.value(r, "ASSET_PRICE");
    }

    if (ds.rowCount == 0) {
        alert("선택된 건이 없습니다");
        return;
    }

    if (!confirm("자본적 지출 확정을 처리하시겠습니까?")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.costmgt.capital.confirm.act.CreateCapitalMgt.do";
    prx.addData(ds);

    prx.onSuccess = function()
    {
        alert("처리되었습니다.");
        fnRetrieve();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//매각 확정취소(삭제)
function fnCancelConfirm()
{
    var gr = document.getElementById("gr_capitalMgtList");
    var ds = document.getElementById("ds_capitalMgtList");

    ds.init();

    for (var r = gr.fg.FixedRows; r < gr.fg.Rows; r++) {
        if (gr.checked(r, "ROW_CHK") == true) ds.value(ds.addRow(), "COST_SEQ") = gr.value(r, "COST_SEQ");
    }

    if (ds.rowCount == 0) {
        alert("선택된 건이 없습니다");
        return;
    }

    if (!confirm("매각확정을 취소하시겠습니까?")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.costmgt.capital.confirm.act.DeleteCapitalMgt.do";
    prx.addData(ds);

    prx.onSuccess = function()
    {
        alert("처리되었습니다.");
        fnRetrieve();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//품의서 생성
function fnCreateConsult()
{
    var gr = document.getElementById("gr_capitalMgtList");
    var ds = document.getElementById("ds_capitalMgtList");

    ds.init();

    for (var r = gr.fg.FixedRows; r < gr.fg.Rows; r++) {
        if (gr.checked(r, "ROW_CHK") == true) ds.value(ds.addRow(), "COST_SEQ") = gr.value(r, "COST_SEQ");
    }

    if (ds.rowCount == 0) {
        alert("선택된 건이 없습니다");
        return;
    }

    if (!confirm("품의서를 생성하시겠습니까?")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.costmgt.capital.consult.act.CreateCapitalMgtConsult.do";
    prx.addData(ds);

    prx.onSuccess = function()
    {
        gr.loader.reload();
        alert("처리되었습니다.");

        var win = new any.viewer();
        win.path = top.getRoot() + "/anyfive/ipims/patent/costmgt/capital/consult/CapitalConsultRD.jsp";
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
                    <COL class="conddata" width="30%">
                    <COL class="condhead" width="10%">
                    <COL class="conddata" width="20%">
                    <COL class="condhead" width="10%">
                    <COL class="conddata" width="20%">
                </COLGROUP>
                <TR>
                    <TD>검색번호</TD>
                    <TD>
                        <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                            <TR>
                                <TD>
                                    <ANY:SELECT id="SEARCH_TYPE" codeData="/costmgt/assetSearchTextType" style="width:80px; margin-right:3px;" />
                                </TD>
                                <TD width="100%">
                                    <INPUT type="text" id="SEARCH_TEXT" style="text-transform:uppercase;">
                                </TD>
                            </TR>
                        </TABLE>
                    </TD>
                    <TD>국가구분</TD>
                    <TD>
                        <ANY:SELECT id="INOUT_DIV" codeData="{INOUT_DIV}" firstName="all" />
                    </TD>
                    <TD>진행상태</TD>
                    <TD>
                        <ANY:SELECT id="ASSET_STATUS" codeData="/costmgt/assetStatus" />
                    </TD>
                </TR>
                <TR>
                    <TD>사무소</TD>
                    <TD>
                        <ANY:SELECT id="OFFICE_CODE" codeData="/common/officeCode" firstName="all" />
                    </TD>
                   <TD>검색일자</TD>
                    <TD colspan="3">
                        <ANY:SELECT id="DATE_GUBUN" codeData="/costmgt/assetSearchDateType" firstName="none" style="width:80px; margin-right:3px;" />
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
            <ANY:GRID id="gr_capitalMgtList" pagingType="0"><COMMENT>
                addColumn({ width:30 , align:"center", type:"check" , sort:false, id:"ROW_CHK" });
                addColumn({ width:120, align:"left"  , type:"string", sort:true , id:"REF_NO"           , name:"REF-NO" });
                addColumn({ width:50 , align:"center", type:"string", sort:true , id:"INOUT_DIV_NAME"   , name:"국내외" });
                addColumn({ width:60 , align:"center", type:"string", sort:true , id:"RIGHT_DIV_NAME"   , name:"권리구분" });
                addColumn({ width:200, align:"left"  , type:"string", sort:true , id:"KO_APP_TITLE"     , name:"발명의 명칭" });
                addColumn({ width:60 , align:"center", type:"string", sort:true , id:"JOB_MAN_NAME"     , name:"건담당자" });
                addColumn({ width:80 , align:"left"  , type:"string", sort:true , id:"OFFICE_NAME"      , name:"사무소" });
                addColumn({ width:110, align:"left"  , type:"string", sort:true , id:"INVENTOR_NAMES"   , name:"발명자" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"APP_NO"           , name:"출원번호" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"APP_DATE"         , name:"출원일" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"REG_NO"           , name:"등록번호" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"REG_DATE"         , name:"등록일" });
                addColumn({ width:100, align:"right" , type:"number", sort:true , id:"ASSET_PRICE"      , name:"금액", format:"#,###"});
                useConfig = true;
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_CHK", "REF_NO");
                addSorting("REF_NO", "ASC");
                addAction("REF_NO", fnDetailMaster);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
    <TR>
        <TD>
            <DIV class="button_area">
                <BUTTON text="자본적확정" onClick="javascript:fnConfirm();" id="btn_confirm" display="none"></BUTTON>
                <BUTTON text="자본적확정취소" onClick="javascript:fnCancelConfirm();" id="btn_cancelConfirm" display="none"></BUTTON>
                <BUTTON text="품의서생성" onClick="javascript:fnCreateConsult();" id="btn_createConsult" display="none"></BUTTON>
            </DIV>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
