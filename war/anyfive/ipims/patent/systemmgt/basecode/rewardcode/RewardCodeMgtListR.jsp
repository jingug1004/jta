<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>보상금종류코드</TITLE>
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
    var ldr = gr_rewardCodeMgtList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.basecode.rewardcode.act.RetrieveRewardCodeMgtList.do";
    ldr.addParam("RIGHT_DIV", RIGHT_DIV.value);
    ldr.addParam("INOUT_DIV", INOUT_DIV.value);
    ldr.addParam("REWARD_DIV", REWARD_DIV.value);
    ldr.addParam("INV_GRADE", INV_GRADE.value);

    ldr.onSuccess = function(gr, fg)
    {
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

//상세 팝업
function fnOpenView(gr, fg, row, colId)
{
    var win = new any.window();
    win.path = "RewardCodeMgtCUD.jsp";
    win.arg.RIGHT_DIV = gr.value(row, "RIGHT_DIV");
    win.arg.INOUT_DIV = gr.value(row, "INOUT_DIV");
    win.arg.REWARD_DIV = gr.value(row, "REWARD_DIV");
    win.arg.INV_GRADE = gr.value(row, "INV_GRADE");
    win.opt.width = 600;
    win.opt.height = 250;

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
            <TABLE border="0" width="100%" cellspacing="1" cellpadding="2" class="main" width="100%">
                <COLGROUP>
                    <COL class="condhead" width="15%">
                    <COL class="conddata" width="35%">
                    <COL class="condhead" width="15%">
                    <COL class="conddata" width="35%">
                </COLGROUP>
                <TR>
                    <TD>권리구분</TD>
                    <TD style="padding-left:2px;">
                        <ANY:SELECT id="RIGHT_DIV" codeData="{RIGHT_DIV}" firstName="all" />
                    </TD>
                    <TD>국내외구분</TD>
                    <TD>
                        <ANY:SELECT id="INOUT_DIV" codeData="{INOUT_DIV}" firstName="all" />
                    </TD>
                </TR>
                <TR>
                    <TD>보상금구분</TD>
                    <TD>
                        <ANY:SELECT id="REWARD_DIV" codeData="{REWARD_DIV}" firstName="all" />
                    </TD>
                    <TD>발명등급</TD>
                    <TD style="padding-left:2px;">
                        <ANY:SELECT id="INV_GRADE" codeData="{INV_GRADE}" firstName="all" />
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
            <ANY:GRID id="gr_rewardCodeMgtList" pagingType="0"><COMMENT>
                addColumn({ width:50 , align:"center", type:"number", sort:false, id:"ROW_NUM"              , name:"<%= app.message.get("lbl.com.no").toJS() %>" });
                addColumn({ width:120, align:"center", type:"string", sort:false, id:"RIGHT_DIV_NAME"       , name:"권리구분" });
                addColumn({ width:100, align:"center", type:"string", sort:false, id:"INOUT_DIV_NAME"       , name:"국내외구분" });
                addColumn({ width:200, align:"left"  , type:"string", sort:false, id:"REWARD_DIV_NAME"      , name:"보상금구분" });
                addColumn({ width:100, align:"center", type:"string", sort:false, id:"INV_GRADE_NAME"       , name:"발명등급" });
                addColumn({ width:150, align:"right" , type:"string", sort:false, id:"REWARD_PRICE"         , name:"금액", format:"#,###" });
                messageSpan = "spn_gridMessage";
                setFixedColumn("ROW_NUM", "INV_GRADE_NAME");
                addAction("INV_GRADE_NAME", fnOpenView);
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
