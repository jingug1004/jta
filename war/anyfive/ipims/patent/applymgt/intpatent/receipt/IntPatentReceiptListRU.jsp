<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>건담당자 지정</TITLE>
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
    var ldr = gr_setJobManList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.intpatent.receipt.act.RetrieveIntPatentReceiptList.do";

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
    win.path = "IntPatentReceiptRU.jsp";
    win.arg.REF_ID = gr.value(row, "REF_ID");

    win.onReload = function()
    {
        gr.loader.reload();
    }

    win.show();
}

//저장
function fnSave()
{
    var gr = gr_setJobManList;
    var ds = ds_setJobManList;

    ds.init();

    for (var r = gr.fg.FixedRows; r < gr.fg.Rows; r++) {
        if (gr.checked(r,"ROW_CHK") != true) continue;
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
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.intpatent.receipt.act.UpdateIntPatentReceiptJobManList.do";
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
            <ANY:GRID id="gr_setJobManList" pagingType="0"><COMMENT>
                addColumn({ width:40 , align:"center", type:"number", sort:false, id:"ROW_NUM"          , name:"No" });
                addColumn({ width:30 , align:"center", type:"check" , sort:true , id:"ROW_CHK" });
                addColumn({ width:200, align:"left"  , type:"string", sort:true , id:"KO_APP_TITLE"     , name:"발명의 명칭" });
                addColumn({ width:130, align:"left"  , type:"string", sort:true , id:"INVENTOR_NAMES"   , name:"발명자" });
                addColumn({ width:130, align:"left"  , type:"string", sort:true , id:"REF_NO"           , name:"REF-NO" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:true , id:"PATTEAM_REQ_DATE" , name:"지적재산팀의뢰일" });
                addColumn({ width:75 , align:"center", type:"string", sort:true , id:"CRE_USER_NAME"    , name:"작성자" });
                useConfig = true;
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_NUM", "KO_APP_TITLE");
                addAction("KO_APP_TITLE", fnDetail);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
    <TR>
        <TD>
            <DIV class="button_area">
                <ANY:SELECT id="JOB_MAN" codeData="/common/jobMan,PAT" value="<%= app.userInfo.getUserId() %>" style="width:100px;"/>
                <BUTTON text="<%= app.message.get("btn.com.jobman").toHTML() %>" onClick="javascript:fnSave();"></BUTTON>
            </DIV>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
