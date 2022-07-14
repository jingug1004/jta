<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>사무소요청사항</TITLE>
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
    var ldr = gr_officeReqList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.priorjob.officereq.act.RetrievePriorJobOfficeReqList.do";
    ldr.addParam("INOUT_DIV", INOUT_DIV.value);
    ldr.addParam("USER_SEARCH_GUBUN", USER_SEARCH_GUBUN.value);
    ldr.addParam("REQ_USER_NAME_NO", REQ_USER_NAME_NO.value);
    ldr.addParam("STATUS", STATUS.value);
    ldr.addParam("REF_NO" , REF_NO.value);
    ldr.addParam("JOB_MAN" , JOB_MAN.value);
    ldr.addParam("OFFICE_CODE", OFFICE_CODE.value);
    ldr.addParam("DATE_START" , DATE_START.value);
    ldr.addParam("DATE_END" , DATE_END.value);

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

    win.path = "OfficeReqRD.jsp";
    win.arg.REQ_ID = gr.value(row, "REQ_ID");

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
                    <TD>국가구분</TD>
                    <TD>
                        <ANY:SELECT id="INOUT_DIV" codeData="{INOUT_DIV}" firstName="all" />
                    </TD>
                    <TD>요청자</TD>
                    <TD>
                        <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                            <TR>
                                <TD>
                                    <ANY:SELECT id="USER_SEARCH_GUBUN" codeData="/common/userSearchGubun" style="width:60px; margin-right:3px;" />
                                </TD>
                                <TD width="100%"><INPUT type="text" id="REQ_USER_NAME_NO"></TD>
                            </TR>
                        </TABLE>
                    </TD>
                    <TD>처리상태</TD>
                    <TD>
                        <ANY:SELECT id="STATUS" codeData="/applymgt/statusGubun" firstName="all" />
                    </TD>
                </TR>
                <TR>
                    <TD>의뢰번호</TD>
                    <TD>
                        <INPUT type="text" id="REF_NO">
                    </TD>
                    <TD>특허담당자</TD>
                    <TD>
                        <ANY:SELECT id="JOB_MAN" codeData="/common/jobMan,PAT" firstName="all" />
                    </TD>
                    <TD>사무소선택</TD>
                    <TD>
                        <ANY:SELECT id="OFFICE_CODE" codeData="/common/officeCode" firstName="all" />
                    </TD>
                </TR>
                <TR>
                    <TD>요청일자</TD>
                    <TD colspan="5" noWrap>
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
            <ANY:GRID id="gr_officeReqList" pagingType="1"><COMMENT>
                addColumn({ width:75  , align:"center" , type:"date"   , sort:true , id:"REQ_DATE"           , name:"요청일시" });
                addColumn({ width:110 , align:"left"   , type:"string" , sort:true , id:"OFFICE_CODE_NAME"   , name:"사무소명" });
                addColumn({ width:125 , align:"center" , type:"string" , sort:true , id:"REQUSER_EMPNO"      , name:"요청자(사번)" });
                addColumn({ width:200 , align:"left"   , type:"string" , sort:true , id:"REQ_SUBJECT"        , name:"제목" });
                addColumn({ width:125 , align:"left"   , type:"string" , sort:true , id:"REF_NO"             , name:"의뢰번호" });
                addColumn({ width:75  , align:"center" , type:"string" , sort:true , id:"INOUT_DIV_NAME"     , name:"요청구분" });
                addColumn({ width:125 , align:"center" , type:"string" , sort:true , id:"JOBMAN_EMPNO"       , name:"담당자지정(사번)" });
                addColumn({ width:75  , align:"center" , type:"date"   , sort:true , id:"ANS_DATE"           , name:"답변일" });
                addColumn({ width:200 , align:"left"   , type:"string" , sort:true , id:"ANS_SUBJECT"        , name:"답변제목" });
                addColumn({ width:75  , align:"left"   , type:"string" , sort:true , id:"STATUS_NAME"        , name:"처리상태" });
                useConfig = true;
                messageSpan = "spn_gridMessage";
                addSorting("REQ_DATE", "DESC");
                addAction("REQ_SUBJECT", fnDetail);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>

