<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.share.common.app.ShareApp"%><% ShareApp app = new ShareApp(request, response, out); %>
<%@page import="anyfive.ipims.share.common.util.SystemTypes"%>
<%@page import="any.util.etc.NDateUtil"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>진행서류</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("PAPER_CODE");
    addBind("PAPER_SUBCODE");
    addBind("CRE_DATE");
    addBind("PAPER_DATE");
    addBind("URGENT_DATE");
    addBind("DUE_DATE");
    addBind("PAPER_REF_NO");
    addBind("COMMENTS");
    addBind("REMARK");
    addBind("FILE_ID", "any_fileId");

    <% if (app.userInfo.getSystemType().equals(SystemTypes.OFFICE) == true || app.userInfo.isPatentTeam() == true) { %>
    <% if (app.userInfo.getSystemType().equals(SystemTypes.OFFICE) == true) { %>
    addBind("PATTEAM_MAIL_YN");
    <% } else { %>
    addBind("OFFICE_DISP_YN");
    addBind("OFFICE_MAIL_YN");
    <% } %>
    addBind("INVENTOR_DISP_YN");
    addBind("INVENTOR_MAIL_YN");
    <% } else { %>
    addBind("PATTEAM_MAIL_YN");
    addBind("OFFICE_MAIL_YN");
    <% } %>
</COMMENT></ANY:DS>
<ANY:DS id="ds_paperInfo" />
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    parent.bfSetTabFrameHeight(true);

    cfShowObjects(["td_inventorCheck", "tr_inputHelp"], parent.gMasterInfo.MST_DIV == "A");

    <% if (app.userInfo.isPatentTeam() == true) { %>
    PAPER_CODE.codeData = "/common/paperCodeByRef," + parent.REF_ID;
    <% } else if (app.userInfo.getSystemType().equals(SystemTypes.PATENT) == true) { %>
    PAPER_CODE.codeData = "/common/paperCodeByRefForInv," + parent.REF_ID;
    <% } else { %>
    PAPER_CODE.codeData = "/common/paperCodeByRefForOff," + parent.REF_ID;
    <% } %>
}

//진행서류 검색
function fnSearchPaperCode()
{
    var win = new any.window();
    win.path = top.getRoot() + "<%= SystemTypes.getSystemRoot(request) %>/common/popup/search/PaperSearchByRefListR.jsp";
    win.arg.REF_ID = parent.REF_ID;
    win.opt.width = 600;
    win.opt.height = 550;
    win.show();

    if (win.rtn == null) return;

    if (PAPER_CODE.valueRow(win.rtn.PAPER_CODE) == -1) {
        PAPER_CODE.addItem(win.rtn.PAPER_CODE, win.rtn.PAPER_NAME);
    }


    PAPER_CODE.value = win.rtn.PAPER_CODE;
}

//진행서류 정보 조회
function fnRetrievePaperInfo()
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.share.docpaper.docpaper.act.RetrieveDocPaperInfo.do";
    prx.addParam("PAPER_CODE", PAPER_CODE.value);
    prx.addParam("REF_ID", parent.REF_ID);
    prx.addData("ds_paperInfo");
    prx.hideMessage = true;

    prx.onStart = function()
    {
        td_dueDate.reqEnable = false;
    }

    prx.onSuccess = function()
    {
        if (ds_paperInfo.value(0, "DUP_AVAIL_YN") != "1" && parseInt(ds_paperInfo.value(0, "PAPER_CNT"), 10) > 0) {
            alert('"' + ds_paperInfo.value(0, "PAPER_NAME") + '" 진행서류는 한번만 입력할 수 있습니다.');
            PAPER_CODE.index = 0;
        } else {
            fnSetPaperInfo();
            fnOpenBizView();
        }
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute(false);
}

//진행서류 정보 설정
function fnSetPaperInfo()
{

    doCheck("PATTEAM_MAIL_YN");
    doCheck("OFFICE_DISP_YN");
    doCheck("OFFICE_MAIL_YN");
    doCheck("INVENTOR_DISP_YN");
    doCheck("INVENTOR_MAIL_YN");

    INPUT_HELP.innerText = (PAPER_CODE.value == "" ? "(진행서류를 선택하세요)" : ds_paperInfo.value(0, "INPUT_HELP"));
    td_dueDate.reqEnable = (ds_paperInfo.value(0, "OA_MGT_STEP") == "S" || ds_paperInfo.value(0, "IS_OA_PERIOD_EXTEND") == "1");

    function doCheck(name)
    {
        var obj = document.getElementById(name);

        if (obj != null) {
            obj.value = ds_paperInfo.value(0, name);
        }
    }
}

//업무화면 팝업
function fnOpenBizView()
{
    if (PAPER_CODE.value == "") return;
    if (ds_paperInfo.value(0, "BIZ_VIEW_PATH") == null) return;
    if (ds_paperInfo.value(0, "BIZ_VIEW_PATH") == "") return;

    var win = new any.window();
    win.path = top.getRoot() + ds_paperInfo.value(0, "BIZ_VIEW_PATH");

    win.arg.REF_ID = parent.REF_ID;
    win.arg.PAPER_CODE = PAPER_CODE.value;
    win.opt.resizable = "yes";

    if (win.show() == "OK") {
       parent.fnReload();
    }

    PAPER_CODE.index = 0;
}

