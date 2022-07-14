<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.share.workprocess.util.WorkProcessConst"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>계약서 현황</TITLE>
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
    var ldr = gr_contractListR.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.ipbiz.contract.act.RetrieveContractList.do";
    ldr.addParam("MGT_ID", MGT_ID.value);
    ldr.addParam("CONTRACT_KIND", CONTRACT_KIND.value);
    ldr.addParam("OTHER_TITLE", OTHER_TITLE.value);
    ldr.addParam("COUNTRY", COUNTRY.value);

    ldr.onSuccess = function(gr, fg)
    {
        fg.ReDraw = 0;
        for (var r = fg.FixedRows; r < fg.Rows; r++) {
            fg.Cell(flexcpForeColor, r, fg.ColIndex("LIMIT_SUBJECT_1")) = fg.Cell(flexcpForeColor, r, fg.ColIndex("LIMIT_1"))= fg.Cell(flexcpForeColor, r, fg.ColIndex("LIMIT_1_DAYS")) = (gr.value(r, "LIMIT_1_DAYS") >= 0 ? "&HFF0000" : "&H0000FF");
            fg.Cell(flexcpForeColor, r, fg.ColIndex("LIMIT_SUBJECT_2")) = fg.Cell(flexcpForeColor, r, fg.ColIndex("LIMIT_2"))= fg.Cell(flexcpForeColor, r, fg.ColIndex("LIMIT_2_DAYS")) = (gr.value(r, "LIMIT_2_DAYS") >= 0 ? "&HFF0000" : "&H0000FF");
            fg.Cell(flexcpForeColor, r, fg.ColIndex("LIMIT_SUBJECT_3")) = fg.Cell(flexcpForeColor, r, fg.ColIndex("LIMIT_3"))= fg.Cell(flexcpForeColor, r, fg.ColIndex("LIMIT_3_DAYS")) = (gr.value(r, "LIMIT_3_DAYS") >= 0 ? "&HFF0000" : "&H0000FF");
        }
        fg.ReDraw = 2;

    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

//작성
function fnWrite(){

    var win = new any.viewer();
    win.path = "ContractC.jsp";

    win.onReload = function()
    {
        gr_contractListR.loader.reload();
    }

    win.show();
}

//상세
function fnDetail(gr, fg, row, colId)
{
    var win = new any.viewer();

    win.path = "ContractRD.jsp";
    win.arg.MGT_ID = gr.value(row, "MGT_ID");
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
                    <COL class="condhead" width="15%">
                    <COL class="conddata" width="35%">
                    <COL class="condhead" width="15%">
                    <COL class="conddata" width="35%">
                </COLGROUP>
                 <TR>
                    <TD>관리번호</TD>
                    <TD>
                       <INPUT type="text" id="MGT_ID" style="text-transform:uppercase;">
                    </TD>
                    <TD>계약서종류</TD>
                    <TD>
                        <ANY:SELECT id="CONTRACT_KIND" codeData="{CONTRACT_KIND}" firstName="all" />
                    </TD>
                </TR>
                <TR>
                    <TD>상대방 명칭</TD>
                    <TD>
                        <INPUT type="text" id="OTHER_TITLE" style="text-transform:uppercase;">
                    </TD>
                    <TD>국가</TD>
                    <TD>
                        <ANY:SELECT id="COUNTRY" codeData="/common/countryCode" firstName="all" />
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
                        <BUTTON text ="작성" onClick="javascript:fnWrite();"></BUTTON>
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
            <ANY:GRID id="gr_contractListR" pagingType="0"><COMMENT>

                addColumn({ width:150, align:"center" , type:"string" , sort:true  , id:"MGT_NO"                 , name:"관리번호" });
                addColumn({ width:300, align:"left"   , type:"string" , sort:true  , id:"OTHER_TITLE"            , name:"상대방 명칭" });
                addColumn({ width:300, align:"left"   , type:"string" , sort:true  , id:"CONTRACT_KIND_NAME"     , name:"계약서종류"  });
                addColumn({ width:300, align:"left"   , type:"string" , sort:true  , id:"CONTRACT_GOAL"          , name:"체결목적(계약명)"  });
                addColumn({ width:100, align:"center" , type:"string" , sort:true  , id:"CONTRACT_JOB_MAN"       , name:"계약담당자"  });
                addColumn({ width:90,  align:"right"  , type:"string" , sort:true  , id:"CONTRACT_PRICE"         , name:"계약금액", format:"#,###"});
                addColumn({ width:110, align:"center" , type:"string" , sort:true  , id:"CURRENCY_UNIT"          , name:"화폐단위" });
                addColumn({ width:90,  align:"center" , type:"date"   , sort:true  , id:"START_DATE"             , name:"체결일" });
                addColumn({ width:90,  align:"center" , type:"date"   , sort:true  , id:"END_DATE"               , name:"종료일" });
                addColumn({ width:90,  align:"center" , type:"date"   , sort:true  , id:"CRE_DATE"               , name:"작성일(접수일)" });

                useConfig = true;
                messageSpan = "spn_gridMessage";
                setFixedColumn(null, "OTHER_TITLE");
                addAction("OTHER_TITLE", fnDetail);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
    <TR>
        <TD height="5"></TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>

