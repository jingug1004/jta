<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>연구소별 실적통계</TITLE>
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
    var ldr = gr_actualByLabList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.statistic.statistic.act.RetrieveActualByLab.do";
    ldr.addParam("SEARCH_GUBUN", parent.SEARCH_GUBUN);
    ldr.addParam("INOUT_DIV"   , parent.INOUT_DIV);
    ldr.addParam("DATE_START"  , parent.DATE_START);
    ldr.addParam("DATE_END"    , parent.DATE_END);
    ldr.addParam("LAB_CODE"    , parent.LAB_CODE);

    ldr.onSuccess = function(gr, fg)
    {
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

</SCRIPT>

</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
    <TR>
        <TD height="5"></TD>
    </TR>
    <TR>
        <TD>
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD><SPAN id="spn_gridMessage"></SPAN></TD>
                    <TD align="right"></TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD height="5"></TD>
    </TR>
    <TR>
        <TD height="100%">
            <ANY:GRID id="gr_actualByLabList" pagingType="1"><COMMENT>
                addColumn({ width:100, align:"left"  , type:"string" , sort:true , id:"REF_NO"            , name:"REF-NO" });
                addColumn({ width:110, align:"left"  , type:"string" , sort:true , id:"APP_NO"            , name:"출원번호" });
                addColumn({ width:200, align:"left"  , type:"string" , sort:true , id:"KO_APP_TITLE"      , name:"발명의 명칭" });
                addColumn({ width:75 , align:"center", type:"date"   , sort:true , id:"PATTEAM_RCPT_DATE" , name:"지적재산팀접수일" });
                addColumn({ width:75 , align:"center", type:"date"   , sort:true , id:"OFFICE_RCPT_DATE"  , name:"사무소접수일" });
                addColumn({ width:75 , align:"center", type:"date"   , sort:true , id:"APP_DATE"          , name:"출원일" });
                addColumn({ width:100, align:"left"  , type:"string" , sort:true , id:"REG_NO"            , name:"등록번호" });
                addColumn({ width:75 , align:"center", type:"date"   , sort:true , id:"REG_DATE"          , name:"등록일" });
                addColumn({ width:100, align:"left"  , type:"string" , sort:true , id:"OFFICE_NAME"       , name:"사무소" });
                addColumn({ width:60 , align:"center", type:"string" , sort:true , id:"JOB_MAN_NAME"      , name:"담당자" });
                addColumn({ width:100, align:"left"  , type:"string" , sort:true , id:"STATUS_NAME"       , name:"진행상태" });
                addColumn({ width:75 , align:"center", type:"date"   , sort:true , id:"STATUS_DATE"       , name:"서류일자" });
                addColumn({ width:100, align:"left"  , type:"string" , sort:true , id:"INVENTOR_NAMES"    , name:"발명자" });

                messageSpan = "spn_gridMessage";
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
