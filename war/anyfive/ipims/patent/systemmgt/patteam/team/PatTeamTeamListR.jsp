<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>팀정보 관리</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<ANY:DS id="ds_patTeamTeamList" />
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    fnRetrieve();
}

//조회
function fnRetrieve()
{
    var ldr = gr_patTeamTeamList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.patteam.team.act.RetrievePatTeamTeamList.do";
    ldr.addParam("DEPT_NAME", DEPT_NAME.value);
    ldr.addParam("USE_YN", USE_YN.value);

    ldr.onSuccess = function(gr, fg)
    {
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

function fnSave()
{
    var gr = gr_patTeamTeamList;
    var ds = ds_patTeamTeamList;

    ds.init();

    for (var r = gr.fg.FixedRows; r < gr.fg.Rows; r++) {
        if (gr.checked(r,"ROW_CHK") != true) continue;
        ds.addRow();
        ds.value(ds.rowCount - 1, "DEPT_CODE") = gr.value(r, "DEPT_CODE");
    }

    if (ds.rowCount == 0) {
        alert("사용구분을 변경할 부서를 1개이상 선택하십시요.");
        return;
    }

    if (USE_YN_NAME.value == "") {
        alert("사용여부를 선택하세요.");
        USE_YN_NAME.focus();
        return;
    }

    if (!confirm(any.message.get("msg.com.useyn.list.save", cfGetFormatNumber(ds.rowCount),USE_YN_NAME.text))) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.patteam.team.act.UpdatePatTeamTeamList.do";
    prx.addParam("USE_YN", USE_YN_NAME.value);
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
                    <COL class="condhead" width="15%">
                    <COL class="conddata" width="35%">
                    <COL class="condhead" width="15%">
                    <COL class="conddata" width="35%">
                </COLGROUP>
                <TR>
                    <TD>팀명</TD>
                    <TD>
                        <INPUT type="text" id="DEPT_NAME">
                    </TD>
                    <TD>사용구분</TD>
                    <TD>
                        <ANY:SELECT id="USE_YN" codeData="{YES_NO}"  firstName="sel"/>
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
                        <ANY:SELECT id="USE_YN_NAME" codeData="{USE_YN}" firstName="sel" style="width:100px;" />
                        <BUTTON text="저장" onClick="javascript:fnSave();"></BUTTON>
                        <BUTTON auto="line" ></BUTTON>
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
            <ANY:GRID id="gr_patTeamTeamList" pagingType="1"><COMMENT>
                addColumn({ width:50 , align:"center", type:"number" , sort:false, id:"ROW_NUM"     , name:"No" });
                addColumn({ width:30 , align:"center", type:"check"  , sort:false, id:"ROW_CHK" });
                addColumn({ width:80 , align:"center", type:"string" , sort:true , id:"DEPT_CODE"   , name:"팀코드" });
                addColumn({ width:250, align:"left"  , type:"string" , sort:true , id:"DEPT_NAME"   , name:"팀명" });
                addColumn({ width:200, align:"left"  , type:"string" , sort:true , id:"DIVISN_NAME" , name:"사업부" });
                addColumn({ width:75 , align:"center", type:"date"   , sort:true , id:"CRE_DATE"    , name:"생성일" });
                addColumn({ width:60 , align:"center", type:"string" , sort:true , id:"USE_YN_NAME" , name:"사용구분" });
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_NUM", "ROW_CHK");
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
