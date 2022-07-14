<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>OA검토현황</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieve()
}

//목록 조회
function fnRetrieve()
{
    var ldr = gr_oaList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.priorjob.oalist.act.RetrieveOAList.do";
    ldr.addParam("OA_PAPER_CODE", OA_PAPER_CODE.value);
    ldr.addParam("JOB_MAN", JOB_MAN.value);
    ldr.addParam("END_YN", END_YN.value);

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

    switch (gr.value(row, "INOUT_DIV")) {
    case "INT":
        win.path = top.getRoot() + "/anyfive/ipims/patent/applymgt/common/IntMasterTabR.jsp?TAB=paper";
        break;
    case "EXT":
        win.path = top.getRoot() + "/anyfive/ipims/patent/applymgt/common/ExtMasterTabR.jsp?TAB=paper";
        break;
    }

    win.arg.REF_ID = gr.value(row, "REF_ID");

    switch (colId) {
    case "START_PAPER_NAME":
        win.arg.LIST_SEQ = gr.value(row, "START_PAPER_SEQ");
        break;
    case "LAST_PAPER_NAME":
        win.arg.LIST_SEQ = gr.value(row, "LAST_PAPER_SEQ");
        break;
    }

    win.onReload = function()
    {
        gr.loader.reload();
    }

    win.show();
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
                    <COL class="conddata" width="23%">
                    <COL class="condhead" width="10%">
                    <COL class="conddata" width="23%">
                    <COL class="condhead" width="10%">
                    <COL class="conddata" width="23%">
                </COLGROUP>
                <TR>
                    <TD>OA발생서류</TD>
                    <TD>
                        <ANY:SELECT id="OA_PAPER_CODE" codeData="/applymgt/oaPaperCode" firstName="all" />
                    </TD>
                    <TD>건담당자</TD>
                    <TD>
                        <ANY:SELECT id="JOB_MAN" codeData="/common/jobManAll" firstName="all" value="<%= app.userInfo.getUserId() %>" />
                    </TD>
                    <TD>종료여부</TD>
                    <TD>
                        <ANY:SELECT id="END_YN" codeData="{YES_NO}" firstName="all" value="0" />
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
            <ANY:GRID id="gr_oaList" pagingType="1"><COMMENT>
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"REF_NO"           , name:"REF-NO" });
                addColumn({ width:150, align:"left"  , type:"string", sort:true , id:"START_PAPER_NAME" , name:"원인 진행서류" });
                addColumn({ width:150, align:"left"  , type:"string", sort:true , id:"LAST_PAPER_NAME"  , name:"최종 진행서류" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"APP_NO"           , name:"출원번호" });
                addColumn({ width:120, align:"left"  , type:"string", sort:true , id:"INVENTOR_NAMES"   , name:"발명자" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"START_PAPER_DATE" , name:"발생일자" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"DUE_DATE"         , name:"법정기한" });
                addColumn({ width:90 , align:"left"  , type:"string", sort:true , id:"OFFICE_NAME"      , name:"사무소" });
                addColumn({ width:60 , align:"center", type:"string", sort:true , id:"JOB_MAN_NAME"     , name:"건담당자" });
                addColumn({ width:60 , align:"center", type:"string", sort:true , id:"END_YN_NAME"      , name:"종료여부" });
                useConfig = true;
                messageSpan = "spn_gridMessage";
                setFixedColumn(null, "LAST_PAPER_NAME");
                addSorting("START_PAPER_DATE", "DESC");
                addAction("START_PAPER_NAME", fnDetail);
                addAction("LAST_PAPER_NAME", fnDetail);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
