<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>출원의뢰서 삭제</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("REF_NO");
    addBind("RIGHT_DIV_NAME");
    addBind("KO_APP_TITLE");
    addBind("INVENTOR_NAMES");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();
}

//조회
function fnRetrieve()
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.datahandle.appreqdelete.act.RetrieveAppReqDelete.do";
    prx.addParam("REF_ID", parent.REF_ID);
    prx.checkData = ds_mainInfo;

    prx.onSuccess = function()
    {
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//상세
function fnDetail()
{
    var win = new any.window();
    switch (ds_mainInfo.value(0, "RIGHT_DIV")) {
    case "10":
    case "20":
        win.path = top.getRoot() + "/anyfive/ipims/patent/applymgt/intpatent/request/IntPatentRequestRD.jsp";
        break;
    case "30":
        win.path = top.getRoot() + "/anyfive/ipims/patent/applymgt/design/intrequest/DesignIntRequestRD.jsp";
        break;
    case "40":
        win.path = top.getRoot() + "/anyfive/ipims/patent/applymgt/tmark/intrequest/TMarkIntRequestRD.jsp";
        break;
    }
    win.arg.REF_ID = parent.REF_ID;
    win.show();
}

//삭제
function fnDelete()
{
    //삭제 확인
    if (!confirm("삭제작업은 복구할 수 없습니다.\n\n정말로 삭제하시겠습니까?")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.datahandle.appreqdelete.act.DeleteAppReq.do";
    prx.addParam("REF_ID", parent.REF_ID);

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.delete").toJS() %>");
        top.window.close();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}
</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="1" cellpadding="2" class="main">
    <COLGROUP>
        <COL class="conthead" width="25%">
        <COL class="contdata" width="75">
    </COLGROUP>
    <TR>
        <TD>REF-NO</TD>
        <TD><INPUT id="REF_NO" readOnly style="border:none;"></TD>
    </TR>
    <TR>
        <TD>권리구분</TD>
        <TD><SPAN id="RIGHT_DIV_NAME"></SPAN></TD>
    </TR>
    <TR>
        <TD>발명의 명칭</TD>
        <TD><SPAN id="KO_APP_TITLE"></SPAN></TD>
    </TR>
    <TR>
        <TD>발명자</TD>
        <TD><SPAN id="INVENTOR_NAMES"></SPAN></TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="상세보기" onClick="javascript:fnDetail();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.delete").toHTML() %>" onClick="javascript:fnDelete();"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.cancel").toHTML() %>" onClick="javascript:top.window.close();"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
