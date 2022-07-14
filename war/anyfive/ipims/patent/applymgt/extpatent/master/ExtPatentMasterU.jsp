<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>해외출원마스터 수정</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("GRP_NO");
    addBind("FIRSTAPP_DATE");
    addBind("REF_NO");
    addBind("RIGHT_DIV");
    addBind("COUNTRY_CODE_NAME");
    addBind("JOB_MAN");
    addBind("EXAMREQ_YN");
    addBind("KO_APP_TITLE");
    addBind("EN_APP_TITLE");
    addBind("CORGT_YN");
    addBind("CORGT_MAN");
    addBind("COSTSHARE_YN");
    addBind("COSTSHARE_RATIO");
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
    addBind("IPC_CLS_CODE");
    addBind("ABD_YN");
    addBind("ABD_DATE");
    addBind("ABD_MEMO");
    addBind("ETC_MEMO");
    addBind("AB_ABSTRACT");
    addBind("AB_CLAIM");
    addBind("SALE_YN");
    addBind("SALE_PLACE");
    addBind("SALE_DATE");
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.extpatent.master.act.RetrieveExtPatentMaster.do";
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.extpatent.master.act.UpdateExtPatentMaster.do";
    prx.addParam("REF_ID", parent.REF_ID);
    prx.addParam("GRP_ID", parent.GRP_ID);
    prx.addData("ds_appExpManCodeList");
    prx.addData("ds_mainInfo");

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        window.location.replace("ExtPatentMasterRD.jsp");
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

<!-- 비용분담여부 변경시 -->
<SCRIPT language="JScript" for="COSTSHARE_YN" event="OnChange()">
    fnSetReqEnable(this, this.value == "1");
</SCRIPT>

