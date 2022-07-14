package anyfive.ipims.patent.systemmgt.basecode.costcode.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.basecode.costcode.biz.CostCodeBiz;

/**
 * 비용대분류 삭제
 */
public class DeleteCostCode implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        CostCodeBiz biz = new CostCodeBiz(nsr);
        biz.deleteCostCode(xReq);
        nsr.closeConnection();
    }
}
