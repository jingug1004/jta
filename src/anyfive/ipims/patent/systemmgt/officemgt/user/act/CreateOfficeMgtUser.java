package anyfive.ipims.patent.systemmgt.officemgt.user.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.ajax.AjaxResponse;
import anyfive.ipims.patent.systemmgt.officemgt.user.biz.OfficeMgtUserBiz;

/**
 * 사무소 사용자 생성
 */
public class CreateOfficeMgtUser implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        OfficeMgtUserBiz biz = new OfficeMgtUserBiz(nsr);
        String result = biz.createOfficeMgtUser(xReq);
        nsr.closeConnection();

        AjaxResponse xRes = new AjaxResponse(res);
        xRes.flush(result);
    }
}
