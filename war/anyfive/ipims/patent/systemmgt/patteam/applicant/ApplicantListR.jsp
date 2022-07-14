<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>출원인 관리</TITLE>
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
    var ldr = gr_applicantList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.patteam.applicant.act.RetrieveApplicantList.do";
    ldr.addParam("APP_MAN_NAME" , APP_MAN_NAME.value);

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
  win.path = "ApplicantC.jsp";

  win.onReload = function()
  {
      gr_applicantList.loader.reload();
  }

  win.show();
}

//수정
function fnModify(gr, fg, row, colId)
{
    var win = new any.viewer();
    win.path = "ApplicantU.jsp";
    win.arg.APP_MAN_CODE = gr.value(row, "APP_MAN_CODE");

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
            <TABLE border="0" width="100%" cellspacing="1" cellpadding="2" class="main" width="100%">
                <COLGROUP>
                    <COL class="condhead" width="15%">
                    <COL class="conddata" width="35%">
                    <COL class="condhead" width="15%">
                    <COL class="conddata" width="35%">
                </COLGROUP>
                <TR>
                    <TD>출원인</TD>
                    <TD>
                        <INPUT type="text" id="APP_MAN_NAME">
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
                        <BUTTON text="<%= app.message.get("btn.com.write").toHTML() %>" onClick="javascript:fnCreate();"></BUTTON>
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
            <ANY:GRID id="gr_applicantList" pagingType="1"><COMMENT>
                addColumn({ width:90 , align:"center", type:"string", sort:true, id:"APP_MAN_CODE"   , name:"출원인 코드" });
                addColumn({ width:150 , align:"center", type:"string", sort:true , id:"APP_MAN_NAME"   , name:"출원인 이름" });
                addColumn({ width:200, align:"left"  , type:"string", sort:true , id:"ADDRESS"      , name:"주소" });
                addColumn({ width:70 , align:"center", type:"string", sort:true , id:"USE_YN_NAME"      , name:"사용구분" });
                messageSpan = "spn_gridMessage";
                addSorting("APP_MAN_CODE", "ASC");
                addAction("APP_MAN_NAME", fnModify);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
