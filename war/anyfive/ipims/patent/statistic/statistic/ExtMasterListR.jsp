<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>해외출원관리대장</TITLE>
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
    var ldr = gr_intMasterList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.statistic.statistic.act.RetrieveExtMasterList.do";
    ldr.addParam("SR_GUBUN"   , SR_GUBUN.value);
    ldr.addParam("SR_NO"      , SR_NO.value);
    ldr.addParam("JOB_MAN"    , JOB_MAN.value);
    ldr.addParam("DATE_GUBUN" , DATE_GUBUN.value);
    ldr.addParam("DATE_START" , DATE_START.value);
    ldr.addParam("DATE_END"   , DATE_END.value);

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
    win.path = top.getRoot() + "/anyfive/ipims/patent/applymgt/common/ExtMasterTabR.jsp";
    win.arg.REF_ID = gr.value(row, "REF_ID");

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
                    <COL class="condhead" width="15%">
                    <COL class="conddata" width="35%">
                    <COL class="condhead" width="15%">
                    <COL class="conddata" width="35%">
                </COLGROUP>
                <TR>
                    <TD>번호검색</TD>
                    <TD>
                        <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                            <TR>
                                <TD>
                                    <ANY:SELECT id="SR_GUBUN" codeData="/applymgt/inNewConsultNoGubun" style="width:80px; margin-right:3px;"/>
                                </TD>
                                <TD width="100%">
                                    <INPUT type="text" id="SR_NO" style="text-transform:uppercase;">
                                </TD>
                            </TR>
                        </TABLE>
                    </TD>
                    <TD>건담당자</TD>
                    <TD>
                        <ANY:SELECT id="JOB_MAN" codeData="/common/jobMan,PAT" firstName="all" />
                    </TD>
                </TR>
                <TR>
                    <TD>검색일</TD>
                    <TD colspan="3" noWrap>
                        <ANY:SELECT id="DATE_GUBUN" codeData="/applymgt/statisticExtPatentSearchDateKind" firstName="none" style="width:105px; margin-right:3px;"/>
                        <ANY:DATE id="DATE_START" disabled />&nbsp;~
                        <ANY:DATE id="DATE_END" disabled />
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
            <ANY:GRID id="gr_intMasterList" pagingType="1"><COMMENT>
                addColumn({ width:120, align:"left"    , type:"string" , sort:true , id:"REF_NO"           , name:"REF-NO" });
                addColumn({ width:150, align:"left"    , type:"string" , sort:true , id:"KO_APP_TITLE"     , name:"출원의명칭" });
                addColumn({ width:100, align:"left"    , type:"string" , sort:true , id:"INVENTOR_NAMES"   , name:"발명자" });
                addColumn({ width:70 , align:"center"  , type:"string" , sort:true , id:"JOB_MAN_NAME"     , name:"건담당자" });
                addColumn({ width:75 , align:"center"  , type:"string" , sort:true , id:"COUNTRY_NAME"     , name:"국가" });
                addColumn({ width:100, align:"left"    , type:"string" , sort:true , id:"OFFICE_NAME"      , name:"국내사무소" });
                addColumn({ width:100, align:"left"    , type:"string" , sort:true , id:"EXT_OFFICE_NAME"  , name:"해외사무소" });
                addColumn({ width:100, align:"center"  , type:"string" , sort:true , id:"REG_NO"           , name:"등록번호" });
                addColumn({ width:75 , align:"center"  , type:"string" , sort:true , id:"REG_DATE"         , name:"등록일" });
                addColumn({ width:100, align:"center"  , type:"string" , sort:true , id:"APP_NO"           , name:"출원번호" });
                addColumn({ width:75 , align:"center"  , type:"string" , sort:true , id:"APP_DATE"         , name:"출원일" });
                addColumn({ width:75 , align:"center"  , type:"string" , sort:true , id:"EXAMREG_YN_NAME"  , name:"심사청구" });
                addColumn({ width:120, align:"left"    , type:"string" , sort:true , id:"STATUS_NAME"      , name:"진행상태" });
                useConfig = true;
                messageSpan = "spn_gridMessage";
                setFixedColumn(null, "REF_NO");
                addSorting("REF_NO", "DESC");
                addAction("REF_NO", fnDetail);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
