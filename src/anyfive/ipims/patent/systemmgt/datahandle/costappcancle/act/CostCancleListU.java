package anyfive.ipims.patent.systemmgt.datahandle.costappcancle.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.datahandle.costappcancle.biz.CostCancleBiz;

/**
 *  비용결재취소 목록 취소
 */
public class CostCancleListU implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        CostCancleBiz biz = new CostCancleBiz(nsr);
        biz.costcancleListU(xReq);
        nsr.closeConnection();
    }
}
