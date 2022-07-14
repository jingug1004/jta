package anyfive.ipims.office.reqreceipt.priorsearch.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.office.reqreceipt.priorsearch.biz.PriorSearchReceiptBiz;

/**
 * 조사의뢰결과 저장
 */
public class UpdatePriorSearchResult implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        PriorSearchReceiptBiz biz = new PriorSearchReceiptBiz(nsr);
        biz.updatePriorSearchResult(xReq);
        nsr.closeConnection();
    }
}
