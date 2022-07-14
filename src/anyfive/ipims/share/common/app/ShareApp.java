package anyfive.ipims.share.common.app;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;

import anyfive.framework.app.AbstractApp;
import anyfive.framework.session.SessionUtil;
import anyfive.ipims.share.common.util.SystemTypes;
import anyfive.ipims.share.login.act.SSOLogin;

public class ShareApp extends AbstractApp
{
    public final String HTC_WORKPROC;

    public ShareApp(HttpServletRequest req, HttpServletResponse res, JspWriter out) throws Exception
    {
        this(req, res, out, false, false);
    }

    public ShareApp(HttpServletRequest req, HttpServletResponse res, JspWriter out, boolean isAccessCheckSkip, boolean isSessionCheckSkip) throws Exception
    {
        super(req, res, out, isAccessCheckSkip, isSessionCheckSkip);

        new SSOLogin().execute(this.req, this.res, null);

        this.checkSystemType(SessionUtil.getUserInfo(req).getSystemType(), isSessionCheckSkip);

        this.HTC_WORKPROC = "/anyfive/ipims/share/workproc/WorkProcHTC.jsp";
    }

    public void checkSystemType(String systemType, boolean isSessionCheckSkip) throws Exception
    {
        if (systemType == null) return;
        if (super.userInfo.isLogin() != true) return;
        if (systemType.equals(super.userInfo.getSystemType()) == true) return;

        SessionUtil.invalidate(super.req);

        super.checkValidSession(isSessionCheckSkip);
    }

    protected void appendHTMLHeader() throws Exception
    {
        if (SystemTypes.getSystemRoot(this.req) != null) {
            super.out.println("<LINK rel=\"StyleSheet\" type=\"text/css\" href=\"" + this.req.getContextPath() + SystemTypes.getSystemRoot(this.req) + "/common/htc/common.jsp\">");
        }
    }
}
