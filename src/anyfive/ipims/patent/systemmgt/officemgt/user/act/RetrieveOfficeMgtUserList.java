package anyfive.ipims.patent.systemmgt.officemgt.user.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.grid.util.GridResponse;
import anyfive.ipims.patent.systemmgt.officemgt.user.biz.OfficeMgtUserBiz;

/**
 * 사무소 사용자 목록 조회
 */
public class RetrieveOfficeMgtUserList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        OfficeMgtUserBiz biz = new OfficeMgtUserBiz(nsr);
        NSingleData result = biz.retrieveOfficeMgtUserList(xReq);
        nsr.closeConnection();

        GridResponse xRes = new GridResponse(req, res);
        xRes.flush(result);
    }
}
