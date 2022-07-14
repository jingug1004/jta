<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>국내출원</TITLE>
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
    var ldr = gr_intPatentMasterList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.intpatent.master.act.RetrieveIntPatentMasterList.do";
    ldr.addParam("SEARCH_TYPE", SEARCH_TYPE.value);
    ldr.addParam("SEARCH_TEXT", SEARCH_TEXT.value);
    ldr.addParam("SEARCH_NO_ONLY", SEARCH_NO_ONLY.value);
    ldr.addParam("OFFICE_CODE", OFFICE_CODE.value);
    ldr.addParam("KO_APP_TITLE", KO_APP_TITLE.value);
    ldr.addParam("RES_STATUS", RES_STATUS.value);
    ldr.addParam("PA_GUBUN", PA_GUBUN.value);
    ldr.addParam("DATE_GUBUN", DATE_GUBUN.value);
    ldr.addParam("DATE_START", DATE_START.value);
    ldr.addParam("DATE_END", DATE_END.value);
    ldr.addParam("JOB_MAN", JOB_MAN.value);
    ldr.addParam("CLEVEL", CLEVEL.value);

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
    win.path = "IntPatentMasterC.jsp";

    win.onReload = function()
    {
        gr_intPatentMasterList.loader.reload();
    }

    win.show();
}

//상세
function fnDetail(gr, fg, row, colId)
{
    var win = new any.viewer();
    win.path = top.getRoot() + "/anyfive/ipims/patent/applymgt/common/IntMasterTabR.jsp?TAB=paper";
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
                    <TD colspan="3">
                        <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                            <TR>
                                <TD>
                                    <ANY:SELECT id="SEARCH_TYPE" codeData="/applymgt/intPatentMasterSearchType" style="width:80px; margin-right:3px;" />
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
                    <TD>사무소</TD>
                    <TD>
                        <ANY:SELECT id="OFFICE_CODE" codeData="/common/intOfficeCode" firstName="all" />
                    </TD>
                </TR>
                <TR>
                    <TD>발명의 명칭</TD>
                    <TD colspan="3">
                        <INPUT type="text" id="KO_APP_TITLE">
                    </TD>
                    <TD>진행상태</TD>
                    <TD>
                        <ANY:SELECT id="RES_STATUS" codeData="/applymgt/masterStatus,10,INT" firstName="all" />
                    </TD>
                </TR>
                <TR>
                    <TD>권리구분</TD>
                    <TD>
                        <ANY:SELECT id="PA_GUBUN" codeData="{RIGHT_DIV_PAT}" firstName="all" />
                    </TD>
                    <TD>건담당자</TD>
                    <TD>
                        <ANY:SELECT id="JOB_MAN" codeData="/common/jobMan,PAT" firstName="all" />
                    </TD>
                    <TD>평가등급</TD>
                    <TD>
                        <ANY:SELECT id="CLEVEL" codeData="{INV_GRADE}" firstName="all" />
                    </TD>
                </TR>
                <TR>
                    <TD>검색일자</TD>
                    <TD colspan="5" noWrap>
                        <ANY:SELECT id="DATE_GUBUN" codeData="/applymgt/intPatentMasterSearchDateType" firstName="none" style="width:80px; margin-right:3px;" />
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
            <ANY:GRID id="gr_intPatentMasterList" pagingType="1"><COMMENT>
                addColumn({ width:100, align:"left"  , type:"string" , sort:true , id:"REF_NO"              , name:"REF-NO" });
                addColumn({ width:100, align:"left"  , type:"string" , sort:true , id:"APP_NO"              , name:"출원번호" });
                addColumn({ width:75 , align:"center", type:"date"   , sort:true , id:"APP_DATE"            , name:"출원일" });
                addColumn({ width:200, align:"left"  , type:"string" , sort:true , id:"KO_APP_TITLE"        , name:"발명의 명칭" });
                addColumn({ width:75 , align:"center", type:"date"   , sort:true , id:"DUE_DATE"         , name:"법정기한일자" });
                addColumn({ width:100, align:"left"  , type:"string" , sort:true , id:"STATUS_NAME"         , name:"진행상태" });
                addColumn({ width:75 , align:"left"  , type:"string" , sort:true , id:"APP_EXT_MAN_CODE"    , name:"출원인" });
                addColumn({ width:100, align:"left"  , type:"string" , sort:true , id:"REG_NO"              , name:"등록번호" });
                addColumn({ width:75 , align:"center", type:"date"   , sort:true , id:"REG_DATE"            , name:"등록일" });
                addColumn({ width:75 , align:"center", type:"date"   , sort:true , id:"PATTEAM_RCPT_DATE"   , name:"지적재산팀접수일" });
                addColumn({ width:75 , align:"center", type:"date"   , sort:true , id:"OFFICE_RCPT_DATE"    , name:"사무소접수일" });
                addColumn({ width:100, align:"left"  , type:"string" , sort:true , id:"INVENTOR_NAMES"      , name:"발명자" });
                addColumn({ width:100, align:"left"  , type:"string" , sort:true , id:"OFFICE_NAME"         , name:"사무소" });
                addColumn({ width:75 , align:"center", type:"string" , sort:true , id:"JOB_MAN_NAME"        , name:"담당자" });
                addColumn({ width:75 , align:"center", type:"string" , sort:true , id:"ABSTRACT"              , name:"초록" });
                addColumn({ width:100, align:"left"  , type:"string" , sort:true , id:"PJT_NAME"            , name:"대표PJ" });
                addColumn({ width:100, align:"left"  , type:"string" , sort:true , id:"DEPT_NAME"           , name:"부서" });
                addColumn({ width:75 , align:"left"  , type:"string" , sort:true , id:"EXT_APP_NEED_YN_NAME", name:"해외출원필요성" });
                addColumn({ width:75 , align:"center", type:"string" , sort:true , id:"KEY_PAT_YN_NAME"     , name:"핵심여부" });
                addColumn({ width:75 , align:"center", type:"string" , sort:true , id:"DISPUTE_PAT_YN_NAME" , name:"분쟁여부" });
                addColumn({ width:75 , align:"center", type:"date"   , sort:true , id:"STATUS_DATE"         , name:"서류일자" });
                useConfig = false;
                messageSpan = "spn_gridMessage";
                setFixedColumn(null, "KO_APP_TITLE");
                addSorting("PATTEAM_RCPT_DATE", "DESC");
                addSorting("REF_NO", "DESC");
                addAction("KO_APP_TITLE", fnDetail);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
