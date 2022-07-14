<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.share.common.app.ShareApp"%><% ShareApp app = new ShareApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>발명자정보</TITLE>
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
    var ldr = gr_inventorList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.office.common.popup.viewer.act.RetrieveInventorList.do";
    ldr.addParam("REF_ID", parent.REF_ID);
    ldr.addParam("GRP_ID", parent.GRP_ID);

    ldr.onSuccess = function(gr, fg)
    {
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}
</SCRIPT>
</HEAD>
<BODY>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
    <TR>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
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
            <ANY:GRID id="gr_inventorList" pagingType="0"><COMMENT>
                addColumn({ width:80 , align:"center", type:"string" , sort:true , id:"EMP_NO"         , name:"사번" });
                addColumn({ width:80 , align:"left"  , type:"string" , sort:true , id:"EMP_HNAME"      , name:"성명" });
                addColumn({ width:110, align:"left"  , type:"string" , sort:true , id:"DEPT_NAME"      , name:"부서명" });
                addColumn({ width:80 , align:"center", type:"string" , sort:true , id:"POSITION_NAME"  , name:"직급" });
                addColumn({ width:80 , align:"center", type:"string" , sort:true , id:"HT_CODE_NAME"   , name:"재직" });
                addColumn({ width:100, align:"left"  , type:"string" , sort:true , id:"MAIL_ADDR"      , name:"이메일" });
                addColumn({ width:100, align:"center", type:"string" , sort:true , id:"OFFICE_TEL"     , name:"사내전화" });
                addColumn({ width:100, align:"center", type:"string" , sort:true , id:"JUMIN_NO"       , name:"주민등록번호" });
                addColumn({ width:100, align:"center", type:"string" , sort:true , id:"HOME_ADDR"      , name:"주소" });
                addColumn({ width:80 , align:"left"  , type:"string" , sort:true , id:"EMP_CNAME"      , name:"중문명" });
                addColumn({ width:80 , align:"left"  , type:"string" , sort:true , id:"EMP_ENAME"      , name:"영문명" });
                messageSpan = "spn_gridMessage";
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
