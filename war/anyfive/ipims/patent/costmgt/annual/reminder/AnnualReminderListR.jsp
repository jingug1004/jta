<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>Reminder 관리</TITLE>
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
    var ldr = gr_annualReminderList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.costmgt.annual.reminder.act.RetrieveAnnualReminderList.do";
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

//작성
function fnWrite()
{
    var win = new any.window();
    win.path = "AnnualReminderC.jsp";
    win.arg.gr = gr_annualReminderList;
    win.opt.width = 700;
    win.opt.height = 200;

    win.onReload = function()
    {
        gr_annualReminderList.loader.reload();
    }

    win.show();
}

//상세
function fnDetail(gr, fg, row, colId)
{
    var win = new any.window();
    win.path = "AnnualReminderUD.jsp";
    win.arg.REF_ID = gr.value(row, "REF_ID");
    win.arg.PAY_YEARDEG = gr.value(row, "PAY_YEARDEG");
    win.opt.width = 700;
    win.opt.height = 200;

    win.onReload = function()
    {
        gr.loader.reload();
    }

    win.show();
}

//일괄등록
function fnExcelImport()
{
    var ldr = new any.excelImporter();
    ldr.templateFile = "/excel/ReminderList.xls";
    ldr.saveAction = top.getRoot() + "/anyfive.ipims.patent.costmgt.annual.reminder.act.UploadAnnualReminder.do";
    if (ldr.execute() == "OK") {
        fnRetrieve();
    }
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
                    <COL class="conddata" width="20%">
                    <COL class="condhead" width="10%">
                    <COL class="conddata" width="20%">
                    <COL class="condhead" width="10%">
                    <COL class="conddata" width="30%">
                </COLGROUP>
                <TR>
                    <TD>권리구분</TD>
                    <TD>
                        <ANY:SELECT id="RIGHT_DIV" codeData="{RIGHT_DIV}" firstName="all" />
                    </TD>
                    <TD>연차구분</TD>
                    <TD>
                        <ANY:SELECT id="ANNUAL_DIV" codeData="{ANNUAL_DIV}" firstName="all" />
                    </TD>
                    <TD>발명의 명칭</TD>
                    <TD>
                        <INPUT type="text" id="KO_APP_TITLE">
                    </TD>
                </TR>
                <TR>
                    <TD>검색일자</TD>
                    <TD colspan="3" noWrap>
                        <ANY:SELECT id="DATE_GUBUN" codeData="/costmgt/annualApplyDateKind" firstName="none" style="width:80px; margin-right:3px;"  />
                        <ANY:DATE id="DATE_START" disabled />&nbsp;~
                        <ANY:DATE id="DATE_END" disabled />
                    </TD>
                    <TD>검색번호</TD>
                    <TD>
                        <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                            <TR>
                                <TD noWrap width="80">
                                    <ANY:SELECT id="SEARCH_TYPE" codeData="/costmgt/annualSearchType" style="width:80px; margin-right:3px;" />
                                </TD>
                                <TD noWrap>
                                    <INPUT type="text" id="SEARCH_TEXT" style="text-transform:uppercase;" />
                                </TD>
                            </TR>
                        </TABLE>
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
                        <BUTTON text="작성" onClick="javascript:fnWrite();"></BUTTON>
                        <BUTTON text="일괄등록" onClick="javascript:fnExcelImport();"></BUTTON>
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
            <ANY:GRID id="gr_annualReminderList" pagingType="1"><COMMENT>
                addColumn({ width:80, align:"left"  , type:"string", sort:true , id:"COUNTRY_CODE"           , name:"국가코드" });
                addColumn({ width:120, align:"left"  , type:"string", sort:true , id:"REF_NO"                 , name:"REF-NO" });
                addColumn({ width:200, align:"left"  , type:"string", sort:true , id:"KO_APP_TITLE"           , name:"발명의명칭" });
                addColumn({ width:70 , align:"center", type:"string", sort:true , id:"RIGHT_DIV_NAME"         , name:"권리구분" });
                addColumn({ width:70 , align:"center", type:"string", sort:true , id:"APP_MAN_NAME"           , name:"출원인" });
                addColumn({ width:70 , align:"center", type:"string", sort:true , id:"COSTSHARE_OWNER_NAME"   , name:"비용주체" });
                addColumn({ width:70 , align:"center", type:"string", sort:true , id:"INDEP_CLAIM"            , name:"독립항" });
                addColumn({ width:70 , align:"center", type:"string", sort:true , id:"SUBORD_CLAIM"           , name:"종속항" });
                addColumn({ width:70 , align:"center", type:"string", sort:true , id:"TOTAL_CLAIM"            , name:"총항수" });
                addColumn({ width:70 , align:"center", type:"string", sort:true , id:"GOVERNMENT_PAY"         , name:"관납료" });
                addColumn({ width:120, align:"left"  , type:"string", sort:true , id:"OFFICE_NAME"            , name:"사무소" });
                addColumn({ width:70 , align:"center", type:"string", sort:true , id:"PAY_YEARDEG"            , name:"납부년차" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"PAY_LIMIT"              , name:"납부기한" });
                addColumn({ width:70 , align:"center", type:"string", sort:true , id:"NEXT_PAY_YEARDEG"       , name:"차기\n납부년차" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"NEXT_PAY_LIMIT"         , name:"차기\n납부기한" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"RIGHT_EXPIRE_DATE"      , name:"권리만료일" });
                addColumn({ width:90 , align:"center", type:"string", sort:true , id:"APP_NO"                 , name:"출원번호" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"APP_DATE"               , name:"출원일" });
                addColumn({ width:90 , align:"center", type:"string", sort:true , id:"REG_NO"                 , name:"등록번호"  });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"REG_DATE"               , name:"등록일" });
                addColumn({ width:70 , align:"center", type:"string", sort:true , id:"STATUS_NAME"            , name:"진행상태" });
                fg.RowHeight(0) = 550;
                messageSpan = "spn_gridMessage";
                setFixedColumn(null, "KO_APP_TITLE");
                addSorting("REF_NO", "ASC");
                addSorting("PAY_YEARDEG", "ASC");
                addAction("REF_NO", fnMaster);
                addAction("PAY_YEARDEG", fnDetail);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
