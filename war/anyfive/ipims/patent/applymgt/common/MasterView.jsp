<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="anyfive.ipims.patent.common.app.PatentApp"%><% PatentApp app = new PatentApp(request, response, out, true, false); %>
<%@page import="any.core.config.NConfig"%>
<%@page import="any.util.etc.NTextUtil"%>
<% app.writeHTMLDocType(); %>
<HTML XMLNS:ANY>
<HEAD>
<TITLE><%= NConfig.getString(NConfig.DEFAULT_CONFIG + "/system-title") %> - 출원마스터</TITLE>
<% app.writeHTMLHeader(); %>
<ANY:DS id="ds_masterInfo" />
<SCRIPT language="JScript">
var IPIMS_MASTER_VIEWER = true;
var REF_ID;

//윈도우 로딩시
window.onload = function()
{
    fnRetrieve();
}

//마스터 정보 조회
function fnRetrieve()
{
    var prx = new any.proxy();
    prx.path = top.getRoot() + "/anyfive.ipims.patent.applymgt.common.act.RetrieveMasterInfo.do";
    prx.addParam("REF_ID", "<%= request.getParameter("ID") %>");

    prx.onSuccess = function()
    {
        if (ds_masterInfo.rowCount == 0) {
            alert("요청하신 데이터가 존재하지 않습니다.");
            return;
        }

        REF_ID = ds_masterInfo.value(0, "REF_ID");

        if (ds_masterInfo.value(0, "IS_MASTER") == "1") {
            var tab = "<%= NTextUtil.nvl(request.getParameter("TAB"), "") %>";
            switch(ds_masterInfo.value(0, "INOUT_DIV")) {
            case "INT":
                ifr_main.location.replace("IntMasterTabR.jsp" + (tab == "" ? "" : "?TAB=" + tab));
                break;
            case "EXT":
                ifr_main.location.replace("ExtMasterTabR.jsp" + (tab == "" ? "" : "?TAB=" + tab));
                break;
            }
        } else {
            switch(ds_masterInfo.value(0, "RIGHT_DIV")) {
            case "10":
            case "20":
                ifr_main.location.replace(top.getRoot() + "/anyfive/ipims/patent/applymgt/intpatent/request/IntPatentRequestRD.jsp");
                break;
            case "30":
                ifr_main.location.replace(top.getRoot() + "/anyfive/ipims/patent/applymgt/design/intrequest/DesignIntRequestRD.jsp");
                break;
            case "40":
                ifr_main.location.replace(top.getRoot() + "/anyfive/ipims/patent/applymgt/tmark/intrequest/TMarkIntRequestRD.jsp");
                break;
            }
        }
    }

    prx.onFail = function()
    {
        this.error.show();
    }

    prx.execute();
}

//마스터 변경
function fnChangeMaster(refId)
{
    window.location.replace("MasterView.jsp?ID=" + refId);
}
</SCRIPT>
</HEAD>

<BODY scroll="no">

<IFRAME id="ifr_main" frameBorder="0" scrolling="no" width="100%" height="100%"></IFRAME>

</BODY>
</HTML>
