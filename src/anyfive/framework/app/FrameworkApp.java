package anyfive.framework.app;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;

public class FrameworkApp extends AbstractApp
{
    public FrameworkApp(HttpServletRequest req, HttpServletResponse res, JspWriter out) throws Exception
    {
        this(req, res, out, false, false);
    }

    public FrameworkApp(HttpServletRequest req, HttpServletResponse res, JspWriter out, boolean isAccessCheckSkip, boolean isSessionCheckSkip) throws Exception
    {
        super(req, res, out, isAccessCheckSkip, isSessionCheckSkip);
    }

    protected void appendHTMLHeader() throws Exception
    {
    }
}
