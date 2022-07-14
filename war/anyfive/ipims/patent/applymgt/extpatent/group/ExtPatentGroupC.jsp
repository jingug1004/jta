<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<%@page import="any.util.etc.NTextUtil"%>
<%@page import="any.util.etc.NDateUtil"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>해외출원품의 작성</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
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
</COMMENT></ANY:DS>
<ANY:DS id="ds_searchInfo" />
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    KO_APP_TITLE.focus();

    any_groupRefNoList.searchData("<%= NTextUtil.nvl(request.getParameter("REF_NO"), "") %>");
}

//국내마스터 조회
function fnRetrieveIntMaster(refId)
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.extpatent.group.act.RetrieveIntMaster.do";
    prx.addParam("REF_ID", refId);

    prx.onSuccess = function()
    {
        RIGHT_DIV.value = ds_searchInfo.value(0, "RIGHT_DIV");
        JOB_MAN.value = ds_searchInfo.value(0, "JOB_MAN");
        KO_APP_TITLE.value = ds_searchInfo.value(0, "KO_APP_TITLE");
        OFFICE_CODE.value = ds_searchInfo.value(0, "OFFICE_CODE");
        CORGT_YN.value = ds_searchInfo.value(0, "CORGT_YN");
        CORGT_MAN.value = ds_searchInfo.value(0, "CORGT_MAN");
        COSTSHARE_YN.value = ds_searchInfo.value(0, "COSTSHARE_YN");
        COSTSHARE_RATIO.value = ds_searchInfo.value(0, "COSTSHARE_RATIO");
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.extpatent.group.act.CreateExtPatentGroup.do";
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
        parent.GRP_ID = this.result;
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
    FIRSTAPP_DATE.value = this.minAppDate;
    if (this.rowCount == 1) fnRetrieveIntMaster(event.REF_ID);
    any_inventorList.addList(event.REF_ID);
    any_projectList.addList(event.REF_ID);
    any_techCodeList.addList([{ name:"REF_ID", value:event.REF_ID }], top.getRoot() + "/anyfive.ipims.patent.common.mapping.tech.act.RetrieveTechCodeList.do");
</SCRIPT>

<!-- 국내 REF-NO 삭제시 -->
<SCRIPT language="JScript" for="any_groupRefNoList" event="OnDeleteRow()">
    FIRSTAPP_DATE.value = this.minAppDate;
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
        <TD disabled>(<%= app.message.get("msg.com.autocreate") %>)</TD>
        <TD>작성자(작성일)</TD>
        <TD><%= app.userInfo.getEmpHname() %>(<ANY:SPAN value="<%= NDateUtil.getSysDate() %>" format="date" />)</TD>
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
                        <ANY:SELECT id="FIRSTAPP_COUNTRY" codeData="/common/countryCode" value="KR" />
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
            <ANY:REFNO id="any_groupRefNoList" mode="C" rightDiv="10,20" inoutDiv="INT" multiCheck="false" />
        </TD>
    </TR>
    <TR>
        <TD req="any_inventorList">발명자</TD>
        <TD colspan="3">
            <ANY:INV id="any_inventorList" mode="C" />
        </TD>
    </TR>
    <TR>
        <TD>대표PJT</TD>
        <TD colspan="3">
            <ANY:PJT id="any_projectList" mode="C" />
        </TD>
    </TR>
    <TR>
        <TD req="any_techCodeList">기술분류코드</TD>
        <TD>
            <ANY:MSEARCH id="any_techCodeList" mode="C"><COMMENT>
                win.path = top.getRoot() + "/anyfive/ipims/patent/common/popup/search/TechCodeSearchTreeR.jsp";
                codeColumn = "TECH_CODE";
                nameExpr = "[{#TECH_CODE}] {#TECH_PATHNAME}";
                size = 6;
            </COMMENT></ANY:MSEARCH>
        </TD>
        <TD>관련제품코드</TD>
        <TD>
            <ANY:MSEARCH id="any_prodCodeList" mode="C"><COMMENT>
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
            <ANY:FILE id="any_attachFile" mode="C" policy="extgroup" />
        </TD>
    </TR>
    <TR>
        <TD>선행조사</TD>
        <TD colspan="3">
            <ANY:PRSCH id="any_prschList" mode="C" />
        </TD>
    </TR>
    <TR>
        <TD>비고</TD>
        <TD colspan="3"><TEXTAREA id="REMARK" rows="5" maxByte="500"></TEXTAREA></TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="list"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
