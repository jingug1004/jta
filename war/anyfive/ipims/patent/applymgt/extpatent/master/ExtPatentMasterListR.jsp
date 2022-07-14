<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>해외출원</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();
}

//목록 조회
function fnRetrieve()
{
    var ldr = gr_ExtMasterList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.extpatent.master.act.RetrieveExtPatentMasterList.do";
    ldr.addParam("OPT_SEL_NO", OPT_SEL_NO.value);
    ldr.addParam("SEL_NO", SEL_NO.value);
    ldr.addParam("NO_ONLY", NO_ONLY.value);
    ldr.addParam("OFFICE_CODE", OFFICE_CODE.value);
    ldr.addParam("STATUS" , STATUS.value);
    ldr.addParam("COUNTRY_CODE" , COUNTRY_CODE.value);
    ldr.addParam("DATE_GUBUN" , DATE_GUBUN.value);
    ldr.addParam("DATE_START" , DATE_START.value);
    ldr.addParam("DATE_END" , DATE_END.value);
    ldr.addParam("JOB_MAN" , JOB_MAN.value);
    ldr.addParam("KO_APP_TITLE" , KO_APP_TITLE.value);

    ldr.onSuccess = function(gr, fg)
    {
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}


//상세
function fnDetail(gr, fg, row, colId)
{
    var win = new any.viewer();
    <% if (app.userInfo.isPatentTeam() == true) { %>
    win.path = top.getRoot() + "/anyfive/ipims/patent/applymgt/common/ExtMasterTabR.jsp?TAB=paper";
    <% } else { %>
    win.path = top.getRoot() + "/anyfive/ipims/patent/applymgt/extpatent/master/ExtPatentMasterRD.jsp?TAB=paper";
    <% } %>
    win.arg.REF_ID = gr.value(row, "REF_ID");
    win.arg.gr = gr;
    win.arg.fg = fg;

    win.onReload = function()
    {
        gr.loader.reload();
    }

    win.show();
}
</SCRIPT>

<!-- 검색일자 구분 변경시 -->
<SCRIPT language="JScript" for="DATE_GUBUN" event="OnChange()">
    DATE_START.disabled = (this.value == "");
    DATE_END.disabled = (this.value == "");
</SCRIPT>

</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
    <TR>
        <TD>
            <TABLE border="0" cellspacing="1" cellpadding="2" class="main" onEnter="javascript:fnRetrieve();">
                <COLGROUP>
                    <COL class="condhead" width="10%">
                    <COL class="conddata" width="23%">
                    <COL class="condhead" width="10%">
                    <COL class="conddata" width="23%">
                    <COL class="condhead" width="10%">
                    <COL class="conddata" width="23%">
                </COLGROUP>
                <TR>
                    <TD>검색번호</TD>
                    <TD colspan="3" noWrap>
                        <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                            <TR>
                                <TD>
                                    <ANY:SELECT id="OPT_SEL_NO" codeData="/applymgt/extMasterSearchOptSelNo" style="width:125px; margin-right:3px;" />
                                </TD>
                                <TD width="100%">
                                    <INPUT type="text" id="SEL_NO" style="text-transform:uppercase;">
                                </TD>
                                <TD noWrap>
                                    <ANY:CHECK id="NO_ONLY" text="번호만 검색" />
                                </TD>
                            </TR>
                        </TABLE>
                    </TD>
                    <TD>발명의명칭</TD>
                    <TD>
                        <INPUT id="KO_APP_TITLE" type="text">
                    </TD>
                </TR>
                <TR>
                    <TD>출원사무소</TD>
                    <TD>
                        <ANY:SELECT id="OFFICE_CODE" codeData="/common/intOfficeCode" firstName="all" />
                    </TD>
                    <TD>진행상태</TD>
                    <TD>
                        <ANY:SELECT id="STATUS" codeData="/applymgt/masterStatus,10,EXT" firstName="all" />
                    </TD>
                    <TD>출원국가</TD>
                    <TD>
                        <ANY:SELECT id="COUNTRY_CODE" codeData="/common/countryCode" firstName="all" />
                    </TD>
                </TR>
                <TR>
                    <TD>검색일자</TD>
                    <TD noWrap colspan="3">
                        <ANY:SELECT id="DATE_GUBUN" codeData="/applymgt/extMasterSearchDateGubun" firstName="none" style="width:80px; margin-right:3px;" />
                        <ANY:DATE id="DATE_START" disabled />&nbsp;~
                        <ANY:DATE id="DATE_END" disabled />
                    </TD>
                    <TD>건담당자</TD>
                    <TD>
                        <ANY:SELECT id="JOB_MAN" codeData="/common/jobMan,PAT" firstName="all" />
                    </TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD height="5"></TD>
    </TR>
    <TR>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD><SPAN id="spn_gridMessage"></SPAN></TD>
                    <TD align="right">
                        <BUTTON auto="retrieve" onClick="javascript:fnRetrieve();"></BUTTON>
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
            <ANY:GRID id="gr_ExtMasterList" pagingType="1"><COMMENT>
                addColumn({ width:110, align:"left"  , type:"string", sort:true , id:"REF_NO"               , name:"REF_NO" });
                addColumn({ width:110, align:"left"  , type:"string", sort:true , id:"APP_NO"               , name:"출원번호" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"APP_DATE"             , name:"출원일" });
                addColumn({ width:200, align:"left"  , type:"string", sort:true , id:"KO_APP_TITLE"         , name:"발명의 명칭" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"DUE_DATE"             , name:"법정기한일자" });
                addColumn({ width:140, align:"left"  , type:"string", sort:true , id:"STATUS_NAME"          , name:"진행상태" });
                addColumn({ width:75 , align:"left"  , type:"string", sort:true , id:"APP_EXT_MAN_CODE"     , name:"출원인" });
                addColumn({ width:110, align:"left"  , type:"string", sort:true , id:"REG_NO"               , name:"등록번호" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"REG_DATE"             , name:"등록일" });
                addColumn({ width:75 , align:"left"  , type:"string", sort:true , id:"COUNTRY_CODE_NAME"    , name:"국가" });
                addColumn({ width:110, align:"left"  , type:"string", sort:true , id:"INVENTOR_NAMES"       , name:"발명자" });
                addColumn({ width:110, align:"left"  , type:"string", sort:true , id:"EXT_OFFICE_NAME"      , name:"해외사무소" });
                addColumn({ width:110, align:"left"  , type:"string", sort:true , id:"OFFICE_NAME"          , name:"국내사무소" });
                addColumn({ width:75 , align:"center", type:"string", sort:true , id:"JOB_MAN_NAME"         , name:"건담당자" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"STATUS_DATE"          , name:"진행일" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"PJT_NAME"             , name:"대표PJ" });
                addColumn({ width:90 , align:"left"  , type:"string", sort:true , id:"DEPT_NAME"            , name:"부서" });
                addColumn({ width:110, align:"left"  , type:"string", sort:true , id:"FIRST_REF_NO"         , name:"국내REF_NO" });
                useConfig = false;
                messageSpan = "spn_gridMessage";
                setFixedColumn(null, "KO_APP_TITLE");
                addSorting("REF_NO", "DESC");
                addAction("KO_APP_TITLE", fnDetail);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>

