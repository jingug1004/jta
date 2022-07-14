package anyfive.ipims.share.cost.request.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.share.cost.request.biz.CostRequestBiz;

/**
 * 국내비용청구 삭제
 */
public class DeleteIntCostRequest implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        CostRequestBiz biz = new CostRequestBiz(nsr);
        biz.deleteIntCostRequest(xReq);
        nsr.closeConnection();
    }
}
