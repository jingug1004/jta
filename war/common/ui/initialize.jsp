<%@ page pageEncoding="UTF-8" %>
<% response.setContentType("text/javascript"); %>
<%@ page import="any.core.config.NConfig" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--<%@ taglib prefix="n" uri="http://framework.anyfive.com/anyworks14/jsp/tags" %>--%>
<%--<%@ include file="/common/ui/anyworks/anyworks-initialize.jsp" %>--%>
<%@ include file="/common/ui/anyworks/anyworks-initialize.jsp" %>
<%= "/*" %>
<script> <%= "*/" %>

(function () {
    <%--any.meta.dateFormat = "<n:config path='/config/date-format' escape='js' />";--%>
    any.meta.dateFormat = "yyyy-MM-dd";

<%--    <c:set var="uiThemeUserChangeable">"<n:config path='/config/ui/theme/user-changeable' />"--%>
<%--    </c:set>--%>
<%--    <c:choose>--%>
<%--    <c:when test="${uiThemeUserChangeable == true}">--%>
<%--    any.meta.themeName = any.cookie("THEME_NAME").get("<n:config path='/config/ui/theme/default-name' escape='js' />");--%>
<%--    </c:when>--%>
<%--    <c:otherwise>--%>
    <%--any.meta.themeName = "<n:config path="/config/ui/theme/default-name" escape="js" />";--%>
    any.meta.themeName = "custom/simple-blue";
<%--    </c:otherwise>--%>
<%--    </c:choose>--%>

    <%--    <c:set var='uiContentsWidth'>"<n:config path='/config/ui/contents-width' />"--%>
    <%--    </c:set>--%>
    <%--var uiContentsWidth = "<n:config path='/config/ui/contents-width' />"--%>
    <%--&lt;%&ndash;    <c:if test="${uiContentsWidth ne ''}">&ndash;%&gt;--%>
    <%--if (uiContentsWidth != '') {--%>
    <%--    any.containerWidth(function () {--%>
    <%--        if (any.topWindow().Menu != null) {--%>
    <%--            &lt;%&ndash;return "<n:text value='${uiContentsWidth}' escape='js' />" - any.topWindow().Menu.getLeftWidth();&ndash;%&gt;--%>
    <%--            return uiContentsWidth - any.topWindow().Menu.getLeftWidth();--%>
    <%--        }--%>
    <%--        // });--%>
    <%--    })--%>
    <%--    &lt;%&ndash;    </c:if>&ndash;%&gt;--%>
    <%--}--%>

    <% if (request.getParameter("mobile") == null) { %>
    any.loadStyle("/common/ui/jquery/themes/" + any.meta.themeName + "/jquery-ui.css", "css_theme");
    <% } %>

    var lang = any.meta.langCode.substr(0, 2).toLowerCase();

    $('html').attr({"lang": lang, "xml:lang": lang});
})();

(function () {
    any.config.booleanValues = "1,0";
    any.config.unicodeCharSize = 3;
    any.config.blockActivated = !!navigator.userAgent.match(/Trident\/(\d)/i);
    any.config.jQueryDialog = false;
    // any.config.messageLoader = "/infrastructure/message/MessageAct/retrieve";
    // any.config.codedataLoader = "/infrastructure/codedata/CodeDataAct/retrieve";
    any.config.scrollToPlugin = "${pageContext.request.contextPath}/common/ui/jquery/plugins/jquery.scrollTo/jquery.scrollTo.min.js";
    any.config.printWindow.url("${pageContext.request.contextPath}/common/util/print.jsp");

    any.progress().config("proxy.url", "/infrastructure/progress/ServletProgressAct/retrieve");

    <%--any.config.approvalInterface = {enable: "<n:config path='/config/interface/approval/enable' />"};--%>
    any.config.approvalInterface = {enable: false};
})();

(function () {
<%--    <c:set var="miniLoginEnable">"<n:config path='/config/login/mini/enable' />"--%>
<%--    </c:set>--%>

<%--    any.error("session").handler(function (error, callback, proxy) {--%>
<%--        <c:choose>--%>
<%--            <c:when test="${miniLoginEnable == true}">--%>
<%--            if (error.message != null && error.message != "" && !any.text.endsWith(error.message, "Exception")) {--%>
<%--                alert(error.message);--%>
<%--            }--%>
<%--            var win = any.window(true);--%>
<%--            win.url("/common.user.UserAct/viewLoginMini");--%>
<%--            win.ok(function () {--%>
<%--                if (callback != null) {--%>
<%--                    callback();--%>
<%--                }--%>
<%--                if (proxy != null) {--%>
<%--                    proxy.execute();--%>
<%--                }--%>
<%--            });--%>
<%--            win.show("miniLogin");--%>
<%--            </c:when>--%>
<%--        <c:otherwise>--%>
<%--            alert(any.message("msg.invalid.session.loggedOut", "오랫동안 사용하지 않아 로그아웃 되었습니다."));--%>
<%--            // any.topWindow().any.reloadPage();--%>
<%--        </c:otherwise>--%>
<%--        </c:choose>--%>
<%--    });--%>
})();

<%--any.body().end(function () {--%>
<%--    Layout.addPreviewFileExtensions("<n:config path='/config/pdf-converter/direct-view-extensions' />".split(","));--%>

<%--    <%--%>
<%--    ArrayList pdfViewTypeList = NConfig.getKeyNameList("/config/pdf-converter/pdf-view-type/extensions");--%>
<%--    for (int i = 0; i < pdfViewTypeList.size(); i++) {--%>
<%--        String typeExtensions = NConfig.getString("/config/pdf-converter/pdf-view-type/extensions[@name=\"" + pdfViewTypeList.get(i) + "\"]", "");--%>
<%--    %>--%>
<%--    Layout.addPreviewFileExtensions("<%= typeExtensions %>".split(","));--%>
<%--    <%--%>
<%--    }--%>
<%--    %>--%>
<%--});--%>
any.body().end(function () {
    Layout.addPreviewFileExtensions("pdf, bmp, jpg, gif, png".split(","));
    Layout.addPreviewFileExtensions("doc, docx, txt".split(","));
    Layout.addPreviewFileExtensions("ppt, pptx".split(","));
    Layout.addPreviewFileExtensions("xls, xlsx".split(","));
});

<%= "/*" %> </script>
<%= "*/" %>
