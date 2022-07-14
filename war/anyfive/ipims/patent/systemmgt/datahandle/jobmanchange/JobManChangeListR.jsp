<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>건담당자 일괄변경</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<ANY:DS id="ds_jobManChangeList" />
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
}

//목록 조회
function fnRetrieve()
{
    var ldr = gr_jobManChangeList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.datahandle.jobmanchange.act.RetrieveJobManChangeList.do";
    ldr.addParam("INOUT_DIV", INOUT_DIV.value);
    ldr.addParam("RIGHT_DIV", RIGHT_DIV.value);
    ldr.addParam("JOB_MAN", JOB_MAN.value);
    ldr.addParam("NUMBER_GUBUN", NUMBER_GUBUN.value);
    ldr.addParam("NUMBER_TEXT", NUMBER_TEXT.value);
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
    switch (gr.value(row, "INOUT_DIV")) {
    case "INT":
        win.path = top.getRoot() + "/anyfive/ipims/patent/applymgt/common/IntMasterTabR.jsp";
        break;
    case "EXT":
        win.path = top.getRoot() + "/anyfive/ipims/patent/applymgt/common/ExtMasterTabR.jsp";
        break;
    }
    win.arg.REF_ID = gr.value(row, "REF_ID");
    win.show();
}

//저장
function fnSave()
{
    var gr = gr_jobManChangeList;
    var ds = ds_jobManChangeList;

    ds.init();

    for (var r = gr.fg.FixedRows; r < gr.fg.Rows; r++) {
        if (gr.checked(r,"ROW_CHK") != true) continue;
        ds.addRow();
        ds.value(ds.rowCount - 1, "RIGHT_DIV") = gr.value(r, "RIGHT_DIV");
        ds.value(ds.rowCount - 1, "INOUT_DIV") = gr.value(r, "INOUT_DIV");
        ds.value(ds.rowCount - 1, "REF_ID") = gr.value(r, "REF_ID");
        ds.value(ds.rowCount - 1, "REF_NO") = gr.value(r,"REF_NO");
        ds.value(ds.rowCount - 1, "KO_APP_TITLE") = gr.value(r,"KO_APP_TITLE");

    }

    if (ds.rowCount == 0) {
        alert("건담당자를 변경할 건을 1개 이상 선택하세요.");
        return;
    }

    if (NEW_JOB_MAN.value == "") {
        alert("건담당자를 선택하세요.");
        NEW_JOB_MAN.focus();
        return;
    }

    //저장 확인
    if (!confirm(any.message.get("msg.com.jobman.list.save", cfGetFormatNumber(ds.rowCount), NEW_JOB_MAN.text))) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.datahandle.jobmanchange.act.UpdateJobManChangeList.do";
    prx.addParam("JOB_MAN", NEW_JOB_MAN.value);
    prx.addData(ds);

    prx.onSuccess = function()
    {
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
        fnRetrieve();
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
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
                    <TD>국내외구분</TD>
                    <TD>
                        <ANY:SELECT id="INOUT_DIV" codeData="{INOUT_DIV}" firstName="all" />
                    </TD>
                    <TD>권리구분</TD>
                    <TD>
                        <ANY:SELECT id="RIGHT_DIV" codeData="{RIGHT_DIV}" firstName="all" />
                    </TD>
                    <TD>건담당자</TD>
                    <TD>
                        <ANY:SELECT id="JOB_MAN" codeData="/common/jobManAll" firstName="all" value="<%= app.userInfo.getUserId() %>" />
                    </TD>
                </TR>
                <TR>
                    <TD>검색번호</TD>
                    <TD>
                        <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                            <TR>
                                <TD>
                                    <ANY:SELECT id="NUMBER_GUBUN" codeData="/systemmgt/jobManChangeSearchNumberGubun" style="width:70px; margin-right:3px;" />
                                </TD>
                                <TD width="100%">
                                    <INPUT type="text" id="NUMBER_TEXT">
                                </TD>
                            </TR>
                        </TABLE>
                    </TD>
                    <TD>검색일자</TD>
                    <TD colspan="3" noWrap>
                        <ANY:SELECT id="DATE_GUBUN" codeData="/systemmgt/jobManChangeSearchDateGubun" style="width:80px; margin-right:3px;" />
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
            <ANY:GRID id="gr_jobManChangeList" pagingType="1"><COMMENT>
                addColumn({ width:30 , align:"center", type:"check"  , sort:false, id:"ROW_CHK" });
                addColumn({ width:120, align:"left"  , type:"string" , sort:true , id:"REF_NO"              , name:"REF-NO" });
                addColumn({ width:250, align:"left"  , type:"string" , sort:true , id:"KO_APP_TITLE"        , name:"발명의 명칭" });
                addColumn({ width:120, align:"left"  , type:"string" , sort:true , id:"APP_NO"              , name:"출원번호" });
                addColumn({ width:60 , align:"center", type:"string" , sort:true , id:"JOB_MAN_NAME"        , name:"담당자" });
                addColumn({ width:100, align:"left"  , type:"string" , sort:true , id:"INVENTOR_NAMES"      , name:"발명자" });
                addColumn({ width:100, align:"left"  , type:"string" , sort:true , id:"DEPT_NAME"           , name:"부서" });
                addColumn({ width:100, align:"left"  , type:"string" , sort:true , id:"REG_NO"              , name:"등록번호" });
                addColumn({ width:100, align:"left"  , type:"string" , sort:true , id:"STATUS_NAME"         , name:"진행상태" });
                addColumn({ width:75 , align:"center", type:"date"   , sort:true , id:"STATUS_DATE"         , name:"서류일자" });
                addColumn({ width:70 , align:"center", type:"string" , sort:true , id:"EXAM_RESULT_NAME"    , name:"검토결과" });
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_CHK", "KO_APP_TITLE");
                addSorting("REF_NO", "DESC");
                addAction("KO_APP_TITLE", fnDetail);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
    <TR>
        <TD height="5"></TD>
    </TR>
    <TR>
        <TD height="1" align="right">
            <ANY:SELECT id="NEW_JOB_MAN" codeData="/common/jobManAll" firstName="sel" style="width:100px;" />
            <BUTTON text="담당자변경처리" onClick="javascript:fnSave();"></BUTTON>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
