<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>진행서류 수정</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("PAPER_DIV_NAME");
    addBind("INOUT_DIV_NAME");
    addBind("PAPER_NAME");
    addBind("USE_YN");
    addBind("PAPER_STEP");
    addBind("OA_MGT_STEP");
    addBind("EVAL_CODE");
    addBind("PATTEAM_INPUT_YN");
    addBind("PATTEAM_MAIL_YN");
    addBind("OFFICE_MAIL_YN");
    addBind("INVENTOR_MAIL_YN");
    addBind("OFFICE_INPUT_YN");
    addBind("INVENTOR_INPUT_YN");
    addBind("OFFICE_DISP_YN");
    addBind("INVENTOR_DISP_YN");
    addBind("MST_STATUS_YN");
    addBind("MST_ABD_YN");
    addBind("WITH_PAPER_CODE");
    addBind("WITH_PAPER_SUBCODE");
    addBind("COPE_PAPER_CODE");
    addBind("DUP_AVAIL_YN");
    addBind("BIZ_BUTTON_NAME");
    addBind("BIZ_VIEW_PATH");
    addBind("PATTEAM_COPE_BUTTON");
    addBind("PATTEAM_COPE_VIEW");
    addBind("OFFICE_COPE_BUTTON");
    addBind("OFFICE_COPE_VIEW");
    addBind("INVENTOR_COPE_BUTTON");
    addBind("INVENTOR_COPE_VIEW");
    addBind("INPUT_HELP");
    addBind("REMARK");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();
    fnRetrieveSubPaperList();
}

