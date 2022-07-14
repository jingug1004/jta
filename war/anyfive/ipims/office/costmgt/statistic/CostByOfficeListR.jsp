<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.office.common.app.OfficeApp"%><% OfficeApp app = new OfficeApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>사무소별 비용통계</TITLE>
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
    var ldr = gr_costByOfficeList.loader;

    ldr.init();
    ldr.path =  top.getRoot() + "/anyfive.ipims.office.costmgt.statistic.act.RetrieveCostByOfficeList.do";
    ldr.addParam("DATE_START", DATE_START.value);
    ldr.addParam("DATE_END", DATE_END.value);

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
function fnCreate()
{
}

//상세
function fnDetail(gr, fg, row, colId)
{
    var win = new any.window();
    var nationDiv; // 국내외구분
    var costDiv;  // 관납료/수수료 구분
    var costKind; // 비용구분(장기선급, 수수료)

    win.path = "DetailCostListR.jsp";
    win.arg.DATE_START = DATE_START.value;
    win.arg.DATE_END = DATE_END.value;
    win.arg.OFFICE_CODE = gr.value(row, "OFFICE_CODE");


    switch(colId)
    {
        case "INT_GOV_PREPAID" :
            nationDiv = "INT";
            costDiv = "0";
            costKind = "4";
            break;
        case "INT_GOV_FEE"     :
            nationDiv = "INT";
            costDiv = "0";
            costKind = "3";
            break;
        case "INT_OFF_PREPAID" :
            nationDiv = "INT";
            costDiv = "1";
            costKind = "4";
            break;
        case "INT_OFF_FEE"     :
            nationDiv = "INT";
            costDiv = "1";
            costKind = "3";
            break;
        case "INT_TOTAL"       :
            nationDiv = "INT";
            costDiv = "";
            costKind = "";
            break;
        case "EXT_GOV_PREPAID" :
            nationDiv = "EXT";
            costDiv = "0";
            costKind = "4";
            break;
        case "EXT_GOV_FEE"     :
            nationDiv = "EXT";
            costDiv = "0";
            costKind = "3";
            break;
        case "EXT_OFF_PREPAID" :
            nationDiv = "EXT";
            costDiv = "1";
            costKind = "4";
            break;
        case "EXT_OFF_FEE"     :
            nationDiv = "EXT";
            costDiv = "1";
            costKind = "3";
            break;
        case "EXT_TOTAL"       :
            nationDiv = "EXT";
            costDiv = "";
            costKind = "";
            break;
        case "TOTAL"           :
            nationDiv = "";
            costDiv = "";
            costKind = "";
            break;
        default :
            break;
    }

    win.arg.COST_KIND = costKind;
    win.arg.NATION_DIV = nationDiv;
    win.arg.COST_DIV = costDiv;

    win.arg.gr = gr;
    win.opt.width = 800;
    win.opt.height = 600;

    win.onReload = function()
    {
        gr_intCostList.loader.reload();
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
                    <COL class="condhead" width="20%">
                    <COL class="conddata" width="80%">
                </COLGROUP>
                <TR>
                    <TD>기간</TD>
                    <TD colspan="3" noWrap>
                        <ANY:DATE id="DATE_START" />&nbsp;~
                        <ANY:DATE id="DATE_END" />
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
            <ANY:GRID id="gr_costByOfficeList" pagingType="1"><COMMENT>
                addHeader([null, null, "국내건", "", "", "", "", "해외건", "", "", "", "", "합계" ]);
                addHeader([null, null, "국내관납", "", "국내수수료", "", "국내소계", "해외비용", "", "해외수수료", "", "해외소계", "합계" ]);

                addColumn({ width:100, align:"left"  , type:"string" , sort:true , id:"OFFICE_CODE" , name:"사무소코드", hide:true });
                addColumn({ width:100, align:"left"  , type:"string" , sort:true , id:"OFFICE_NAME" , name:"사무소" });
                addColumn({ width:80 , align:"right" , type:"number" , sort:true , id:"INT_GOV_PREPAID" , name:"장기선급금", format:"#,###" });
                addColumn({ width:80 , align:"right" , type:"number" , sort:true , id:"INT_GOV_FEE" , name:"특허수수료", format:"#,###" });
                addColumn({ width:80 , align:"right" , type:"number" , sort:true , id:"INT_OFF_PREPAID" , name:"장기선급금", format:"#,###" });
                addColumn({ width:80 , align:"right" , type:"number" , sort:true , id:"INT_OFF_FEE" , name:"특허수수료", format:"#,###" });
                addColumn({ width:80 , align:"right" , type:"number" , sort:true , id:"INT_TOTAL" , name:"국내소계", format:"#,###" });
                addColumn({ width:80 , align:"right" , type:"number" , sort:true , id:"EXT_GOV_PREPAID" , name:"장기선급금", format:"#,###" });
                addColumn({ width:80 , align:"right" , type:"number" , sort:true , id:"EXT_GOV_FEE" , name:"특허수수료", format:"#,###" });
                addColumn({ width:80 , align:"right" , type:"number" , sort:true , id:"EXT_OFF_PREPAID" , name:"장기선급금", format:"#,###" });
                addColumn({ width:80 , align:"right" , type:"number" , sort:true , id:"EXT_OFF_FEE" , name:"특허수수료", format:"#,###" });
                addColumn({ width:80 , align:"right" , type:"number" , sort:true , id:"EXT_TOTAL" , name:"해외소계", format:"#,###" });
                addColumn({ width:80 , align:"right" , type:"number" , sort:true , id:"TOTAL" , name:"합계", format:"#,###" });

                messageSpan = "spn_gridMessage";
                addAction("INT_GOV_PREPAID", fnDetail);
                addAction("INT_GOV_FEE", fnDetail);
                addAction("INT_OFF_PREPAID", fnDetail);
                addAction("INT_OFF_FEE", fnDetail);
                addAction("INT_TOTAL", fnDetail);
                addAction("EXT_GOV_PREPAID", fnDetail);
                addAction("EXT_GOV_FEE", fnDetail);
                addAction("EXT_OFF_PREPAID", fnDetail);
                addAction("EXT_OFF_FEE", fnDetail);
                addAction("EXT_TOTAL", fnDetail);
                addAction("TOTAL", fnDetail);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
