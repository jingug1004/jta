<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>사원정보 관리</TITLE>
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
    var ldr = gr_patTeamUserList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.patteam.user.act.RetrievePatTeamUserList.do";
    ldr.addParam("MAIL_ADDR", MAIL_ADDR.value);
    ldr.addParam("EMP_NAME", EMP_NAME.value);

    ldr.onSuccess = function(gr, fg)
    {
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

//수정
function fnModify(gr, fg, row, colId)
{
    var win = new any.viewer();
    win.path = "PatTeamUserUD.jsp";
    win.arg.USER_ID = gr.value(row, "USER_ID");

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
                    <TD>메일ID</TD>
                    <TD>
                        <INPUT type="text" id="MAIL_ADDR">
                    </TD>
                    <TD>성명</TD>
                    <TD>
                        <INPUT type="text" id="EMP_NAME">
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
            <ANY:GRID id="gr_patTeamUserList" pagingType="1"><COMMENT>
                addColumn({ width:50 , align:"center", type:"number" , sort:false, id:"ROW_NUM"         , name:"No" });
                addColumn({ width:80 , align:"center", type:"string" , sort:true , id:"EMP_HNAME"       , name:"한글성명" });
                addColumn({ width:70 , align:"center", type:"string" , sort:true , id:"HT_CODE_NAME"    , name:"현재상태" });
                addColumn({ width:110, align:"left"  , type:"string" , sort:true , id:"EMP_ENAME"       , name:"영문성명" });
                addColumn({ width:80 , align:"left"  , type:"string" , sort:true , id:"POSITION_NAME"   , name:"직위" });
                addColumn({ width:100, align:"left"  , type:"string" , sort:true , id:"LAB_NAME"        , name:"연구소" });
                addColumn({ width:100, align:"left"  , type:"string" , sort:true , id:"TEAM_NAME"       , name:"팀" });
                addColumn({ width:90 , align:"left"  , type:"string" , sort:true , id:"OFFICE_TEL"      , name:"사내전화번호" });
                addColumn({ width:120, align:"left"  , type:"string" , sort:true , id:"MAIL_ADDR"       , name:"메일ID" });
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_NUM", "EMP_HNAME");
                addSorting("EMP_HNAME", "ASC");
                addAction("EMP_HNAME", fnModify);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
