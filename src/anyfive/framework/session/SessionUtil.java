package anyfive.framework.session;

import javax.servlet.http.HttpServletRequest;

import any.core.config.NConfig;
import any.core.service.common.NServiceResource;
import any.core.session.NAbstractSessionUtil;
import any.core.session.NSessionKeys;

public class SessionUtil extends NAbstractSessionUtil
{
    private static final long serialVersionUID = -6660902920932672772L;

    private SessionUtil()
    {
    }

    public static String getClientIp(HttpServletRequest req)
    {
        String clientIp = req.getHeader("WL-Proxy-Client-IP");

        if (clientIp == null || clientIp.equals("")) clientIp = req.getRemoteAddr();

        return clientIp;
    }

    public static UserInfo getUserInfo(NServiceResource nsr)
    {
        return (UserInfo)nsr.userInfo;
    }

    public static UserInfo getUserInfo(HttpServletRequest req)
    {
        UserInfo userInfo = (UserInfo)req.getSession().getAttribute(NSessionKeys.USER_INFO);

        if (userInfo == null) return new UserInfo();

        return userInfo;
    }

    public static void setUserInfo(HttpServletRequest req, UserInfo userInfo)
    {
        req.getSession().setAttribute(NSessionKeys.USER_INFO, userInfo);

        if (NConfig.getString(NConfig.DEFAULT_CONFIG + "/session-timeout").equals("") != true) {
            req.getSession().setMaxInactiveInterval(NConfig.getInt(NConfig.DEFAULT_CONFIG + "/session-timeout"));
        }
    }
}
