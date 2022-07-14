package anyfive.ipims.patent.applymgt.tmark.intreceipt.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.tmark.intreceipt.biz.TMarkIntReceiptBiz;

/**
 * 상표국내출원의뢰 담당자지정
 */
public class UpdateTMarkIntReceipt implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        TMarkIntReceiptBiz biz = new TMarkIntReceiptBiz(nsr);
        biz.updateTMarkIntReceiptJobMan(xReq.getParam("REF_ID"), xReq.getParam("JOB_MAN"));
        nsr.closeConnection();
    }
}
