<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>프로젝트별 실적통계</TITLE>
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
    var ldr = gr_actualByProjectList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.statistic.statistic.act.RetrieveActualByProjectList.do";
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

//작성
function fnCreate()
{
}

//상세
function fnDetail(gr, fg, row, colId)
{
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
                    <COL class="condhead" width="20%">
                    <COL class="conddata" width="80%">
                </COLGROUP>
                <TR>
                    <TD>검색일</TD>
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
            <ANY:GRID id="gr_actualByProjectList" pagingType="1"><COMMENT>
                addColumn({ width:150, align:"left"  , type:"string" , sort:true , id:"PJT_NAME" , name:"프로젝트" });
                addColumn({ width:70 , align:"right" , type:"string" , sort:true , id:"INT_APP_CNT"  , name:"국내출원" });
                addColumn({ width:70 , align:"right" , type:"string" , sort:true , id:"INT_REG_CNT"  , name:"국내등록" });
                addColumn({ width:70 , align:"right" , type:"string" , sort:true , id:"EXT_APP_CNT"   , name:"해외출원" });
                addColumn({ width:70 , align:"right" , type:"string" , sort:true , id:"EXT_REG_CNT"   , name:"해외등록" });
                messageSpan = "spn_gridMessage";
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
