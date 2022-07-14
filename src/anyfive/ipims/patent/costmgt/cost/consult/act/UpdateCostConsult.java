package anyfive.ipims.patent.costmgt.cost.consult.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.costmgt.cost.consult.biz.CostConsultBiz;

/**
 * 출원비용 품의서 수정
 */
public class UpdateCostConsult implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        CostConsultBiz biz = new CostConsultBiz(nsr);
        biz.updateCostConsult(xReq);
        nsr.closeConnection();

    }
}
