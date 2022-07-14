<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>프로그램 접수</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<ANY:DS id="ds_setJobManList" />
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();
}

//목록 조회
function fnRetrieve()
{
    var ldr = gr_examReceiptList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.program.receipt.act.RetrieveProgramReceiptList.do";

    ldr.onSuccess = function(gr, fg)
    {
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

//저장
function fnSave()
{
    var gr = gr_examReceiptList;
    var ds = ds_setJobManList;

    ds.init();

    for (var r = gr.fg.FixedRows; r < gr.fg.Rows; r++) {
        if (gr.checked(r, "ROW_CHK") != true) continue;
        ds.addRow();
        ds.value(ds.rowCount - 1, "REF_ID") = gr.value(r, "REF_ID");
    }

    if (ds.rowCount == 0) {
        alert("건담당자를 지정할 건을 1개 이상 선택하세요.");
        return;
    }

    if (JOB_MAN.value == "") {
        alert("건담당자를 선택하세요.");
        JOB_MAN.focus();
        return;
    }

    //저장 확인
    if (!confirm(any.message.get("msg.com.jobman.list.save", cfGetFormatNumber(ds.rowCount), JOB_MAN.text))) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.program.receipt.act.UpdateProgramReceiptJobManList.do";
    prx.addParam("JOB_MAN", JOB_MAN.value);
    prx.addData("ds_setJobManList");

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

//상세
function fnDetail(gr, fg, row, colId)
{
    var win = new any.viewer();
    win.path = "ProgramReceiptRU.jsp";
    win.arg.REF_ID = gr.value(row, "REF_ID");

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
            <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                <TR>
                    <TD><SPAN id="spn_gridMessage"></SPAN></TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD height="5"></TD>
    </TR>
    <TR>
        <TD height="100%">
            <ANY:GRID id="gr_examReceiptList" pagingType="0"><COMMENT>
                addColumn({ width:40 , align:"center"   , type:"number", sort:false, id:"ROW_NUM"          , name:"No" });
                addColumn({ width:30 , align:"center"   , type:"check" , sort:true , id:"ROW_CHK" });
                addColumn({ width:200, align:"left"     , type:"string", sort:true , id:"PROG_TITLE"       , name:"프로그램명칭" });
                addColumn({ width:130, align:"center"   , type:"string", sort:true , id:"RIGHT_TYPE_NAME"  , name:"권리유형" });
                addColumn({ width:130, align:"center"   , type:"string", sort:true , id:"REGULAR_DIV_NAME" , name:"상용구분" });
                addColumn({ width:90 , align:"center"   , type:"date"  , sort:true , id:"PATTEAM_REQ_DATE" , name:"의뢰일" });
                addColumn({ width:75 , align:"center"   , type:"string", sort:true , id:"CRE_USER_NAME"    , name:"의뢰자" });
                useConfig = true;
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_NUM", "PROG_TITLE");
                addSorting("REF_NO", "DESC");
                addAction("PROG_TITLE", fnDetail);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
    <TR>
        <TD>
            <DIV class="button_area">
                <ANY:SELECT id="JOB_MAN" codeData="/common/jobManAll" value="<%= app.userInfo.getUserId() %>" style="width:100px;"/>
                <BUTTON text="<%= app.message.get("btn.com.jobman").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>
            </DIV>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
