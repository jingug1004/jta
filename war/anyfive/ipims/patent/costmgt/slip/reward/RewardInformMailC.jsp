<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<%@page import="any.util.etc.NDateUtil"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>보상금 알림메일 발송</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<ANY:DS id="ds_mailList" />
<SCRIPT language="JScript">
var gMailRow = -1;

//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();
}

//조회
function fnRetrieve()
{
    var ldr = gr_mailList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.costmgt.slip.reward.act.RetrieveRewardInformMailList.do";
    ldr.addParam("SLIP_ID", parent.SLIP_ID);

    ldr.onStart = function()
    {
        gMailRow = -1;
    }

    ldr.onSuccess = function()
    {
    }

    ldr.onFail = function()
    {
        this.error.show();
    }

    ldr.execute();
}

//저장
function fnSave()
{
    var gr = gr_mailList;
    var ds = ds_mailList;

    ds.init();

    for (var r = gr.fg.FixedRows; r < gr.fg.Rows; r++) {
        if (gr.checked(r,"ROW_CHK") != true) continue;
        ds.addRow();
        ds.value(ds.rowCount - 1, "COST_SEQ") = gr.value(r, "COST_SEQ");
        ds.value(ds.rowCount - 1, "TO_ADDR") = gr.value(r, "MAIL_ADDR");
        ds.value(ds.rowCount - 1, "TO_NAME") = gr.value(r, "EMP_HNAME");
        ds.value(ds.rowCount - 1, "SUBJECT") = gr.value(r, "SUBJECT");
        ds.value(ds.rowCount - 1, "BODY") = gr.value(r, "BODY");
    }

    if (ds.rowCount == 0) {
        alert("발송할 메일을 1개 이상 선택하세요.");
        return;
    }

    //필수항목 체크
    if (!cfCheckAllReqValid()) return;

    //저장 확인
    if (!confirm("총 " + cfGetFormatNumber(ds.rowCount) + " 건의 보상금 알림메일을 발송하시겠습니까?")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.costmgt.slip.reward.act.CreateRewardInformMailList.do";
    prx.addData("ds_mailList");

    prx.onSuccess = function()
    {
        alert("성공적으로 발송되었습니다.");
        gr_mailList.loader.reload();
    }

    prx.onFail = function()
    {
        this.error.show();
        gr_mailList.loader.reload();
    }

    prx.execute();
}

//선택한 행의 메일정보를 컨트롤에 입력
function fnSetMailInfo(row)
{
    if (gMailRow == row) return;

    gMailRow = row;

    var disabled = (gMailRow < gr_mailList.fg.FixedRows);

    TO_ADDR.innerText = (disabled ? "" : gr_mailList.value(gMailRow, "MAIL_ADDR") + " (" + gr_mailList.value(gMailRow, "EMP_HNAME") + ")");
    SUBJECT.value = (disabled ? "" : gr_mailList.value(gMailRow, "SUBJECT"));
    BODY.value = (disabled ? "" : gr_mailList.value(gMailRow, "BODY"));
}
</SCRIPT>

<!-- 제목 변경시 -->
<SCRIPT language="JScript" for="SUBJECT" event="onpropertychange()">
    if (event.propertyName == "value" && gMailRow >= gr_mailList.fg.FixedRows) {
        gr_mailList.value(gMailRow, "SUBJECT") = this.value;
    }
</SCRIPT>

<!-- 내용 변경시 -->
<SCRIPT language="JScript" for="BODY" event="onpropertychange()">
    if (event.propertyName == "value" && gMailRow >= gr_mailList.fg.FixedRows) {
        gr_mailList.value(gMailRow, "BODY") = this.value;
    }
</SCRIPT>
</HEAD>

<BODY>

<% app.writeBodyHeader(); %>

<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
    <TR>
        <TD height="100%">
            <ANY:GRID id="gr_mailList" pagingType="0"><COMMENT>
                addColumn({ width:40 , align:"center", type:"number", sort:false, id:"ROW_NUM"          , name:"No" });
                addColumn({ width:30 , align:"center", type:"check" , sort:false, id:"ROW_CHK" });
                addColumn({ width:120, align:"left"  , type:"string", sort:false, id:"REF_NO"           , name:"REF-NO" });
                addColumn({ width:50 , align:"center", type:"string", sort:false, id:"INOUT_DIV_NAME"   , name:"국내외" });
                addColumn({ width:70 , align:"center", type:"string", sort:false, id:"REWARD_DIV_NAME"  , name:"보상금구분" });
                addColumn({ width:60 , align:"center", type:"sring" , sort:false, id:"GRADE"            , name:"발명등급" });
                addColumn({ width:70 , align:"center", type:"string", sort:false, id:"EMP_HNAME"        , name:"발명자" });
                addColumn({ width:120, align:"left"  , type:"string", sort:false, id:"MAIL_ADDR"        , name:"메일주소" });
                addColumn({ width:70 , align:"center", type:"string", sort:false, id:"EMP_NO"           , name:"사번" });
                addColumn({ width:100, align:"left"  , type:"string", sort:false, id:"APP_NO"           , name:"출원번호" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:false, id:"APP_DATE"         , name:"출원일" });
                addColumn({ width:100, align:"left"  , type:"string", sort:false, id:"REG_NO"           , name:"등록번호" });
                addColumn({ width:75 , align:"center", type:"date"  , sort:false, id:"REG_DATE"         , name:"등록일" });
                addColumn({ width:80 , align:"right" , type:"number", sort:false, id:"REWARD_PRICE"     , name:"금액" , format:"#,###" });
                addColumn({ width:60 , align:"center", type:"string", sort:false, id:"MAIL_SEND_YN_NAME", name:"발송여부" });
                setFixedColumn("ROW_NUM", "ROW_CHK");

                fg.SelectionMode = flexSelectionListBox;
                fg.AllowSelection = false;

                fg.attachEvent("AfterRowColChange", function(iOldRow, iOldCol, iNewRow, iNewCol)
                {
                    if (element.loader.loading == true) return;

                    fnSetMailInfo(iNewRow);
                });
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
    <TR>
        <TD height="5px"></TD>
    </TR>
    <TR>
        <TD height="1px">
            <TABLE border="0" cellspacing="1" cellpadding="2" class="main">
                <COLGROUP>
                    <COL class="conthead" width="15%">
                    <COL class="contdata" width="35%">
                    <COL class="conthead" width="15%">
                    <COL class="contdata" width="35%">
                </COLGROUP>
                <TR>
                    <TD>발신인</TD>
                    <TD><%= app.userInfo.getEmpHname() + " (" + app.userInfo.getMailAddr() + ")" %></TD>
                    <TD>수신인</TD>
                    <TD><SPAN id="TO_ADDR"></SPAN></TD>
                </TR>
                <TR>
                    <TD>제목</TD>
                    <TD colspan="3"><INPUT type="text" id="SUBJECT"></TD>
                </TR>
                <TR>
                    <TD>내용</TD>
                    <TD colspan="3"><TEXTAREA id="BODY" rows="10"></TEXTAREA></TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <TR>
        <TD height="1px">
            <DIV class="button_area">
                <BUTTON text="발송" onClick="javascript:fnSave();"></BUTTON>
                <BUTTON text="취소" onClick="javascript:top.window.close();"></BUTTON>
            </DIV>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
