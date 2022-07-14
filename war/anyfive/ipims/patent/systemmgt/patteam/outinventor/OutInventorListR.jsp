<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>외부발명자 관리</TITLE>
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
    var ldr = gr_outInventorList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.patteam.outinventor.act.RetrieveOutInventorList.do";
    ldr.addParam("EMP_NAME", EMP_NAME.value);
    ldr.addParam("EMP_NO", EMP_NO.value);
    ldr.addParam("COUNTRY_CODE", COUNTRY_CODE.value);
    ldr.addParam("APP_MAN_CODE", APP_MAN_CODE.value);

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
    win.path = "OutInventorC.jsp";

    win.onReload = function()
    {
        gr_outInventorList.loader.reload();
    }

    win.show();
}

//수정
function fnModify(gr, fg, row, colId)
{
    var win = new any.viewer();
    win.path = "OutInventorUD.jsp";
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
                    <COL class="condhead" width="5%">
                    <COL class="conddata" width="10%">
                    <COL class="condhead" width="5%">
                    <COL class="conddata" width="10%">
                    <COL class="condhead" width="5%">
                    <COL class="conddata" width="10%">
                    <COL class="condhead" width="5%">
                    <COL class="conddata" width="10%">
                </COLGROUP>
                <TR>
                    <TD>성명</TD>
                    <TD>
                        <INPUT type="text" id="EMP_NAME">
                    </TD>
                    <TD>자회사</TD>
                    <TD>
                        <ANY:SELECT id="APP_MAN_CODE" codeData="/common/inAppManCode" firstName="all" />
                    </TD>
                    <TD>관리번호</TD>
                    <TD>
                        <INPUT type="text" id="EMP_NO">
                    </TD>
                    <TD>국가</TD>
                    <TD>
                        <ANY:SELECT id="COUNTRY_CODE" codeData="/common/countryCode" firstName="all" />
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
            <ANY:GRID id="gr_outInventorList" pagingType="1"><COMMENT>
                addColumn({ width:50 , align:"center", type:"number" , sort:false, id:"ROW_NUM"         , name:"No" });
                addColumn({ width:100, align:"left"  , type:"string" , sort:true , id:"EMP_NO"          , name:"관리번호" });
                addColumn({ width:130, align:"left"  , type:"string" , sort:true , id:"EMP_HNAME"       , name:"한글성명" });
                addColumn({ width:250, align:"left"  , type:"string" , sort:true , id:"EMP_ENAME"       , name:"영문성명" });
                addColumn({ width:150, align:"left"  , type:"string" , sort:true , id:"APP_MAN_NAME"    , name:"자회사" });
                addColumn({ width:100, align:"left"  , type:"string" , sort:true , id:"OFFICE_TEL"      , name:"전화번호" });
                addColumn({ width:150, align:"left"  , type:"string" , sort:true , id:"MAIL_ADDR"       , name:"메일주소" });
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_NUM", "EMP_HNAME");
                addSorting("EMP_NO", "ASC");
                addAction("EMP_HNAME", fnModify);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
