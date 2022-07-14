<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.share.workprocess.util.WorkProcessConst"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>심의평가현황</TITLE>
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
    //var ldr = gr_intPatentConsultList.loader;
    var ldr = gr_councilRequestListR.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.council.act.RetrieveCouncilEvlListR.do";
    ldr.addParam("MGT_ID", MGT_ID.value);
    ldr.addParam("REQ_SUBJECT", REQ_SUBJECT.value);
    ldr.addParam("START_DATE", START_DATE.value);
    ldr.addParam("END_DATE", END_DATE.value);
    ldr.addParam("REVIEW_MEMBER", REVIEW_MEMBER.value);

    ldr.onSuccess = function(gr, fg)
    {
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

//심의신청
function fnCreate(){

    var win = new any.viewer();
    win.path = "CouncilRequestC.jsp";

    win.onReload = function()
    {
        gr_councilRequestListR.loader.reload();
    }

    win.show();
}

//상세
function fnDetail(gr, fg, row, colId)
{
    var win = new any.viewer();

    win.path = "CouncilEvlListRD.jsp";
    win.arg.MGT_ID = gr.value(row, "MGT_ID");
    win.onReload = function()
    {
        gr.loader.reload();
    }

    win.show();
}
</SCRIPT>

<!-- 업무프로세스 로딩시 -->
<SCRIPT language="JScript" for="wp" event="OnLoad()">
    var isCreUser = (ds_mainInfo.value(0, "CRE_USER") == "<%= app.userInfo.getUserId() %>");
    var actRewrite = "<%= WorkProcessConst.Action.REWRITE %>";
    var actModify = "<%= WorkProcessConst.Action.MODIFY %>";

    //cfShowObjects([btn_rewrite, btn_line1], isCreUser && wp.avail([actRewrite]));
    //cfShowObjects([btn_modify, btn_line2], isCreUser && wp.avail([actModify]));
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
                    <TD>심의요청번호</TD>
                    <TD>
                       <INPUT type="text" id="MGT_ID" style="text-transform:uppercase;">
                    </TD>
                    <TD>심의요청제목</TD>
                    <TD>
                        <INPUT type="text" id="REQ_SUBJECT" style="text-transform:uppercase;">
                    </TD>
                </TR>
                <TR>
                    <TD>검색일자</TD>
                    <TD noWrap>
                        <ANY:DATE id="START_DATE" />&nbsp;~
                        <ANY:DATE id="END_DATE" />
                    </TD>
                    <TD>심의위원</TD>
                    <TD>
                        <INPUT type="text" id="REVIEW_MEMBER" style="text-transform:uppercase;">
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
            <ANY:GRID id="gr_councilRequestListR" pagingType="1"><COMMENT>
                addColumn({ width:130, align:"center" , type:"string" , sort:true  , id:"MGT_NO"        , name:"심의요청번호" });
                addColumn({ width:210, align:"left"   , type:"string" , sort:true  , id:"REQ_SUBJECT"   , name:"심의요청제목" });
                addColumn({ width:150, align:"center" , type:"date"   , sort:true  , id:"SE_DATE"       , name:"심의기간"  });
                addColumn({ width:100, align:"left"   , type:"string" , sort:true  , id:"STATUS"        , name:"진행상태" });
                addColumn({ width:130, align:"left"   , type:"string" , sort:true  , id:"REVIEW_NAMES"  , name:"심의위원" });
                addColumn({ width:90,  align:"center" , type:"date"   , sort:true  , id:"CRE_DATE"      , name:"작성일자" });
                addColumn({ width:90,  align:"center" , type:"string" , sort:true  , id:"CRE_USER"      , name:"작성자" });
                setFixedColumn(null, "REQ_SUBJECT");
                addSorting("MGT_NO", "DESC");
                addAction("REQ_SUBJECT", fnDetail);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
    <TR>
        <TD height="5"></TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
