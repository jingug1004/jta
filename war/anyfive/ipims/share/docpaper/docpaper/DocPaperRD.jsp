<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.share.common.app.ShareApp"%><% ShareApp app = new ShareApp(request, response, out); %>
<%@page import="anyfive.ipims.share.common.util.SystemTypes"%>
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
    <% if (app.userInfo.isPatentTeam() == true) { %>
    addBind("OFFICE_DISP_YN");
    addBind("INVENTOR_DISP_YN");
    addBind("CONFIRM_DATE2");
    <% } %>
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{

    parent.gRetrieveDetail = fnRetrieve;
    cfShowObjects(["td_inventorCheck"], parent.gMasterInfo.MST_DIV == "A");

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
         if(ds_mainInfo.value(0, "CONFIRM_DATE2") == "미확인"){
             if(!<%= app.userInfo.isPatentTeam()%> && ds_mainInfo.value(0, "INPUT_OWNER") == "PAT" ){
                 fnConfirm2();
             }
         }
        fnShowHideButtons();
        bfSetTabFrameHeight(true);
        parent.bfSetTabFrameHeight(true);
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//버튼 표시/숨김
function fnShowHideButtons()
{
    var isPatentTeam = <%= app.userInfo.isPatentTeam() %>;
    var isSysType = "<%= app.userInfo.getSystemType() %>";
    var isInputOwner = ds_mainInfo.value(0, "INPUT_OWNER");
    var isJobMan = (ds_mainInfo.value(0, "JOB_MAN") == "<%= app.userInfo.getUserId() %>");
    var isCreUser = (ds_mainInfo.value(0, "CRE_USER") == "<%= app.userInfo.getUserId() %>");


    btn_bizView.text = ds_mainInfo.value(0, "BIZ_BUTTON_NAME");
    cfShowObjects([btn_bizView], ds_mainInfo.value(0, "BIZ_BUTTON_NAME") != "" && (isPatentTeam || ds_mainInfo.value(0, "INVENTOR_INPUT_YN") == "1"));


    btn_copeBizView.text = ds_mainInfo.value(0, "COPE_BIZ_BUTTON_NAME");

    cfShowObjects([btn_copeBizView], ds_mainInfo.value(0, "COPE_BIZ_BUTTON_NAME") != "" && (isPatentTeam || ds_mainInfo.value(0, "COPE_INVENTOR_INPUT_YN") == "1"));

    if (isSysType == "OFFICE") {
        if (isInputOwner != "OFF") {
            cfShowObjects([btn_confirm], 1 == 1);
        } else {
            cfShowObjects([btn_confirm], 1 != 1);
        }
    } else {
        cfShowObjects([btn_confirm], ds_mainInfo.value(0, "CONFIRM_OWNER") == "<%= app.userInfo.getSystemType() %>".substring(0, 3));
    }
    btn_confirm.disabled = (ds_mainInfo.value(0, "CONFIRM_DATE") != "");
    cfShowObjects([btn_modify, btn_delete, btn_line3], ds_mainInfo.value(0, "CONFIRM_DATE") == ""  );

    <% if (app.userInfo.getSystemType().equals(SystemTypes.PATENT)) { %>

    btn_patteamCope.text = ds_mainInfo.value(0, "PATTEAM_COPE_BUTTON");
    cfShowObjects([btn_patteamCope], ds_mainInfo.value(0, "PATTEAM_COPE_BUTTON") != "" && isPatentTeam == true);
    btn_inventorCope.text = ds_mainInfo.value(0, "INVENTOR_COPE_BUTTON");

    cfShowObjects([btn_inventorCope], ds_mainInfo.value(0, "INVENTOR_COPE_BUTTON") != "" && isPatentTeam != true);

    cfShowObjects([btn_modify, btn_delete, btn_line3], isCreUser || isJobMan  );
    cfShowObjects([btn_mailSend], (isCreUser || isJobMan)); // 메일 (해외/국내 통일)

    cfShowObjects([btn_line2], btn_bizView.display != "none" || btn_copeBizView.display != "none" || btn_patteamCope.display != "none" || btn_inventorCope.display != "none");
    cfShowObjects([btn_line4], btn_confirm.display != "none" || btn_mailSend.display != "none");
    <% } else { %>
    cfShowObjects([btn_line2], btn_bizView.display != "none" || btn_copeBizView.display != "none");
    cfShowObjects([btn_line4], btn_confirm.display != "none");


    <% } %>
}

//업무화면 팝업
function fnOpenBizView()
{
    var win = new any.window();
    win.path = top.getRoot() + ds_mainInfo.value(0, "BIZ_VIEW_PATH");
    win.arg.REF_ID = parent.REF_ID;
    win.arg.LIST_SEQ = parent.LIST_SEQ;
    win.opt.resizable = "yes";
    win.show();
}

//대응진행서류 팝업
function fnOpenCopeBizView()
{
    var win = new any.window();
    win.path = top.getRoot() + ds_mainInfo.value(0, "COPE_BIZ_VIEW_PATH");
    win.arg.REF_ID = parent.REF_ID;
    win.arg.LIST_SEQ = parent.LIST_SEQ;
    win.opt.resizable = "yes";
    win.show();
}

<% if (app.userInfo.getSystemType().equals(SystemTypes.PATENT)) { %>
//특허팀 대응업무화면 팝업
function fnOpenPatteamCope()
{
    var win = new any.window();
    win.path = top.getRoot() + ds_mainInfo.value(0, "PATTEAM_COPE_VIEW");
    win.arg.REF_ID = parent.REF_ID;
    win.arg.LIST_SEQ = parent.LIST_SEQ;
    win.opt.resizable = "yes";
    win.show();
}

//발명자 대응업무화면 팝업
function fnOpenInventorCope()
{
    var win = new any.window();
    win.path = top.getRoot() + ds_mainInfo.value(0, "INVENTOR_COPE_VIEW");
    win.arg.REF_ID = parent.REF_ID;
    win.arg.LIST_SEQ = parent.LIST_SEQ;
    win.opt.resizable = "yes";
    win.show();
}
<% } %>

//추가
function fnCreate()
{
    parent.fnMovePage(0);

}

//수정
function fnModify()
{
    window.location.href = "DocPaperU.jsp";
}

//삭제
function fnDelete()
{
    //삭제 확인
    if (!confirm("<%= app.message.get("msg.com.confirm.delete").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.share.docpaper.docpaper.act.DeleteDocPaper.do";
    prx.addParam("REF_ID", parent.REF_ID);
    prx.addParam("LIST_SEQ", parent.LIST_SEQ);

    prx.onSuccess = function()
    {
        parent.fnRetrieve();
        alert("<%= app.message.get("msg.com.info.delete").toJS() %>");
        fnCreate();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//메일발송
function fnMailSend()
{
    var win = new any.window();
    win.path = top.getRoot() + "/anyfive/ipims/share/docpaper/informmail/InformMailC.jsp";
    win.arg.REF_ID = parent.REF_ID;
    win.arg.LIST_SEQ = parent.LIST_SEQ;
    win.opt.width = 750;
    win.opt.height = 650;
    win.show();
}

//확인처리
function fnConfirm()
{
    //저장 확인
    if (!confirm("담당자 확인처리 하시겠습니까?")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.share.docpaper.docpaper.act.ConfirmDocPaper.do";
    prx.addParam("REF_ID", parent.REF_ID);
    prx.addParam("LIST_SEQ", parent.LIST_SEQ);

    prx.onSuccess = function()
    {
        fnRetrieve();
        parent.fnReload();
        alert("처리되었습니다.");
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}
//확인처리
function fnConfirm2()
{
    //사무소 확인시 저장확인 alert 없이 바로 확인 처리 되도록
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.share.docpaper.docpaper.act.ConfirmDocPaper.do";
    prx.addParam("REF_ID", parent.REF_ID);
    prx.addParam("LIST_SEQ", parent.LIST_SEQ);

    prx.onSuccess = function()
    {
        fnRetrieve();
        parent.fnReload();
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
        <COL class="conthead" width="15%">
        <COL class="contdata" width="18%">
        <COL class="conthead" width="15%">
        <COL class="contdata" width="18%">
        <COL class="conthead" width="15%">
        <COL class="contdata" width="18%">
    </COLGROUP>
    <TR>
        <TD colspan="6" class="title_table">[진행서류 내용]</TD>
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
        <TD>서류일자</TD>
        <TD><ANY:SPAN id="PAPER_DATE" format="date" /></TD>
        <TD>다음 업무처리기한</TD>
        <TD><ANY:SPAN id="URGENT_DATE" format="date" /></TD>
        <TD>법정기한</TD>
        <TD><ANY:SPAN id="DUE_DATE" format="date" /></TD>
    </TR>
    <TR>
        <TD>관련번호</TD>
        <TD><SPAN id="PAPER_REF_NO"></SPAN></TD>
        <TD>참고사항(심사관)</TD>
        <TD colspan="3"><SPAN id="COMMENTS"></SPAN></TD>
    </TR>
    <TR>
        <TD>담당자 의견</TD>
        <TD colspan="5"><SPAN id="REMARK"  rows="7"></SPAN></TD>
    </TR>
    <TR>
        <TD>관련파일</TD>
        <TD colspan="5">
            <ANY:FILE id="any_fileId" mode="R" />
        </TD>
    </TR>
    <% if (app.userInfo.isPatentTeam() == true) { %>
    <TR>
        <TD>공개여부</TD>
        <TD colspan="3">
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD width="50%">
                        <ANY:CHECK id="OFFICE_DISP_YN" text="사무소 공개" readOnly />
                    </TD>
                    <TD width="50%" id="td_inventorCheck" style="display:none;">
                        <ANY:CHECK id="INVENTOR_DISP_YN" text="발명자 공개" readOnly />
                    </TD>
                </TR>
            </TABLE>
        </TD>
        <TD>확인일자</TD>
        <TD><ANY:SPAN id="CONFIRM_DATE2" format="date" /></TD>
    </TR>
    <% } %>
</TABLE>

<DIV class="button_area">
    <% if (app.userInfo.getSystemType().equals(SystemTypes.OFFICE)) { %>
    <BUTTON text="수정" onClick="javascript:fnModify();" id="btn_modify" display="none"></BUTTON>
    <BUTTON text="삭제" onClick="javascript:fnDelete();" id="btn_delete" display="none"></BUTTON>
    <BUTTON auto="line" id="btn_line3" display="none"></BUTTON>
    <% }%>
    <BUTTON auto="line" id="btn_line1"></BUTTON>
    <BUTTON text="추가진행" onClick="javascript:fnCreate();"></BUTTON>
    <BUTTON auto="line" id="btn_line1"></BUTTON>

    <BUTTON onClick="javascript:fnOpenBizView();" id="btn_bizView" display="none"></BUTTON>
    <BUTTON onClick="javascript:fnOpenCopeBizView();" id="btn_copeBizView" display="none"></BUTTON>

    <% if (app.userInfo.getSystemType().equals(SystemTypes.PATENT)) { %>
    <BUTTON onClick="javascript:fnOpenPatteamCope();" id="btn_patteamCope" display="none"></BUTTON>
    <BUTTON onClick="javascript:fnOpenInventorCope();" id="btn_inventorCope" display="none"></BUTTON>
    <BUTTON auto="line" id="btn_line2" display="none"></BUTTON>

    <BUTTON text="수정" onClick="javascript:fnModify();" id="btn_modify" display="none"></BUTTON>
    <BUTTON text="삭제" onClick="javascript:fnDelete();" id="btn_delete" display="none"></BUTTON>
    <BUTTON auto="line" id="btn_line3" display="none"></BUTTON>

    <BUTTON text="메일발송" onClick="javascript:fnMailSend();" id="btn_mailSend" display="none"></BUTTON>
    <% } else { %>
    <BUTTON auto="line" id="btn_line2" display="none"></BUTTON>
    <% } %>

    <BUTTON text="확인처리" onClick="javascript:fnConfirm();" id="btn_confirm" display="none"></BUTTON>
    <BUTTON auto="line" id="btn_line4" display="none"></BUTTON>

    <BUTTON auto="list"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
