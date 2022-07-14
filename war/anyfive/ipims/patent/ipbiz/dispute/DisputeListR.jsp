<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE></TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<%
   String disputeDiv = request.getParameter("disputeDiv");
%>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();
    if("<%=disputeDiv%>" == "O"){
        cfSetPageTitle("분쟁/소송 현황");
    } else {
        cfSetPageTitle("분쟁/소송 현황");
    }

}

//목록 조회
function fnRetrieve()
{
    var ldr = gr_disputeList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.ipbiz.dispute.act.RetrieveDisputeList.do";
    ldr.addParam("DISPUTE_DIV"    , "<%=disputeDiv%>");
    ldr.addParam("SEARCH_TYPE"    , SEARCH_TYPE.value);
    ldr.addParam("SEARCH_TEXT"    , SEARCH_TEXT.value);
    ldr.addParam("DISPUTE_KIND"   , DISPUTE_KIND.value);
    ldr.addParam("DISPUTE_SUBJECT", DISPUTE_SUBJECT.value);
    ldr.addParam("OTHER_KIND"     , OTHER_KIND.value);
    ldr.addParam("OTHER_TEXT"     , OTHER_TEXT.value);
    ldr.addParam("DATE_GUBUN"     , DATE_GUBUN.value);
    ldr.addParam("DATE_START"     , DATE_START.value);
    ldr.addParam("DATE_END"       , DATE_END.value);

    ldr.onSuccess = function(gr, fg)
    {
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

//작성
function fnOpenCreate()
{
    var win = new any.viewer();
    if("<%=disputeDiv%>" == "O"){
        win.path = "DisputeOffenseC.jsp";
    } else {
        win.path = "DisputeDefenseC.jsp";
    }

    win.onReload = function()
    {
        gr_disputeList.loader.reload();
    }

    win.show();
}

//상세
function fnOpenView(gr, fg, row, colId)
{
    var win = new any.viewer();
    if("<%=disputeDiv%>" == "O"){
        win.path = "DisputeOffenseRD.jsp";
    } else {
        win.path = "DisputeDefenseRD.jsp";
    }
    win.arg.DISPUTE_ID = gr.value(row, "DISPUTE_ID");

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
            <TABLE border="0" width="100%" cellspacing="1" cellpadding="2" class="main" width="100%" onEnter="javascript:fnRetrieve();">
                <COLGROUP>
                    <COL class="condhead" width="15%">
                    <COL class="conddata" width="35%">
                    <COL class="condhead" width="15%">
                    <COL class="conddata" width="35%">
                </COLGROUP>
                <TR>
                    <TD>검색번호</TD>
                    <TD>
                        <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                            <TR>
                                <TD>
                                    <ANY:SELECT id="SEARCH_TYPE" codeData="/ipbiz/disputePaperSearchNumKind" style="width:80px; margin-right:3px;" />
                                </TD>
                                <TD width="100%">
                                    <INPUT type="text" id="SEARCH_TEXT" style="text-transform:uppercase;">
                                </TD>
                            </TR>
                        </TABLE>
                    </TD>
                    <TD>분쟁(소송)종류</TD>
                    <TD>
                        <ANY:SELECT id="DISPUTE_KIND" codeData="{DISPUTE_KIND}" firstName="sel" />
                    </TD>
                </TR>
                <TR>
                    <TD>분쟁제목</TD>
                    <TD>
                        <INPUT type="text" id="DISPUTE_SUBJECT" />
                    </TD>
                    <TD>기타 정보</TD>
                    <TD>
                        <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                            <TR>
                                <TD>
                                    <ANY:SELECT id="OTHER_KIND" codeData="/ipbiz/disputeOtherSearch" style="width:90px; margin-right:3px;" />
                                </TD>
                                <TD width="100%">
                                    <INPUT type="text" id="OTHER_TEXT" />
                                </TD>
                            </TR>
                        </TABLE>
                    </TD>
                </TR>
                <TR>
                    <TD>검색일자</TD>
                    <TD noWrap colspan="3">
                        <ANY:SELECT id="DATE_GUBUN" codeData="/ipbiz/disputeSearchDate" firstName="none" style="width:80px; margin-right:3px;" />
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
                        <BUTTON auto="line"></BUTTON>
                        <BUTTON text="<%= app.message.get("btn.com.write").toHTML() %>" onClick="javascript:fnOpenCreate();"></BUTTON>
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
            <ANY:GRID id="gr_disputeList" pagingType="1"><COMMENT>
                addColumn({ width:50 , align:"center", type:"number", sort:false, id:"ROW_NUM"              , name:"<%= app.message.get("lbl.com.no").toJS() %>" });
                addColumn({ width:90 , align:"left"  , type:"string", sort:true , id:"MGT_NO"               , name:"관리번호"   });
                addColumn({ width:90 , align:"left"  , type:"string", sort:true , id:"DISPUTE_NO"           , name:"분쟁번호" });
                addColumn({ width:70 , align:"left"  , type:"string", sort:true , id:"COUNTRY_NAME"         , name:"국가"   });
                addColumn({ width:150, align:"left"  , type:"string", sort:true , id:"DISPUTE_SUBJECT"      , name:"분쟁제목"       });
                addColumn({ width:90 , align:"left"  , type:"string", sort:true , id:"OTHER_NAME"           , name:"상대명(회사)"     });
                addColumn({ width:120, align:"left"  , type:"string", sort:true , id:"DISPUTE_KIND_NAME"    , name:"분쟁종류"   });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"REQ_DATE"             , name:"청구일"     });
                addColumn({ width:90 , align:"left"  , type:"string", sort:true , id:"OFFICE_NAME"          , name:"당사사무소" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"LAST_DISPOSAL_DATE"   , name:"최종처분일"     });
                addColumn({ width:60 , align:"center", type:"string", sort:true , id:"LAST_RESULT_NAME"     , name:"최종처분결과"     });
                addColumn({ width:90 , align:"left"  , type:"string", sort:true , id:"JUDGE_MAN"            , name:"심판관"     });
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_NUM", "DISPUTE_SUBJECT");
                addSorting("MGT_NO", "DESC");
                addAction("MGT_NO", fnOpenView);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