//조회
function fnRetrieve()
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.papermgt.papercode.act.RetrievePaperCode.do";
    prx.addParam("PAPER_CODE", parent.PAPER_CODE);
    prx.checkData = ds_mainInfo;

    prx.onSuccess = function()
    {
        PAPER_NAME.focus();
        WITH_PAPER_SUBCODE.codeData = "/common/paperSubcodeAll," + ds_mainInfo.value(0, "WITH_PAPER_CODE");
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//저장
function fnSave()
{
    if (!cfCheckAllReqValid()) return;

    if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.papermgt.papercode.act.UpdatePaperCode.do";
    prx.addParam("PAPER_CODE", parent.PAPER_CODE);
    prx.addData("ds_mainInfo");

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//삭제
function fnDelete()
{
    if (!confirm("<%= app.message.get("msg.com.confirm.delete").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.papermgt.papercode.act.DeletePaperCode.do";
    prx.addParam("PAPER_CODE", parent.PAPER_CODE);

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.delete").toJS() %>");
        parent.goList();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//세부서류 목록 조회
function fnRetrieveSubPaperList()
{
    var ldr = gr_subPaperCodeList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.papermgt.papercode.act.RetrieveSubPaperCodeList.do";
    ldr.addParam("PAPER_CODE", parent.PAPER_CODE);

    ldr.onSuccess = function(gr, fg)
    {
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

//"없음" 세부서류 추가
function fnAddDefaultSubPaper()
{
    if (!confirm('"없음" 세부서류를 추가하시겠습니까?')) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.papermgt.papercode.act.CreateDefaultSubPaperCode.do";
    prx.addParam("PAPER_CODE", parent.PAPER_CODE);

    prx.onSuccess = function()
    {
        gr_subPaperCodeList.loader.reload();
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//세부서류 추가
function fnAddSubPaper()
{
    var win = new any.window();
    win.path = "PaperSubCodeCUD.jsp";
    win.arg.PAPER_CODE = parent.PAPER_CODE;
    win.opt.width = 600;
    win.opt.height = 220;

    win.onReload = function()
    {
        gr_subPaperCodeList.loader.reload();
    }

    win.show();
}

//세부서류 상세
function fnDetailSubPaper(gr, fg, row, colId)
{
    var win = new any.window();
    win.path = "PaperSubCodeCUD.jsp";
    win.arg.PAPER_CODE = parent.PAPER_CODE;
    win.arg.PAPER_SUBCODE = gr.value(row, "PAPER_SUBCODE");
    win.opt.width = 600;
    win.opt.height = 220;

    win.onReload = function()
    {
        gr_subPaperCodeList.loader.reload();
    }

    win.show();
}
</SCRIPT>

<!-- 진행서류 변경시 -->
<SCRIPT language="JScript" for="WITH_PAPER_CODE" event="OnChange()">
    if (this.value == "") {
        WITH_PAPER_SUBCODE.clearAll();
    } else {
        WITH_PAPER_SUBCODE.codeData = "/common/paperSubcodeAll," + this.value;
        WITH_PAPER_SUBCODE.index = 0;
    }
</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
    <TR>
        <TD height="1">
            <TABLE border="0" cellspacing="1" cellpadding="2" class="main">
                <COLGROUP>
                    <COL class="conthead" width="15%">
                    <COL class="contdata" width="35%">
                    <COL class="conthead" width="15%">
                    <COL class="contdata" width="35%">
                </COLGROUP>
                <TR>
                    <TD>서류구분</TD>
                    <TD><SPAN id="PAPER_DIV_NAME"></SPAN></TD>
                    <TD>국내외구분</TD>
                    <TD><SPAN id="INOUT_DIV_NAME"></SPAN></TD>
                </TR>
                <TR>
                    <TD req="PAPER_NAME">진행서류명</TD>
                    <TD colspan="3">
                        <INPUT type="text" id="PAPER_NAME" maxByte="300">
                    </TD>
                </TR>
                <TR>
                    <TD req="PAPER_STEP">진행서류 단계</TD>
                    <TD>
                        <ANY:SELECT id="PAPER_STEP" codeData="{PAPER_STEP}" firstName="sel" />
                    </TD>
                    <TD req="USE_YN">사용여부</TD>
                    <TD>
                        <ANY:RADIO id="USE_YN" codeData="{USE_YN}" value="1" />
                    </TD>
                </TR>
                <TR>
                    <TD>OA 관리단계</TD>
                    <TD>
                        <ANY:SELECT id="OA_MGT_STEP" codeData="{OA_MGT_STEP}" firstName="none" />
                    </TD>
                    <TD>평가표</TD>
                    <TD>
                        <ANY:SELECT id="EVAL_CODE" codeData="/systemmgt/evalCode" firstName="sel" />
                    </TD>
                </TR>
                <TR>
                    <TD req="PATTEAM_INPUT_YN">특허팀 입력가능</TD>
                    <TD>
                        <ANY:RADIO id="PATTEAM_INPUT_YN" codeData="{YES_NO}" />
                    </TD>
                    <TD req="PATTEAM_MAIL_YN">특허팀 메일발송</TD>
                    <TD>
                        <ANY:RADIO id="PATTEAM_MAIL_YN" codeData="{YES_NO}" />
                    </TD>
                </TR>
                <TR>
                    <TD req="OFFICE_MAIL_YN">사무소 메일발송</TD>
                    <TD>
                        <ANY:RADIO id="OFFICE_MAIL_YN" codeData="{YES_NO}" />
                    </TD>
                    <TD req="INVENTOR_MAIL_YN">발명자 메일발송</TD>
                    <TD>
                        <ANY:RADIO id="INVENTOR_MAIL_YN" codeData="{YES_NO}" />
                    </TD>
                </TR>
                <TR>
                    <TD req="OFFICE_INPUT_YN">사무소 입력가능</TD>
                    <TD>
                        <ANY:RADIO id="OFFICE_INPUT_YN" codeData="{YES_NO}" />
                    </TD>
                    <TD req="INVENTOR_INPUT_YN">발명자 입력가능</TD>
                    <TD>
                        <ANY:RADIO id="INVENTOR_INPUT_YN" codeData="{YES_NO}" />
                    </TD>
                </TR>
                <TR>
                    <TD req="OFFICE_DISP_YN">사무소 조회가능</TD>
                    <TD>
                        <ANY:RADIO id="OFFICE_DISP_YN" codeData="{YES_NO}" />
                    </TD>
                    <TD req="INVENTOR_DISP_YN">발명자 조회가능</TD>
                    <TD>
                        <ANY:RADIO id="INVENTOR_DISP_YN" codeData="{YES_NO}" />
                    </TD>
                </TR>
                <TR>
                    <TD req="MST_STATUS_YN">마스터상태 반영</TD>
                    <TD>
                        <ANY:RADIO id="MST_STATUS_YN" codeData="{YES_NO}" />
                    </TD>
                    <TD req="MST_ABD_YN">마스터포기처리</TD>
                    <TD>
                        <ANY:RADIO id="MST_ABD_YN" codeData="{YES_NO}" />
                    </TD>
                </TR>
                <TR>
                    <TD>동시진행 서류</TD>
                    <TD>
                        <ANY:SEARCH id="WITH_PAPER_CODE" mode="U"><COMMENT>
                            win.path = top.getRoot() + "/anyfive/ipims/patent/common/popup/search/PaperSearchListR.jsp";
                            win.opt.width = 600;
                            codeColumn = "WITH_PAPER_CODE";
                            nameExpr = "[{#WITH_PAPER_CODE}] {#WITH_PAPER_NAME}";
                            setColumn("WITH_PAPER_CODE", "PAPER_CODE");
                            setColumn("WITH_PAPER_NAME", "PAPER_NAME");
                        </COMMENT></ANY:SEARCH>
                    </TD>
                    <TD>동시진행 세부서류</TD>
                    <TD><ANY:SELECT id="WITH_PAPER_SUBCODE" /></TD>
                </TR>
                <TR>
                    <TD>대응 진행서류</TD>
                    <TD>
                        <ANY:SEARCH id="COPE_PAPER_CODE" mode="U"><COMMENT>
                            win.path = top.getRoot() + "/anyfive/ipims/patent/common/popup/search/PaperSearchListR.jsp";
                            win.opt.width = 600;
                            codeColumn = "COPE_PAPER_CODE";
                            nameExpr = "[{#COPE_PAPER_CODE}] {#COPE_PAPER_NAME}";
                            setColumn("COPE_PAPER_CODE", "PAPER_CODE");
                            setColumn("COPE_PAPER_NAME", "PAPER_NAME");
                        </COMMENT></ANY:SEARCH>
                    </TD>
                    <TD req="DUP_AVAIL_YN">중복 입력가능</TD>
                    <TD>
                        <ANY:RADIO id="DUP_AVAIL_YN" codeData="{YES_NO}" />
                    </TD>
                </TR>
                <TR>
                    <TD>업무버튼 이름</TD>
                    <TD>
                        <INPUT type="text" id="BIZ_BUTTON_NAME" maxByte="300">
                    </TD>
                    <TD>업무화면 경로</TD>
                    <TD>
                        <INPUT type="text" id="BIZ_VIEW_PATH" maxByte="500">
                    </TD>
                </TR>
                <TR>
                    <TD>특허팀 대응버튼</TD>
                    <TD>
                        <INPUT type="text" id="PATTEAM_COPE_BUTTON" maxByte="300">
                    </TD>
                    <TD>특허팀 대응화면</TD>
                    <TD>
                        <INPUT type="text" id="PATTEAM_COPE_VIEW" maxByte="500">
                    </TD>
                </TR>
                <TR>
                    <TD>사무소 대응버튼</TD>
                    <TD>
                        <INPUT type="text" id="OFFICE_COPE_BUTTON" maxByte="300">
                    </TD>
                    <TD>사무소 대응화면</TD>
                    <TD>
                        <INPUT type="text" id="OFFICE_COPE_VIEW" maxByte="500">
                    </TD>
                </TR>
                <TR>
                    <TD>발명자 대응버튼</TD>
                    <TD>
                        <INPUT type="text" id="INVENTOR_COPE_BUTTON" maxByte="300">
                    </TD>
                    <TD>발명자 대응화면</TD>
                    <TD>
                        <INPUT type="text" id="INVENTOR_COPE_VIEW" maxByte="500">
                    </TD>
                </TR>
                <TR>
                    <TD>입력 도움말</TD>
                    <TD colspan="3">
                        <TEXTAREA id="INPUT_HELP" rows="2" maxByte="4000"></TEXTAREA>
                    </TD>
                </TR>
                <TR>
                    <TD>비고</TD>
                    <TD colspan="3">
                        <TEXTAREA id="REMARK" rows="2" maxByte="4000"></TEXTAREA>
                    </TD>
                </TR>
            </TABLE>
            <DIV class="button_area">
                <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>
                <BUTTON text="<%= app.message.get("btn.com.delete").toHTML() %>" onClick="javascript:fnDelete();"></BUTTON>
                <BUTTON auto="line"></BUTTON>
                <BUTTON auto="list"></BUTTON>
            </DIV>
        </TD>
    </TR>
    <TR>
        <TD height="10"></TD>
    </TR>
    <TR>
        <TD height="1">
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD class="title_sub">세부서류 목록</TD>
                    <TD align="right">
                        <SPAN id="spn_gridMessage"></SPAN>
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
            <ANY:GRID id="gr_subPaperCodeList" pagingType="0" minHeight="150px"><COMMENT>
                addColumn({ width:50 , align:"center", type:"number" , sort:false, id:"ROW_NUM"             , name:"No" });
                addColumn({ width:80 , align:"center", type:"string" , sort:true , id:"PAPER_SUBCODE"       , name:"세부서류코드" });
                addColumn({ width:150, align:"left"  , type:"string" , sort:true , id:"PAPER_SUBNAME"       , name:"세부서류명" });
                addColumn({ width:80 , align:"center", type:"string" , sort:true , id:"MST_ABD_YN_NAME"     , name:"마스터포기처리" });
                addColumn({ width:130, align:"left"  , type:"string" , sort:true , id:"BIZ_BUTTON_NAME"     , name:"업무버튼 이름" });
                addColumn({ width:150, align:"left"  , type:"string" , sort:true , id:"BIZ_VIEW_PATH"       , name:"업무화면 경로" });
                addColumn({ width:70 , align:"center", type:"string" , sort:true , id:"USE_YN_NAME"         , name:"사용여부" });
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_NUM", "PAPER_SUBNAME");
                addSorting("PAPER_SUBCODE", "ASC");
                addAction("PAPER_SUBNAME", fnDetailSubPaper);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
    <TR>
        <TD height="1">
            <DIV class="button_area">
                <BUTTON text="&#34;없음&#34; 서류 추가" onClick="javascript:fnAddDefaultSubPaper();"></BUTTON>
                <BUTTON text="세부서류 추가" onClick="javascript:fnAddSubPaper();"></BUTTON>
            </DIV>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
