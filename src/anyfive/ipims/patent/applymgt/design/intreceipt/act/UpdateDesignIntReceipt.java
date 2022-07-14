package anyfive.ipims.patent.applymgt.design.intreceipt.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.design.intreceipt.biz.DesignIntReceiptBiz;

/**
 * 디자인국내출원의뢰 상세 담당자지정
 */
public class UpdateDesignIntReceipt implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        DesignIntReceiptBiz biz = new DesignIntReceiptBiz(nsr);
        biz.updateDesignIntReceiptJobMan(xReq.getParam("REF_ID"), xReq.getParam("JOB_MAN"));
        nsr.closeConnection();
    }
}
