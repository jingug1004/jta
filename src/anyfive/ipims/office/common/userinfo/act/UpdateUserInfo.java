package anyfive.ipims.office.common.userinfo.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.office.common.userinfo.biz.UserInfoBiz;

/**
 * 사용자정보 수정(비밀번호)
 */
public class UpdateUserInfo implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        UserInfoBiz biz = new UserInfoBiz(nsr);
        biz.updateUserInfo(xReq);
        nsr.closeConnection();
    }
}
