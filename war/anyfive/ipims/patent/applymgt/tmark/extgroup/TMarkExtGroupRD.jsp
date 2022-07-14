<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>상표해외출원품의</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_APPROVAL); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("GRP_NO");
    addBind("CRE_USER_NAME");
    addBind("CRE_DATE");
    addBind("RIGHT_DIV_NAME");
    addBind("JOB_MAN_NAME");
    addBind("KO_APP_TITLE");
    addBind("FIRSTAPP_COUNTRY_NAME");
    addBind("FIRSTAPP_DATE");
    addBind("OFFICE_NAME");
    addBind("CORGT_YN");
    addBind("CORGT_MAN");
    addBind("COSTSHARE_YN");
    addBind("COSTSHARE_RATIO");
    addBind("SPEC_PROD");
    addBind("ATTACH_FILE", "any_attachFile");
    addBind("REMARK");
    addBind("APP_REWARD_GIVETARGET_YN");
    addBind("REG_REWARD_GIVETARGET_YN");
    addBind("APP_REWARD_GIVE_DATE");
    addBind("APP_REWARD_GIVE_AMOUNT");
    addBind("REG_REWARD_GIVE_DATE");
    addBind("REG_REWARD_GIVE_AMOUNT");
    addBind("COSTSHARE_OWNER_NAME");
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.tmark.extgroup.act.RetrieveTMarkExtGroup.do";
    prx.addParam("GRP_ID", parent.GRP_ID);
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

//수정
function fnModify()
{
    window.location.href = "TMarkExtGroupU.jsp";
}

//신규OL작성
function fnOrderLetter()
{
    window.location.href = top.getRoot() + "/anyfive/ipims/patent/applymgt/tmark/extorderletter/TMarkExtOrderLetterC.jsp";
}

//해외출원현황
function fnExtMasterList()
{
    var win = new any.window();
    win.path = top.getRoot() + "/anyfive/ipims/patent/common/popup/viewer/ExtApplyByExtListR.jsp";
    win.arg.GRP_ID = parent.GRP_ID;
    win.opt.width = 700;
    win.opt.height = 400;
    win.show();
}
</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="1" cellpadding="2" class="main">
    <COLGROUP>
        <COL class="conthead" width="15%">
        <COL class="contdata" width="35%">
        <COL class="conthead" width="15%">
        <COL class="contdata" width="35%">
    </COLGROUP>
    <TR>
        <TD>출원품의번호</TD>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD>
                        <SPAN id="GRP_NO"></SPAN>
                    </TD>
                    <TD align="right">
                        <BUTTON text="해외출원현황" onClick="javascript:fnExtMasterList();"></BUTTON>
                    </TD>
                </TR>
            </TABLE>
        </TD>
        <TD>작성자(작성일)</TD>
        <TD><SPAN id="CRE_USER_NAME"></SPAN>(<ANY:SPAN id="CRE_DATE" format="date" />)</TD>
    </TR>
    <TR>
        <TD>권리구분</TD>
        <TD><SPAN ID="RIGHT_DIV_NAME"></SPAN></TD>
        <TD>특허담당자</TD>
        <TD><SPAN id="JOB_MAN_NAME"></SPAN></TD>
    </TR>
    <TR>
        <TD>상표명(한글)</TD>
        <TD colspan="3"><SPAN id="KO_APP_TITLE"></SPAN></TD>
    </TR>
    <TR>
        <TD>선출원국가/일자</TD>
        <TD><SPAN id="FIRSTAPP_COUNTRY_NAME"></SPAN>&nbsp;/&nbsp;<ANY:SPAN id="FIRSTAPP_DATE" format="date" /></TD>
        <TD>국내사무소</TD>
        <TD><SPAN id="OFFICE_NAME"/></SPAN></TD>
    </TR>
    <TR>
        <TD>국내 REF-NO</TD>
        <TD colspan="3">
            <ANY:REFNO id="any_groupRefNoList" mode="R" />
        </TD>
    </TR>
    <TR>
        <TD>발명자</TD>
        <TD colspan="3">
            <ANY:INV id="any_inventorList" mode="R"/>
        </TD>
    </TR>
    <TR>
        <TD>공동출원여부</TD>
        <TD><ANY:RADIO id="CORGT_YN" codeData="{YES_NO}" readOnly/></TD>
        <TD>공동권리자</TD>
        <TD>
            <SPAN id="CORGT_MAN"></SPAN>
        </TD>
    </TR>
    <TR>
        <TD>비용분담여부</TD>
        <TD><ANY:RADIO id="COSTSHARE_YN" codeData="{COSTSHARE_YN}" readOnly /></TD>
        <TD>비용분담율</TD>
        <TD><SPAN id="COSTSHARE_RATIO"></SPAN>&nbsp;%</TD>
    </TR>
    <TR>
        <TD>비용분담주체</TD>
        <TD><SPAN id="COSTSHARE_OWNER_NAME" ></SPAN></TD>
     <TD>출원인</TD>
        <TD>
            <ANY:MSEARCH id="any_appExpManCodeList" mode="R"><COMMENT>
                nameExpr = "[{#APP_MAN_CODE}] {#APP_MAN_NAME}";
            </COMMENT></ANY:MSEARCH>
        </TD>
    </TR>
    <TR>
        <TD>상품류</TD>
        <TD colspan="3">
            <ANY:TMARKCLS id="any_tmarkClsList" mode="R" />
        </TD>
    </TR>
    <TR>
        <TD>지정상품</TD>
        <TD colspan="3"><SPAN id="SPEC_PROD"></SPAN></TD>
    </TR>
    <TR>
        <TD>관련파일첨부</TD>
        <TD colspan="3">
            <ANY:FILE id="any_attachFile" mode="R" />
        </TD>
    </TR>
    <TR>
        <TD>비고</TD>
        <TD colspan="3"><SPAN id="REMARK"></SPAN></TD>
    </TR>
    <TR>
        <TD colspan="2" class="title_table">[출원 보상금]</TD>
        <TD colspan="2" class="title_table">[등록 보상금]</TD>
    </TR>
    <TR>
        <TD>지급대상 여부</TD>
        <TD><ANY:CHECK id="APP_REWARD_GIVETARGET_YN" text="출원보상금 대상" readOnly /></TD>
        <TD>지급대상 여부</TD>
        <TD><ANY:CHECK id="REG_REWARD_GIVETARGET_YN" text="등록보상금 대상" readOnly /></TD>
    </TR>
    <TR>
        <TD>지급금액/지급일</TD>
        <TD><ANY:SPAN id="APP_REWARD_GIVE_AMOUNT" format="number2" />&nbsp;/&nbsp;<ANY:SPAN id="APP_REWARD_GIVE_DATE" format="date" /></TD>
        <TD>지급금액/지급일</TD>
        <TD><ANY:SPAN id="REG_REWARD_GIVE_AMOUNT" format="number2" />&nbsp;/&nbsp;<ANY:SPAN id="REG_REWARD_GIVE_DATE" format="date" /></TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="신규OL작성" onClick="javascript:fnOrderLetter();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.modify").toHTML() %>" onClick="javascript:fnModify();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="list"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
