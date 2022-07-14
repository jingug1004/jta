<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.share.workprocess.util.WorkProcessConst"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>오더레터현황</TITLE>
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
    var ldr = gr_OrderLetterList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.extpatent.orderletter.act.RetrieveExtPatentOrderLetterList.do";
    ldr.addParam("GRP_NO", GRP_NO.value);
    ldr.addParam("SR_NO_ONLY", SR_NO_ONLY.value);
    ldr.addParam("KO_APP_TITLE", KO_APP_TITLE.value);
    ldr.addParam("OL_STATUS", OL_STATUS.value);
    ldr.addParam("JOB_MAN", JOB_MAN.value);
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

//상세
function fnDetail(gr, fg, row, colId)
{
    var win = new any.viewer();

    switch (gr.value(row, "OL_DIV")) {
    case "C":
        win.path = top.getRoot() + "/anyfive/ipims/patent/applymgt/extpatent/condiv/ExtPatentConDivRD.jsp";
        break;
    case "E":
        win.path = top.getRoot() + "/anyfive/ipims/patent/applymgt/extpatent/eppct/ExtPatentEpPctRD.jsp";
        break;
    default:
        win.path = "ExtPatentOrderLetterRD.jsp";
        break;
    }

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
                    <COL class="condhead" width="10%">
                    <COL class="conddata" width="23%">
                    <COL class="condhead" width="10%">
                    <COL class="conddata" width="23%">
                    <COL class="condhead" width="10%">
                    <COL class="conddata" width="23%">
                </COLGROUP>
                <TR>
                    <TD>해외품의번호</TD>
                    <TD>
                        <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                            <TR>
                                <TD width="100%">
                                    <INPUT type="text" id="GRP_NO" style="text-transform:uppercase;">
                                </TD>
                                <TD noWrap>
                                    <ANY:CHECK id="SR_NO_ONLY" text="번호만 검색" />
                                </TD>
                            </TR>
                        </TABLE>
                    </TD>
                    <TD>발명의명칭</TD>
                    <TD>
                        <INPUT type="text" id="KO_APP_TITLE">
                    </TD>
                    <TD>진행상태</TD>
                    <TD>
                        <ANY:SELECT id="OL_STATUS" codeData="/common/bizStepStatus,<%= WorkProcessConst.Step.EXT_PATENT_NEW_OL %>||<%= WorkProcessConst.Step.EXT_PATENT_CONDIV_OL %>" firstName="all" />
                    </TD>
                </TR>
                <TR>
                    <TD>건담당자</TD>
                    <TD>
                        <ANY:SELECT id="JOB_MAN" codeData="/common/jobMan,PAT" firstName="all" />
                    </TD>
                    <TD>작성기간</TD>
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
            <ANY:GRID id="gr_OrderLetterList" pagingType="1"><COMMENT>
                addColumn({ width:110, align:"left"  , type:"string" , sort:true , id:"GRP_NO"              , name:"해외출원품의번호"  });
                addColumn({ width:110, align:"left"  , type:"string" , sort:true , id:"KR_APP_NOS"          , name:"국내출원번호" });
                addColumn({ width:200, align:"left"  , type:"string" , sort:true , id:"KO_APP_TITLE"        , name:"발명의 명칭" });
                addColumn({ width:75 , align:"left"  , type:"string" , sort:true , id:"DIVISION_TYPE_NAME"  , name:"구분" });
                addColumn({ width:110, align:"left"  , type:"string" , sort:true , id:"COUNTRY_NAMES"       , name:"츨원국가" });
                addColumn({ width:110, align:"left"  , type:"string" , sort:true , id:"STATUS_NAME"         , name:"진행상태" });
                addColumn({ width:75 , align:"center", type:"string" , sort:true , id:"CRE_USER_NAME"       , name:"작성자" });
                addColumn({ width:110, align:"left"  , type:"string" , sort:true , id:"OFFICE_NAME"         , name:"국내사무소" });
                useConfig = true;
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
