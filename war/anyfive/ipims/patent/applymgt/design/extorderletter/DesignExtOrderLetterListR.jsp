<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.share.workprocess.util.WorkProcessConst"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>디자인오더레터현황</TITLE>
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
    var ldr = gr_designOLList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.design.extorderletter.act.RetrieveDesignExtOrderLetterList.do";
    ldr.addParam("GRP_NO", GRP_NO.value);
    ldr.addParam("STATUS", STATUS.value);
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


//상세
function fnDetail(gr, fg, row, colId)
{
    var win = new any.viewer();
    win.path = "DesignExtOrderLetterRD.jsp";
    win.arg.OL_ID = gr.value(row, "OL_ID");

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
                    <TD>해외품의번호</TD>
                    <TD>
                        <INPUT type="text" id="GRP_NO">
                    </TD>
                    <TD>진행상태</TD>
                    <TD>
                        <ANY:SELECT id="STATUS" codeData="/common/bizStepStatus,<%= WorkProcessConst.Step.EXT_DESIGN_NEW_OL %>" firstName="all" />
                    </TD>
                </TR>
                <TR>
                    <TD>건담당자</TD>
                    <TD>
                        <ANY:SELECT id="JOB_MAN" codeData="/common/jobMan,DES" firstName="all" />
                    </TD>
                    <TD>작성기간</TD>
                    <TD noWrap>
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
                        <BUTTON auto="retrieve" color="1" onClick="javascript:fnRetrieve();"></BUTTON>
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
            <ANY:GRID id="gr_designOLList" pagingType="1"><COMMENT>
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"GRP_NO"           , name:"해외출원품의번호" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"APP_NO"           , name:"국내출원번호" });
                addColumn({ width:90 , align:"left"  , type:"date"  , sort:true , id:"COUNTRY_NAME"     , name:"출원국가" });
                addColumn({ width:200, align:"left"  , type:"string", sort:true , id:"KO_APP_TITLE"     , name:"디자인명" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"STATUS_NAME"      , name:"진행상태" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"CRE_USER_NAME"    , name:"작성자" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"KR_OFFICE"        , name:"국내사무소" });
                messageSpan = "spn_gridMessage";
                setFixedColumn(null, "KO_APP_TITLE");
                addSorting("GRP_NO", "DESC");
                addAction("KO_APP_TITLE", fnDetail);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>
<% app.writeBodyFooter(); %>

</BODY>
</HTML>
