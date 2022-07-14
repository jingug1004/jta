<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/include/PageHeader.jspf" %>
<%--<%@ include file="/war/anyfive/ipims/common/include/PageHeader.jspf" %> --%>
<%--<%@ include file="../../../../WEB-INF/jsp/common/include/PageHeader.jspf" %>--%>
<!DOCTYPE html>
<head>
    <title>SS - Login</title>
    <%@ include file="/jsp/common/include/HtmlHeader.jspf" %>
    <%--<%@ include file="/war/anyfive/ipims/common/include/HtmlHeader.jspf" %>--%>
    <link rel="stylesheet" type="text/css" />
    <script type="text/javascript">

        var gControl = {};
        var gColors = {activityText: {emphasis: "#6666ff", normal: "#a0a0a0"}};

        // (function main() {

        //윈도우 로딩시
        // window.onready = function () {
        // SYSTEM_TYPE.addItem("", "(전체)");
        // SYSTEM_TYPE.addItem("PATENT", "특허팀");
        // SYSTEM_TYPE.addItem("OFFICE", "사무소");
        //
        // SEARCH_TEXT.value = (any.getCookie("LAST_LOGIN_ID") == null ? "" : any.getCookie("LAST_LOGIN_ID"));
        // SEARCH_TEXT.focus();
        //
        // if (SEARCH_TEXT.value != "") {
        //     fnRetrieve();
        // }
        // }
        any.ready(function () {

            gControl.$grid = $('#gr_userList');
            gControl.$SYSTEM_TYPE = $('div#SYSTEM_TYPE');
            gControl.$SEARCH_TEXT = $('input#SEARCH_TEXT');

            gControl.$SEARCH_TEXT.value = (any.cookie("LAST_LOGIN_ID") == null ? "" : any.cookie("LAST_LOGIN_ID"));
            gControl.$SEARCH_TEXT.focus();

            if (gControl.$SEARCH_TEXT.value != "") {
                fnRetrieve();
            }

            // fnRetrieve();
        });
        // })();


        //검색
        function fnRetrieve() {
            // var ldr = gr_userList.loader;
            //
            // ldr.init();
            // ldr.path = top.getRoot() + "/anyfive.ipims.share.login.act.RetrieveLoginUserSearchList.do";
            // ldr.addParam("SYSTEM_TYPE", SYSTEM_TYPE.value);
            // ldr.addParam("SEARCH_TEXT", SEARCH_TEXT.value);
            //
            // ldr.onSuccess = function (gr, fg) {
            //     SEARCH_TEXT.focus();
            //     SEARCH_TEXT.select();
            // }
            //
            // ldr.onFail = function (gr, fg) {
            //     this.error.show();
            // }
            //
            // ldr.execute();

            //

            var prx = $('#gr_userList').prop("loader").proxy();
            // var prx = gControl.$grid.prop("loader").proxy();
            // var prx = any.proxy();
            prx.url("/anyfive.ipims.share.login.act.RetrieveLoginUserSearchList.do");
            // prx.param("SYSTEM_TYPE", gControl.$SYSTEM_TYPE.val());
            // prx.param("SEARCH_TEXT", gControl.$SEARCH_TEXT.val());
            prx.param("SEARCH_TEXT", 'pat1');
            prx.data("ds_condInfo");

            prx.onStart = function () {
                // gControl.$buttons.exec("reset", activityId);
            };

            prx.onSuccess = function () {
                // gControl.$SEARCH_TEXT.focus();
                // gControl.$SEARCH_TEXT.select();
            };

            prx.onError = function () {
                this.error.show();
                console.log('l~ this.error : ', this.error);
            };

            prx.execute();
        }

        //로그인
        function fnLogin(gr, fg, row, colId) {
            var prx = new any.proxy();
            prx.url = "/anyfive.ipims.share.login.act.Login.do";
            prx.param("LOGIN_ID", gr.value(row, "LOGIN_ID"));
            prx.param("LOGIN_PW", gr.value(row, "LOGIN_PW"));
            prx.param("SYS_ID", "SYSADMIN");

            prx.onSuccess = function () {
                // any.setCookie("LAST_LOGIN_ID", gr.value(row, "LOGIN_ID"), 999);

                // top.location.replace(top.getRoot() + "/");
            }

            prx.onError = function () {
                this.error.show();
            }

            prx.execute();
        }
    </script>

    <%--    <!-- 시스템형태 변경시 -->--%>
    <%--    <script language="text/javascript" for="SYSTEM_TYPE" event="OnChange()">--%>
    <%--        SEARCH_TEXT.value = "";--%>
    <%--        SEARCH_TEXT.focus();--%>
    <%--    </script>--%>

