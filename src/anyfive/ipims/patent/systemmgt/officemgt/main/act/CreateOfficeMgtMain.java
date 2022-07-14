package anyfive.ipims.patent.systemmgt.officemgt.main.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.ajax.AjaxResponse;
import anyfive.ipims.patent.systemmgt.officemgt.main.biz.OfficeMgtMainBiz;

/**
 * 사무소 생성
 */
public class CreateOfficeMgtMain implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        OfficeMgtMainBiz biz = new OfficeMgtMainBiz(nsr);
        String result = biz.createOfficeMgtMain(xReq);
        nsr.closeConnection();

        AjaxResponse xRes = new AjaxResponse(res);
        xRes.flush(result);
    }
}
