<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>

<%@page import="any.core.config.NConfig"%><HTML XMLNS:ANY>
<HEAD>
<TITLE>양도증 인쇄</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_conveyPrintMain"><COMMENT>
    addBind("COMPANY_NAME");
    addBind("COMPANY_ADDRESS");
    addBind("CONVEY_DATE_YYYY");
    addBind("CONVEY_DATE_MM");
    addBind("CONVEY_DATE_DD");
</COMMENT></ANY:DS>
<ANY:DS id="ds_conveyPrintInventor" />
<ANY:DS id="ds_conveyPrintInventorTop" />
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();
}

//윈도우 인쇄 전
window.onbeforeprint = function()
{
    div_button.style.display = "none";
}

//윈도우 인쇄 후
window.onafterprint = function()
{
    div_button.style.display = "";
}

//목록 조회
function fnRetrieve()
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.intpatent.conveyprint.act.RetrieveIntPatentConveyPrint.do";
    prx.addParam("REF_ID", parent.REF_ID);
    prx.checkData = ds_conveyPrintMain;

    prx.onSuccess = function()
    {
        fnMakeInventorList();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//
function fnChkSave(){
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.intpatent.request.act.CreatePatentConveyChk.do";
    prx.addParam("REF_ID", parent.REF_ID);
    prx.checkData = ds_conveyPrintMain;

    prx.onSuccess = function()
    {
        top.window.close();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();

}

function fnOpenInvEval(){

    var win = new any.window();
    win.path = top.getRoot() + "/anyfive/ipims/patent/applymgt/intpatent/request/IntPatentRequestPop.jsp";
    win.arg.REF_ID = parent.REF_ID;
    win.opt.width = 700;
    win.opt.height = 400;
    win.show();
}



//발명자 목록 생성
function fnMakeInventorList()
{
    var main = ds_conveyPrintMain;
    var inv = ds_conveyPrintInventor;

    var html = new Array();

    html.push('<TABLE border="0" cellspacing="1" cellpadding="0" class="main">           ');
    html.push('    <COLGROUP>                                                            ');
    html.push('        <COL width="15%">                                                 ');
    html.push('        <COL width="20%">                                                 ');
    html.push('        <COL width="25%">                                                 ');
    html.push('        <COL width="20%">                                                 ');
    html.push('    </COLGROUP>                                                           ');
    html.push('    <TR>                                                                  ');
    html.push('        <TD class="conthead" colspan="2">REF-NO</TD>                      ');
    html.push('        <TD class="contdata" colspan="3">                                             ');
    html.push('           <a href="javascript:fnOpenInvEval();">' + main.value(0,"REF_NO") + '</a></TD>          ');
    html.push('    </TR>                                                                 ');
    html.push('    <TR>                                                                  ');
    html.push('        <TD class="conthead" colspan="2">발명의 명칭</TD>                 ');
    html.push('        <TD class="contdata" colspan="3">' + main.value(0,"KO_APP_TITLE") + '</TD>    ');
    html.push('    </TR>                                                                 ');

    for (var i = 0; i < inv.rowCount; i++) {
        html.push('    <TR>                                                                                      ');
        html.push('        <TD class="conthead" rowspan="4">양도인</TD>                                          ');
        html.push('        <TD class="conthead" rowspan="2">성명</TD>                                            ');
        html.push('        <TD class="contdata" colspan="3">                                                                 ');
        html.push('            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">                   ');
        html.push('                <TR>                                                                          ');
        html.push('                    <TD width="50%">[한글]&nbsp;' + inv.value(i,"EMP_HNAME") + '</TD>         ');
        html.push('                    <TD align="right" width="1" nowrap style="padding-left:8px;" >(인)</TD>    ');
        html.push('                </TR>                                                                         ');
        html.push('            </TABLE>                                                                          ');
        html.push('        </TD>                                                                                 ');
        html.push('    </TR>                                                                                     ');
        html.push('    <TR>                                                                                      ');
        html.push('        <TD class="contdata" colspan="3">                                                                 ');
        html.push('            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">                   ');
        html.push('                <TR>                                                                          ');
        html.push('                    <TD width="50%">[한자]&nbsp;' + inv.value(i,"EMP_CNAME") + '</TD>         ');
        html.push('                    <TD width="50%">[영문]&nbsp;' + inv.value(i,"EMP_ENAME") + '</TD>         ');
        html.push('                </TR>                                                                         ');
        html.push('            </TABLE>                                                                          ');
        html.push('        </TD>                                                                                 ');
        html.push('    </TR>                                                                                     ');
        html.push('    <TR>                                                                                      ');
        html.push('        <TD class="conthead">주소</TD>                                                        ');
        html.push('        <TD class="contdata" colspan="3">' + inv.value(i,"HOME_ADDR") + '</TD>                ');
        html.push('    </TR>                                                                                     ');
        html.push('    <TR>                                                                                      ');
        html.push('        <TD class="conthead">사번</TD>                                                        ');
        html.push('        <TD class="contdata" colspan="3">' + inv.value(i,"EMP_NO") + '</TD>                ');
        html.push('    </TR>                                                                                     ');
        html.push('    <TR>                                                                                      ');
        html.push('        <TD class="conthead">주민등록번호</TD>                                                ');
        html.push('        <TD class="contdata">' + inv.value(i,"JUMIN_NO") + '</TD>                             ')
        html.push('        <TD class="conthead">소속</TD>                                                ');
        html.push('        <TD class="contdata">' + inv.value(i,"APP_MAN_CODE") + '</TD>                             ');
        html.push('    </TR>                                                                                     ');
    }

    html.push('</TABLE>                                                                  ');


    div_inventorList.innerHTML = html.join("\n");
}


</SCRIPT>
</HEAD>

<BODY>

<DIV style="width:100%; height:100%; padding:15px; text-align:center; overflow-y:auto;">

<IMG src="image/conveyPrint.gif" width="176" height="57"><BR><BR>

<TABLE border="0" cellspacing="1" cellpadding="0" class="main" width="100%">
    <COLGROUP>
        <COL width="15%">
        <COL width="15%">
        <COL width="70%">
    </COLGROUP>
    <TR>
        <TD class="conthead" rowspan="2">양수인</TD>
        <TD class="conthead">회사</TD>
        <TD class="contdata"><SPAN id="COMPANY_NAME"></SPAN></TD>
    </TR>
    <TR>
        <TD class="conthead">주소</TD>
        <TD class="contdata"><SPAN id="COMPANY_ADDRESS"></SPAN></TD>
    </TR>
</TABLE>

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" style="margin-top:10px;">
    <TR>
        <TD style="font-family:바탕; font-weight:bold; font-size:11pt; color:black; text-align:center;">
            하기 발명자는 직무발명관련 규정에 근거하여,<BR>
            정당한 보상을 받을 권리를 전제로 하여<BR>
            당사 지식자산에 관한 일체의 권리를 회사에 양도합니다.
        </TD>
    </TR>
    <TR>
        <TD style="font-weight:bold; color:black; text-align:center; padding:10 0 10 0;">
            <SPAN id="CONVEY_DATE_YYYY" style="width:40px; text-align:right;"></SPAN>&nbsp;년
            <SPAN id="CONVEY_DATE_MM" style="width:20px; text-align:right;"></SPAN>&nbsp;월
            <SPAN id="CONVEY_DATE_DD" style="width:20px; text-align:right;"></SPAN>&nbsp;일
        </TD>
    </TR>
</TABLE>

<DIV id="div_inventorList"></DIV>

<DIV id="div_button" class="button_area">
    <BUTTON text="확인" onClick="javascript:fnChkSave()"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON text="인쇄" onClick="javascript:window.print();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="close"></BUTTON>
</DIV>

</DIV>

</BODY>
</HTML>
