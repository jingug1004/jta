<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>감정서 현황</TITLE>
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
    var ldr = gr_expOpinionList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.ipbiz.expopin.act.RetrieveExpOpinionList.do";
    ldr.addParam("MGT_NO"       , MGT_NO.value);
    //ldr.addParam("EXPOPIN_CLS"  , EXPOPIN_CLS.value);
    ldr.addParam("COUNTRY_CODE" , COUNTRY_CODE.value);
    ldr.addParam("RIGHT_DIV"    , RIGHT_DIV.value);
    ldr.addParam("SEARCH_DATE"  , SEARCH_DATE.value);
    ldr.addParam("DATE_START"   , DATE_START.value);
    ldr.addParam("DATE_END"     , DATE_END.value);

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
    win.path = "ExpOpinionC.jsp";

    win.onReload = function()
    {
       gr.loader.reload();
    }

    win.show();
}

//상세
function fnOpenView(gr, fg, row, colId)
{
    var win = new any.viewer();
    win.path = "ExpOpinionUD.jsp";
    win.arg.EXPOPIN_ID = gr.value(row, "EXPOPIN_ID");

    win.onReload = function()
    {
       gr.loader.reload();
    }

    win.show();
}
</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
    <TR>
        <TD>
            <TABLE border="0" width="100%" cellspacing="1" cellpadding="2" class="main" width="100%" onEnter="javascript:fnRetrieve();">
                <COLGROUP>
                    <COL class="condhead" width="10%">
                    <COL class="conddata" width="30%">
                    <COL class="condhead" width="10%">
                    <COL class="conddata" width="20%">
                    <COL class="condhead" width="10%">
                    <COL class="conddata" width="20%">
                </COLGROUP>
                <TR>
                    <TD>관리번호</TD>
                    <TD>
                        <INPUT type="text" id="MGT_NO" maxByte="12">
                    </TD>
                    <TD>감정의 분류</TD>
                    <TD style="padding-left:2px;">

                    </TD>
                    <TD>국가</TD>
                    <TD>
                        <ANY:SELECT id="COUNTRY_CODE" codeData="/common/countryCode" firstName="all" />
                    </TD>
                </TR>
                <TR>

                    <TD>권리구분</TD>
                    <TD style="padding-left:2px;">
                        <ANY:SELECT id="RIGHT_DIV" codeData="{RIGHT_DIV}" firstName="all" />
                    </TD>
                    <TD>검색일자</TD>
                    <TD colspan="3" style="padding-left:2px;" noWrap>
                        <ANY:SELECT id="SEARCH_DATE" codeData="/ipbiz/expOpinionSearchDateType" style="width:100px; margin-right:3px;"/>
                        <ANY:DATE id="DATE_START" />&nbsp;~
                        <ANY:DATE id="DATE_END" />
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
            <ANY:GRID id="gr_expOpinionList" pagingType="1"><COMMENT>
                addColumn({ width:50 , align:"center", type:"number" , sort:false, id:"ROW_NUM"         , name:"<%= app.message.get("lbl.com.no").toJS() %>" });
                addColumn({ width:90 , align:"left"  , type:"string" , sort:true , id:"MGT_NO"          , name:"관리번호"   });
                addColumn({ width:180, align:"left"  , type:"string" , sort:true , id:"EXPOPIN_FEATURE" , name:"감정의 특징" });
                addColumn({ width:70 , align:"center", type:"string" , sort:true , id:"RIGHT_DIV_NAME"  , name:"권리구분"   });
                addColumn({ width:80 , align:"center", type:"string" , sort:true , id:"COUNTRY_NAME"    , name:"국가"       });
                addColumn({ width:100, align:"center", type:"string" , sort:true , id:"REQ_MAN"         , name:"의뢰인"     });
                addColumn({ width:100, align:"left"  , type:"string" , sort:true , id:"EXPOPIN_ORGAN"   , name:"감정 기관"   });
                addColumn({ width:100, align:"center", type:"string" , sort:true , id:"EXPOPIN_MAN"     , name:"감정인"     });
                addColumn({ width:80 , align:"center", type:"string" , sort:true , id:"EXPOPIN_CLS"     , name:"감정의 분류" });
                addColumn({ width:75 , align:"center", type:"date"   , sort:true , id:"EXPOPIN_DATE"    , name:"감정일"     });
                addColumn({ width:75 , align:"center", type:"date"   , sort:true , id:"CRE_DATE"        , name:"작성일"     });
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_NUM", "MGT_NO");
                addSorting("MGT_NO", "ASC");
                addAction("MGT_NO", fnOpenView);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
