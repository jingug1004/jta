package anyfive.ipims.office.reqreceipt.intapply.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.office.reqreceipt.intapply.biz.IntApplyReceiptBiz;

/**
 * 국내출원의뢰접수 저장
 */
public class UpdateIntApplyReceipt implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        IntApplyReceiptBiz biz = new IntApplyReceiptBiz(nsr);
        biz.updateIntApplyReceipt(xReq);
        nsr.closeConnection();
    }
}
