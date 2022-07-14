<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>연차료 현황</TITLE>
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
    var ldr = gr_annualCurrentList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.costmgt.annual.current.act.RetrieveAnnualCurrentList.do";
    ldr.addParam("RIGHT_DIV", RIGHT_DIV.value);
    ldr.addParam("ANNUAL_DIV", ANNUAL_DIV.value);
    ldr.addParam("SEARCH_TYPE", SEARCH_TYPE.value);
    ldr.addParam("SEARCH_TEXT", SEARCH_TEXT.value);
    ldr.addParam("STATUS", STATUS.value);
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
                    <TD>검색번호</TD>
                    <TD colspan="3">
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
                    <TD>진행상태</TD>
                    <TD>
                        <ANY:SELECT id="STATUS" codeData="/costmgt/annualStatus" firstName="all"  value="0" />
                    </TD>
                </TR>
                <TR>
                    <TD>검색일자</TD>
                    <TD colspan="5" noWrap>
                        <ANY:SELECT id="DATE_GUBUN" codeData="/costmgt/annualApplyDateKind" firstName="none" style="width:80px; margin-right:3px;"  />
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
            <ANY:GRID id="gr_annualCurrentList" pagingType="0"><COMMENT>
                addColumn({ width:120, align:"left"  , type:"string", sort:true , id:"REF_NO"                 , name:"REF-NO" });
                addColumn({ width:200, align:"left"  , type:"string", sort:true , id:"KO_APP_TITLE"           , name:"발명의명칭" });
                addColumn({ width:90 , align:"center", type:"string", sort:true , id:"RIGHT_DIV_NAME"         , name:"권리구분" });
                addColumn({ width:90 , align:"center", type:"string", sort:true , id:"COSTSHARE_OWNER_NAME"   , name:"비용주체" });
                addColumn({ width:120, align:"left"  , type:"string", sort:true , id:"OFFICE_NAME"            , name:"사무소" });
                addColumn({ width:70 , align:"center", type:"string", sort:true , id:"PAY_YEARDEG"            , name:"최종\n납부년차" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"PAY_LIMIT"              , name:"최종\n납부일" });
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
                addAction("KO_APP_TITLE", fnMaster);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
