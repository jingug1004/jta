<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>분석자료현황</TITLE>
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

    var ldr = gr_analyDocList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.rivalpat.analysis.act.RetrieveRivalPatAnalysisDocList.do";
    ldr.addParam("SEARCH_TYPE", SEARCH_TYPE.value);//검색번호구분
    ldr.addParam("SEARCH_TEXT", SEARCH_TEXT.value);//검색번호
    ldr.addParam("SR_NO_ONLY", SR_NO_ONLY.value);//번호만구분
    ldr.addParam("ONLY", ONLY.value);//자회만 구분
    ldr.addParam("OUR_RIGHT", OUR_RIGHT.value);//권리구분
    ldr.addParam("AN_TITLE", AN_TITLE.value);//분석자료명
    ldr.addParam("THEM_NAME", THEM_NAME.value);//경쟁사명
    ldr.addParam("DATE_GUBUN", DATE_GUBUN.value);//검색일자구분
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

//작성
function fnWrite()
{
    var win = new any.viewer();
    win.path = "RivalPatAnalysisDocC.jsp";

    win.onReload = function()
    {
        //gr_programRequestList.loader.reload();
    }

    win.show();
}

//상세
function fnDetail(gr, fg, row, colId)
{
    var win = new any.viewer();
    win.path = top.getRoot() + "/anyfive/ipims/patent/rivalpat/analysis/RivalPatAnalysisDocR.jsp";

    win.arg.ANALY_ID = gr.value(row, "ANALY_ID");

    win.onReload = function()
    {
        gr.loader.reload();
    }

    win.show();
}

function fnOurAppNo(gr, fg, row, colId)
{
    var addr = gr.value(row,"OUR_APPNO");
    window.open("http://192.168.1.17:8081/fullText.do?execute=fullTextCheckPT&applno="+addr+"" );
}

function fnThemAppNo(gr, fg, row, colId)
{
    var addr = gr.value(row,"THEM_APPNO");
    window.open("http://192.168.1.17:8081/fullText.do?execute=fullTextCheckPT&applno="+addr+"" );
}
</SCRIPT>

<!-- 검색일자 구분 변경시 -->
<SCRIPT language="JScript" for="DATE_KIND" event="OnChange()">
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
                                    <ANY:SELECT id="SEARCH_TYPE" codeData="/rivalpat/PaperSearchNumKind" style="width:80px; margin-right:3px;" />
                                </TD>
                                <TD width="100%">
                                    <INPUT type="text" id="SEARCH_TEXT" style="text-transform:uppercase;">
                                </TD>
                                <TD noWrap>
                                    <ANY:CHECK id="SR_NO_ONLY" text="번호만 검색" />
                                </TD>
                            </TR>
                        </TABLE>
                    </TD>
                    <TD>권리구분</TD>
                    <TD>
                        <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                            <TR>
                                <TD>
                                    <ANY:SELECT id="OUR_RIGHT" codeData="/common/ourRight" firstName="all"  style="width:150"; margin-right;1px"/>
                                </TD>
                                <TD nwWrap>
                                    <ANY:CHECK id="ONLY" text="자회사정보조회" />
                                </TD>
                        </TABLE>
                   </TD>
                </TR>
                <TR>
                    <TD>분석자료명</TD>
                    <TD>
                        <INPUT type="text" id="AN_TITLE" />
                    </TD>
                    <TD>경쟁사명</TD>
                    <TD>
                        <INPUT type="text" id="THEM_NAME" />
                    </TD>
                </TR>
                <TR>
                    <TD>검색일자</TD>
                    <TD noWrap colspan="3">
                        <ANY:SELECT id="DATE_GUBUN" codeData="/rivalpat/dateKind" firstName="none" style="width:80px; margin-right:3px;" />
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
                        <BUTTON text="작성" onClick="javascript:fnWrite();"></BUTTON>
                        <BUTTON auto="line"></BUTTON>
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
            <ANY:GRID id="gr_analyDocList" pagingType="1"><COMMENT>
                addHeader([ null, null, null, null, "자사정보", "","", "경쟁사정보","","",null,null ]);
                addColumn({ width:120, align:"left"  , type:"string", sort:true , id:"MNG_NO"          , name:"관리번호" });
                addColumn({ width:120, align:"left"  , type:"string", sort:true , id:"AN_TITLE"        , name:"분석자료명" });
                addColumn({ width:120, align:"left"  , type:"string", sort:true , id:"RIGHT_DIV_NAME"  , name:"권리구분" });
                addColumn({ width:120, align:"left"  , type:"string", sort:true , id:"THEM_NAME"       , name:"경쟁사" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"OUR_APPNO"       , name:"출원번호" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"OUR_REGNO"       , name:"등록번호" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"OUR_PUBNO"       , name:"공개번호" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"THEM_APPNO"       , name:"출원번호" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"THEM_REGNO"       , name:"등록번호" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"THEM_PUBNO"       , name:"공개번호" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"CRE_USER_NAME"        , name:"작성자" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"CRE_DATE"        , name:"작성일" });
                //useConfig = true;
                //messageSpan = "spn_gridMessage";
                setFixedColumn(null, "AN_TITLE");
                addSorting("MNG_NO", "DESC");
                addAction("AN_TITLE", fnDetail);
                addAction("OUR_APPNO", fnOurAppNo);
                addAction("THEM_APPNO", fnThemAppNo);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
