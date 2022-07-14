<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>보상금지급</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<ANY:DS id="ds_rewardSupplyList" />
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
}

//목록 조회
function fnRetrieve()
{
    var htCodes = new Array();
    var htCodeChecks = document.getElementsByName("HT_CODE");

    for (var i = 0; i < htCodeChecks.length; i++) {
        if (htCodeChecks[i].checked != true) continue;
        htCodes.push(htCodeChecks[i].value);
    }

    var ldr = gr_rewardSupplyList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.costmgt.reward.supply.act.RetrieveRewardSupplyList.do";
    ldr.addParam("SEARCH_TYPE", SEARCH_TYPE.value);
    ldr.addParam("SEARCH_TEXT", SEARCH_TEXT.value);
    ldr.addParam("INOUT_DIV", INOUT_DIV.value);
    ldr.addParam("REWARD_DIV", REWARD_DIV.value);
    ldr.addParam("EMP_GUBUN", EMP_GUBUN.value);
    ldr.addParam("SR_INV", SR_INV.value);
    ldr.addParam("DATE_GUBUN", DATE_GUBUN.value);
    ldr.addParam("DATE_START", DATE_START.value);
    ldr.addParam("DATE_END", DATE_END.value);
    ldr.addParam("REWARD_STATUS_DIV", REWARD_STATUS_DIV.value);
    ldr.addParam("HT_CODE", htCodes.join("|"));

    ldr.onStart = function(gr, fg)
    {
        cfShowObjects([btn_confirm], ldr.getParam("REWARD_STATUS_DIV") == "GIVE_TARGET");
        cfShowObjects([btn_createConsult, btn_cancelConfirm], ldr.getParam("REWARD_STATUS_DIV") == "CONSULT_TARGET");
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

//품의대상 처리
function fnConfirm()
{
    var gr = document.getElementById("gr_rewardSupplyList");
    var ds = document.getElementById("ds_rewardSupplyList");

    ds.init();

    for (var r = gr.fg.FixedRows; r < gr.fg.Rows; r++) {
        if (gr.checked(r, "ROW_CHK") != true) continue;

        ds.addRow();
        ds.value(ds.rowCount - 1, "COST_SEQ") = "";
        ds.value(ds.rowCount - 1, "REF_ID") = gr.value(r, "REF_ID");
        ds.value(ds.rowCount - 1, "REWARD_DIV") = gr.value(r, "REWARD_DIV");
        ds.value(ds.rowCount - 1, "INV_USER") = gr.value(r, "INV_USER");
        ds.value(ds.rowCount - 1, "REWARD_PRICE") = gr.value(r, "REWARD_PRICE");
        ds.value(ds.rowCount - 1, "CRE_USER") = "<%= app.userInfo.getUserId() %>";
        ds.value(ds.rowCount - 1, "REWARD_GRADE") = (gr.value(r, "REWARD_GRADE") == "" ? "N" : gr.value(r, "REWARD_GRADE"));
    }

    if (ds.rowCount == 0) {
        alert("선택된 건이 없습니다");
        return;
    }

    if (!confirm("품의대상 처리하시겠습니까?")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.costmgt.reward.supply.act.CreateRewardSupplyConfirm.do";
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

//품의대상 취소(삭제)
function fnCancelConfirm()
{
    var gr = document.getElementById("gr_rewardSupplyList");
    var ds = document.getElementById("ds_rewardSupplyList");

    ds.init();

    for (var r = gr.fg.FixedRows; r < gr.fg.Rows; r++) {
        if (gr.checked(r, "ROW_CHK") == true) ds.value(ds.addRow(), "COST_SEQ") = gr.value(r, "COST_SEQ");
    }

    if (ds.rowCount == 0) {
        alert("선택된 건이 없습니다");
        return;
    }

    if (!confirm("품의대상을 취소하시겠습니까?")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.costmgt.reward.supply.act.DeleteRewardSupplyConfirm.do";
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
    var gr = document.getElementById("gr_rewardSupplyList");
    var ds = document.getElementById("ds_rewardSupplyList");

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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.costmgt.reward.consult.act.CreateRewardConsult.do";
    prx.addData(ds);

    prx.onSuccess = function()
    {
        gr.loader.reload();
        alert("처리되었습니다.");

        var win = new any.viewer();
        win.path = top.getRoot() + "/anyfive/ipims/patent/costmgt/reward/consult/RewardConsultRD.jsp";
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
                    <COL class="conddata" width="23%">
                    <COL class="condhead" width="10%">
                    <COL class="conddata" width="23%">
                    <COL class="condhead" width="10%">
                    <COL class="conddata" width="23%">
                </COLGROUP>
                <TR>
                    <TD>검색번호</TD>
                    <TD colspan="3">
                        <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                            <TR>
                                <TD>
                                    <ANY:SELECT id="SEARCH_TYPE" codeData="/costmgt/rewardSupplyNoGubun" style="width:80px; margin-right:3px;" />
                                </TD>
                                <TD width="100%">
                                    <INPUT type="text" id="SEARCH_TEXT" style="text-transform:uppercase;">
                                </TD>
                            </TR>
                        </TABLE>
                    </TD>
                    <TD>보상금구분</TD>
                    <TD>
                        <ANY:SELECT id="REWARD_DIV" codeData="{REWARD_DIV}" firstname="all"/>
                    </TD>
                </TR>
                <TR>
                    <TD>발명자</TD>
                    <TD>
                        <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                            <TR>
                                <TD>
                                    <ANY:SELECT id="EMP_GUBUN" codeData="/common/userSearchGubun" style="width:80px; margin-right:3px;" />
                                </TD>
                                <TD width="100%">
                                    <INPUT type="text" id="SR_INV" style="width:100%;">
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
                        <ANY:SELECT id="REWARD_STATUS_DIV" codeData="/costmgt/rewardStatus" />
                    </TD>
                </TR>
                <TR>
                    <TD>검색일자</TD>
                    <TD colspan="3">
                        <ANY:SELECT id="DATE_GUBUN" codeData="/costmgt/rewardSupplySearchDateType" firstName="none" style="width:80px; margin-right:3px;" />
                        <ANY:DATE id="DATE_START" disabled />&nbsp;~
                        <ANY:DATE id="DATE_END" disabled />
                    </TD>
                    <TD>휴퇴구분</TD>
                    <TD colspan="3" noWrap>
                        <ANY:CHECK id="HT_CODE" text="재직" checkValue="C" />
                        <ANY:CHECK id="HT_CODE" text="휴직" checkValue="H" />
                        <ANY:CHECK id="HT_CODE" text="퇴직" checkValue="T" />
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
            <ANY:GRID id="gr_rewardSupplyList" pagingType="0"><COMMENT>
                addColumn({ width:30 , align:"center", type:"check" , sort:false, id:"ROW_CHK" });
                addColumn({ width:120, align:"left"  , type:"string", sort:true , id:"REF_NO"                , name:"REF-NO" });
                addColumn({ width:50 , align:"center", type:"string", sort:true , id:"INOUT_DIV_NAME"        , name:"국내외" });
                addColumn({ width:60 , align:"center", type:"string", sort:true , id:"RIGHT_DIV_NAME"        , name:"권리구분" });
                addColumn({ width:70 , align:"center", type:"string", sort:true , id:"REWARD_DIV_NAME"       , name:"보상금구분" });
                addColumn({ width:40 , align:"center", type:"string", sort:true , id:"REWARD_GRADE"          , name:"등급" });
                addColumn({ width:60 , align:"center", type:"string", sort:true , id:"EMP_HNAME"             , name:"발명자" });
                addColumn({ width:70 , align:"center", type:"string", sort:true , id:"EMP_NO"                , name:"사번" });
                addColumn({ width:70 , align:"left"  , type:"string", sort:true , id:"APP_EXT_MAN_CODE"      , name:"출원인" });
                addColumn({ width:70 , align:"left"  , type:"string", sort:true , id:"COSTSHARE_OWNER_NAME"  , name:"비용주체" });
                addColumn({ width:80 , align:"left"  , type:"string", sort:true , id:"DEPT_NAME"             , name:"부서" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"APP_NO"                , name:"출원번호" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"APP_DATE"              , name:"출원일" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"REG_NO"                , name:"등록번호" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"REG_DATE"              , name:"등록일" });
                addColumn({ width:80 , align:"right" , type:"number", sort:true , id:"REWARD_PRICE"          , name:"금액" , format:"#,###"});
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
                <BUTTON text="품의대상" onClick="javascript:fnConfirm();" id="btn_confirm" display="none"></BUTTON>
                <BUTTON text="품의대상취소" onClick="javascript:fnCancelConfirm();" id="btn_cancelConfirm" display="none"></BUTTON>
                <BUTTON text="품의서생성" onClick="javascript:fnCreateConsult();" id="btn_createConsult" display="none"></BUTTON>
            </DIV>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
