<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>해외출원 마스터 수정</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("REF_NO");
    addBind("RIGHT_DIV_NAME");
    addBind("COUNTRY_NAME");
    addBind("GRP_NO");
    addBind("JOB_MAN");
    addBind("EXAMREQ_YN");
    addBind("FIRSTAPP_DATE");
    addBind("CORGT_YN");
    addBind("CORGT_MAN");
    addBind("COSTSHARE_YN");
    addBind("COSTSHARE_RATIO");
    addBind("KO_APP_TITLE");
    addBind("EN_APP_TITLE");
    addBind("DIVISION_PRIOR_REF_ID");
    addBind("DIVISION_TYPE");
    addBind("OFFICE_CODE");
    addBind("OFFICE_SEND_DATE");
    addBind("OFFICE_REF_NO");
    addBind("OFFICE_JOB_MAN");
    addBind("OFFICE_CONTACT_YN");
    addBind("EXT_OFFICE_CODE");
    addBind("EXT_OFFICE_REF_NO");
    addBind("STATUS");
    addBind("STATUS_DATE");
    addBind("BUY_DATE");
    addBind("BUY_COUNTRY");
    addBind("PRIORITY_CLAIM_YN");
    addBind("PRIORITY_CLAIM_COUNTRY");
    addBind("APP_NO");
    addBind("APP_DATE");
    addBind("PUB_NO");
    addBind("PUB_DATE");
    addBind("NOTICE_NO");
    addBind("NOTICE_DATE");
    addBind("REG_NO");
    addBind("REG_DATE");
    addBind("ABD_YN");
    addBind("ABD_DATE");
    addBind("ABD_MEMO");
    addBind("ETC_MEMO");
    addBind("COSTSHARE_OWNER");
    addBind("DEPT_CODE");
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.design.extmaster.act.RetrieveDesignExtMaster.do";
    prx.addParam("REF_ID", parent.REF_ID);
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

