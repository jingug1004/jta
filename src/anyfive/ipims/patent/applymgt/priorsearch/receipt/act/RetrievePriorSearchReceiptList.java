package anyfive.ipims.patent.applymgt.priorsearch.receipt.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.grid.util.GridResponse;
import anyfive.ipims.patent.applymgt.priorsearch.receipt.biz.PriorSearchReceiptBiz;

/**
 * 조사의뢰접수 목록 조회
 */
public class RetrievePriorSearchReceiptList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        PriorSearchReceiptBiz biz = new PriorSearchReceiptBiz(nsr);
        NSingleData result = biz.retrievePriorSearchReceiptList(xReq);
        nsr.closeConnection();

        GridResponse xRes = new GridResponse(req, res);
        xRes.flush(result);
    }
}
