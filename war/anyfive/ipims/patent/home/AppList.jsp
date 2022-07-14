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
<SCRIPT language="JScript">
var gBoardConfig;

//윈도우 로딩시
window.onready = function()
{

    fnRetrieveBizFlowCount();

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
