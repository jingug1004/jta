<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>프로그램 진행현황</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieve()
}

//목록 조회
function fnRetrieve()
{
    var ldr = gr_programRequestList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.program.request.act.RetrieveProgramRequestList.do";
    ldr.addParam("SEARCH_TYPE", SEARCH_TYPE.value);
    ldr.addParam("SEARCH_TEXT", SEARCH_TEXT.value);
    ldr.addParam("SEARCH_NO_ONLY", SEARCH_NO_ONLY.value);
    ldr.addParam("INV_TYPE", INV_TYPE.value);
    ldr.addParam("INV_TEXT", INV_TEXT.value);
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

//작성
function fnWrite()
{
    var win = new any.viewer();
    win.path = "ProgramRequestC.jsp";

    win.onReload = function()
    {
        gr_programRequestList.loader.reload();
    }

    win.show();
}

//상세
function fnGoView(gr, fg, row, colId)
{
    var win = new any.viewer();
    win.path = "ProgramRequestRD.jsp";
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
                    <COL class="condhead" width="10%">
                    <COL class="conddata" width="40%">
                    <COL class="condhead" width="10%">
                    <COL class="conddata" width="40%">
                </COLGROUP>
                <TR>
                    <TD>번호검색</TD>
                    <TD >
                        <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                            <TR>
                                <TD>
                                    <ANY:SELECT id="SEARCH_TYPE" codeData="/applymgt/programRequestListSearchNo" style="width:80px; margin-right:3px;" />
                                </TD>
                                <TD width="100%">
                                    <INPUT type="text" id="SEARCH_TEXT" style="text-transform:uppercase;">
                                </TD>
                                <TD noWrap>
                                    <ANY:CHECK id="SEARCH_NO_ONLY" text="번호만 검색" />
                                </TD>
                            </TR>
                        </TABLE>
                    </TD>
                    <TD>발명자</TD>
                    <TD>
                     <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                         <TR>
                            <TD>
                                <ANY:SELECT id="INV_TYPE" codeData="/applymgt/programRequestListSearchINVGubun" style="width:80px; margin-right:3px;" />
                            </TD>
                            <TD width="100%">
                                <INPUT type="text" id="INV_TEXT" style="text-transform:uppercase;">
                            </TD>
                         </TR>
                     </TABLE>
                  </TD>
                </TR>
                <TR>
                    <TD>검색일자</TD>
                    <TD noWrap colspan="3">
                        <ANY:SELECT id="DATE_GUBUN" codeData="/applymgt/programRequestListSearchDataType" firstName="none" style="width:80px; margin-right:3px;" />
                        <ANY:DATE id="DATE_START" disabled />&nbsp;~
                        <ANY:DATE id="DATE_END" disabled />
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
                        <BUTTON text="<%= app.message.get("btn.com.write").toHTML() %>" onClick="javascript:fnWrite();"></BUTTON>
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
            <ANY:GRID id="gr_programRequestList" pagingType="1"><COMMENT>
                addColumn({ width:110, align:"left"  , type:"string", sort:true, id:"REF_NO"           , name:"REF_NO" });
                addColumn({ width:200, align:"left"  , type:"string", sort:true, id:"PROG_TITLE"       , name:"프로그램명칭" });
                addColumn({ width:100, align:"center", type:"string", sort:true, id:"RIGHT_TYPE_NAME"  , name:"권리유형" });
                addColumn({ width:100, align:"center", type:"string", sort:true, id:"REGULAR_DIV_NAME" , name:"상용구분" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true, id:"CRE_DATE"         , name:"작성일" });
                addColumn({ width:110, align:"center", type:"string", sort:true, id:"CRE_USER_NAME"    , name:"작성자" });
                addColumn({ width:110, align:"left"  , type:"string", sort:true, id:"BIZ_STATUS_NAME"  , name:"진행상태" });

                useConfig = true;
                messageSpan = "spn_gridMessage";
                setFixedColumn(null, "PROG_TITLE");
                addSorting("REF_NO", "DESC");
                addAction("PROG_TITLE", fnGoView);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
