package anyfive.ipims.share.login.util;

import javax.servlet.http.HttpServletRequest;

import any.core.config.NConfig;

public class LoginUtil
{
    /**
     * 관리자 로그인 가능 여부 반환
     *
     * @param req
     * @return
     */
    public static boolean isAdminLoginAvail(HttpServletRequest req)
    {
        if (NConfig.getString("/security/admin-key").equals(req.getParameter("key"))) return true;

        if (NConfig.getBoolean(NConfig.DEFAULT_CONFIG + "/admin-login/ip[@name=\"*\"]")) return true;

        String ip = req.getRemoteAddr();

        if (NConfig.getBoolean(NConfig.DEFAULT_CONFIG + "/admin-login/ip[@name=\"" + ip + "\"]")) return true;

        for (int i = 1; i <= ip.length(); i++) {
            if (NConfig.getBoolean(NConfig.DEFAULT_CONFIG + "/admin-login/ip[@name=\"" + ip.substring(0, i) + "*\"]")) return true;
        }

        return false;
    }
}
