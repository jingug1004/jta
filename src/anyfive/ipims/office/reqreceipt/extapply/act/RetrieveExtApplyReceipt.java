package anyfive.ipims.office.reqreceipt.extapply.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.ajax.AjaxResponse;
import anyfive.ipims.office.reqreceipt.extapply.biz.ExtApplyReceiptBiz;

/**
 * 해외출원의뢰접수 조회
 */
public class RetrieveExtApplyReceipt implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        ExtApplyReceiptBiz biz = new ExtApplyReceiptBiz(nsr);
        NSingleData result = biz.retrieveExtApplyReceipt(xReq);
        nsr.closeConnection();

        AjaxResponse xRes = new AjaxResponse(res);
        xRes.flushAll(result);
    }
}
