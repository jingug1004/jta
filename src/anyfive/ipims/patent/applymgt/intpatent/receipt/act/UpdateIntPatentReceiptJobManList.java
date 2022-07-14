package anyfive.ipims.patent.applymgt.intpatent.receipt.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NMultiData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.intpatent.receipt.biz.IntPatentReceiptBiz;

/**
 * 건담당자지정 목록 담당자지정
 */
public class UpdateIntPatentReceiptJobManList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        String jobMan = xReq.getParam("JOB_MAN");
        NMultiData resList = xReq.getMultiData("ds_setJobManList");

        nsr.openConnection(true);
        IntPatentReceiptBiz biz = new IntPatentReceiptBiz(nsr);
        for (int i = 0; i < resList.getRowSize(); i++) {
            biz.updateIntPatentReceiptJobMan(resList.getString(i, "REF_ID"), jobMan);
            nsr.commitTrans();
        }
        nsr.closeConnection();
    }
}