<!-- 매각구분 변경시 -->
<SCRIPT language="JScript" for="SALE_YN" event="OnChange()">
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
        <TD colspan="4" class="title_table">[해외 출원품의 정보]</TD>
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
        <TD colspan="5">
            <ANY:INV id="any_inventorList" mode="U" />
        </TD>
    </TR>
    <TR>
        <TD colspan="4" class="title_table">[해외 마스터 정보]</TD>
    </TR>
    <TR>
        <TD>REF-NO</TD>
        <TD colspan="3"><SPAN id="REF_NO"></SPAN></TD>
    </TR>
    <TR>
        <TD>권리구분</TD>
        <TD><ANY:SELECT id="RIGHT_DIV" codeData="{RIGHT_DIV_PAT}" /></TD>
        <TD>출원국가</TD>
        <TD><SPAN id="COUNTRY_CODE_NAME"></SPAN></TD>
    </TR>
    <TR>
        <TD>건담당자</TD>
        <TD><ANY:SELECT id="JOB_MAN" codeData="/common/jobMan,PAT" /></TD>
        <TD>심사청구</TD>
        <TD><ANY:RADIO id="EXAMREQ_YN" codeData="{EXAMREQ_YN}" /></TD>
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
        <TD>공동권리여부</TD>
        <TD>
            <ANY:RADIO id="CORGT_YN" codeData="{YES_NO}" reqTd="td_corgtMan" />
        </TD>
        <TD id="td_corgtMan" req="CORGT_MAN" reqEnable="false">공동권리자</TD>
        <TD><INPUT type="text" id="CORGT_MAN" maxByte="100" disabled></TD>
    </TR>
    <TR>
        <TD>비용분담여부</TD>
        <TD>
            <ANY:RADIO id="COSTSHARE_YN" codeData="{COSTSHARE_YN}" reqTd="td_costshareRatio" />
        </TD>
        <TD id="td_costshareRatio" req="COSTSHARE_RATIO" reqEnable="false">비용분담율</TD>
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
        <TD>
            <ANY:SEARCH id="DIVISION_PRIOR_REF_ID" mode="U"><COMMENT>
                win.path = top.getRoot() + "/anyfive/ipims/patent/common/popup/search/RefNoSearchListR.jsp";
                win.arg.RIGHT_DIV = "10,20"
                win.arg.ABD_YN = "0";
                win.opt.width = 700;
                win.opt.height = 500;
                codeColumn = "REF_ID";
                nameExpr = "{#REF_NO}";
            </COMMENT></ANY:SEARCH>
        </TD>
        <TD>분할구분</TD>
        <TD><ANY:SELECT id="DIVISION_TYPE" codeData="{OL_DIVISION_TYPE}" firstName="" /></TD>
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
        <TD><ANY:SELECT id="OFFICE_JOB_MAN" firstName="sel" /></TD>
        <TD>사무소연계방법</TD>
        <TD><ANY:RADIO id="OFFICE_CONTACT_YN" codeData="{OFFICE_CONTACT_YN}" /></TD>
    </TR>
    <TR>
        <TD>해외사무소</TD>
        <TD><ANY:SELECT id="EXT_OFFICE_CODE" codeData="/common/extOfficeCode" firstName="sel" /></TD>
        <TD>해외사무소 REF</TD>
        <TD><INPUT id="EXT_OFFICE_REF_NO" type="text" maxByte="30"></TD>
    </TR>
    <TR>
        <TD>진행상태/일자</TD>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD width="100%">
                        <ANY:SELECT id="STATUS" codeData="/applymgt/masterStatus,10,EXT" firstName="sel" />
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
        <TD><ANY:SELECT id="PRIORITY_CLAIM_COUNTRY" codeData="/common/countryCode" /></TD>
    </TR>
    <TR>
       <TD>매각구분</TD>
        <TD>
            <ANY:RADIO id="SALE_YN" codeData="{YES_NO}"  reqTd="td_salePlaceDate" />
        </TD>
        <TD id="td_salePlaceDate" req="SALE_PLACE:매각처,SALE_DATE:매긱일" reqEnable="false">매각처/매각일</TD>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD width="100%">
                        <INPUT type="text" id="SALE_PLACE" maxByte="50" disabled>
                    </TD>
                    <TD>&nbsp;</TD>
                    <TD>
                        <ANY:DATE id="SALE_DATE" disabled />
                    </TD>
                </TR>
            </TABLE>
        </TD>
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
        <TD>IPC 분류 코드</TD>
        <TD colspan="3"><INPUT type="text" id="IPC_CLS_CODE" maxByte="100"></TD>
    </TR>
    <TR>
        <TD req="COSTSHARE_OWNER">비용분담주체</TD>
        <TD>
            <ANY:SELECT id="COSTSHARE_OWNER" codeData="/common/inAppManCode"  firstName="sel" />
        </TD>
         <TD req="any_appExpManCodeList">출원인</TD>
        <TD>
           <ANY:MSEARCH id="any_appExpManCodeList" mode="C"><COMMENT>
                win.path = top.getRoot() + "/anyfive/ipims/patent/common/popup/search/ApplicantLSearchListR.jsp";
                codeColumn = "APP_MAN_CODE";
                nameExpr = "[{#APP_MAN_CODE}] {#APP_MAN_NAME}";
                size = 6;
            </COMMENT></ANY:MSEARCH>
        </TD>
    </TR>
    <TR>
        <TD>진행여부/포기일</TD>
        <TD colspan="3">
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD>
                        <ANY:RADIO id="ABD_YN" codeData="{ABD_YN}" />
                    </TD>
                    <TD>&nbsp;</TD>
                    <TD>
                        <ANY:DATE id="ABD_DATE" />
                    </TD>
                    <TD>&nbsp;</TD>
                    <TD width="100%">
                        <INPUT type="text" id="ABD_MEMO" maxByte="4000">
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD>비고</TD>
        <TD colspan="3"><TEXTAREA id="ETC_MEMO" rows="5" maxByte="4000"></TEXTAREA></TD>
    </TR>
    <TR>
        <TD>초록</TD>
        <TD colspan="3"><TEXTAREA id="AB_ABSTRACT" rows="5"></TEXTAREA></TD>
    </TR>
    <TR>
        <TD>청구범위</TD>
        <TD colspan="3"><TEXTAREA id="AB_CLAIM" rows="5"></TEXTAREA></TD>
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
