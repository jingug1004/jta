package anyfive.ipims.office.reqreceipt.extapply.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.office.reqreceipt.extapply.biz.ExtApplyReceiptBiz;

/**
 * 해외출원의뢰접수 저장
 */
public class UpdateExtApplyReceipt implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        ExtApplyReceiptBiz biz = new ExtApplyReceiptBiz(nsr);
        biz.updateExtApplyReceipt(xReq);
        nsr.closeConnection();
    }
}
