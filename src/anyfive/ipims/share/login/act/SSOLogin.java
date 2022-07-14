package anyfive.ipims.share.login.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.message.NMessage;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.session.SessionUtil;
import anyfive.framework.session.UserInfo;
import anyfive.ipims.share.login.biz.LoginBiz;

/**
 * SSO 로그인
 */
public class SSOLogin implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        String loginId = (String)req.getSession().getAttribute("USER_ID");

        if (loginId == null || loginId.equals("")) return;
        if (loginId.equals(SessionUtil.getUserInfo(req).getLoginId())) return;

        if (nsr == null) {
            nsr = new NServiceResource(req.getServletPath());
            nsr.message = new NMessage(nsr.langCode);
        }

        nsr.openConnection();
        LoginBiz biz = new LoginBiz(nsr);
        UserInfo userInfo = biz.retrieveLogin(loginId, null, "");
        nsr.closeConnection();

        SessionUtil.setUserInfo(req, userInfo);
    }
}