//세부서류 업무화면 팝업
function fnOpenSubBizView()
{
    if (PAPER_SUBCODE.value == "") return;
    if (PAPER_SUBCODE.value(null, "BIZ_VIEW_PATH") == null) return;
    if (PAPER_SUBCODE.value(null, "BIZ_VIEW_PATH") == "") return;

    var win = new any.window();
    win.path = top.getRoot() + PAPER_SUBCODE.value(null, "BIZ_VIEW_PATH");
    win.arg.REF_ID = parent.REF_ID;
    win.arg.PAPER_CODE = PAPER_CODE.value;
    win.arg.PAPER_SUBCODE = PAPER_SUBCODE.value;
    win.opt.resizable = "yes";

     if (win.show() != "OK") {
         parent.fnReload();
    }

    PAPER_SUBCODE.index = 0;
}

//저장
function fnSave(isFileUploaded)
{
    //필수항목 체크
    if (!cfCheckAllReqValid()) return;
    //세부서류 체크
    if (PAPER_SUBCODE.value == "") {
        alert("세부서류를 선택하세요.");
        PAPER_SUBCODE.focus();
        return;
    }
    if (isFileUploaded != true) {
        if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;
        cfFileUpload("fnSave(true);");
        return;
    }

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.share.docpaper.docpaper.act.CreateDocPaper.do";
    prx.addParam("REF_ID", parent.REF_ID);
    prx.addData("ds_mainInfo");
    prx.addData("ds_paperInfo");
    prx.addData("ds_fileId");

    prx.onSuccess = function()
    {
        parent.LIST_SEQ = this.result;
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        parent.fnRetrieve();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

</SCRIPT>

<!-- 진행서류 변경시 -->
<SCRIPT language="JScript" for="PAPER_CODE" event="OnChange()">
    fnRetrievePaperInfo();
    PAPER_SUBCODE.codeData = "/common/paperSubcode," + this.value;
</SCRIPT>

<!-- 세부서류 변경시 -->
<SCRIPT language="JScript" for="PAPER_SUBCODE" event="OnChange()">
    fnOpenSubBizView();
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
        <TD colspan="6" class="title_table">[진행서류 작성]</TD>
    </TR>
    <TR>
        <TD req="PAPER_CODE">진행서류</TD>
        <TD colspan="2">
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD width="100%">
                        <ANY:SELECT id="PAPER_CODE" firstName="sel" />
                    </TD>
                    <% if (app.userInfo.getSystemType().equals(SystemTypes.OFFICE) == true || app.userInfo.isPatentTeam() == true) { %>
                    <TD width="1px">
                        <BUTTON icon="<%= request.getContextPath() %>/anyfive/ipims/share/image/icon_search.gif" width="25px" space="left:2" onClick="javascript:fnSearchPaperCode();"></BUTTON>
                    </TD>
                    <% } %>
                </TR>
            </TABLE>
        </TD>
        <TD><ANY:SELECT id="PAPER_SUBCODE" firstName="sel" /></TD>
        <TD>입력일자</TD>
        <TD><ANY:SPAN id="CRE_DATE" format="date" value="<%= NDateUtil.getSysDate() %>" /></TD>
    </TR>
    <TR>
        <TD req="PAPER_DATE">서류일자</TD>
        <TD><ANY:DATE id="PAPER_DATE" value="<%= NDateUtil.getSysDate() %>" /></TD>
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
        <TD colspan="5"><TEXTAREA id="REMARK" rows="7" maxByte="4000" ></TEXTAREA></TD>
    </TR>
    <TR>
        <TD>관련파일</TD>
        <TD colspan="5">
            <ANY:FILE id="any_fileId" mode="C" policy="paper" />
        </TD>
    </TR>
    <% if (app.userInfo.getSystemType().equals(SystemTypes.OFFICE) == true || app.userInfo.isPatentTeam() == true) { %>
    <TR>
        <TD>공개/메일발송</TD>
        <TD colspan="5">
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD width="50%">
                        <% if (app.userInfo.getSystemType().equals(SystemTypes.OFFICE) == true) { %>
                        <ANY:CHECK id="PATTEAM_MAIL_YN" text="특허팀 건담당자 알림메일 발송 " />
                        <% } else { %>
                        <ANY:CHECK id="OFFICE_DISP_YN" text="사무소 공개" />
                        <ANY:CHECK id="OFFICE_MAIL_YN" text="사무소 알림메일 발송" />
                        <% } %>
                    </TD>
                    <TD width="50%" id="td_inventorCheck" style="display:none;">
                        <ANY:CHECK id="INVENTOR_DISP_YN" text="발명자 공개" />
                        <ANY:CHECK id="INVENTOR_MAIL_YN" text="발명자 알림메일 발송" />
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <% } else { %>
    <TR>
        <TD>메일발송</TD>
        <TD colspan="5">
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD width="50%">
                        <ANY:CHECK id="PATTEAM_MAIL_YN" text="특허팀 건담당자 알림메일 발송 " />
                    </TD>
                    <TD width="50%">
                        <ANY:CHECK id="OFFICE_MAIL_YN" text="사무소 알림메일 발송" />
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <% } %>
    <TR id="tr_inputHelp" style="display:none;">
        <TD>입력 도움말</TD>
        <TD colspan="5"><SPAN id="INPUT_HELP" style="color:#FF0000;">(진행서류를 선택하세요)</SPAN></TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="저장" onClick="javascript:fnSave();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="list"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
<!-- ㅇㅇ -->
