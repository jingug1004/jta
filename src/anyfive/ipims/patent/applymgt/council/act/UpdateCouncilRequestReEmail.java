package anyfive.ipims.patent.applymgt.council.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.ajax.AjaxResponse;
import anyfive.ipims.patent.applymgt.council.biz.CouncilEvlBiz;

public class UpdateCouncilRequestReEmail implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        CouncilEvlBiz biz = new CouncilEvlBiz(nsr);
        biz.updateCouncilRequestReEmail(xReq);
        nsr.closeConnection();

        AjaxResponse xRes = new AjaxResponse(res);
        xRes.flush("");
    }
}
