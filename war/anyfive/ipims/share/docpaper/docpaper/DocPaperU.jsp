<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.share.common.app.ShareApp"%><% ShareApp app = new ShareApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>진행서류</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("PAPER_NAME");
    addBind("PAPER_SUBNAME");
    addBind("CRE_DATE");
    addBind("PAPER_DATE");
    addBind("URGENT_DATE");
    addBind("DUE_DATE");
    addBind("PAPER_REF_NO");
    addBind("COMMENTS");
    addBind("REMARK");
    addBind("FILE_ID", "any_fileId");
    addBind("OFFICE_DISP_YN");
    addBind("INVENTOR_DISP_YN");
    addBind("CONFIRM_DATE2");
    addBind("INPUT_HELP");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    parent.bfSetTabFrameHeight(true);

    //cfShowObjects(["td_inventorCheck", "tr_inputHelp"], parent.gMasterInfo.MST_DIV == "A");

    fnRetrieve();
}

//조회
function fnRetrieve()
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.share.docpaper.docpaper.act.RetrieveDocPaper.do";
    prx.addParam("REF_ID", parent.REF_ID);
    prx.addParam("LIST_SEQ", parent.LIST_SEQ);

    prx.onSuccess = function()
    {
        td_dueDate.reqEnable = (ds_mainInfo.value(0, "OA_MGT_STEP") == "S");
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//추가
function fnCreate()
{
  parent.fnMovePage(0);
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

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.share.docpaper.docpaper.act.UpdateDocPaper.do";
    prx.addParam("REF_ID", parent.REF_ID);
    prx.addParam("LIST_SEQ", parent.LIST_SEQ);
    prx.addData("ds_mainInfo");
    prx.addData("ds_fileId");

    prx.onSuccess = function()
    {
        parent.fnReload();
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        window.location.replace("DocPaperRD.jsp");
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
    window.location.replace("DocPaperRD.jsp");
}
</SCRIPT>

<!-- 진행서류 변경시 -->
<SCRIPT language="JScript" for="PAPER_CODE" event="OnChange()">
    PAPER_SUBCODE.codeData = "/common/paperSubcode," + this.value;
    PAPER_SUBCODE.disabled = (this.value == "");
</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="1" cellpadding="2" class="main">
    <COLGROUP>
        <COL class="conthead" width="15%">
        <COL class="contdata" width="18%">
        <COL class="conthead" width="15%">
        <COL class="contdata" width="18%">
        <COL class="conthead" width="15%">
        <COL class="contdata" width="18%">
    </COLGROUP>
    <TR>
        <TD colspan="6" class="title_table">[진행서류 수정]</TD>
    </TR>
    <TR>
        <TD>진행서류</TD>
        <TD><SPAN id="PAPER_NAME"></SPAN></TD>
        <TD>세부서류</TD>
        <TD><SPAN id="PAPER_SUBNAME"></SPAN></TD>
        <TD>입력일자</TD>
        <TD><ANY:SPAN id="CRE_DATE" format="date" /></TD>
    </TR>
    <TR>
        <TD req="PAPER_DATE">서류일자</TD>
        <TD><ANY:DATE id="PAPER_DATE" /></TD>
        <TD>다음 업무처리기한</TD>
        <TD><ANY:DATE id="URGENT_DATE" /></TD>
        <TD id="td_dueDate" req="DUE_DATE" reqEnable="false">법정기한</TD>
        <TD><ANY:DATE id="DUE_DATE" /></TD>
    </TR>
    <TR>
        <TD>관련번호</TD>
        <TD><INPUT type="text" id="PAPER_REF_NO" maxByte="1000"></TD>
        <TD>참고사항(심사관)</TD>
        <TD colspan="3"><INPUT type="text" id="COMMENTS" maxByte="1000"></TD>
    </TR>
    <TR>
        <TD>담당자 의견</TD>
        <TD colspan="5"><TEXTAREA id="REMARK" rows="7" maxByte="4000"></TEXTAREA></TD>
    </TR>
    <TR>
        <TD>관련파일</TD>
        <TD colspan="5">
            <ANY:FILE id="any_fileId" mode="U" policy="paper" />
        </TD>
    </TR>
    <TR>
        <TD>공개여부</TD>
        <TD colspan="3">
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD width="50%">
                        <ANY:CHECK id="OFFICE_DISP_YN" text="사무소 공개" />
                    </TD>
                    <TD width="50%" id="td_inventorCheck" >
                        <ANY:CHECK id="INVENTOR_DISP_YN" text="발명자 공개" />
                    </TD>
                </TR>
            </TABLE>
        </TD>
        <TD>확인일자</TD>
        <TD><ANY:SPAN id="CONFIRM_DATE2" format="date" /></TD>
    </TR>
    <TR id="tr_inputHelp" style="display:none;">
        <TD>입력 도움말</TD>
        <TD colspan="5"><SPAN id="INPUT_HELP" style="color:#FF0000;"></SPAN></TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="추가진행" onClick="javascript:fnCreate();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON text="저장" onClick="javascript:fnSave();"></BUTTON>
    <BUTTON text="취소" onClick="javascript:fnDetail();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="list"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
