package anyfive.ipims.patent.applymgt.intpatent.receipt.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.intpatent.receipt.biz.IntPatentReceiptBiz;

/**
 * 건담당자지정 담당자지정
 */
public class UpdateIntPatentReceiptJobMan implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        IntPatentReceiptBiz biz = new IntPatentReceiptBiz(nsr);
        biz.updateIntPatentReceiptJobMan(xReq.getParam("REF_ID"), xReq.getParam("JOB_MAN"));
        nsr.closeConnection();
    }
}
