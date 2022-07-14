package anyfive.ipims.share.cost.extinvoice.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.share.cost.extinvoice.biz.ExtInvoiceBiz;

/**
 * 해외비용 일괄확인
 */
public class UpdateExtCostConfirmYn implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        ExtInvoiceBiz biz = new ExtInvoiceBiz(nsr);
        biz.updateExtCostConfirmYn(xReq);
        nsr.closeConnection();
    }
}
