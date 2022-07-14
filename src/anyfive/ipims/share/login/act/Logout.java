package anyfive.ipims.share.login.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import any.core.session.NSessionKeys;

/**
 * 로그아웃
 */
public class Logout implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        req.getSession().removeAttribute(NSessionKeys.USER_INFO);
    }
}
