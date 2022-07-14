<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>해외출원현황</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();
}

//조회
function fnRetrieve()
{
    var ldr = gr_extApplyList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.common.popup.viewer.act.RetrieveExtApplyByIntList.do";
    ldr.addParam("REF_ID", parent.REF_ID);

    ldr.onSuccess = function(gr, fg)
    {
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

//해외출원마스터 팝업
function fnOpenExtMaster(gr, fg, row, colId)
{
    var win = new any.window();
    win.path = top.getRoot() + "/anyfive/ipims/patent/applymgt/common/ExtMasterTabR.jsp";
    win.arg.REF_ID = gr.value(row, "REF_ID");
    win.opt.width = 900;
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
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%" onEnter="javascript:fnSearch();">
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
            <ANY:GRID id="gr_extApplyList" pagingType="0"><COMMENT>
                addColumn({ width:120, align:"left"  , type:"string" , sort:true , id:"REF_NO"          , name:"REF-NO" });
                addColumn({ width:80 , align:"left"  , type:"string" , sort:true , id:"COUNTRY_NAME"    , name:"국가" });
                addColumn({ width:150, align:"left"  , type:"string" , sort:true , id:"KO_APP_TITLE"    , name:"발명의 명칭" });
                addColumn({ width:110, align:"left"  , type:"string" , sort:true , id:"APP_NO"          , name:"출원번호" });
                addColumn({ width:75 , align:"center", type:"date"   , sort:true , id:"APP_DATE"        , name:"출원일" });
                addColumn({ width:110, align:"left"  , type:"string" , sort:true , id:"REG_NO"          , name:"등록번호" });
                addColumn({ width:75 , align:"center", type:"date"   , sort:true , id:"REG_DATE"        , name:"등록일" });
                addColumn({ width:60 , align:"center", type:"string" , sort:true , id:"STATUS"          , name:"진행상태" });
                addColumn({ width:60 , align:"center", type:"string" , sort:true , id:"STATUS_DATE"     , name:"진행일자" });
                messageSpan = "spn_gridMessage";
                addAction("KO_APP_TITLE", fnOpenExtMaster);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
    <TR>
        <TD height="5"></TD>
    </TR>
    <TR>
        <TD align="right">
            <BUTTON auto="close" id="btn_close"></BUTTON>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
