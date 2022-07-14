package anyfive.ipims.patent.common.app;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;

import anyfive.ipims.share.common.app.ShareApp;
import anyfive.ipims.share.common.util.SystemTypes;

public class PatentApp extends ShareApp
{
    public final String HTC_APPROVAL;
    public final String HTC_IPBHIST;

    public PatentApp(HttpServletRequest req, HttpServletResponse res, JspWriter out) throws Exception
    {
        this(req, res, out, false, false);
    }

    public PatentApp(HttpServletRequest req, HttpServletResponse res, JspWriter out, boolean isAccessCheckSkip, boolean isSessionCheckSkip) throws Exception
    {
        super(req, res, out, isAccessCheckSkip, isSessionCheckSkip);

        super.checkSystemType(SystemTypes.PATENT, isSessionCheckSkip);

        this.HTC_APPROVAL = "/anyfive/ipims/patent/common/approval/ApprovalHTC.jsp";
        this.HTC_IPBHIST = "/anyfive/ipims/patent/ipbiz/history/IpBizHistoryHTC.jsp";
    }
}
