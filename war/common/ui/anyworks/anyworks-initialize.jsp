<%@ page pageEncoding="UTF-8" %><% response.setContentType("text/javascript"); %>
<% out.clear(); %><%= "/*" %> <script> <%= "*/" %>

(function() {
    <%--any.home = "<n:config path='/anyworks/ui/home' escape='js' />";--%>
    any.home = "/common/ui/anyworks";

    <%--any.meta.contextPath = "<n:url />";--%>
    any.meta.contextPath = "/JuSung_IPIMS";

    <%--any.meta.defaultLocale = "<n:config path='/anyworks/default-locale' escape='js' />";--%>
    any.meta.defaultLocale = "";
    <%--any.meta.userLocale = any.text.blank("<n:locale />", any.meta.defaultLocale);--%>
    any.meta.userLocale = any.text.blank("ko_KR", any.meta.defaultLocale);

    <%--any.meta.defaultLangCode = "<n:config path='/anyworks/default-lang-code' escape='js' />";--%>
    any.meta.defaultLangCode = "ko_KR";
    <%--any.meta.langCode = any.text.blank("<n:locale />", any.meta.defaultLangCode);--%>
    any.meta.langCode = any.text.blank("ko_KR", any.meta.defaultLangCode);

    any.rootWindow().any.meta.servletToken = "00by3Ii8ZOBBU2hCinEWQbP0NutiTbUJNBGZH6NGSuH32k66ea6WpZ3pgW2i9h13";

    any.url.servletPattern = {
        <%--pattern: "<n:config path='/anyworks/servlet/url-pattern/pattern' escape='js' />",--%>
        pattern: "",
        <%--prefix: "<n:config path='/anyworks/servlet/url-pattern/prefix' escape='js' />",--%>
        prefix: "",
        <%--suffix: "<n:config path='/anyworks/servlet/url-pattern/suffix' escape='js' />"--%>
        suffix: ".do"
    };

    any.message.invalidText = {
        <%--prefix: "<n:config path='/anyworks/message/invalid-text/prefix' escape='js' />",--%>
        prefix: "#",
        <%--suffix: "<n:config path='/anyworks/message/invalid-text/suffix' escape='js' />"--%>
        suffix: ""
    };

    <%--any.session().keep("<n:config path='/anyworks/session/keep/path' escape='js' />", {--%>
    <%--    value: "<n:config path='/anyworks/session/keep/interval/value' escape='js' />",--%>
    <%--    unit: "<n:config path='/anyworks/session/keep/interval/unit' escape='js' />"--%>
    <%--});--%>
    any.session().keep("/anyfive/framework/util/blank.jsp", {
        value: "25",
        unit: "minute"
    });

    <%--any.config["/anyworks/servlet-token-check/param-name"] = any.text.empty("<n:config path='/anyworks/servlet-token-check/param-name' escape='js' />", "_csrf");--%>
    any.config["/anyworks/servlet-token-check/param-name"] = any.text.empty("X-AnyWorks-Servlet-Token", "_csrf");
    any.config["/anyworks/loading/page/progressbar-mode"] = false;
    any.config["/anyworks/file/session-continuous-proxy"] = false;
    <%--any.config["/anyworks/paging/parameter-key"] = "<n:config path='/anyworks/paging/parameter-key' escape='js' />";--%>
    any.config["/anyworks/paging/parameter-key"] = "";
})();

<%= "/*" %> </script> <%= "*/" %>
