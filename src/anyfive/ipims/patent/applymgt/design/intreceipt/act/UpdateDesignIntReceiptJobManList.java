package anyfive.ipims.patent.applymgt.design.intreceipt.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NMultiData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.design.intreceipt.biz.DesignIntReceiptBiz;

/**
 * 디자인 건담당자지정 목록
 */
public class UpdateDesignIntReceiptJobManList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        String jobMan = xReq.getParam("JOB_MAN");
        NMultiData resList = xReq.getMultiData("ds_setJobManList");

        nsr.openConnection(true);
        DesignIntReceiptBiz biz = new DesignIntReceiptBiz(nsr);
        for (int i = 0; i < resList.getRowSize(); i++) {
            biz.updateDesignIntReceiptJobMan(resList.getString(i, "REF_ID"), jobMan);
            nsr.commitTrans();
        }
        nsr.closeConnection();
    }
}
