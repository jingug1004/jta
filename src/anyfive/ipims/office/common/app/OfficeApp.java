package anyfive.ipims.office.common.app;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;

import anyfive.ipims.share.common.app.ShareApp;
import anyfive.ipims.share.common.util.SystemTypes;

public class OfficeApp extends ShareApp
{
    public OfficeApp(HttpServletRequest req, HttpServletResponse res, JspWriter out) throws Exception
    {
        this(req, res, out, false, false);
    }

    public OfficeApp(HttpServletRequest req, HttpServletResponse res, JspWriter out, boolean isAccessCheckSkip, boolean isSessionCheckSkip) throws Exception
    {
        super(req, res, out, isAccessCheckSkip, isSessionCheckSkip);

        super.checkSystemType(SystemTypes.OFFICE, isSessionCheckSkip);
    }
}
