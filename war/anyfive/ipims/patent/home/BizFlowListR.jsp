<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>업무현황</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    if (parent.BIZ_FLOW_ID.indexOf("APP_") != -1) {
        cfSetPageTitle("출원현황 목록");
    }

    if (parent.BIZ_FLOW_ID.indexOf("OA_") != -1) {
        cfSetPageTitle("OA현황 목록");
    }

    fnRetrieve();
}

//조회
function fnRetrieve()
{
    var ldr = gr_bizFlowList.loader;
    ldr.init(parent.BIZ_FLOW_ID);
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.home.act.RetrieveBizFlowList.do";
    ldr.addParam("BIZ_FLOW_ID", parent.BIZ_FLOW_ID);

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
    var win = new any.window(2);
    var editMode;

    switch (parent.BIZ_FLOW_ID) {
    case "APP_INT01":
        switch (gr.value(row, "RIGHT_DIV")) {
        case "10":
        case "20":
            win.path = top.getRoot() + "/anyfive/ipims/patent/applymgt/intpatent/request/IntPatentRequestRD.jsp";
            break;
        case "30":
            win.path = top.getRoot() + "/anyfive/ipims/patent/applymgt/design/intrequest/DesignIntRequestRD.jsp";
            break;
        case "40":
            win.path = top.getRoot() + "/anyfive/ipims/patent/applymgt/tmark/intrequest/TMarkIntRequestRD.jsp";
            break;
        }
        break;
    case "APP_INT02":
        editMode = (gr.value(row, "EXAM_RESULT") == "" && gr.value(row, "JOB_MAN") == "<%= app.userInfo.getUserId() %>");
        switch (gr.value(row, "RIGHT_DIV")) {
        case "10":
        case "20":
            win.path = top.getRoot() + "/anyfive/ipims/patent/applymgt/intpatent/consult/IntPatentConsult" + (editMode ? "U" : "RD") + ".jsp";
            break;
        case "30":
            win.path = top.getRoot() + "/anyfive/ipims/patent/applymgt/design/intconsult/DesignIntConsult" + (editMode ? "U" : "RD") + ".jsp";
            break;
        case "40":
            win.path = top.getRoot() + "/anyfive/ipims/patent/applymgt/tmark/intconsult/TMarkIntConsult" + (editMode ? "U" : "RD") + ".jsp";
            break;
        }
        break;
    case "APP_EXT01":
        parent.opener.window.open(top.getRoot() + "/anyfive/ipims/patent/applymgt/common/MasterView.jsp?ID=" + gr.value(row, "REF_ID"), "_blank", "width=1000,height=800,resizable=yes");
        break;
    case "APP_EXT02":
        win.arg.OL_ID = gr.value(row, "OL_ID");
        switch (gr.value(row, "RIGHT_DIV")) {
        case "10":
        case "20":
            win.path = top.getRoot() + "/anyfive/ipims/patent/applymgt/extpatent/orderletter/ExtPatentOrderLetterRD.jsp";
            break;
        case "30":
            win.path = top.getRoot() + "/anyfive/ipims/patent/applymgt/design/extorderletter/DesignExtOrderLetterRD.jsp";
            break;
        case "40":
            win.path = top.getRoot() + "/anyfive/ipims/patent/applymgt/tmark/extorderletter/TMarkExtOrderLetterRD.jsp";
            break;
        }
        break;
    default:
        parent.opener.window.open(top.getRoot() + "/anyfive/ipims/patent/applymgt/common/MasterView.jsp?ID=" + gr.value(row, "REF_ID") + "&TAB=paper", "_blank", "width=1000,height=800,resizable=yes");
        break;
    }

    if (win.path == null || win.path == "") return;

    win.arg.REF_ID = gr.value(row, "REF_ID");
    win.opt.width = 850;
    win.opt.height = 700;
    win.opt.resizable = "yes";
    win.show();
}
</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
    <TR>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD><SPAN id="spn_gridMessage"></SPAN></TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD height="5"></TD>
    </TR>
    <TR>
        <TD height="100%">
            <ANY:GRID id="gr_bizFlowList" pagingType="1"><COMMENT>
                addColumn({ width:40 , align:"center", type:"number", sort:false, id:"ROW_NUM"          , name:"No" });
                switch (parent.BIZ_FLOW_ID) {
                case "APP_EXT02":
                    addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"GRP_NO"           , name:"GRP-NO" });
                    break;
                default:
                    addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"REF_NO"           , name:"REF-NO" });
                    break;
                }
                addColumn({ width:70 , align:"center", type:"string", sort:true , id:"RIGHT_DIV_NAME"   , name:"권리구분" });
                addColumn({ width:200, align:"left"  , type:"string", sort:true , id:"KO_APP_TITLE"     , name:"발명의 명칭" });
                addColumn({ width:120, align:"left"  , type:"string", sort:true , id:"STATUS_NAME"      , name:"진행상태" });
                if (parent.BIZ_FLOW_ID.indexOf("OA_") == 0) {
                    addColumn({ width:80 , align:"center", type:"number", sort:true , id:"PERIOD_EXTEND_CNT", name:"기간연장횟수" });
                    addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"DUE_DATE"         , name:"DUE-DATE" });
                }
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_NUM", "REF_NO");
                addAction("KO_APP_TITLE", fnDetail);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
    <TR>
        <TD height="5"></TD>
    </TR>
    <TR>
        <TD align="right">
            <BUTTON auto="close"></BUTTON>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