//저장
function fnSave()
{
    //필수항목 체크
    if (!cfCheckAllReqValid()) return;

    //저장 확인
    if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.design.extmaster.act.UpdateDesignExtMaster.do";
    prx.addParam("REF_ID", parent.REF_ID);
    prx.addData("ds_mainInfo");
    prx.addData("ds_appManCodeList");

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        window.location.replace("DesignExtMasterRD.jsp");
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//필수여부 설정
function fnSetReqEnable(obj, enable)
{
    var td = document.getElementById(obj.reqTd);

    td.reqEnable = enable;

    for (var i = 0; i < td.req.length; i++) {
        document.getElementById(td.req[i].ctrl).disabled = !enable;
    }
}

</SCRIPT>

<!-- 사무소 변경시 -->
<SCRIPT language="JScript" for="OFFICE_CODE" event="OnChange()">
    OFFICE_JOB_MAN.codeData = "/applymgt/officeJobMan," + this.value;
</SCRIPT>

<!-- 공동출원여부 변경시 -->
<SCRIPT language="JScript" for="CORGT_YN" event="OnChange()">
    fnSetReqEnable(this, this.value == "1");
</SCRIPT>

<!-- 포기여부 변경시 -->
<SCRIPT language="JScript" for="ABD_YN" event="OnChange()">
    ABD_DATE.disabled = ABD_MEMO.disabled = (this.value != "1");
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
        <TD colspan="4" class="title_table">[해외출원품의 정보]</TD>
    </TR>
    <TR>
        <TD>해외품의번호</TD>
        <TD><SPAN id="GRP_NO"></SPAN></TD>
        <TD>선출원일</TD>
        <TD><ANY:SPAN id="FIRSTAPP_DATE" format="date" /></TD>
    </TR>
    <TR>
        <TD>선출원번호</TD>
        <TD colspan="3"><ANY:PRIORAPP id="any_priorAppList" /></TD>
    </TR>
    <TR>
        <TD>발명자</TD>
        <TD colspan="3">
            <ANY:INV id="any_inventorList" mode="R" />
        </TD>
    </TR>
    <TR>
        <TD colspan="4" class="title_table">[해외마스터 정보]</TD>
    </TR>
    <TR>
        <TD>REF-NO</TD>
        <TD colspan="3"><SPAN id="REF_NO"></SPAN></TD>
    </TR>
    <TR>
        <TD>발명의 명칭(한)</TD>
        <TD colspan="3"><INPUT id="KO_APP_TITLE" type="text" maxByte="1000"></TD>
    </TR>
    <TR>
        <TD>발명의 명칭(영)</TD>
        <TD colspan="3"><INPUT id="EN_APP_TITLE" type="text" maxByte="1000"></TD>
    </TR>
    <TR>
        <TD>건담당자</TD>
        <TD><ANY:SELECT id="JOB_MAN" codeData="/common/jobMan,DES"/></TD>
        <TD>심사청구</TD>
        <TD><ANY:RADIO id="EXAMREQ_YN" codeData="{EXAMREQ_YN}"/></TD>
    </TR>
    <TR>
        <TD>권리구분</TD>
        <TD><SPAN id="RIGHT_DIV_NAME"></SPAN></TD>
        <TD>출원국가</TD>
        <TD><SPAN id="COUNTRY_NAME"></SPAN></TD>
    </TR>
    <TR>
        <TD>부서</TD>
        <TD colspan="3"><ANY:SEARCH id="DEPT_CODE" mode="U" style="width:40%"><COMMENT>
                win.path = top.getRoot() + "/anyfive/ipims/patent/common/popup/search/DeptCodeSearchListR.jsp";
                win.opt.width = 600;
                codeColumn = "DEPT_CODE";
                nameExpr = "[{#DEPT_CODE}] {#DEPT_NAME}";
            </COMMENT></ANY:SEARCH>
        </TD>
    </TR>
    <TR>
        <TD>공동권리 여부</TD>
        <TD><ANY:RADIO id="CORGT_YN" codeData="{YES_NO}" style="width:130" reqTd="td_corgtMan" /></TD>
        <TD id="td_corgtMan" req="CORGT_MAN" reqEnable="false">공동권리자</TD>
        <TD><INPUT id="CORGT_MAN" type="text" maxByte="100" disabled></TD>
    </TR>
    <TR>
        <TD>비용분담여부</TD>
        <TD>
            <ANY:RADIO id="COSTSHARE_YN" codeData="{COSTSHARE_YN}" reqTd="td_costshareRatio" />
        </TD>
        <TD>비용분담율</TD>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD width="100%">
                        <INPUT type="text" id="COSTSHARE_RATIO" format="number" maxByte="3" disabled>
                    </TD>
                    <TD noWrap>&nbsp;%&nbsp;(당사분담율)</TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD>모출원정보</TD>
        <TD><INPUT id="DIVISION_PRIOR_REF_ID" type="text" maxByte="15"></TD>
        <TD>분할구분</TD>
        <TD><INPUT id="DIVISION_TYPE" type="text" maxByte="2"></TD>
    </TR>
    <TR>
        <TD>국내사무소/의뢰일</TD>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD width="100%">
                        <ANY:SELECT id="OFFICE_CODE" codeData="/common/intOfficeCode" firstName="sel" />
                    </TD>
                    <TD>&nbsp;</TD>
                    <TD>
                        <ANY:DATE id="OFFICE_SEND_DATE" />
                    </TD>
                </TR>
            </TABLE>
        </TD>
        <TD>국내사무소 REF</TD>
        <TD><INPUT id="OFFICE_REF_NO" type="text" maxByte="30"></TD>
    </TR>
    <TR>
        <TD>사무소담당자</TD>
        <TD><ANY:SELECT id="OFFICE_JOB_MAN" /></TD>
        <TD>사무소연계방법</TD>
        <TD><ANY:RADIO id="OFFICE_CONTACT_YN" codeData="{OFFICE_CONTACT_YN}" /></TD>
    </TR>
    <TR>
        <TD>해외사무소</TD>
        <TD><ANY:SELECT id="EXT_OFFICE_CODE" codeData="/common/extOfficeCode"/></TD>
        <TD>해외사무소 REF</TD>
        <TD><INPUT id="EXT_OFFICE_REF_NO" type="text" maxByte="30"></TD>
    </TR>
    <TR>
        <TD>진행상태/일자</TD>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD width="100%">
                        <ANY:SELECT id="STATUS" codeData="/applymgt/masterStatus,40,EXT" firstName="sel" />
                    </TD>
                    <TD>&nbsp;</TD>
                    <TD>
                        <ANY:DATE id="STATUS_DATE" />
                    </TD>
                </TR>
            </TABLE>
        </TD>
        <TD>매입일자/국가</TD>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD>
                        <ANY:DATE id="BUY_DATE" />
                    </TD>
                    <TD>&nbsp;</TD>
                    <TD width="100%">
                        <ANY:SELECT id="BUY_COUNTRY" codeData="/common/countryCode" />
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD>우선권주장여부</TD>
        <TD><ANY:RADIO id="PRIORITY_CLAIM_YN" codeData="{YES_NO}" /></TD>
        <TD>우선권주장국가</TD>
        <TD><ANY:SELECT id="PRIORITY_CLAIM_COUNTRY" codeData="/common/countryCode"/></TD>
    </TR>
    <TR>
        <TD>출원번호/일자</TD>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD width="100%">
                        <INPUT type="text" id="APP_NO" maxByte="30">
                    </TD>
                    <TD>&nbsp;</TD>
                    <TD>
                        <ANY:DATE id="APP_DATE" />
                    </TD>
                </TR>
            </TABLE>
        </TD>
        <TD>공개번호/일자</TD>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD width="100%">
                        <INPUT type="text" id="PUB_NO" maxByte="30">
                    </TD>
                    <TD>&nbsp;</TD>
                    <TD>
                        <ANY:DATE id="PUB_DATE" />
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD>공고번호/일자</TD>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD width="100%">
                        <INPUT type="text" id="NOTICE_NO" maxByte="30">
                    </TD>
                    <TD>&nbsp;</TD>
                    <TD>
                        <ANY:DATE id="NOTICE_DATE" />
                    </TD>
                </TR>
            </TABLE>
        </TD>
        <TD>등록번호/일자</TD>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD width="100%">
                        <INPUT type="text" id="REG_NO" maxByte="30">
                    </TD>
                    <TD>&nbsp;</TD>
                    <TD>
                        <ANY:DATE id="REG_DATE" />
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD>진행여부/포기일</TD>
        <TD colspan="3">
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD noWrap>
                        <ANY:RADIO id="ABD_YN" codeData="{ABD_YN}" />&nbsp;
                    </TD>
                    <TD noWrap>
                        <ANY:DATE id="ABD_DATE" />&nbsp;
                    </TD>
                    <TD width="100%">
                        <INPUT type="text" id="ABD_MEMO" maxByte="4000">
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD req="COSTSHARE_OWNER">비용분담주체</TD>
        <TD>
            <ANY:SELECT id="COSTSHARE_OWNER" codeData="/common/inAppManCode"  firstName="sel" />
        </TD>
        <TD req="any_appManCodeList">출원인</TD>
        <TD>
           <ANY:MSEARCH id="any_appManCodeList" mode="C"><COMMENT>
                win.path = top.getRoot() + "/anyfive/ipims/patent/common/popup/search/ApplicantLSearchListR.jsp";
                codeColumn = "APP_MAN_CODE";
                nameExpr = "[{#APP_MAN_CODE}] {#APP_MAN_NAME}";
                size = 6;
            </COMMENT></ANY:MSEARCH>
        </TD>
    </TR>
    <TR>
        <TD>비고</TD>
        <TD colspan="3"><TEXTAREA id="ETC_MEMO" rows="5" maxByte="4000"></TEXTAREA></TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.cancel").toHTML() %>" onClick="javascript:history.back();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="list"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
