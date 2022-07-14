package anyfive.ipims.patent.applymgt.priorsearch.receipt.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.priorsearch.receipt.biz.PriorSearchReceiptBiz;

/**
 * 조사의뢰접수 담당자지정
 */
public class UpdatePriorSearchReceiptJobMan implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        PriorSearchReceiptBiz biz = new PriorSearchReceiptBiz(nsr);
        biz.updatePriorSearchReceiptJobMan(xReq.getParam("PRSCH_ID"), xReq.getParam("JOB_MAN"));
        nsr.closeConnection();
    }
}
