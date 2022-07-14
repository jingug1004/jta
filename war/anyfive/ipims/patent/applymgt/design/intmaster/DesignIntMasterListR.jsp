<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>디자인국내출원</TITLE>
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
    var ldr = gr_designIntMasterList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.design.intmaster.act.RetrieveDesignIntMasterList.do";
    ldr.addParam("SR_NO_GUBUN", SR_NO_GUBUN.value);
    ldr.addParam("SR_NO", SR_NO.value);
    ldr.addParam("SR_NO_ONLY", SR_NO_ONLY.value);
    ldr.addParam("SR_JOB_MAN", SR_JOB_MAN.value);
    ldr.addParam("SR_FIRM_CODE", SR_FIRM_CODE.value);
    ldr.addParam("SR_STATUS", SR_STATUS.value);
    ldr.addParam("SR_DATE_CODE", SR_DATE_CODE.value);
    ldr.addParam("SR_SDATE", SR_SDATE.value);
    ldr.addParam("SR_EDATE", SR_EDATE.value);

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
    win.path = "DesignIntMasterC.jsp";

    win.onReload = function()
    {
        gr_designIntMasterList.loader.reload();
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
<SCRIPT language="JScript" for="SR_DATE_CODE" event="OnChange()">
    SR_SDATE.disabled = (this.value == "");
    SR_EDATE.disabled = (this.value == "");
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
                    <COL class="conddata" width="30%">
                    <COL class="condhead" width="10%">
                    <COL class="conddata" width="20%">
                    <COL class="condhead" width="10%">
                    <COL class="conddata" width="20%">
                </COLGROUP>
                <TR>
                    <TD>검색번호</TD>
                    <TD colspan="3">
                        <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                            <TR>
                                <TD>
                                    <ANY:SELECT id="SR_NO_GUBUN" codeData="/applymgt/designMasterSearchType" style="width:105px; margin-right:3px;" />
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
                    <TD>사무소</TD>
                    <TD>
                        <ANY:SELECT id="SR_FIRM_CODE" codeData="/common/officeCode" firstName="all" />
                    </TD>
                </TR>
                <TR>
                    <TD>검색일자</TD>
                    <TD noWrap>
                        <ANY:SELECT id="SR_DATE_CODE" codeData="/applymgt/designMasterSearchDateType" firstName="none" style="width:105px; margin-right:3px;"/>
                        <ANY:DATE id="SR_SDATE" disabled />&nbsp;~
                        <ANY:DATE id="SR_EDATE" disabled />
                    </TD>
                    <TD>건담당자</TD>
                    <TD>
                        <ANY:SELECT id="SR_JOB_MAN" codeData="/common/jobMan,DES" firstName="all" value="<%= app.userInfo.getUserId() %>" />
                    </TD>
                    <TD>진행상태</TD>
                    <TD>
                        <ANY:SELECT id="SR_STATUS" codeData="/applymgt/masterStatus,30,INT" firstName="all" />
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
                        <BUTTON text="<%= app.message.get("btn.com.retrieve").toHTML() %>" color="1" onClick="javascript:fnRetrieve();"></BUTTON>
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
            <ANY:GRID id="gr_designIntMasterList" pagingType="1"><COMMENT>
                addColumn({ width:120, align:"left"  , type:"string", sort:true , id:"REF_NO"               , name:"REF-NO" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"APP_NO"               , name:"출원번호" });
                addColumn({ width:200, align:"left"  , type:"string", sort:true , id:"KO_APP_TITLE"         , name:"디자인명" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"PATTEAM_RCPT_DATE"    , name:"특허팀접수일" });
                addColumn({ width:75 , align:"center", type:"date", sort:true , id:"OFFICE_RCPT_DATE"     , name:"사무소접수일" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"APP_DATE"             , name:"출원일" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"STATUS_NAME"          , name:"진행상태" });
                addColumn({ width:100 , align:"center", type:"date"  , sort:true , id:"APP_EXT_MAN_CODE"    , name:"출원인" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"REG_NO"               , name:"등록번호" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"REG_DATE"             , name:"등록일" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"FIRM_HNAME"           , name:"사무소" });
                addColumn({ width:75 , align:"center", type:"string", sort:true , id:"JOB_MAN_NAME"         , name:"담당자" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"STATUS_DATE"          , name:"서류일자" });
                addColumn({ width:100, align:"left"  , type:"string", sort:true , id:"INVENTOR_NAMES"       , name:"발명자" });
                addColumn({ width:100, align:"left"  , type:"string" , sort:true , id:"DEPT_NAME"           , name:"부서" });
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
