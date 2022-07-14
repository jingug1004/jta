<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.share.common.app.ShareApp"%><% ShareApp app = new ShareApp(request, response, out); %>
<%@page import="anyfive.ipims.share.common.util.SystemTypes"%>
<%@page import="any.util.etc.NDateUtil"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>국내출원정보 입력</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("REF_NO");
    addBind("RIGHT_DIV");
    addBind("APP_DATE");
    addBind("PAPER_DATE");
    addBind("INDEP_CLAIM");
    addBind("SUBORD_CLAIM");
    addBind("DRAWING_CNT");
    addBind("PAPER_CNT");
    addBind("KO_APP_TITLE");
    addBind("EN_APP_TITLE");
    addBind("EXAMREQ_DATE");
    addBind("REMARK");
    addBind("APPDOC_FILE", "any_appdocFile");
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
    prx.path = top.getRoot() + "/anyfive.ipims.share.docpaper.inputappno.act.RetrieveInputAppNo.do";
    prx.addParam("REF_ID", parent.REF_ID);

    prx.onSuccess = function()
    {
        cfShowObjects(["tr_patOnly"], ds_mainInfo.value(0, "RIGHT_DIV") == "10" || ds_mainInfo.value(0, "RIGHT_DIV") == "20");

        var appNo = ds_mainInfo.value(0, "APP_NO");

        APP_YEAR.value = appNo.substr(2, 4);
        APP_NUM.value = appNo.substr(6);
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//저장
function fnSave(isFileUploaded)
{

    //필수항목 체크
    if (!cfCheckAllReqValid()) return;

    if (isFileUploaded != true) {
        if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;
        cfFileUpload("fnSave(true);");
        return;
    }

    ds_mainInfo.value(0, "APP_NO") = RIGHT_DIV.innerText + APP_YEAR.value + APP_NUM.value;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.share.docpaper.inputappno.act.UpdateInputAppNo.do";
    //prx.path = top.getRoot() + "/anyfive.ipims.share.docpaper.docpaper.act.CreateDocPaper.do";
    prx.addParam("REF_ID", parent.REF_ID);
    prx.addParam("PAPER_CODE", parent.PAPER_CODE);
    prx.addParam("PAPER_SUBCODE", parent.PAPER_SUBCODE);
    prx.addData("ds_mainInfo");
    prx.addData("ds_ipcCodeList");
    prx.addData("ds_appdocFile");

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        top.window.returnValue = "OK";
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
        <COL class="conthead" width="20%">
        <COL class="contdata" width="80%">
    </COLGROUP>
    <TR>
        <TD>REF-NO</TD>
        <TD><SPAN id="REF_NO"></SPAN></TD>
    </TR>
    <TR>
        <TD req="PAPER_DATE">서류일자</TD>
        <TD><ANY:DATE id="PAPER_DATE" value="<%= NDateUtil.getSysDate() %>" /></TD>
    </TR>
    <TR>
        <TD req="APP_YEAR,APP_NUM">출원번호</TD>
        <TD noWrap>
            <SPAN id="RIGHT_DIV"></SPAN>&nbsp;-
            <INPUT type="text" id="APP_YEAR" maxByte="4" style="width:40px; text-align:center;">&nbsp;-
            <INPUT type="text" id="APP_NUM" maxByte="7" style="width:60px; text-align:center;"><BR>
        </TD>
    </TR>
    <TR>
        <TD>출원번호 입력설명</TD>
        <TD>
                            ㅇ. 권리구분(2자리)-년도(4자리)-일련번호(7자리)<BR>
                            ㅇ. 권리구분 : 특허 10, 실용신안 20, 디자인 30, 상표 40<BR>
                            ㅇ. 입력예) 10-2005-1234567, 20-2004-1122334
        </TD>
    </TR>
    <TR>
        <TD req="APP_DATE">출원일자</TD>
        <TD><ANY:DATE id="APP_DATE" /></TD>
    </TR>
    <TR id="tr_patOnly" style="display:none;">
        <TD req="INDEP_CLAIM">독립항</TD>
        <TD>
            <INPUT type="text" id="INDEP_CLAIM" maxByte="2" format="number" style="width:40px;">
        </TD>
    </TR>
    <TR id="tr_patOnly" style="display:none;">
        <TD req="SUBORD_CLAIM">종속항</TD>
        <TD>
            <INPUT type="text" id="SUBORD_CLAIM" maxByte="2" format="number" style="width:40px;">
        </TD>
    </TR>
    <TR id="tr_patOnly" style="display:none;">
        <TD req="DRAWING_CNT">도면수</TD>
        <TD>
            <INPUT type="text" id="DRAWING_CNT" maxByte="3" format="number" style="width:40px;">
        </TD>
    </TR>
    <TR id="tr_patOnly" style="display:none;">
        <TD req="PAPER_CNT">면수</TD>
        <TD>
            <INPUT type="text" id="PAPER_CNT" maxByte="3" format="number" style="width:40px;">
            (도면수와 요약서를 제외한 면수입니다)
        </TD>
    </TR>
    <TR>
        <TD req="KO_APP_TITLE">출원의 명칭(한)</TD>
        <TD><INPUT type="text" id="KO_APP_TITLE" maxByte="1000"></TD>
    </TR>
    <TR>
        <TD req="EN_APP_TITLE">출원의 명칭(영)</TD>
        <TD><INPUT type="text" id="EN_APP_TITLE" maxByte="1000"></TD>
    </TR>
    <TR id="tr_patOnly" style="display:none;">
        <TD>심사청구일자</TD>
        <TD><ANY:DATE id="EXAMREQ_DATE" /></TD>
    </TR>
    <TR>
        <TD>IPC분류코드</TD>
        <TD>
            <ANY:MSEARCH id="any_ipcCodeList" mode="C"><COMMENT>
                <% if (app.userInfo.getSystemType().equals(SystemTypes.OFFICE)) { %>
                win.path = top.getRoot() + "/anyfive/ipims/office/common/popup/search/IpcCodeSearchTreeR.jsp";
                <%}else{  %>
                win.path = top.getRoot() + "/anyfive/ipims/patent/common/popup/search/IpcCodeSearchTreeR.jsp";
                <% }%>
                codeColumn = "IPC_CODE";
                nameExpr = "[{#IPC_CODE}] {#IPC_PATHNAME}";
                size = 6;

            </COMMENT></ANY:MSEARCH>
        </TD>
    </TR>
    <TR>
        <TD>비고</TD>
        <TD><TEXTAREA id="REMARK" rows="3" maxByte="4000"></TEXTAREA></TD>
    </TR>
    <TR>
        <TD req="any_appdocFile">출원명세서</TD>
        <TD>
            <ANY:FILE id="any_appdocFile" mode="U" policy="appdoc_int" />
        </TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="close"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
