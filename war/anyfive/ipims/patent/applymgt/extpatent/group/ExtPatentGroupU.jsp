<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>해외출원품의 수정</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("GRP_NO");
    addBind("CRE_USER_NAME");
    addBind("CRE_DATE");
    addBind("RIGHT_DIV");
    addBind("JOB_MAN");
    addBind("KO_APP_TITLE");
    addBind("FIRSTAPP_COUNTRY");
    addBind("FIRSTAPP_DATE");
    addBind("OFFICE_CODE");
    addBind("CORGT_YN");
    addBind("CORGT_MAN");
    addBind("COSTSHARE_YN");
    addBind("COSTSHARE_RATIO");
    addBind("COSTSHARE_OWNER");
    addBind("ATTACH_FILE", "any_attachFile");
    addBind("REMARK");
    addBind("APP_REWARD_GRADE");
    addBind("APP_REWARD_GIVETARGET_YN");
    addBind("APP_REWARD_GIVE_AMOUNT");
    addBind("APP_REWARD_GIVE_DATE");
    addBind("REG_REWARD_GRADE");
    addBind("REG_REWARD_GIVETARGET_YN");
    addBind("REG_REWARD_GIVE_AMOUNT");
    addBind("REG_REWARD_GIVE_DATE");
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.extpatent.group.act.RetrieveExtPatentGroup.do";
    prx.addParam("GRP_ID", parent.GRP_ID);
    prx.checkData = ds_mainInfo;

    prx.onSuccess = function()
    {
        any_groupRefNoList.onAddRowEnable = true;
        KO_APP_TITLE.focus();
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

    //발명자 목록 체크
    if (!any_inventorList.valid) return;

    if (isFileUploaded != true) {
        if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;
        cfFileUpload("fnSave(true);");
        return;
    }

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.extpatent.group.act.UpdateExtPatentGroup.do";
    prx.addParam("GRP_ID", parent.GRP_ID);
    prx.addData("ds_mainInfo");
    prx.addData("ds_groupRefNoList");
    prx.addData("ds_inventorList");
    prx.addData("ds_projectList");
    prx.addData("ds_techCodeList");
    prx.addData("ds_prodCodeList");
    prx.addData("ds_prschList");
    prx.addData("ds_attachFile");
    prx.addData("ds_appExpManCodeList");


    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        window.location.replace("ExtPatentGroupRD.jsp");
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

<!-- 국내 REF-NO 추가시 -->
<SCRIPT language="JScript" for="any_groupRefNoList" event="OnAddRow()">
    if (any_groupRefNoList.onAddRowEnable != true) return;
    any_inventorList.addList(event.REF_ID);
    any_projectList.addList(event.REF_ID);
    any_techCodeList.addList([{ name:"REF_ID", value:event.REF_ID }], top.getRoot() + "/anyfive.ipims.patent.common.mapping.tech.act.RetrieveTechCodeList.do");
</SCRIPT>

<!-- 공동출원여부 변경시 -->
<SCRIPT language="JScript" for="CORGT_YN" event="OnChange()">
    fnSetReqEnable(this, this.value == "1");
</SCRIPT>

<!-- 비용분담여부 변경시 -->
<SCRIPT language="JScript" for="COSTSHARE_YN" event="OnChange()">
    fnSetReqEnable(this, this.value == "1");
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
        <TD><SPAN id="GRP_NO"></SPAN></TD>
        <TD>작성자(작성일)</TD>
        <TD><SPAN id="CRE_USER_NAME"></SPAN>(<ANY:SPAN id="CRE_DATE" format="date" />)</TD>
    </TR>
    <TR>
        <TD req="RIGHT_DIV">권리구분</TD>
        <TD><ANY:SELECT id="RIGHT_DIV" codeData="{RIGHT_DIV_PAT}" firstName="select" /></TD>
        <TD req="JOB_MAN">특허담당자</TD>
        <TD><ANY:SELECT id="JOB_MAN" codeData="/common/jobMan,PAT" firstName="select" /></TD>
    </TR>
    <TR>
        <TD req="KO_APP_TITLE">출원의 명칭(한글)</TD>
        <TD colspan="3"><INPUT type="text" id="KO_APP_TITLE"></TD>
    </TR>
    <TR>
        <TD>선출원국가/일자</TD>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD width="100%">
                        <ANY:SELECT id="FIRSTAPP_COUNTRY" codeData="/common/countryCode" />
                    </TD>
                    <TD>&nbsp;</TD>
                    <TD>
                        <ANY:DATE id="FIRSTAPP_DATE" />
                    </TD>
                </TR>
            </TABLE>
        </TD>
        <TD req="OFFICE_CODE">국내사무소</TD>
        <TD><ANY:SELECT id="OFFICE_CODE" codeData="/common/intOfficeCode" firstName="select" /></TD>
    </TR>
    <TR>
        <TD>국내 REF-NO</TD>
        <TD colspan="3">
            <ANY:REFNO id="any_groupRefNoList" mode="U" rightDiv="10,20" inoutDiv="INT" multiCheck="false" />
        </TD>
    </TR>
    <TR>
        <TD req="any_inventorList">발명자</TD>
        <TD colspan="3">
            <ANY:INV id="any_inventorList" mode="U"/>
        </TD>
    </TR>
    <TR>
        <TD>대표PJT</TD>
        <TD colspan="3">
            <ANY:PJT id="any_projectList" mode="U" />
        </TD>
    </TR>
    <TR>
        <TD req="any_techCodeList">기술분류코드</TD>
        <TD>
            <ANY:MSEARCH id="any_techCodeList" mode="U"><COMMENT>
                win.path = top.getRoot() + "/anyfive/ipims/patent/common/popup/search/TechCodeSearchTreeR.jsp";
                codeColumn = "TECH_CODE";
                nameExpr = "[{#TECH_CODE}] {#TECH_PATHNAME}";
                size = 6;
            </COMMENT></ANY:MSEARCH>
        </TD>
        <TD>관련제품코드</TD>
        <TD>
            <ANY:MSEARCH id="any_prodCodeList" mode="U"><COMMENT>
                win.path = top.getRoot() + "/anyfive/ipims/patent/common/popup/search/ProdCodeSearchListR.jsp";
                win.opt.width = 650;
                codeColumn = "PROD_CODE";
                nameExpr = "[{#PROD_CODE}] {#PROD_NAME}";
                size = 6;
            </COMMENT></ANY:MSEARCH>
        </TD>
    </TR>
    <TR>
        <TD>공동출원여부</TD>
        <TD><ANY:RADIO id="CORGT_YN" codeData="{YES_NO}" reqTd="td_corgtMan" /></TD>
        <TD id="td_corgtMan" req="CORGT_MAN" reqEnable="false">공동권리자</TD>
        <TD>
            <INPUT id="CORGT_MAN" type="text" maxByte="100" disabled>
        </TD>
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
        <TD>관련파일첨부</TD>
        <TD colspan="3">
            <ANY:FILE id="any_attachFile" mode="U" policy="extgroup" />
        </TD>
    </TR>
    <TR>
        <TD>선행조사</TD>
        <TD colspan="3">
            <ANY:PRSCH id="any_prschList" mode="U" />
        </TD>
    </TR>
    <TR>
        <TD>비고</TD>
        <TD colspan="3"><TEXTAREA id="REMARK" rows="5" maxByte="4000"></TEXTAREA></TD>
    </TR>
    <TR>
        <TD colspan="2" class="title_table">[출원 보상금]</TD>
        <TD colspan="2" class="title_table">[등록 보상금]</TD>
    </TR>
    <TR>
        <TD>출원보상금 등급</TD>
        <TD><ANY:RADIO id="APP_REWARD_GRADE" codeData="{APP_REWARD_GRADE}" /></TD>
        <TD>등록보상금 등급</TD>
        <TD><ANY:RADIO id="REG_REWARD_GRADE" codeData="{REG_REWARD_GRADE}" /></TD>
    </TR>
    <TR>
        <TD>지급대상 여부</TD>
        <TD><ANY:CHECK id="APP_REWARD_GIVETARGET_YN" text="출원보상금 대상" /></TD>
        <TD>지급대상 여부</TD>
        <TD><ANY:CHECK id="REG_REWARD_GIVETARGET_YN" text="등록보상금 대상" /></TD>
    </TR>
    <TR>
        <TD>지급금액/지급일</TD>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD width="100%">
                        <INPUT id="APP_REWARD_GIVE_AMOUNT" format="number2(16)"/>
                    </TD>
                    <TD>&nbsp;</TD>
                    <TD>
                        <ANY:DATE id="APP_REWARD_GIVE_DATE" />
                    </TD>
                </TR>
            </TABLE>
        </TD>
        <TD>지급금액/지급일</TD>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD width="100%">
                        <INPUT id="REG_REWARD_GIVE_AMOUNT" format="number2(16)"/>
                    </TD>
                    <TD>&nbsp;</TD>
                    <TD>
                        <ANY:DATE id="REG_REWARD_GIVE_DATE" />
                    </TD>
                </TR>
            </TABLE>
        </TD>
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
