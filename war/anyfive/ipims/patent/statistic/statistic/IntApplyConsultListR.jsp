<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>국내출원 품의대장</TITLE>
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
    var ldr = gr_intApplyConsultList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.statistic.statistic.act.RetrieveIntApplyConsultList.do";
    ldr.addParam("NO_GUBUN", NO_GUBUN.value);
    ldr.addParam("SR_NO", SR_NO.value);
    ldr.addParam("SR_NO_ONLY", SR_NO_ONLY.value);
    ldr.addParam("JOB_MAN", JOB_MAN.value);
    ldr.addParam("DATE_GUBUN", DATE_GUBUN.value);
    ldr.addParam("DATE_START", DATE_START.value);
    ldr.addParam("DATE_END", DATE_END.value);

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
    switch (gr.value(row, "RIGHT_DIV")) {
    case "10":
    case "20":
        win.path = top.getRoot() + "/anyfive/ipims/patent/applymgt/intpatent/consult/IntPatentConsultRD.jsp";
        break;
    case "30":
        win.path = top.getRoot() + "/anyfive/ipims/patent/applymgt/design/intconsult/DesignIntConsultRD.jsp";
        break;
    case "40":
        win.path = top.getRoot() + "/anyfive/ipims/patent/applymgt/tmark/intconsult/TMarkIntConsultRD.jsp";
        break;
    }
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
                                    <ANY:SELECT id="NO_GUBUN" codeData="/applymgt/inNewConsultNoGubun" value="REF_NO" style="width:105px; margin-right:3px;"/>
                                </TD>
                                <TD width="100%">
                                    <INPUT type="text" id="SR_NO" style="text-transform:uppercase;">
                                </TD>
                                <TD noWrap>
                                    <ANY:CHECK id="SR_NO_ONLY" text="번호만 검색" />
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
                        <ANY:SELECT id="DATE_GUBUN" codeData="/applymgt/statisticIntPatentDateGubun" firstName="none" style="width:105px; margin-right:3px;"/>
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
            <ANY:GRID id="gr_intApplyConsultList" pagingType="1"><COMMENT>
                addColumn({ width:100, align:"left"    , type:"string" , sort:true , id:"REF_NO"            , name:"REF-NO" });
                addColumn({ width:75 , align:"center"  , type:"string" , sort:true , id:"JOB_MAN_NAME"      , name:"건담당자" });
                addColumn({ width:110, align:"left"    , type:"string" , sort:true , id:"OFFICE_NAME"       , name:"사무소" });
                addColumn({ width:75 , align:"center"  , type:"date"   , sort:true , id:"PATTEAM_RCPT_DATE" , name:"특허팀접수일" });
                addColumn({ width:75 , align:"center"  , type:"date"   , sort:true , id:"OFFICE_SEND_DATE"  , name:"사무소위임일" });
                addColumn({ width:75 , align:"center"  , type:"date"   , sort:true , id:"DATE_1"            , name:"보완요청일" });
                addColumn({ width:75 , align:"center"  , type:"date"   , sort:true , id:"OFFICE_RCPT_DATE"  , name:"사무소접수일" });
                addColumn({ width:75 , align:"center"  , type:"date"   , sort:true , id:"DATE_2"            , name:"초안접수일" });
                addColumn({ width:75 , align:"center"  , type:"date"   , sort:true , id:"DATE_3"            , name:"수정안접수일" });
                addColumn({ width:75 , align:"center"  , type:"date"   , sort:true , id:"DATE_4"            , name:"출원지시일" });
                addColumn({ width:75 , align:"center"  , type:"date"   , sort:true , id:"APP_DATE"          , name:"출원일" });
                addColumn({ width:75 , align:"center"  , type:"date"   , sort:true , id:"DATE_5"            , name:"위임철회일" });
                addColumn({ width:100, align:"left"    , type:"string" , sort:true , id:"INVENTOR_NAMES"    , name:"발명자명" });
                addColumn({ width:50 , align:"center"  , type:"string" , sort:true , id:"INV_GRADE"         , name:"등급" });
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
