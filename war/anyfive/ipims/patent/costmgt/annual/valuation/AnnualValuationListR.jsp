<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<%@page import="any.core.config.NConfig"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>등록유지평가 현황</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<ANY:DS id="ds_annualValuationList" />
<SCRIPT language="JScript">
var gEvalCode = "E03";

//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();
}

//목록 조회
function fnRetrieve()
{
    var ldr = gr_annualValuationList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.costmgt.annual.valuation.act.RetrieveAnnualValuationList.do";
    ldr.addParam("RIGHT_DIV", RIGHT_DIV.value);
    ldr.addParam("ANNUAL_DIV", ANNUAL_DIV.value);
    ldr.addParam("KO_APP_TITLE", KO_APP_TITLE.value);
    ldr.addParam("STATUS", STATUS.value);
    ldr.addParam("SEARCH_TYPE", SEARCH_TYPE.value);
    ldr.addParam("SEARCH_TEXT", SEARCH_TEXT.value);
    ldr.addParam("DATE_GUBUN", DATE_GUBUN.value);
    ldr.addParam("DATE_START", DATE_START.value);
    ldr.addParam("DATE_END", DATE_END.value);

    ldr.onStart = function(gr, fg)
    {
        fg.ColHidden(fg.ColIndex("ROW_CHK")) = (ldr.getParam("STATUS") != "S");
        cfShowObjects([btn_request, btn_bundle], ldr.getParam("STATUS") == "S");

        if (ldr.getParam("STATUS") == "S") {
            gr.addAction("INVDEPT_EVAL_USER_NAME", fnSearchEvalUser);
        } else {
            gr.delAction("INVDEPT_EVAL_USER_NAME");
        }
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
function fnDetail(gr, fg, row, colId)
{
    var win = new any.window();
    win.path = "AnnualValuationR.jsp";
    win.arg.REF_ID = gr.value(row, "REF_ID");
    win.arg.PAY_YEARDEG = gr.value(row, "PAY_YEARDEG");

    win.onReload = function()
    {
        gr.loader.reload();
    }

    win.show();
}

//발명부서 평가자 검색
function fnSearchEvalUser(gr, fg, row, colId)
{
    var win = new any.window();
    win.path = "AnnualValuationInvUserSearchList.jsp";
    win.arg.REF_ID = gr.value(row, "REF_ID");
    win.opt.width = 700;
    win.opt.height = 450;
    win.show();

    if (win.rtn == null) return;

    gr.value(row, "ROW_CHK") = "1";
    gr.value(row, "INVDEPT_EVAL_USER") = win.rtn.USER_ID;
    gr.value(row, "INVDEPT_EVAL_USER_NAME") = win.rtn.EMP_HNAME;
}

//발명자 평가요청
function fnReqValuation()
{
    var gr = document.getElementById("gr_annualValuationList");
    var ds = document.getElementById("ds_annualValuationList");

    ds.init();

    for (var r = gr.fg.FixedRows; r < gr.fg.Rows; r++) {
        if (gr.checked(r, "ROW_CHK") != true) continue;
        if (gr.value(r, "INVDEPT_EVAL_USER") == "") {
            alert("발명부서 평가자가 입력되지 않았습니다.");
            gr.fg.Select(r, gr.fg.ColIndex("INVDEPT_EVAL_USER_NAME"));
            gr.fg.ShowCell(r, gr.fg.ColIndex("INVDEPT_EVAL_USER_NAME"));
            fnSearchEvalUser(gr, gr.fg, r, "INVDEPT_EVAL_USER_NAME");
            return;
        }
        ds.addRow();
        ds.value(ds.rowCount - 1, "REF_ID") = gr.value(r, "REF_ID");
        ds.value(ds.rowCount - 1, "PAPER_LIST_SEQ") = gr.value(r, "PAY_YEARDEG");
        ds.value(ds.rowCount - 1, "EVAL_CODE") = gEvalCode;
        ds.value(ds.rowCount - 1, "INVDEPT_EVAL_USER") = gr.value(r, "INVDEPT_EVAL_USER");
    }

    if (ds.rowCount == 0) {
        alert("선택된 건이 없습니다");
        return;
    }

    if (!confirm("총 " + ds.rowCount + " 건을 평가요청하시겠습니까?")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.costmgt.annual.valuation.act.CreateAnnualValuationInvUserList.do";
    prx.addData(ds);

    prx.onSuccess = function()
    {
        alert("성공적으로 처리되었습니다.");
        gr.loader.reload();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//특허팀 일괄평가
function fnBundleValuation()
{
    var gr = document.getElementById("gr_annualValuationList");
    var ds = document.getElementById("ds_annualValuationList");

    ds.init();

    for (var r = gr.fg.FixedRows; r < gr.fg.Rows; r++) {
        if (gr.checked(r, "ROW_CHK") != true) continue;

        ds.addRow();
        ds.value(ds.rowCount - 1, "REF_ID") = gr.value(r, "REF_ID");
    }

    if (ds.rowCount == 0) {
        alert("선택된 건이 없습니다");
        return;
    }

    if (!confirm("총 " + ds.rowCount + " 건을 일괄평가하시겠습니까?")) return;

    var win = new any.window();
    win.path = "AnnualValuationListU.jsp";
    win.opt.width = 700;
    win.opt.height = 150;

    win.onReload = function()
    {
        gr.loader.reload();
    }

    win.show();
}

//KIPRIS 상세
function fnKipris(gr, fg, row, colId)
{
    window.open("<%= NConfig.getString("/config/kipris/fulldoc-url") %>?APPLNO=" + gr.value(row, "PAT_APP_NO"), "_blank", "width=1000,height=800,resizable=yes");
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
                    <TD>구분</TD>
                    <TD noWrap>
                        <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                            <TR>
                                <TD>
                                    <ANY:SELECT id="RIGHT_DIV" codeData="{RIGHT_DIV}" firstName="all" style="width:90px; margin-right:3px;" />
                                </TD>
                                <TD width="100%">
                                    <ANY:SELECT id="ANNUAL_DIV" codeData="{ANNUAL_DIV}" firstName="all" />
                                </TD>
                            </TR>
                        </TABLE>
                    </TD>
                    <TD>발명의 명칭</TD>
                    <TD>
                        <INPUT type="text" id="KO_APP_TITLE">
                    </TD>
                    <TD>평가상태</TD>
                    <TD>
                        <ANY:SELECT id="STATUS" codeData="/costmgt/annualValuationStatus" firstName="all" value="S" />
                    </TD>
                </TR>
                <TR>
                    <TD>검색번호</TD>
                    <TD>
                        <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                            <TR>
                                <TD>
                                    <ANY:SELECT id="SEARCH_TYPE" codeData="/costmgt/annualSearchType" style="width:90px; margin-right:3px;" />
                                </TD>
                                <TD width="100%">
                                    <INPUT type="text" id="SEARCH_TEXT" style="text-transform:uppercase;" />
                                </TD>
                            </TR>
                        </TABLE>
                    </TD>
                    <TD>검색일자</TD>
                    <TD noWrap colspan="3">
                        <ANY:SELECT id="DATE_GUBUN" codeData="/costmgt/annualApplyDateKind" firstName="none" style="width:90px; margin-right:3px;"  />
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
            <ANY:GRID id="gr_annualValuationList" pagingType="0"><COMMENT>
                addHeader([ null, null, null, null, null, null, null, "발명부서", "", "특허부서", "", null, null, null, null, null, null, null ]);
                addColumn({ width:30 , align:"center", type:"check" , sort:false, id:"ROW_CHK" });
                addColumn({ width:120, align:"left"  , type:"string", sort:true , id:"REF_NO"                   , name:"REF-NO" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"APP_NO"                   , name:"출원번호" });
                addColumn({ width:200, align:"left"  , type:"string", sort:true , id:"KO_APP_TITLE"             , name:"발명의명칭" });
                addColumn({ width:70 , align:"center", type:"string", sort:true , id:"RIGHT_DIV_NAME"           , name:"권리구분" });
                addColumn({ width:70 , align:"center", type:"string", sort:true , id:"COSTSHARE_OWNER_NAME"     , name:"비용주체" });
                addColumn({ width:70 , align:"center", type:"string", sort:true , id:"INDEP_CLAIM"              , name:"독립항" });
                addColumn({ width:70 , align:"center", type:"string", sort:true , id:"SUBORD_CLAIM"             , name:"종속항" });
                addColumn({ width:70 , align:"center", type:"string", sort:true , id:"INVDEPT_EVAL_USER_NAME"   , name:"평가자" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"INVDEPT_EVAL_DATE"        , name:"평가일" });
                addColumn({ width:70 , align:"center", type:"string", sort:true , id:"PATDEPT_EVAL_USER_NAME"   , name:"평가자" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"PATDEPT_EVAL_DATE"        , name:"평가일" });
                addColumn({ width:70 , align:"center", type:"number", sort:true , id:"PAY_YEARDEG"              , name:"납부년차", format:"#.#" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"PAY_LIMIT"                , name:"납부예정일" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"APP_DATE"                 , name:"출원일" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"REG_NO"                   , name:"등록번호"  });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"REG_DATE"                 , name:"등록일" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"STATUS_NAME"              , name:"평가상태" });
                addColumn({ width:75 , align:"center", type:"string", sort:true , id:"KEEP_YN"                  , name:"평가결과" });
                messageSpan = "spn_gridMessage";
                setFixedColumn(null, "KO_APP_TITLE");
                addAction("KO_APP_TITLE", fnDetail);
                addAction("APP_NO", fnKipris);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
    <TR>
        <TD height="1">
            <DIV class="button_area">
                <BUTTON text="발명자 평가요청" onClick="javascript:fnReqValuation();" id="btn_request" style="display:none;"></BUTTON>
                <BUTTON text="특허팀 일괄평가" onClick="javascript:fnBundleValuation();" id="btn_bundle" style="display:none;"></BUTTON>
            </DIV>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
