package anyfive.framework.userlog.act;

import java.net.InetAddress;
import java.net.UnknownHostException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.config.NConfig;
import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import anyfive.framework.session.SessionUtil;
import anyfive.framework.userlog.biz.UserLogBiz;
import anyfive.ipims.share.common.util.SystemTypes;

/**
 * 사용자 로그 생성
 */
public class CreateUserLog
{
    public static void execute(HttpServletRequest req, HttpServletResponse res, String errorMsg)
    {
        if (NConfig.getBoolean("/config/user-log/enable") != true) return;

        String servletPath = req.getServletPath();

        if (isSkipPath(servletPath)) return;

        String systemType = SessionUtil.getUserInfo(req).getSystemType();

        if (systemType == null || systemType.equals("")) {
            systemType = SystemTypes.getSystemType(req);
        }

        if (systemType == null || systemType.equals("")) return;

        String userId = SessionUtil.getUserInfo(req).getUserId();

        String serverIp = null;

        try {
            serverIp = InetAddress.getLocalHost().getHostAddress();
        } catch (UnknownHostException e) {
            serverIp = req.getServerName();
        }

        NSingleData logInfo = new NSingleData();

        logInfo.setString("SYSTEM_TYPE", systemType);
        logInfo.setString("USER_ID", userId);
        logInfo.setString("LOG_TYPE", servletPath.indexOf("/anyfive.ipims.share.login.act.") != -1 ? "0" : "1");
        logInfo.setString("CLIENT_IP", SessionUtil.getClientIp(req));
        logInfo.setString("SERVER_IP", serverIp);
        logInfo.setString("REFERER_URL", req.getHeader("referer"));
        logInfo.setString("SERVLET_PATH", servletPath);
        logInfo.setString("ERROR_YN", errorMsg == null ? "0" : "1");
        logInfo.setString("ERROR_MSG", errorMsg);

        NServiceResource nsr = new NServiceResource();

        try {
            nsr.openConnection();
            new UserLogBiz(nsr).createUserLog(logInfo);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                nsr.closeConnection();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    private static boolean isSkipPath(String servletPath)
    {
        if (servletPath == null || servletPath.equals("")) return true;

        String configPath = "/config/user-log/skip-path-list/skip";

        if (NConfig.getBoolean(configPath + "[@path=\"" + servletPath + "\"]")) return true;

        for (int i = 1; i <= servletPath.length(); i++) {
            if (NConfig.getBoolean(configPath + "[@path=\"" + servletPath.substring(0, i) + "*\"]")) return true;
        }

        return false;
    }
}
