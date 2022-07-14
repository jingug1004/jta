package anyfive.ipims.patent.applymgt.tmark.intreceipt.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NMultiData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.tmark.intreceipt.biz.TMarkIntReceiptBiz;

/**
 * 상표 건담당자지정 목록
 */
public class UpdateTMarkIntReceiptJobManList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        String jobMan = xReq.getParam("JOB_MAN");
        NMultiData resList = xReq.getMultiData("ds_setJobManList");

        nsr.openConnection(true);
        TMarkIntReceiptBiz biz = new TMarkIntReceiptBiz(nsr);
        for (int i = 0; i < resList.getRowSize(); i++) {
            biz.updateTMarkIntReceiptJobMan(resList.getString(i, "REF_ID"), jobMan);
            nsr.commitTrans();
        }
        nsr.closeConnection();
    }
}