</head>

<body scroll="auto" width="800" height="600">
<%--<BODY scroll="no">--%>

<tbody border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
<tr>
    <td height="1" />
<tbody border="0" cellspacing="1" cellpadding="2" class="main" onEnter="javascript:fnRetrieve();">
<colgroup>
    <col class="condhead" width="15%">
    <col class="conddata" width="35%">
    <col class="condhead" width="15%">
    <col class="conddata" width="35%">
</colgroup>
<tr>
    <td>시스템구분</td>
    <%--    <td><ANY:SELECT id="SYSTEM_TYPE"/></td>--%>
    <td>
        <%--        <div any-select id="SYSTEM_TYPE" firstName="all"></div>--%>
        <div any-select id="SYSTEM_TYPE" bind="ds_condInfo"></div>
        <script ${AI}>
            this.addItem("", "(전체)");
            this.addItem("PATENT", "특허팀");
            this.addItem("OFFICE", "사무소");

            $(this).on("onChange", function () {
                $('#SEARCH_TEXT').val("").focus();
            });
        </script>
    </td>
    <td>이름/사번</td>
    <td><input type="text" id="SEARCH_TEXT" bind="ds_condInfo"></td>
</tr>
</tbody>
</td>
</tr>
<tr>
    <td height="5"></td>
</tr>
<tr>
    <td>
        <tbody border="0" cellspacing="0" cellpadding="0" width="100%">
        <tr>
            <td><span id="spn_gridMessage"></span></td>
            <td align="right">
                <button auto="retrieve" onClick="javascript:fnRetrieve();"></button>
            </td>
        </tr>
        </tbody>
    </td>
</tr>
<tr>
    <td height="5"></td>
</tr>
<tr>
    <td height="100%">
        <div any-jqgrid id="gr_userList" fullHeight class="page-space"></div><script ${AI}>
            this.addColumn({width: 50, align: "center", sortable: false, name: "ROW_NUM", label: "No"});
            this.addColumn({width: 80, align: "center", sortable: true, name: "SYSTEM_TYPE_NAME", label: "구분"});
            this.addColumn({width: 100, align: "center", sortable: true, name: "EMP_NO", label: "사번"});
            this.addColumn({width: 150, align: "left", sortable: true, name: "EMP_HNAME", label: "이름"});
            this.addColumn({width: 250, align: "left", sortable: true, name: "DIVISN_NAME", label: "본부"});
            this.addColumn({width: 250, align: "left", sortable: true, name: "DEPT_NAME", label: "팀"});
            this.addColumn({width: 80, align: "center", sortable: true, name: "HT_CODE_NAME", label: "휴퇴구분"});
            this.setOption({ rownumbers:true, shrinkToFit:true });
            // messageSpan = "spn_gridMessage";
            // this.setFixedColumn("ROW_NUM", "EMP_HNAME");

            // this.setButton({excel: true});
            // this.setPaging();
            // this.addSorting("EMP_HNAME", "ASC");
            // this.addAction("EMP_HNAME", fnLogin);
        </script>

        <div class="page-footer">
            <div clone="div.page-header > div.buttons"></div>
        </div>
    </td>
</tr>
</tbody>

</body>
</html>
