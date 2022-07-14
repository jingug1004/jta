package anyfive.ipims.office.reqreceipt.dispute.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.grid.util.GridResponse;
import anyfive.ipims.office.reqreceipt.dispute.biz.DisputeReceiptBiz;

/**
 * 분쟁/소송의뢰접수 목록 조회
 */
public class RetrieveDisputeReceiptList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        DisputeReceiptBiz biz = new DisputeReceiptBiz(nsr);
        NSingleData result = biz.retrieveDisputeReceiptList(xReq);
        nsr.closeConnection();

        GridResponse xRes = new GridResponse(req, res);
        xRes.flush(result);
    }
}
