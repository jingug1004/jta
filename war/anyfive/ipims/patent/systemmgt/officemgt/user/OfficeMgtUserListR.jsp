<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>사무소직원 관리</TITLE>
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
    var ldr = gr_officeMainList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.officemgt.user.act.RetrieveOfficeMgtUserList.do";
    ldr.addParam("OFFICE_CODE", OFFICE_CODE.value);
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

//작성
function fnCreate()
{
    var win = new any.viewer();
    win.path = "OfficeMgtUserC.jsp";

    win.onReload = function()
    {
        gr_officeMainList.loader.reload();
    }

    win.show();
}

//수정
function fnModify(gr, fg, row, colId)
{
    var win = new any.viewer();
    win.path = "OfficeMgtUserUD.jsp";
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
                    <TD>사무소</TD>
                    <TD>
                        <ANY:SELECT id="OFFICE_CODE" codeData="/common/officeCode" firstName="all" />
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
                        <BUTTON auto="line"></BUTTON>
                        <BUTTON text="작성" onClick="javascript:fnCreate();"></BUTTON>
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
            <ANY:GRID id="gr_officeMainList" pagingType="1"><COMMENT>
                addColumn({ width:50 , align:"center", type:"number" , sort:false, id:"ROW_NUM"         , name:"No" });
                addColumn({ width:140, align:"left"  , type:"string" , sort:true , id:"FIRM_HNAME"      , name:"사무소" });
                addColumn({ width:80 , align:"left"  , type:"string" , sort:true , id:"EMP_NO"          , name:"관리사번" });
                addColumn({ width:80 , align:"left"  , type:"string" , sort:true , id:"EMP_HNAME"       , name:"성명" });
                addColumn({ width:90 , align:"left"  , type:"string" , sort:true , id:"DEPT_NAME"       , name:"부서" });
                addColumn({ width:80 , align:"left"  , type:"string" , sort:true , id:"POSITION_NAME"   , name:"직위" });
                addColumn({ width:120, align:"left"  , type:"string" , sort:true , id:"OFFICE_TEL"      , name:"전화번호" });
                addColumn({ width:150, align:"left"  , type:"string" , sort:true , id:"MAIL_ADDR"       , name:"메일주소" });
                addColumn({ width:60 , align:"center", type:"string" , sort:true , id:"USE_YN_NAME"     , name:"사용여부" });
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_NUM", "EMP_HNAME");
                addSorting("FIRM_HNAME", "ASC");
                addSorting("EMP_HNAME", "ASC");
                addAction("EMP_HNAME", fnModify);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
