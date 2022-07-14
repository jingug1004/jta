<%@page pageEncoding="UTF-8"%><% response.setContentType("text/x-component; charset=utf-8"); %>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out, true, true); %>
<PUBLIC:COMPONENT tagName="IPBHIST" lightWeight="false">
    <PUBLIC:DEFAULTS tabStop="true" viewInheritStyle="true" viewLinkContent="true" viewMasterTab="false" />
    <PUBLIC:ATTACH event="ondocumentready" onevent="document_onready();" />
    <PUBLIC:PROPERTY name="refId" get="getRefId" put="setRefId" />
    <PUBLIC:PROPERTY name="gr" get="getGrid" />
</PUBLIC:COMPONENT>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML XMLNS:ANY>
<HEAD>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<SCRIPT language="JScript">
element.style.marginTop = "10px";

var gRefId;

function document_onready()
{
    gr_ipBizHistoryList.addAction("HIST_TITLE", fnHistModify);
    gr_ipBizHistoryList.setExtendColumnWidth();

    for (var i = 0, elements = element.getElementsByTagName("*"); i < elements.length; i++) {
        if (elements[i].tagName == "SCRIPT" || elements[i].tagName == "COMMENT") eval(elements[i].text);
    }
}

function getRefId()
{
    return gRefId;
}

function setRefId(val)
{
    gRefId = val;

    fnRetrieveHist();
}

function getGrid()
{
    return gr_ipBizHistoryList;
}

//History 조회
function fnRetrieveHist()
{
    var ldr = gr_ipBizHistoryList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.ipbiz.history.act.RetrieveIpBizHistoryList.do";
    ldr.addParam("REF_ID", gRefId);

    ldr.onSuccess = function(gr, fg)
    {
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

//History 추가
function fnCreateHistory()
{
    var win = new any.window();
    win.path = top.getRoot() + "/anyfive/ipims/patent/ipbiz/history/IpBizHistoryC.jsp";
    win.arg.REF_ID = gRefId;
    win.opt.width = 600;
    win.opt.height = 300;

    win.onReload = function()
    {
        gr_ipBizHistoryList.loader.reload();
    }

    win.show();
}

//History 수정
function fnHistModify(gr, fg, row, colId)
{
    var win = new any.window();
    win.path = top.getRoot() + "/anyfive/ipims/patent/ipbiz/history/IpBizHistoryUD.jsp";
    win.arg.REF_ID = gRefId;
    win.arg.HIST_SEQ = gr.value(row, "HIST_SEQ");
    win.opt.width = 600;
    win.opt.height = 300;

    win.onReload = function()
    {
        gr_ipBizHistoryList.loader.reload();
    }

    win.show();
}
</SCRIPT>
</HEAD>

<BODY>

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
    <TR>
        <TD height="1">
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD class="title_sub">History List</TD>
                    <TD align="right"><SPAN id="spn_gridMessage"></SPAN></TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD height="5"></TD>
    </TR>
    <TR>
        <TD height="100%">
            <ANY:GRID id="gr_ipBizHistoryList" pagingType="0"><COMMENT>
                addColumn({ width:50 , align:"center", type:"string", sort:false, id:"ROW_NUM"          , name:"No" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"HIST_DATE"        , name:"날짜" });
                addColumn({ width:100, align:"center", type:"string", sort:true , id:"HIST_DIV_NAME"    , name:"구분" });
                addColumn({ width:200, align:"left"  , type:"string", sort:true , id:"HIST_TITLE"       , name:"업무처리내용" });
                addColumn({ width:150, align:"left"  , type:"string", sort:true , id:"HIST_RECV"        , name:"수신자" });
                addColumn({ width:150, align:"left"  , type:"string", sort:true , id:"HIST_CHARGE"      , name:"담당자" });
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_NUM");
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
    <TR>
        <TD height="1">
            <DIV class="button_area">
                <BUTTON text="History 추가" onClick="javascript:fnCreateHistory();"></BUTTON>
            </DIV>
        </TD>
    </TR>
</TABLE>

</BODY>
</HTML>
