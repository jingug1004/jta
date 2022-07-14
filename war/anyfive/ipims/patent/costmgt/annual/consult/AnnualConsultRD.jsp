<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>연차료 품의서 상세</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_APPROVAL); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<ANY:DS id="ds_mainInfo"><COMMENT>
    addBind("CONSULT_SUBJECT");
    addBind("TOTAL_PRICE");
    addBind("TOTAL_EXT_OFFICE_CHARGE");
    addBind("TOTAL_INT_OFFICE_CHARGE");
    addBind("CRE_USER_NAME");
    addBind("CRE_DATE");
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.costmgt.annual.consult.act.RetrieveAnnualConsult.do";
    prx.addParam("CONSULT_ID", parent.CONSULT_ID);
    prx.checkData = ds_mainInfo;

    prx.onSuccess = function()
    {
        fnRetrieveCostInput();
        any_approval.reset();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//비용목록 조회
function fnRetrieveCostInput()
{
    var ldr = gr_costInputList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.costmgt.annual.consult.act.RetrieveAnnualConsultInputList.do";
    ldr.addParam("CONSULT_ID", parent.CONSULT_ID);

    ldr.onSuccess = function()
    {
    }

    ldr.onFail = function()
    {
        this.error.show();
    }

    ldr.execute();
}

//수정
function fnModify()
{
    window.location.href = "AnnualConsultU.jsp";
}

//삭제
function fnDelete()
{
    if (!confirm("<%= app.message.get("msg.com.confirm.delete").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.costmgt.annual.consult.act.DeleteAnnualConsult.do";
    prx.addParam("CONSULT_ID", parent.CONSULT_ID);

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
</SCRIPT>

<!-- 결재현황 로딩시 -->
<SCRIPT language="JScript" for="any_approval" event="OnLoad()">
    cfShowObjects([btn_modify, btn_delete, btn_line], ds_mainInfo.value(0, "CRE_USER") == "<%= app.userInfo.getUserId() %>" && this.avail("REQUEST"));
</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
    <TR>
        <TD>
            <TABLE border="0" cellspacing="1" cellpadding="2" class="main">
                <COLGROUP>
                    <COL class="conthead" width="15%">
                    <COL class="contdata" width="35%">
                    <COL class="conthead" width="15%">
                    <COL class="contdata" width="35%">
                </COLGROUP>
                <TR>
                    <TD>품의서 제목</TD>
                    <TD colspan="3"><SPAN id="CONSULT_SUBJECT"></SPAN></TD>
                </TR>
                <TR>
                    <TD>관납료 합계</TD>
                    <TD><ANY:SPAN id="TOTAL_PRICE" format="number2" /></TD>
                    <TD>수수료 합계</TD>
                    <TD><ANY:SPAN id="TOTAL_INT_OFFICE_CHARGE" format="number2" /></TD>
                </TR>
                <TR>
                    <TD>송금수수료 합계</TD>
                    <TD><ANY:SPAN id="TOTAL_EXT_OFFICE_CHARGE" format="number2" /></TD>
                    <TD>작성자(작성일)</TD>
                    <TD><ANY:SPAN id="CRE_USER_NAME" />(<ANY:SPAN id="CRE_DATE" format="date" />)</TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
</TABLE>

<DIV style="margin-top:10px;">
    <SPAN id="spn_gridMessage"></SPAN>
</DIV>

<ANY:GRID id="gr_costInputList" pagingType="0" minHeight="200px" style="height:200px; margin-top:5px;"><COMMENT>
    addColumn({ width:40 , align:"center", type:"number", sort:false, id:"ROW_NUM"                , name:"No" });
    addColumn({ width:120, align:"left"  , type:"string", sort:true , id:"REF_NO"                 , name:"REF-NO" });
    addColumn({ width:200, align:"left"  , type:"string", sort:true , id:"KO_APP_TITLE"           , name:"발명의명칭" });
    addColumn({ width:70 , align:"center", type:"string", sort:true , id:"RIGHT_DIV_NAME"         , name:"권리구분" });
    addColumn({ width:70 , align:"center", type:"string", sort:true , id:"COSTSHARE_OWNER_NAME"   , name:"비용주체" });
    addColumn({ width:120, align:"left"  , type:"string", sort:true , id:"OFFICE_NAME"            , name:"사무소" });
    addColumn({ width:70 , align:"center", type:"string", sort:true , id:"PAY_YEARDEG"            , name:"납부년차" });
    addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"PAY_LIMIT"              , name:"납부기한" });
    addColumn({ width:90 , align:"right" , type:"number", sort:true , id:"PRICE"                  , name:"관납료"     , format:"#,##0.##" });
    addColumn({ width:90 , align:"right" , type:"number", sort:true , id:"INT_OFFICE_CHARGE"      , name:"수수료"     , format:"#,##0.##" });
    addColumn({ width:90 , align:"right" , type:"number", sort:true , id:"EXT_OFFICE_CHARGE"      , name:"송금수수료" , format:"#,##0.##" });
    addColumn({ width:90 , align:"center", type:"string", sort:true , id:"APP_NO"                 , name:"출원번호" });
    addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"APP_DATE"               , name:"출원일" });
    addColumn({ width:90 , align:"center", type:"string", sort:true , id:"REG_NO"                 , name:"등록번호"  });
    addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"REG_DATE"               , name:"등록일" });
    messageSpan = "spn_gridMessage";
    addSorting("REF_NO", "ASC");
    setFixedColumn("ROW_NUM", "KO_APP_TITLE");
</COMMENT></ANY:GRID>

<DIV class="button_area">
    <BUTTON text="<%= app.message.get("btn.com.modify").toHTML() %>" id="btn_modify" onClick="javascript:fnModify();" display="none"></BUTTON>
    <BUTTON text="<%= app.message.get("btn.com.delete").toHTML() %>" id="btn_delete" onClick="javascript:fnDelete();" display="none"></BUTTON>
    <BUTTON auto="line" id="btn_line" display="none"></BUTTON>
    <BUTTON auto="list"></BUTTON>
</DIV>

<ANY:APPROVAL id="any_approval" code="C03"><COMMENT>
    reqUser = ds_mainInfo.value(0, "CRE_USER");
    addKey("CONSULT_ID", parent.CONSULT_ID);
</COMMENT></ANY:APPROVAL>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
