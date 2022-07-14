<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<%@page import="any.core.config.NConfig"%>
<%@page import="any.core.config.NConfigTypes"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>시스템 환경정보 Refresh</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_memoryInfo"><COMMENT>
    addBind("HOST_NAME");
    addBind("HOST_ADDR");
    addBind("MEASURE_TIME");
    addBind("FULL_MEMORY_SIZE");
    addBind("USED_MEMORY_SIZE");
    addBind("FREE_MEMORY_SIZE");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieveMemoryInfo();
}

//환경정보 Refresh
function fnRefreshConfigure(type)
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.configure.refresh.act.RefreshConfigure.do";
    prx.addParam("TYPE", type);

    prx.onSuccess = function()
    {
        alert("Refresh OK");
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//스케줄러 재시작
function fnRestartScheduler()
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.configure.refresh.act.RestartScheduler.do";

    prx.onSuccess = function()
    {
        alert("Scheduler Restart OK");
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//스케줄러 실행
function fnExecuteScheduler()
{
    if (SCHEDULE_NAME.value.trim() == "") {
        alert("실행할 스케줄러 이름을 입력하세요.");
        SCHEDULE_NAME.focus();
        return;
    }

    if (!confirm("스케줄러 [" + SCHEDULE_NAME.value.trim() + "] 를 직접 실행하시겠습니까?")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.configure.refresh.act.ExecuteScheduler.do";
    prx.addParam("SCHEDULE_NAME", SCHEDULE_NAME.value);

    prx.onSuccess = function()
    {
        alert("Scheduler Execute OK");
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//메모리 정보 조회
function fnRetrieveMemoryInfo()
{
    if (TIMER_INTERVAL.timer != null) window.clearTimeout(TIMER_INTERVAL.timer);

    TIMER_INTERVAL.timer = window.setTimeout("fnRetrieveMemoryInfo();", TIMER_INTERVAL.value * 1000);

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.configure.refresh.act.RetrieveMemoryInfo.do";
    prx.hideMessage = true;

    prx.onSuccess = function()
    {
        var full = parseInt(ds_memoryInfo.value(0, "FULL_MEMORY_SIZE"), 10);
        var used = parseInt(ds_memoryInfo.value(0, "USED_MEMORY_SIZE"), 10);
        var free = parseInt(ds_memoryInfo.value(0, "FREE_MEMORY_SIZE"), 10);

        USED_MEMORY_RATIO.value = used / full * 100;
        FREE_MEMORY_RATIO.value = free / full * 100;

        td_usedMemory.style.width = USED_MEMORY_RATIO.value + "%";
        td_freeMemory.style.width = FREE_MEMORY_RATIO.value + "%";
    }

    prx.onFail = function()
    {
    }

    prx.execute();
}

//Garbage Collection
function fnGarbageCollection()
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.configure.refresh.act.ExecuteGarbageCollection.do";

    prx.onSuccess = function()
    {
        fnRetrieveMemoryInfo();
        alert("Garbage Collection OK");
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}
</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<DIV class="title_sub" style="margin-top:0px;">Configuration Refresh</DIV>
<TABLE border="0" cellspacing="1" cellpadding="2" class="main">
    <COLGROUP>
        <COL class="conthead" width="30%">
        <COL class="contdata" width="70%">
    </COLGROUP>
    <TR>
        <TD>Configuration</TD>
        <TD>
            <BUTTON text="Refresh Configuration" width="160px" space="none" onClick="javascript:fnRefreshConfigure(<%= NConfigTypes.CONFIG %>);"></BUTTON>
        </TD>
    </TR>
    <TR>
        <TD>Message</TD>
        <TD>
            <BUTTON text="Refresh Message" width="160px" space="none" onClick="javascript:fnRefreshConfigure(<%= NConfigTypes.MESSAGE %>);"></BUTTON>
        </TD>
    </TR>
    <TR>
        <TD>Query XML</TD>
        <TD>
            <BUTTON text="Refresh Query XML" width="160px" space="none" onClick="javascript:fnRefreshConfigure(<%= NConfigTypes.QUERY_XML %>);"></BUTTON>
        </TD>
    </TR>
    <TR>
        <TD>Code Data</TD>
        <TD>
            <BUTTON text="Refresh Code Data" width="160px" space="none" onClick="javascript:fnRefreshConfigure(<%= NConfigTypes.CODE_DATA %>);"></BUTTON>
        </TD>
    </TR>
    <TR>
        <TD>File Policy</TD>
        <TD>
            <BUTTON text="Refresh File Policy" width="160px" space="none" onClick="javascript:fnRefreshConfigure(<%= NConfigTypes.FILE_POLICY %>);"></BUTTON>
        </TD>
    </TR>
    <TR>
        <TD>Mail Templates</TD>
        <TD>
            <BUTTON text="Refresh Mail Templates" width="160px" space="none" onClick="javascript:fnRefreshConfigure(<%= NConfigTypes.MAIL_TEMPLATE %>);"></BUTTON>
        </TD>
    </TR>
    <TR>
        <TD height="1" colspan="2" bgColor="#FFFFFF"></TD>
    </TR>
    <TR>
        <TD>All</TD>
        <TD>
            <BUTTON text="Refresh All" width="160px" space="none" onClick="javascript:fnRefreshConfigure(<%= NConfigTypes.ALL %>);"></BUTTON>
        </TD>
    </TR>
</TABLE>

<DIV class="title_sub">Scheduler Restart</DIV>
<TABLE border="0" cellspacing="1" cellpadding="2" class="main">
    <COLGROUP>
        <COL class="conthead" width="30%">
        <COL class="contdata" width="70%">
    </COLGROUP>
    <TR>
        <TD>Restart</TD>
        <TD>
            <BUTTON text="Restart Scheduler" width="160px" space="none" onClick="javascript:fnRestartScheduler();"></BUTTON>
        </TD>
    </TR>
    <TR>
        <TD>Execute</TD>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD width="100%"><INPUT type="text" id="SCHEDULE_NAME"></TD>
                    <TD><BUTTON text="Execute Scheduler" width="160px" onClick="javascript:fnExecuteScheduler();"></BUTTON></TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
</TABLE>

<DIV class="title_sub">Memory Monitor</DIV>
<TABLE border="0" cellspacing="1" cellpadding="2" class="main">
    <COLGROUP>
        <COL class="conthead" width="30%">
        <COL class="contdata" width="70%">
    </COLGROUP>
    <TR>
        <TD>System Info</TD>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD width="50%">
                        Host name : <SPAN id="HOST_NAME"></SPAN>
                    </TD>
                    <TD width="50%">
                        Host address : <SPAN id="HOST_ADDR"></SPAN>
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD class="contdata" colspan="2">
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD width="33%" style="color:#FF00FF;" align="left">
                        Used : <ANY:SPAN id="USED_MEMORY_SIZE" format="number2" />KB (<ANY:SPAN id="USED_MEMORY_RATIO" format="number2(3.2)" />%)
                    </TD>
                    <TD width="34%" style="color:#000000;" align="center">
                        Full : <ANY:SPAN id="FULL_MEMORY_SIZE" format="number2" />KB
                    </TD>
                    <TD width="33%" style="color:#0000FF;" align="right">
                        Free : <ANY:SPAN id="FREE_MEMORY_SIZE" format="number2" />KB (<ANY:SPAN id="FREE_MEMORY_RATIO" format="number2(3.2)" />%)
                    </TD>
                </TR>
            </TABLE>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="15px" style="margin-top:2px;">
                <TR>
                    <TD id="td_usedMemory" bgColor="#FF00FF"></TD>
                    <TD id="td_freeMemory" bgColor="#0000FF" width="100%"></TD>
                </TR>
            </TABLE>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%" style="margin-top:2px;">
                <TR>
                    <TD align="left">
                        <TABLE border="0" cellspacing="0" cellpadding="0">
                            <TR>
                                <TD>Interval :&nbsp;</TD>
                                <TD><INPUT type="text" id="TIMER_INTERVAL" value="2" format="number(2)" style="border:none; text-align:center; padding:0px; width:20px; height:14px;"></TD>
                                <TD>&nbsp;sec</TD>
                            </TR>
                        </TABLE>
                    </TD>
                    <TD align="right">[<SPAN id="MEASURE_TIME"></SPAN>]</TD>
                </TR>
            </TABLE>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%" style="margin-top:2px;">
                <TR>
                    <TD align="right">
                        <BUTTON text="Refresh" width="160px" onClick="javascript:fnRetrieveMemoryInfo();"></BUTTON>
                        <BUTTON text="Garbage Collection" width="160px" onClick="javascript:fnGarbageCollection();"></BUTTON>
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
