package anyfive.ipims.patent.systemmgt.datahandle.costappcancle.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.grid.util.GridResponse;
import anyfive.ipims.patent.systemmgt.datahandle.costappcancle.biz.CostCancleBiz;

/**
 *  비용결재취소 목록 조회
 */
public class RetrieveCostCancleList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        CostCancleBiz biz = new CostCancleBiz(nsr);
        NSingleData result = biz.retrieveCostCancleList(xReq);
        nsr.closeConnection();

        GridResponse xRes = new GridResponse(req, res);
        xRes.flush(result);
    }
}
