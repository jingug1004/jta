package anyfive.ipims.office.reqreceipt.dispute.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.office.reqreceipt.dispute.biz.DisputeReceiptBiz;

/**
 * 분쟁/소송의뢰접수 저장
 */
public class UpdateDisputeReceipt implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        DisputeReceiptBiz biz = new DisputeReceiptBiz(nsr);
        biz.updateDisputeReceipt(xReq);
        nsr.closeConnection();
    }
}
