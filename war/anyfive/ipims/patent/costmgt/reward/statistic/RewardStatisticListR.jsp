<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>보상금통계</TITLE>
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
    var ldr = gr_rewardStatisticList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.costmgt.reward.statistic.act.RetrieveRewardStatisticList.do";
    ldr.addParam("DATE_KIND", DATE_KIND.value);
    ldr.addParam("DATE_START", DATE_START.value);
    ldr.addParam("DATE_END", DATE_END.value);
    ldr.addParam("STATUS", STATUS.value);

    ldr.onSuccess = function(gr, fg)
    {
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}
</SCRIPT>

<!-- 검색일자 구분 변경시 -->
<SCRIPT language="JScript" for="DATE_KIND" event="OnChange()">
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
                    <COL class="condhead" width="15%">
                    <COL class="conddata" width="35%">
                    <COL class="condhead" width="15%">
                    <COL class="conddata" width="35%">
                </COLGROUP>
                <TR>
                    <TD>검색일자</TD>
                    <TD noWrap>
                        <ANY:SELECT id="DATE_KIND" codeData="/costmgt/rewardSupplySearchDateType" firstName="none" style="width:80px; margin-right:3px;" />
                        <ANY:DATE id="DATE_START" disabled />&nbsp;~
                        <ANY:DATE id="DATE_END" disabled />
                    </TD>
                    <TD>진행상태</TD>
                    <TD>
                        <ANY:SELECT id="STATUS" codeData="/costmgt/rewardStatisticStatus" />
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
            <ANY:GRID id="gr_rewardStatisticList" pagingType="0"><COMMENT>
                addHeader([ null, null,  "국내", "", "해외", "" ]);
                addColumn({ width:160, align:"left"  , type:"string" , sort:true , id:"REWARD_DIV_NAME" , name:"구분" });
                addColumn({ width:150, align:"center", type:"string" , sort:true , id:"DEPT_NAME"   , name:"부서" });
                addColumn({ width:100, align:"center", type:"number" , sort:true , id:"INT_CNT"         , name:"대상건" });
                addColumn({ width:150, align:"right" , type:"number" , sort:true , id:"INT_PRICE"       , name:"지급금액" , format:"#,###"});
                addColumn({ width:100, align:"center", type:"number" , sort:true , id:"EXT_CNT"         , name:"대상건" });
                addColumn({ width:150, align:"right" , type:"number" , sort:true , id:"EXT_PRICE"       , name:"지급금액" , format:"#,###"});
                useConfig = true;
                messageSpan = "spn_gridMessage";
                setFixedColumn(null, "DEPT_NAME");
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
