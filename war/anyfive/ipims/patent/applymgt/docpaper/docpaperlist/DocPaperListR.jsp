<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>진행서류현황</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();
    fnRetrievePaperCodeData();
}

//목록 조회
function fnRetrieve()
{
    var ldr = gr_docPaperList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.docpaper.docpaperlist.act.RetrieveDocPaperList.do";
    ldr.addParam("NO_GUBUN", NO_GUBUN.value);
    ldr.addParam("SR_NO_TEXT", SR_NO_TEXT.value);
    ldr.addParam("SR_NO_ONLY", SR_NO_ONLY.value);
    ldr.addParam("INOUT_DIV", INOUT_DIV.value);
    ldr.addParam("RIGHT_DIV" , RIGHT_DIV.value);
    ldr.addParam("OFFICE_CODE" , OFFICE_CODE.value);
    ldr.addParam("PAPER_CODE", PAPER_CODE.value);
    ldr.addParam("JOB_MAN" , JOB_MAN.value);
    ldr.addParam("INPUT_OWNER" , INPUT_OWNER.value);
    ldr.addParam("DATE_GUBUN", DATE_GUBUN.value);
    ldr.addParam("DATE_START" , DATE_START.value);
    ldr.addParam("DATE_END" , DATE_END.value);
    ldr.addParam("CHK_LAST" , CHK_LAST.value);
    ldr.addParam("CHK_NOREAD" , CHK_NOREAD.value);

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
function fnWrite(gr, fg, row, colId)
{
    fnMaster(gr, fg, row, colId);
}

//상세
function fnDetail(gr, fg, row, colId)
{
    fnMaster(gr, fg, row, colId, gr.value(row, "LIST_SEQ"));
}

//마스터 보기
function fnMaster(gr, fg, row, colId, listSeq)
{
    var win = new any.viewer();

    <% if (app.userInfo.isPatentTeam() == true) { %>
    switch (gr.value(row, "INOUT_DIV")) {
    case "INT":
        win.path = top.getRoot() + "/anyfive/ipims/patent/applymgt/common/IntMasterTabR.jsp?TAB=paper";
        break;
    case "EXT":
        win.path = top.getRoot() + "/anyfive/ipims/patent/applymgt/common/ExtMasterTabR.jsp?TAB=paper";
        break;
    }
    <% } else { %>
    win.path = top.getRoot() + "/anyfive/ipims/share/docpaper/docpaper/DocPaperM.jsp";
    <% } %>
    win.arg.REF_ID = gr.value(row, "REF_ID");
    win.arg.LIST_SEQ = listSeq;

    win.onReload = function()
    {
        gr.loader.reload();
    }

    win.show();
}

//진행서류 코드데이터 조회
function fnRetrievePaperCodeData()
{
    PAPER_CODE.codeData = "/common/paperCodeByPaperInoutDiv," + RIGHT_DIV.value + "," + INOUT_DIV.value;
}
</SCRIPT>

<!-- 서류구분 변경시 -->
<SCRIPT language="JScript" for="RIGHT_DIV" event="OnChange()">
    fnRetrievePaperCodeData();
</SCRIPT>

<!-- 국내외구분 변경시 -->
<SCRIPT language="JScript" for="INOUT_DIV" event="OnChange()">
    fnRetrievePaperCodeData();
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
                                    <ANY:SELECT id="NO_GUBUN" codeData="/applymgt/searchNoGubun" style="width:105px; margin-right:3px;" />
                                </TD>
                                <TD width="100%">
                                    <INPUT type="text" id="SR_NO_TEXT" style="text-transform:uppercase;">
                                </TD>
                                <TD noWrap>
                                    <ANY:CHECK id="SR_NO_ONLY" text="번호만 검색" />
                                </TD>
                            </TR>
                        </TABLE>
                    </TD>
                    <TD>국가/구분</TD>
                    <TD>
                        <TABLE border="0" cellspacing="0" cellpadding="1" width="100%">
                            <TR>
                                <TD width="50%">
                                    <ANY:SELECT id="INOUT_DIV" codeData="{INOUT_DIV}" firstName="all" />
                                </TD>
                                <TD width="50%">
                                    <ANY:SELECT id="RIGHT_DIV" codeData="{RIGHT_DIV}" firstName="all" />
                                </TD>
                            </TR>
                        </TABLE>
                    </TD>
                </TR>
                <TR>
                    <TD>사무소</TD>
                    <TD>
                        <ANY:SELECT id="OFFICE_CODE" codeData="/common/officeCode" firstName="all" />
                    </TD>
                    <TD>건담당자</TD>
                    <TD>
                        <ANY:SELECT id="JOB_MAN" codeData="/common/jobManAll" firstName="all" firstName="all" />
                    </TD>
                    <TD>진행서류</TD>
                    <TD>
                        <ANY:SELECT id="PAPER_CODE" firstName="all" />
                    </TD>
                </TR>
                <TR>
                    <TD>입력자구분</TD>
                    <TD>
                        <ANY:SELECT id="INPUT_OWNER" codeData="{DOC_INPUT_OWNER}" firstName="all" />
                    </TD>
                    <TD>검색일자</TD>
                    <TD colspan="3">
                        <TABLE border="0" cellspacing="0" cellpadding="1" width="100%">
                            <TR>
                                <TD noWrap>
                                    <ANY:SELECT id="DATE_GUBUN" codeData="/applymgt/paperSearchDateGubun" firstName="none" style="width:80px; margin-right:3px;" />
                                    <ANY:DATE id="DATE_START" disabled />&nbsp;~
                                    <ANY:DATE id="DATE_END" disabled />
                                </TD>
                                <TD noWrap align="right">
                                    <ANY:CHECK id="CHK_LAST" text="최후입력건조회" />
                                    <ANY:CHECK id="CHK_NOREAD" text="미확인건"  />
                                </TD>
                            </TR>
                        </TABLE>
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
            <ANY:GRID id="gr_docPaperList" pagingType="1"><COMMENT>
                addColumn({ width:110 , align:"left"   , type:"string" , sort:true , id:"REF_NO"             , name:"REF_NO" });
                addColumn({ width:110 , align:"left"   , type:"string" , sort:true , id:"APP_NO"             , name:"출원번호" });
                addColumn({ width:110 , align:"left"   , type:"string" , sort:true , id:"PAPER_NAME"         , name:"진행서류명" });
                addColumn({ width:100 , align:"left"   , type:"string" , sort:true , id:"COMMENTS"           , name:"기타사항" });
                addColumn({ width:140 , align:"left"   , type:"string" , sort:true , id:"KO_APP_TITLE"       , name:"발명의 명칭" });
                addColumn({ width:110 , align:"left"   , type:"string" , sort:true , id:"INVENTOR_NAMES"     , name:"발명자" });
                addColumn({ width:75  , align:"center" , type:"date"   , sort:true , id:"PAPER_DATE"         , name:"서류일자" });
                addColumn({ width:75  , align:"center" , type:"date"   , sort:true , id:"DUE_DATE"           , name:"법정기한" });
                addColumn({ width:110 , align:"left"   , type:"string" , sort:true , id:"OFFICE_CODE_NAME"   , name:"사무소" });
                addColumn({ width:75  , align:"center" , type:"string" , sort:true , id:"JOB_MAN_NAME"       , name:"건담당자" });
                addColumn({ width:110 , align:"left"   , type:"string" , sort:true , id:"STATUS_NAME"        , name:"진행상태" });
                useConfig = true;
                messageSpan = "spn_gridMessage";
                setFixedColumn(null, "PAPER_NAME");
                addSorting("PAPER_DATE", "DESC");
                addSorting("REF_NO", "DESC");
                addAction("REF_NO", fnWrite);
                addAction("PAPER_NAME", fnDetail);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>

