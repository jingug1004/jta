<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out); %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE>그룹별 사용자</TITLE>
<% app.writeHTMLHeader(); %>
<% app.writeHTCImport(app.HTC_GRID); %>
<ANY:DS id="ds_groupUserList" />
<SCRIPT language="JScript">
//윈도우 로딩시
window.onready = function()
{
    cfSetPageTitle("그룹별 사용자 - " + parent.GROUP_NAME + "(" + parent.SYSTEM_TYPE_NAME + ")");

    fnRetrieve();
}

//목록 조회
function fnRetrieve()
{
    var ldr = gr_groupUserList.loader;

    ldr.init();
    ldr.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.menugroup.groupuser.act.RetrieveGroupUserList.do";
    ldr.addParam("SYSTEM_TYPE", parent.SYSTEM_TYPE);
    ldr.addParam("GROUP_CODE", parent.GROUP_CODE);

    ldr.onSuccess = function(gr, fg)
    {
    }

    ldr.onFail = function(gr, fg)
    {
        this.error.show();
    }

    ldr.execute();
}

//추가
function fnAddUser()
{
    var win = new any.window();
    win.path = top.getRoot() + "/anyfive/ipims/patent/common/popup/search/UserSearchListR.jsp";
    win.arg.SYSTEM_TYPE = parent.SYSTEM_TYPE;
    win.opt.width = 600;
    win.opt.height = 450;
    win.show();

    if (win.rtn == null) return;

    if (!confirm("<%= app.message.get("msg.com.confirm.save").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.menugroup.groupuser.act.CreateGroupUser.do";
    prx.addParam("SYSTEM_TYPE", parent.SYSTEM_TYPE);
    prx.addParam("GROUP_CODE", parent.GROUP_CODE);
    prx.addParam("USER_ID", win.rtn.USER_ID);

    prx.onSuccess = function()
    {
        gr_groupUserList.loader.reload();
        alert("<%= app.message.get("msg.com.info.save").toJS() %>");
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//삭제
function fnDelUser()
{
    var gr = document.getElementById("gr_groupUserList");
    var ds = document.getElementById("ds_groupUserList");

    ds.init();

    for (var r = gr.fg.FixedRows; r < gr.fg.Rows; r++) {
        if (gr.checked(r, "ROW_CHK") != true) continue;
        ds.addRow();
        ds.value(ds.rowCount - 1, "USER_ID") = gr.value(r, "USER_ID");
    }

    if (ds.rowCount == 0) {
        alert("삭제할 사용자를 선택하세요.");
        return;
    }

    if (!confirm("<%= app.message.get("msg.com.confirm.delete").toJS() %>")) return;

    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.systemmgt.menugroup.groupuser.act.DeleteGroupUserList.do";
    prx.addParam("SYSTEM_TYPE", parent.SYSTEM_TYPE);
    prx.addParam("GROUP_CODE", parent.GROUP_CODE);
    prx.addData(ds);

    prx.onSuccess = function()
    {
        gr_groupUserList.loader.reload();
        alert("<%= app.message.get("msg.com.info.delete").toJS() %>");
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
                    <TD align="right">
                        <BUTTON text="추가" onClick="javascript:fnAddUser();"></BUTTON>
                        <BUTTON text="삭제" onClick="javascript:fnDelUser();"></BUTTON>
                        <BUTTON auto="line"></BUTTON>
                        <BUTTON auto="close"></BUTTON>
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
            <ANY:GRID id="gr_groupUserList" pagingType="1"><COMMENT>
                addColumn({ width:30 , align:"center", type:"check" , sort:false, id:"ROW_CHK" });
                addColumn({ width:60 , align:"center", type:"string", sort:true , id:"EMP_NO"      , name:"사번" });
                addColumn({ width:80 , align:"left"  , type:"string", sort:true , id:"EMP_HNAME"   , name:"이름" });
                if (parent.SYSTEM_TYPE == "PATENT") {
                    addColumn({ width:150, align:"left"  , type:"string", sort:true , id:"DIVISN_NAME" , name:"사업부" });
                    addColumn({ width:160, align:"left"  , type:"string", sort:true , id:"DEPT_NAME"   , name:"부서" });
                } else {
                    addColumn({ width:150, align:"left"  , type:"string", sort:true , id:"OFFICE_NAME" , name:"사무소" });
                    addColumn({ width:160, align:"left"  , type:"string", sort:true , id:"DEPT_NAME"   , name:"부서" });
                }
                messageSpan = "spn_gridMessage";
                addSorting("EMP_HNAME", "ASC");
            </COMMENT></ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
