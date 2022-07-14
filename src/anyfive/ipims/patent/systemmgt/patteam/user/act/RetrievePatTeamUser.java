package anyfive.ipims.patent.systemmgt.patteam.user.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.ajax.AjaxResponse;
import anyfive.ipims.patent.systemmgt.patteam.user.biz.PatTeamUserBiz;

/**
 * 특허팀 사용자 조회
 */
public class RetrievePatTeamUser implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        PatTeamUserBiz biz = new PatTeamUserBiz(nsr);
        NSingleData result = biz.retrievePatTeamUser(xReq);
        nsr.closeConnection();

        AjaxResponse xRes = new AjaxResponse(res);
        xRes.flush(result, "ds_mainInfo");
    }
}
