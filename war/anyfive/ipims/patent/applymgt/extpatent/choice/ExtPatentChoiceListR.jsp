<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>해외출원품의대상</TITLE>
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
    var ldr = gr_extApplyList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.extpatent.choice.act.RetrieveExtPatentChoiceList.do";
    ldr.addParam("NO_GUBUN", NO_GUBUN.value);
    ldr.addParam("SR_NO", SR_NO.value);
    ldr.addParam("SR_NO_ONLY", SR_NO_ONLY.value);
    ldr.addParam("RIGHT_DIV", RIGHT_DIV.value);
    ldr.addParam("OFFICE_CODE", OFFICE_CODE.value);
    ldr.addParam("JOB_MAN", JOB_MAN.value);
    ldr.addParam("EXT_APP_STATUS", EXT_APP_STATUS.value);
    ldr.addParam("EXT_APP_LIMIT", EXT_APP_LIMIT.value);
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
    win.path = top.getRoot() + "/anyfive/ipims/patent/applymgt/common/IntMasterTabR.jsp";
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
                                    <ANY:SELECT id="NO_GUBUN" codeData="/applymgt/inNewConsultNoGubun" style="width:80px; margin-right:3px;" />
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
                    <TD>권리구분</TD>
                    <TD noWrap>
                        <ANY:SELECT id="RIGHT_DIV" codeData="{RIGHT_DIV_PAT}" firstName="all" />
                    </TD>
                </TR>
                <TR>
                    <TD>사무소</TD>
                    <TD>
                        <ANY:SELECT id="OFFICE_CODE" codeData="/common/intOfficeCode" firstName="all" />
                    </TD>
                    <TD>건담당자</TD>
                    <TD>
                        <ANY:SELECT id="JOB_MAN" codeData="/common/jobMan,PAT" firstName="all" />
                    </TD>
                    <TD>해외품의상태</TD>
                    <TD>
                        <ANY:SELECT id="EXT_APP_STATUS" codeData="{EXT_APP_STATUS}" firstName="all" />
                    </TD>
                </TR>
                <TR>
                    <TD>출원기한</TD>
                    <TD>
                        <ANY:SELECT id="EXT_APP_LIMIT" codeData="/applymgt/extApplySearchLimit" firstName="all" />
                    </TD>
                    <TD>검색일자</TD>
                    <TD colspan="3" noWrap>
                        <ANY:SELECT id="DATE_GUBUN" codeData="/applymgt/extApplySearchDateType" firstName="none" style="width:100px; margin-right:3px;" />
                        <ANY:DATE id="DATE_START" value="" disabled />&nbsp;~
                        <ANY:DATE id="DATE_END" value="" disabled />
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
            <ANY:GRID id="gr_extApplyList" pagingType="1"><COMMENT>
                addColumn({ width:110, align:"left"  , type:"string" , sort:true , id:"REF_NO"              , name:"REF-NO" });
                addColumn({ width:110, align:"left"  , type:"string" , sort:true , id:"APP_NO"              , name:"출원번호" });
                addColumn({ width:150, align:"left"  , type:"string" , sort:true , id:"KO_APP_TITLE"        , name:"발명의 명칭" });
                addColumn({ width:75 , align:"center", type:"date"   , sort:true , id:"APP_DATE"            , name:"출원일" });
                addColumn({ width:75 , align:"center", type:"date"   , sort:true , id:"EXT_APP_LIMIT_DATE"  , name:"출원기한" });
                addColumn({ width:75 , align:"center", type:"date"   , sort:true , id:"PATTEAM_RCPT_DATE"   , name:"접수일" });
                addColumn({ width:110, align:"left"  , type:"string" , sort:true , id:"OFFICE_NAME"         , name:"사무소" });
                addColumn({ width:110, align:"left"  , type:"string" , sort:true , id:"INVENTOR_NAMES"      , name:"발명자" });
                addColumn({ width:75 , align:"center", type:"string" , sort:true , id:"JOB_MAN_NAME"        , name:"담당자" });
                addColumn({ width:110, align:"left"  , type:"string" , sort:true , id:"REG_NO"              , name:"등록번호" });
                addColumn({ width:75 , align:"center", type:"string" , sort:true , id:"EXT_APP_STATUS_NAME" , name:"품의상태" });
                useConfig = true;
                messageSpan = "spn_gridMessage";
                setFixedColumn(null, "KO_APP_TITLE");
                addSorting("EXT_APP_LIMIT_DATE", "ASC");
                addAction("KO_APP_TITLE", fnDetail);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
