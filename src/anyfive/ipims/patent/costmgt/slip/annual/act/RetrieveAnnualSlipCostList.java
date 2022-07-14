package anyfive.ipims.patent.costmgt.slip.annual.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.grid.util.GridResponse;
import anyfive.ipims.patent.costmgt.slip.annual.biz.AnnualSlipBiz;

/**
 * 연차료 전표처리 비용 목록 조회
 */
public class RetrieveAnnualSlipCostList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        AnnualSlipBiz biz = new AnnualSlipBiz(nsr);
        NSingleData result = biz.retrieveAnnualSlipCostList(xReq);
        nsr.closeConnection();

        GridResponse xRes = new GridResponse(req, res);
        xRes.flush(result);
    }
}
