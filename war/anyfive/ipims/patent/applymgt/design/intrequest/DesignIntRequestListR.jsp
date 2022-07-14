<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<%@page import="anyfive.ipims.share.workprocess.util.WorkProcessConst"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>디자인출원의뢰현황</TITLE>
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
    var ldr = gr_tradeMarkList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.design.intrequest.act.RetrieveDesignIntRequestList.do";
    ldr.addParam("REF_NO", REF_NO.value);
    ldr.addParam("STATUS", STATUS.value);
    ldr.addParam("DATE_GUBUN", DATE_GUBUN.value);
    ldr.addParam("DATE_START", DATE_START.value);
    ldr.addParam("DATE_END", DATE_END.value);
    ldr.addParam("JOB_MAN", JOB_MAN.value);

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
function fnWrite()
{
    var win = new any.viewer();
    win.path = "DesignIntRequestC.jsp";

    win.onReload = function()
    {
        gr_tradeMarkList.loader.reload();
    }

    win.show();
}

//상세
function fnDetail(gr, fg, row, colId)
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.common.act.RetrieveIntRequestEditAvail.do";
    prx.addParam("REF_ID", gr.value(row, "REF_ID"));
    prx.hideMessage = true;

    prx.onSuccess = function()
    {
        var win = new any.viewer();
        win.path = (this.result == "1" ? "DesignIntRequestU.jsp" : "DesignIntRequestRD.jsp");
        win.arg.REF_ID = gr.value(row, "REF_ID");

        win.onReload = function()
        {
            gr.loader.reload();
        }

        win.show();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
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
                    <TD>REF-NO</TD>
                    <TD>
                        <INPUT type="text" id="REF_NO">
                    </TD>
                    <TD>진행상태</TD>
                    <TD>
                        <ANY:SELECT id="STATUS" codeData="/common/bizStepStatus,<%= WorkProcessConst.Step.INT_DESIGN_REQUEST %>" firstName="all" />
                    </TD>
                </TR>
                <TR>
                    <TD>검색일자</TD>
                    <TD noWrap>
                        <ANY:SELECT id="DATE_GUBUN" codeData="/applymgt/designIntRequestListDateType" firstName="none" style="width:100px; margin-right:3px;" />
                        <ANY:DATE id="DATE_START" value="" disabled />&nbsp;~
                        <ANY:DATE id="DATE_END" value="" disabled />
                    </TD>
                    <TD>건담당자</TD>
                    <TD>
                        <ANY:SELECT id="JOB_MAN" codeData="/common/jobMan,DES" firstName="all" />
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
                        <BUTTON auto="retrieve" color="1" onClick="javascript:fnRetrieve();"></BUTTON>
                        <BUTTON auto="line"></BUTTON>
                        <BUTTON text="<%= app.message.get("btn.com.write").toHTML() %>" onClick="javascript:fnWrite();"></BUTTON>
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
            <ANY:GRID id="gr_tradeMarkList" pagingType="1"><COMMENT>
                addColumn({ width:120, align:"left"  , type:"string" , sort:true , id:"REF_NO"              , name:"REF-NO" });
                addColumn({ width:205, align:"left"  , type:"string" , sort:true , id:"KO_APP_TITLE"        , name:"디자인명" });
                addColumn({ width:100, align:"left"  , type:"string" , sort:true , id:"INVENTOR_NAMES"      , name:"발명자" });
                addColumn({ width:75 , align:"center", type:"date"   , sort:true , id:"CRE_DATE"            , name:"작성일" });
                addColumn({ width:75 , align:"center", type:"string" , sort:true , id:"CRE_USER_NAME"       , name:"작성자" });
                addColumn({ width:90 , align:"left"  , type:"string" , sort:true , id:"STATUS_NAME"         , name:"진행상태" });
                addColumn({ width:75 , align:"center", type:"date"   , sort:true , id:"PATTEAM_RCPT_DATE"   , name:"특허팀접수일" });
                addColumn({ width:80 , align:"center", type:"string" , sort:true , id:"EXAM_RESULT"         , name:"검토결과" });
                addColumn({ width:75 , align:"center", type:"string" , sort:true , id:"JOB_MAN_NAME"        , name:"특허팀담당자" });
                messageSpan = "spn_gridMessage";
                setFixedColumn(null, "KO_APP_TITLE");
                addSorting("REF_NO", "DESC");
                addAction("KO_APP_TITLE", fnDetail);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>
<% app.writeBodyFooter(); %>

</BODY>
</HTML>
