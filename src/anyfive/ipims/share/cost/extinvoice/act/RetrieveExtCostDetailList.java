package anyfive.ipims.share.cost.extinvoice.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.grid.util.GridResponse;
import anyfive.ipims.share.cost.extinvoice.biz.ExtInvoiceBiz;

/**
 * 해외비용 상세목록 조회
 */
public class RetrieveExtCostDetailList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        ExtInvoiceBiz biz = new ExtInvoiceBiz(nsr);
        NSingleData result = biz.retrieveExtCostDetailList(xReq);
        nsr.closeConnection();

        GridResponse xRes = new GridResponse(req, res);
        xRes.flush(result);
    }
}
