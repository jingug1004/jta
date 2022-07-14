package anyfive.ipims.patent.applymgt.intpatent.receipt.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.grid.util.GridResponse;
import anyfive.ipims.patent.applymgt.intpatent.receipt.biz.IntPatentReceiptBiz;

/**
 * 건담당자지정 목록 조회
 */
public class RetrieveIntPatentReceiptList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        IntPatentReceiptBiz biz = new IntPatentReceiptBiz(nsr);
        NSingleData result = biz.retrieveIntPatentReceiptList(xReq);
        nsr.closeConnection();

        GridResponse xRes = new GridResponse(req, res);
        xRes.flush(result);
    }
}
