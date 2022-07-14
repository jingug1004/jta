<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%@page import="anyfive.ipims.share.common.app.ShareApp" %>
<% ShareApp app = new ShareApp(request, response, out, true, true); %>
<%@page import="anyfive.ipims.share.login.util.LoginUtil" %>
<%@page import="any.core.config.NConfig" %>
<% if (LoginUtil.isAdminLoginAvail(request) != true) { %>
<SCRIPT language="JScript">
    window.location.replace("<%= NConfig.getString("/config/logout-path", request.getContextPath() + "/anyfive/ipims/share/login/Login.jsp") %>");
</SCRIPT>
<% } else { %>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
    <TITLE><%= NConfig.getString(NConfig.DEFAULT_CONFIG + "/system-title") %> - 관리자 로그인</TITLE>
    <% app.writeHTMLHeader(); %>
    <% app.writeHTCImport(app.HTC_GRID); %>
    <SCRIPT language="JScript">
        //윈도우 로딩시
        window.onready = function () {
            SYSTEM_TYPE.addItem("", "(전체)");
            SYSTEM_TYPE.addItem("PATENT", "특허팀");
            SYSTEM_TYPE.addItem("OFFICE", "사무소");

            SEARCH_TEXT.value = (any.getCookie("LAST_LOGIN_ID") == null ? "" : any.getCookie("LAST_LOGIN_ID"));
            SEARCH_TEXT.focus();

            if (SEARCH_TEXT.value != "") {
                fnRetrieve();
            }
        }

        //검색
        function fnRetrieve() {
            var ldr = gr_userList.loader;

            ldr.init();
            ldr.path = top.getRoot() + "/anyfive.ipims.share.login.act.RetrieveLoginUserSearchList.do";
            ldr.addParam("SYSTEM_TYPE", SYSTEM_TYPE.value);
            ldr.addParam("SEARCH_TEXT", SEARCH_TEXT.value);

            ldr.onSuccess = function (gr, fg) {
                SEARCH_TEXT.focus();
                SEARCH_TEXT.select();
            }

            ldr.onFail = function (gr, fg) {
                this.error.show();
            }

            ldr.execute();
        }

        //로그인
        function fnLogin(gr, fg, row, colId) {
            var prx = new any.proxy();
            prx.path = top.getRoot() + "/anyfive.ipims.share.login.act.Login.do";
            prx.addParam("LOGIN_ID", gr.value(row, "LOGIN_ID"));
            prx.addParam("LOGIN_PW", gr.value(row, "LOGIN_PW"));
            prx.addParam("SYS_ID", "SYSADMIN");

            prx.onSuccess = function () {
                any.setCookie("LAST_LOGIN_ID", gr.value(row, "LOGIN_ID"), 999);

                top.location.replace(top.getRoot() + "/");
            }

            prx.onFail = function () {
                this.error.show();
            }

            prx.execute();
        }
    </SCRIPT>

    <!-- 시스템형태 변경시 -->
    <SCRIPT language="JScript" for="SYSTEM_TYPE" event="OnChange()">
        SEARCH_TEXT.value = "";
        SEARCH_TEXT.focus();
    </SCRIPT>
</HEAD>

<BODY scroll="no">

<% app.writeBodyHeader(); %>

<TABLE border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
    <TR>
        <TD height="1">
            <TABLE border="0" cellspacing="1" cellpadding="2" class="main" onEnter="javascript:fnRetrieve();">
                <COLGROUP>
                    <COL class="condhead" width="15%">
                    <COL class="conddata" width="35%">
                    <COL class="condhead" width="15%">
                    <COL class="conddata" width="35%">
                </COLGROUP>
                <TR>
                    <TD>시스템구분</TD>
                    <TD><ANY:SELECT id="SYSTEM_TYPE"/></TD>
                    <TD>이름/사번</TD>
                    <TD><INPUT type="text" id="SEARCH_TEXT"></TD>
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
            <ANY:GRID id="gr_userList" pagingType="1">
                <COMMENT>
                    addColumn({ width:50 , align:"center", type:"number" , sort:false, id:"ROW_NUM" , name:"No" });
                    addColumn({ width:80 , align:"center", type:"string" , sort:true , id:"SYSTEM_TYPE_NAME" , name:"구분"
                    });
                    addColumn({ width:100, align:"center", type:"string" , sort:true , id:"EMP_NO" , name:"사번" });
                    addColumn({ width:150, align:"left" , type:"string" , sort:true , id:"EMP_HNAME" , name:"이름" });
                    addColumn({ width:250, align:"left" , type:"string" , sort:true , id:"DIVISN_NAME" , name:"본부" });
                    addColumn({ width:250, align:"left" , type:"string" , sort:true , id:"DEPT_NAME" , name:"팀" });
                    addColumn({ width:80 , align:"center", type:"string" , sort:true , id:"HT_CODE_NAME" , name:"휴퇴구분"
                    });
                    messageSpan = "spn_gridMessage";
                    setFixedColumn("ROW_NUM", "EMP_HNAME");
                    addSorting("EMP_HNAME", "ASC");
                    addAction("EMP_HNAME", fnLogin);
                </COMMENT>
            </ANY:GRID>
        </TD>
    </TR>
</TABLE>

<% app.writeBodyFooter(); %>

</BODY>
</HTML>
<% } %>
