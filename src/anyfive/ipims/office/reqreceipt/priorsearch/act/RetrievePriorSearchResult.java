package anyfive.ipims.office.reqreceipt.priorsearch.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.ajax.AjaxResponse;
import anyfive.ipims.office.reqreceipt.priorsearch.biz.PriorSearchReceiptBiz;

/**
 * 조사의뢰결과 조회
 */
public class RetrievePriorSearchResult implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        PriorSearchReceiptBiz biz = new PriorSearchReceiptBiz(nsr);
        NSingleData result = biz.retrievePriorSearchResult(xReq);
        nsr.closeConnection();

        AjaxResponse xRes = new AjaxResponse(res);
        xRes.flushAll(result);
    }
}
