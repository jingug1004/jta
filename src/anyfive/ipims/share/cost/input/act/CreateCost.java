package anyfive.ipims.share.cost.input.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.share.cost.input.biz.CostInputBiz;

/**
 * 비용 생성
 */
public class CreateCost implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        CostInputBiz biz = new CostInputBiz(nsr);
        biz.createCost(xReq);
        nsr.closeConnection();
    }
}
