package anyfive.ipims.office.reqreceipt.intapply.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.ajax.AjaxResponse;
import anyfive.ipims.office.reqreceipt.intapply.biz.IntApplyReceiptBiz;

/**
 * 국내출원의뢰접수 조회
 */
public class RetrieveIntApplyReceipt implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        IntApplyReceiptBiz biz = new IntApplyReceiptBiz(nsr);
        NSingleData result = biz.retrieveIntApplyReceipt(xReq);
        nsr.closeConnection();

        AjaxResponse xRes = new AjaxResponse(res);
        xRes.flushAll(result);
    }
}
