package anyfive.ipims.patent.costmgt.annual.payment.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.grid.util.GridResponse;
import anyfive.ipims.patent.costmgt.annual.payment.biz.AnnualPaymentBiz;

/**
 * 연차료 납부관리 목록 조회
 */
public class RetrieveAnnualPaymentList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        AnnualPaymentBiz biz = new AnnualPaymentBiz(nsr);
        NSingleData result = biz.retrieveAnnualPaymentList(xReq);
        nsr.closeConnection();

        GridResponse xRes = new GridResponse(req, res);
        xRes.flush(result);
    }
}
