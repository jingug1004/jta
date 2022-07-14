package anyfive.ipims.share.common.util;

import javax.servlet.http.HttpServletRequest;

import any.core.config.NConfig;
import anyfive.framework.session.SessionUtil;

public class SystemTypes
{
    public static final String PATENT = "PATENT";
    public static final String OFFICE = "OFFICE";

    public static final String getSystemType(HttpServletRequest req)
    {
        if (req.getServletPath().indexOf("/anyfive.ipims.patent.") != -1) return PATENT;
        if (req.getServletPath().indexOf("/anyfive/ipims/patent/") != -1) return PATENT;
        if (req.getServletPath().indexOf("/anyfive.ipims.office.") != -1) return OFFICE;
        if (req.getServletPath().indexOf("/anyfive/ipims/office/") != -1) return OFFICE;

        String systemType = SessionUtil.getUserInfo(req).getSystemType();

        if (PATENT.equals(systemType)) return PATENT;
        if (OFFICE.equals(systemType)) return OFFICE;

        return NConfig.getString(NConfig.DEFAULT_CONFIG + "/system-type", null);
    }

    public static final String getSystemRoot(HttpServletRequest req)
    {
        return getSystemRoot(getSystemType(req));
    }

    public static final String getSystemRoot(String systemType)
    {
        if (PATENT.equals(systemType)) return "/anyfive/ipims/patent";
        if (OFFICE.equals(systemType)) return "/anyfive/ipims/office";

        return NConfig.getString(NConfig.DEFAULT_CONFIG + "/system-root", null);
    }
}
