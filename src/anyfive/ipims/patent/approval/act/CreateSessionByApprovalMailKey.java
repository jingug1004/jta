package anyfive.ipims.patent.approval.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import anyfive.framework.session.SessionUtil;
import anyfive.framework.session.UserInfo;
import anyfive.ipims.patent.approval.biz.ApprovalListBiz;
import anyfive.ipims.share.login.biz.LoginBiz;

/**
 * 메일 KEY 로부터 세션정보 생성
 */
public class CreateSessionByApprovalMailKey
{
    public boolean execute(HttpServletRequest req, HttpServletResponse res) throws Exception
    {
        if (SessionUtil.getUserInfo(req).isLogin()) return true;

        String mailKey = req.getParameter("MAIL_KEY");

        if (mailKey == null || mailKey.equals("")) return false;

        NServiceResource nsr = new NServiceResource(req.getServletPath());

        nsr.openConnection();

        ApprovalListBiz biz = new ApprovalListBiz(nsr);
        String loginId = biz.retrieveLoginIdByApprovalMailKey(mailKey);

        if (loginId == null || loginId.equals("")) {
            nsr.closeConnection();
            res.reset();
            res.setContentType("text/html; charset=utf-8");
            res.getWriter().println("<SCRIPT language=\"JScript\">");
            res.getWriter().println("alert(\"올바르지 않은 KEY [" + mailKey + "] 입니다.\");");
            res.getWriter().println("</SCRIPT>");
            return false;
        }

        LoginBiz loginBiz = new LoginBiz(nsr);
        UserInfo userInfo = loginBiz.retrieveLogin(loginId, null, "");

        nsr.closeConnection();

        SessionUtil.setUserInfo(req, userInfo);

        return true;
    }
}
