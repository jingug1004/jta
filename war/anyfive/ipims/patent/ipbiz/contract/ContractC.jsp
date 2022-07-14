
<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<%@page import="any.util.etc.NDateUtil"%>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>계약서 작성</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
addBind("CONTRACT_KIND");
addBind("COUNTRY");
addBind("OTHER_TITLE");
addBind("OTHER_TITLE2");
addBind("LOCATION");
addBind("CEO_NAME");
addBind("CONTRACT_JOB_MAN");
addBind("SIGNATURE");
addBind("OFFICE_TITLE");
addBind("CONTRACT_GOAL");
addBind("START_DATE");
addBind("END_DATE");
addBind("CONTRACT_PRICE");
addBind("CURRENCY_UNIT");
addBind("SECRET_DATE");
addBind("DISP_RESOLUTION");
addBind("GOVERNING_LAW");
addBind("COMPETENT_COURT");
addBind("ATTACH_FILE", "any_attachFile");
addBind("MAIN_CONTENT");
addBind("REMARK");
</COMMENT></ANY:DS>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    CONTRACT_KIND.focus();
}

//저장
function fnSave(isFileUploaded)
{
  //필수항목 체크
    if (!cfCheckAllReqValid()) return;

  var prx = new any.proxy();

  if (isFileUploaded != true) {
      if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;
      cfFileUpload("fnSave(true);");
      return;
  }

  prx.path = top.getRoot() + "/anyfive.ipims.patent.ipbiz.contract.act.CreateContract.do";
  prx.addData("ds_mainInfo");
  prx.addData("ds_attachFile");

  prx.onSuccess = function()
  {
      parent.MGT_ID = this.result;
      alert("<%= app.message.get("msg.com.info.save").toJS() %>");
      window.location.replace("ContractRD.jsp");
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
        <COL class="contdata" width="35%">
        <COL class="conthead" width="15%">
        <COL class="contdata" width="35%">
    </COLGROUP>
    <TR>
        <TD>관리번호</TD>
        <TD disabled>(<%= app.message.get("msg.com.autocreate") %>)</TD>
        <TD>작성자(작성일)</TD>
        <TD><%= app.userInfo.getEmpHname() %>&nbsp;(<ANY:SPAN format="date" value="<%= NDateUtil.getSysDate() %>" />)</TD>
    </TR>
    <TR>
        <TD req="CONTRACT_KIND">계약서 종류</TD>
        <TD><ANY:SELECT id="CONTRACT_KIND" codeData="{CONTRACT_KIND}" firstName="sel" /></TD>
        <TD req="COUNTRY">국가</TD>
        <TD><ANY:SELECT id="COUNTRY" codeData="/common/countryCode" firstName="sel" /></TD>
    </TR>
    <TR>
        <TD req="OTHER_TITLE">상대방 명칭1</TD>
        <TD><INPUT type="text" id="OTHER_TITLE" maxByte="200"></TD>
        <TD>상대방 명칭2</TD>
        <TD><INPUT type="text" id="OTHER_TITLE2" maxByte="200"></TD>
    </TR>
    <TR>
        <TD req="LOCATION">본/지점 소재지</TD>
        <TD colspan="3"><INPUT type="text" id="LOCATION" maxByte="200"></TD>
    </TR>
    <TR>
        <TD req="CEO_NAME">대표이사명</TD>
        <TD><INPUT type="text" id="CEO_NAME" maxByte="50"></TD>
        <TD req="CONTRACT_JOB_MAN">계약담당자</TD>
        <TD><INPUT type="text" id="CONTRACT_JOB_MAN" maxByte="50"></TD>
    </TR>
    <TR>
        <TD>서명(날인)자</TD>
        <TD><INPUT type="text" id="SIGNATURE" maxByte="50"></TD>
        <TD>서명(날인)자 직함</TD>
        <TD><INPUT type="text" id="OFFICE_TITLE" maxByte="50"></TD>
    </TR>
    <TR>
        <TD req="CONTRACT_GOAL">체결목적</TD>
        <TD colspan="3"><INPUT type="text" id="CONTRACT_GOAL" maxByte="500"></TD>
    </TR>
    <TR>
        <TD req="START_DATE">체결일</TD>
        <TD>
             <ANY:DATE id="START_DATE" />
        </TD>
        <TD>종료일</TD>
        <TD>
             <ANY:DATE id="END_DATE" />
        </TD>
    </TR>
    <TR>
        <TD req="CONTRACT_PRICE">계약금액</TD>
        <TD><INPUT type="text"  id="CONTRACT_PRICE" format="number2(16)" /></TD>
        <TD req="CURRENCY_UNIT">화폐단위</TD>
        <TD><ANY:SELECT id="CURRENCY_UNIT" codeData="/ipbiz/currencyDiv" firstName="sel" /></TD>
    </TR>
    <TR>
        <TD>비밀유지(의무)기간</TD>
        <TD><ANY:DATE id="SECRET_DATE"/></TD>
        <TD>분쟁해결</TD>
        <TD><ANY:SELECT id="DISP_RESOLUTION" codeData="{DISP_RESOLUTION}" firstName="sel" /></TD>
    </TR>
    <TR>
        <TD>준거법</TD>
        <TD colspan="3"><INPUT type="text" id="GOVERNING_LAW" maxByte="500"></TD>
    </TR>
    <TR>
        <TD>관할법원/중재원</TD>
        <TD colspan="3"><INPUT type="text" id="COMPETENT_COURT" maxByte="500"></TD>
    </TR>
    <TR>
        <TD>첨부파일</TD>
        <TD colspan="3">
            <ANY:FILE id="any_attachFile" mode="C" policy="contract"/>
        </TD>
    </TR>
    <TR>
        <TD>주요내용</TD>
        <TD colspan="3">
            <TEXTAREA id="MAIN_CONTENT" rows="5" maxByte="4000"></TEXTAREA>
        </TD>
    </TR>
    <TR>
        <TD>기타사항</TD>
        <TD colspan="3">
            <TEXTAREA id="REMARK" rows="5" maxByte="4000"></TEXTAREA>
        </TD>
    </TR>
</TABLE>

<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.save").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>
    <BUTTON auto="line"></BUTTON>
    <BUTTON auto="list" list="ContractListR.jsp"></BUTTON>
</DIV>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
