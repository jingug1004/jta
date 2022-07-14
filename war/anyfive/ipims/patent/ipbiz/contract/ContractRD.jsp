<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<%@page import="any.util.etc.NDateUtil"%>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>계약서 상세</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<% app.writeHTCImport(app.HTC_IPBHIST); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
addBind("MGT_NO");
addBind("CONTRACT_KIND_NAME");
addBind("COUNTRY_NAME");
addBind("OTHER_TITLE");
addBind("OTHER_TITLE2");
addBind("LOCATION");
addBind("CEO_NAME");
addBind("CONTRACT_GOAL");
addBind("CONTRACT_PRICE");
addBind("CURRENCY_UNIT");
addBind("START_DATE");
addBind("END_DATE");
addBind("CONTRACT_JOB_MAN");
addBind("SIGNATURE");
addBind("OFFICE_TITLE");
addBind("SECRET_DATE");
addBind("DISP_RESOLUTION_NAME");
addBind("GOVERNING_LAW");
addBind("COMPETENT_COURT");
addBind("ATTACH_FILE", "any_attachFile");
addBind("MAIN_CONTENT");
addBind("REMARK");
addBind("CRE_USER_NAME");
addBind("CRE_DATE");
addBind("UPD_USER_NAME");
addBind("UPD_DATE");
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

    prx.path = top.getRoot() + "/anyfive.ipims.patent.ipbiz.contract.act.RetrieveContractRD.do";
    prx.addParam("MGT_ID", parent.MGT_ID);
    prx.checkData = ds_mainInfo;

    prx.onSuccess = function(gr, fg)
    {
    }

    prx.onFail = function(gr, fg)
    {
        this.error.show();
    }

    prx.execute();
}

//수정
function fnModify()
{
    window.location.href = "ContractU.jsp";
}

//삭제
function fnDelete()
{
    var isCreUser = (ds_mainInfo.value(0, "CRE_USER") == "<%= app.userInfo.getUserId()%>");

    if(isCreUser){
        if (!confirm("<%= app.message.get("msg.com.confirm.delete").toJS() %>")) return;

        var prx = new any.proxy();
        prx.path = top.getRoot() + "/anyfive.ipims.patent.ipbiz.contract.act.DeleteContract.do";
        prx.addParam("MGT_ID", parent.MGT_ID);

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
    }else{
        alert("계약서를 삭제할 수 없습니다.");
        return;
    }
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
        <TD>관리번호</TD>
        <TD colspan="3"><SPAN id="MGT_NO"/></TD>
    </TR>
    <TR>
        <TD>작성자(작성일)</TD>
        <TD><SPAN id="CRE_USER_NAME"></span>&nbsp;(<ANY:SPAN format="date"  id="CRE_DATE" />)</TD>
        <TD>수정자(수정일)</TD>
        <TD><SPAN id="UPD_USER_NAME"></span>&nbsp;(<ANY:SPAN format="date"  id="UPD_DATE" />)</TD>
    </TR>
    <TR>
        <TD>계약서 종류</TD>
        <TD><SPAN id="CONTRACT_KIND_NAME" /></TD>
        <TD>국가</TD>
        <TD><SPAN id="COUNTRY_NAME" /></TD>
    </TR>
    <TR>
        <TD>상대방 명칭1</TD>
        <TD><SPAN id="OTHER_TITLE"/></TD>
        <TD>상대방 명칭2</TD>
        <TD><SPAN id="OTHER_TITLE2"/></TD>
    </TR>
    <TR>
        <TD>본/지점 소재지</TD>
        <TD colspan="3"><SPAN id="LOCATION" /></TD>
    </TR>
    <TR>
        <TD>대표이사명</TD>
        <TD><SPAN id="CEO_NAME" /></TD>
        <TD>계약담당자</TD>
        <TD><SPAN id="CONTRACT_JOB_MAN" /></TD>
    </TR>
    <TR>
        <TD>서명(날인)자</TD>
        <TD><SPAN id="SIGNATURE" /></TD>
        <TD>서명(날인)자 직함</TD>
        <TD><SPAN id="OFFICE_TITLE" /></TD>
    </TR>
    <TR>
        <TD>체결목적</TD>
        <TD colspan="3"><SPAN id="CONTRACT_GOAL" /></TD>
    </TR>
    <TR>
        <TD>체결일</TD>
        <TD>
             <ANY:SPAN format="date"  id="START_DATE" />
        </TD>
        <TD>종료일</TD>
        <TD>
            <ANY:SPAN format="date"  id="END_DATE" />
        </TD>
    </TR>
    <TR>
        <TD>계약금액</TD>
        <TD><SPAN id="CONTRACT_PRICE"  format="number2"/></TD>
        <TD>화폐단위</TD>
        <TD><SPAN id="CURRENCY_UNIT" /></TD>
    </TR>
    <TR>
        <TD>비밀유지(의무)기간</TD>
        <TD><ANY:SPAN format="date"  id="SECRET_DATE" /></TD>
        <TD>분쟁해결</TD>
        <TD><SPAN id="DISP_RESOLUTION_NAME" /></TD>
    </TR>
    <TR>
        <TD>준거법</TD>
        <TD colspan="3"><SPAN id="GOVERNING_LAW" /></TD>
    </TR>
    <TR>
        <TD>관할법원/중재원</TD>
        <TD colspan="3"><SPAN id="COMPETENT_COURT" /></TD>
    </TR>
    <TR>
        <TD>첨부파일</TD>
        <TD colspan="3">
            <ANY:FILE id="any_attachFile" mode="R" />
        </TD>
    </TR>
    <TR>
        <TD>주요내용</TD>
        <TD colspan="3">
            <SPAN id="MAIN_CONTENT"/>
        </TD>
    </TR>
    <TR>
        <TD>기타사항</TD>
        <TD colspan="3">
            <SPAN id="REMARK"/>
        </TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="수정" onClick="javascript:fnModify();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON text="삭제" onClick="javascript:fnDelete();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="list" list="ContractListR.jsp"></BUTTON>
</DIV>

<ANY:IPBHIST id="any_ipbHistory" style="height:250px;"><COMMENT>
    refId = parent.MGT_ID;
</COMMENT></ANY:IPBHIST>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
