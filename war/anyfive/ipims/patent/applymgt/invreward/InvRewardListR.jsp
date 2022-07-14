<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>보상금지급내역</TITLE>
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
    var ldr = gr_invRewardList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.invreward.act.RetrieveInvRewardList.do";
    ldr.addParam("SR_GUBUN"   , SR_GUBUN.value);
    ldr.addParam("SR_NO"      , SR_NO.value);
    ldr.addParam("INOUT_DIV"  , INOUT_DIV.value);
    ldr.addParam("REWARD_DIV" , REWARD_DIV.value);
    ldr.addParam("DATE_GUBUN" , DATE_GUBUN.value);
    ldr.addParam("DATE_START" , DATE_START.value);
    ldr.addParam("DATE_END"   , DATE_END.value);

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
                    <COL class="condhead" width="15%">
                    <COL class="conddata" width="35%">
                    <COL class="condhead" width="15%">
                    <COL class="conddata" width="35%">
                </COLGROUP>
                <TR>
                    <TD>검색번호</TD>
                    <TD>
                        <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                            <TR>
                                <TD>
                                    <ANY:SELECT id="SR_GUBUN" codeData="/applymgt/statisticRewardSearchNo" style="width:80px; margin-right:3px;" />
                                </TD>
                                <TD width="100%">
                                    <INPUT type="text" id="SR_NO" style="text-transform:uppercase;">
                                </TD>
                            </TR>
                        </TABLE>
                    </TD>
                    <TD>국가구분</TD>
                    <TD>
                        <ANY:SELECT id="INOUT_DIV" codeData="{INOUT_DIV}" firstName="all" />
                    </TD>
                </TR>
                <TR>
                    <TD>검색일자</TD>
                    <TD noWrap>
                        <ANY:SELECT id="DATE_GUBUN" codeData="/applymgt/statisticRewardDateKind" firstName="none" style="width:80px; margin-right:3px;" />
                        <ANY:DATE id="DATE_START" disabled />&nbsp;~
                        <ANY:DATE id="DATE_END" disabled />
                    </TD>
                    <TD>보상금구분</TD>
                    <TD>
                        <ANY:SELECT id="REWARD_DIV" codeData="{REWARD_DIV}" firstname="all"/>
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
            <ANY:GRID id="gr_invRewardList" pagingType="1"><COMMENT>
                addColumn({ width:120, align:"left"  , type:"string", sort:true , id:"REF_NO"               , name:"REF-NO" });
                addColumn({ width:60 , align:"center", type:"string", sort:true , id:"INOUT_DIV_NAME"       , name:"국내외" });
                addColumn({ width:70 , align:"center", type:"string", sort:true , id:"RIGHT_DIV_NAME"       , name:"권리구분" });
                addColumn({ width:80 , align:"center", type:"string", sort:true , id:"REWARD_DIV_NAME"      , name:"보상금구분" });
                addColumn({ width:45 , align:"center", type:"string", sort:true , id:"REWARD_GRADE"         , name:"등급" });
                addColumn({ width:90 , align:"right" , type:"string", sort:true , id:"PRICE"                , name:"보상금" , format:"#,###" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"ANS_DATE"             , name:"결재완료일" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"APP_NO"               , name:"출원번호" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"APP_DATE"             , name:"출원일" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"REG_NO"               , name:"등록번호" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"REG_DATE"             , name:"등록일" });
                useConfig = true;
                messageSpan = "spn_gridMessage";
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
