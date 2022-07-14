<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<%@page import="any.util.etc.NTextUtil"%>
<%@page import="any.util.etc.NDateUtil"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>Home</TITLE>
<% app.writeHTMLHeader(); %>
<LINK rel="StyleSheet" type="text/css" href="Home.css">
<ANY:DS id="ds_bizFlowCount" />
<ANY:DS id="ds_dueDateCount" />
<SCRIPT language="JScript">

//윈도우 로딩시
window.onready = function()
{
    var gubun ="<%=request.getParameter("gubun")%>";
    if(gubun == "App" || gubun == "Oa"){
        fnRetrieveBizFlowCount();
    }else{
        fnMakeDueDateCalendar();
    }
}



//업무현황 건수 조회
function fnRetrieveBizFlowCount()
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.home.act.RetrieveBizFlowCount.do";
    prx.hideMessage = true;

    prx.onSuccess = function()
    {
        for (var i = 0; i < ds_bizFlowCount.rowCount; i++) {
            fnSetCountValue(ds_bizFlowCount.value(i, "WF_ID"), ds_bizFlowCount.value(i, "WF_CNT"));
        }
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//건수 셋팅
function fnSetCountValue(objId, val)
{
    var obj = document.getElementById(objId);

    if (obj != null) obj.innerText = cfGetFormatNumber(val);
}



//업무현황 목록
function fnOpenBizFlowList(bizFlowId)
{
    var win = new any.window();
    win.path = "BizFlowListR.jsp";
    win.arg.BIZ_FLOW_ID = bizFlowId;
    win.opt.width = 750;
    win.opt.height = 500;
    win.opt.resizable = "yes";
    win.show();
}

//DUE-DATE 달력 생성
function fnMakeDueDateCalendar(num)
{
    var makeDate;
    var makeYear;
    var makeMonth;

    if (num == null) {
        makeDate = new Date();
        makeYear = makeDate.getFullYear();
        makeMonth = makeDate.getMonth();
    } else {
        makeDate = new Date(spn_dueDateTitle.makeYear, spn_dueDateTitle.makeMonth - 1 + num);
        makeYear = makeDate.getFullYear();
        makeMonth = makeDate.getMonth();
    }

    spn_dueDateTitle.innerText = makeYear + "년 " + (makeMonth + 1) + "월";
    spn_dueDateTitle.makeYear = makeYear;
    spn_dueDateTitle.makeMonth = makeMonth + 1;

    var tbd = document.getElementById("tbd_dueDateCalendar");

    for (var i = tbd.rows.length - 1; i >= 0; i--) {
        tbd.deleteRow(i);
    }

    var firstDate = new Date(makeYear, makeMonth, 1);
    var lastDate = new Date(makeYear, makeMonth + 1, 0);
    var weekCnt = parseInt((firstDate.getDay() + lastDate.getDate() - 1) / 7, 10) + 1;
    var tdDate;
    var tr, td;

    for (var r = 0; r < weekCnt; r++) {
        tr = document.createElement('<TR>');
        tbd.appendChild(tr);

        for (var c = 0; c < 7; c++) {
            tdDate = new Date(makeYear, makeMonth, r * 7 + c - firstDate.getDay() + 1);

            td = tr.appendChild(document.createElement('<TD style="cursor:default;">'));

            if (c == 0) td.className = "sun";
            if (c == 6) td.className = "sat";

            if (getDateString(tdDate) == getDateString(new Date())) td.bgColor = "#FFFF99";

            if (tdDate < firstDate || tdDate > lastDate) {
                td.innerHTML = '&nbsp;';
            } else {
                td.innerHTML = '<DIV class="float_left">' + any.lpad(tdDate.getDate(), 2, "0") + '</DIV><DIV id="spn_dueCount_' + getDateString(tdDate) + '" class="float_right"></DIV>';
                td.title = cfGetFormatDate(getDateString(tdDate));
            }
        }
    }

    function getDateString(date)
    {
        return date.getFullYear() + any.lpad(date.getMonth() + 1, 2, "0") + any.lpad(date.getDate(), 2, "0");
    }

    fnRetrieveDueDateCount(makeYear, makeMonth);
}

//DUE-DATE 건수 조회
function fnRetrieveDueDateCount(makeYear, makeMonth)
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.home.act.RetrieveDueDateCount.do";
    prx.addParam("DUE_YEAR", makeYear);
    prx.addParam("DUE_MONTH", makeMonth + 1);
    prx.hideMessage = true;

    prx.onSuccess = function()
    {
        var spn;

        for (var i = 0; i < ds_dueDateCount.rowCount; i++) {
            spn = document.getElementById("spn_dueCount_" + ds_dueDateCount.value(i, "DUE_DATE"));
            if (spn == null) continue;
            spn.innerText = ds_dueDateCount.value(i, "DUE_COUNT") + "건";
            spn.dueDate = ds_dueDateCount.value(i, "DUE_DATE");
            spn.onclick = function()
            {
                fnOpenDueDateList(this.dueDate);
            }
        }
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//DUE-DATE 목록
function fnOpenDueDateList(dueDate)
{
    var win = new any.window();
    win.path = "DueDateListR.jsp";
    win.arg.DUE_DATE = dueDate;
    win.opt.width = 750;
    win.opt.height = 500;
    win.opt.resizable = "yes";
    win.show();
}


</SCRIPT>

</HEAD>

<BODY style="padding:15px;">

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
    <TR>
        <TD height="10px"></TD>
    </TR>
</TABLE>

<%
String intBizFlowId = null;
String extBizFlowId = null;
%>

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
    <COLGROUP>
        <COL width="120">
        <COL width="">
        <COL width="">
    </COLGROUP>
   <% String gubun = request.getParameter("gubun");
      if(gubun.equals("Oa") == true){
   %>

    <TR>
        <TD colspan="2" class="ipims_portlet_head">OA 현황</TD>
        <TD class="ipims_portlet_title" align="right"><IMG src="image/ipims_title_end.gif" width="6" height="32"></TD>
    </TR>
    <TR>
        <TD height="161" colspan="3" align="center" class="ipims_portlet_content" style="vertical-align:middle;">
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD colspan="6" align="right">
                        <FONT color="#3255b1" style="font-family:굴림;">■ 국내</FONT>
                        <FONT color="#ec1602" style="font-family:굴림;">■ 해외</FONT>
                    </TD>
                </TR>
                <TR>
                    <TD colspan="6" height="10"></TD>
                </TR>
                <TR>
                    <TD class="ipims_flow02_01"></TD>
                    <TD class="ipims_flow02_02"></TD>
                    <TD class="ipims_flow02_03"></TD>
                    <TD class="ipims_flow02_04"></TD>
                    <TD class="ipims_flow02_05"></TD>
                    <TD class="ipims_flow02_06"><IMG src="image/end.gif"></TD>
                </TR>
                <TR>
                    <TD height="10" colspan="6"></TD>
                </TR>
                <TR>
                    <TD width="17%" align="center">OA<BR>발생 </TD>
                    <TD width="17%" align="center">OA<BR>발명자검토 </TD>
                    <TD width="17%" align="center">OA의뢰<BR>검토 </TD>
                    <TD width="17%" align="center">의견안<BR>작성/수정 </TD>
                    <TD width="17%" align="center">의견안<BR>특허팀검토 </TD>
                    <TD width="17%" align="center">제<BR>출</TD>
                </TR>
                <TR>
                    <%
                    for (int i = 1; i <= 6; i++) {
                        intBizFlowId = "OA_INT" + NTextUtil.rpad(i + "", 2, "0");
                        extBizFlowId = "OA_EXT" + NTextUtil.rpad(i + "", 2, "0");
                    %>
                    <TD align="center">
                        <DIV class="int_count" onClick="javascript:fnOpenBizFlowList('<%= intBizFlowId %>');">(<SPAN id="<%= intBizFlowId %>"></SPAN>)</DIV>
                        <DIV class="ext_count" onClick="javascript:fnOpenBizFlowList('<%= extBizFlowId %>');">(<SPAN id="<%= extBizFlowId %>"></SPAN>)</DIV>
                    </TD>
                    <%
                    }
                    %>
                </TR>
     <%
     }else if(gubun.equals("Due") == true){
     %>
      <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD class="ipims_portlet_head" width="120">Due Date</TD>
                    <TD class="ipims_portlet_title" width="*" align="center">
                        <SPAN style="font-size:20px; cursor:hand;" onSelectStart="javascript:return false;" onClick="javascript:fnMakeDueDateCalendar(-1);">◀</SPAN>
                        <SPAN class="ipims_month" style="font-size:18px; width:130px;" id="spn_dueDateTitle"></SPAN>
                        <SPAN style="font-size:20px; cursor:hand;" onSelectStart="javascript:return false;" onClick="javascript:fnMakeDueDateCalendar(+1);">▶</SPAN>
                    </TD>
                    <TD class="ipims_portlet_title" width="120" align="right"><IMG src="image/ipims_title_end.gif" width="6" height="32" style="margin-left:4px;"></TD>
                </TR>
            </TABLE>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD height="161" class="ipims_portlet_content">
                        <TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="100%" class="ipims_portlet_calendar">
                            <TR>
                                <TH width="14%" noWrap class="sun">SUN</TH>
                                <TH width="14%" noWrap>MON</TH>
                                <TH width="14%" noWrap>TUE</TH>
                                <TH width="14%" noWrap>WED</TH>
                                <TH width="14%" noWrap>THU</TH>
                                <TH width="14%" noWrap>FRI</TH>
                                <TH width="14%" noWrap class="sat">SAT</TH>
                            </TR>
                            <TBODY id="tbd_dueDateCalendar"></TBODY>
                        </TABLE>
                    </TD>
                </TR>
                <TR>
                    <TD>
                        <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                            <TR>
                                <TD class="ipims_portlet_b_bg" width="1"><IMG src="image/ipims_portlet_b_left.gif"></TD>
                                <TD class="ipims_portlet_b_bg" width="100%"></TD>
                                <TD class="ipims_portlet_b_bg" width="1"><IMG src="image/ipims_portlet_b_right.gif"></TD>
                            </TR>
                        </TABLE>
                    </TD>
                </TR>
            </TABLE>
     <%
     }else if(gubun.equals("App") == true){ %>
                <TR>
                    <TD colspan="2" class="ipims_portlet_head">출원현황</TD>
                    <TD class="ipims_portlet_title" align="right"><IMG src="image/ipims_title_end.gif" width="6" height="32"></TD>
                </TR>
                <TR>
                    <TD height="161" colspan="3" align="center" class="ipims_portlet_content" style="vertical-align:middle;">
                        <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                            <TR>
                                <TD colspan="7" align="right">
                                    <FONT color="#3255b1" style="font-family:굴림;">■ 국내</FONT>
                                    <FONT color="#ec1602" style="font-family:굴림;">■ 해외</FONT>
                                </TD>
                            </TR>
                            <TR>
                                <TD colspan="7" height="10"></TD>
                            </TR>
                            <TR>
                                <TD class="ipims_flow01_01"></TD>
                                <TD class="ipims_flow01_02"></TD>
                                <TD class="ipims_flow01_03"></TD>
                                <TD class="ipims_flow01_04"></TD>
                                <TD class="ipims_flow01_05"></TD>
                                <TD class="ipims_flow01_06"></TD>
                                <TD class="ipims_flow01_07"><IMG src="image/end.gif"></TD>
                            </TR>
                            <TR>
                                <TD height="10" colspan="7"></TD>
                            </TR>
                            <TR>
                                <TD width="14%" align="center">품의<BR>중</TD>
                                <TD width="14%" align="center">의뢰<BR>검토</TD>
                                <TD width="14%" align="center">사무소<BR>의뢰 </TD>
                                <TD width="14%" align="center">명세서<BR>작성/수정 </TD>
                                <TD width="14%" align="center">명세서<BR>발명자검토 </TD>
                                <TD width="14%" align="center">명세서<BR>특허팀검토 </TD>
                                <TD width="14%" align="center">출<BR>원 </TD>
                            </TR>
                            <TR>
                                <%
                                for (int i = 1; i <= 7; i++) {
                                    intBizFlowId = "APP_INT" + NTextUtil.rpad(i + "", 2, "0");
                                    extBizFlowId = "APP_EXT" + NTextUtil.rpad(i + "", 2, "0");
                                %>
                                <TD align="center">
                                    <DIV class="int_count" onClick="javascript:fnOpenBizFlowList('<%= intBizFlowId %>');">(<SPAN id="<%= intBizFlowId %>"></SPAN>)</DIV>
                                    <DIV class="ext_count" onClick="javascript:fnOpenBizFlowList('<%= extBizFlowId %>');">(<SPAN id="<%= extBizFlowId %>"></SPAN>)</DIV>
                                </TD>
                                <%
                                }
                                %>
                            </TR>
     <%} %>

            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD class="ipims_portlet_b_bg"><IMG src="image/ipims_portlet_b_left.gif"></TD>
        <TD class="ipims_portlet_b_bg"></TD>
        <TD class="ipims_portlet_b_bg" align="right"><IMG src="image/ipims_portlet_b_right.gif"></TD>
    </TR>
</TABLE>
</BODY>
</HTML>
