package anyfive.ipims.patent.applymgt.priorsearch.receipt.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NMultiData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.priorsearch.receipt.biz.PriorSearchReceiptBiz;

/**
 * 조사의뢰접수 목록 담당자지정
 */
public class UpdatePriorSearchReceiptJobManList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        String jobMan = xReq.getParam("JOB_MAN");
        NMultiData resList = xReq.getMultiData("ds_setJobManList");

        nsr.openConnection(true);
        PriorSearchReceiptBiz biz = new PriorSearchReceiptBiz(nsr);
        for (int i = 0; i < resList.getRowSize(); i++) {
            biz.updatePriorSearchReceiptJobMan(resList.getString(i, "PRSCH_ID"), jobMan);
            nsr.commitTrans();
        }
        nsr.closeConnection();
    }
}
