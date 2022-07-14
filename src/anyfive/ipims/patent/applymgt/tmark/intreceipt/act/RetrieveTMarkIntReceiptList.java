package anyfive.ipims.patent.applymgt.tmark.intreceipt.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.grid.util.GridResponse;
import anyfive.ipims.patent.applymgt.tmark.intreceipt.biz.TMarkIntReceiptBiz;

/**
 * 상표 국내출원의뢰 조회
 */
public class RetrieveTMarkIntReceiptList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        TMarkIntReceiptBiz biz = new TMarkIntReceiptBiz(nsr);
        NSingleData result = biz.retrieveTMarkIntReceiptList(xReq);
        nsr.closeConnection();

        GridResponse xRes = new GridResponse(req, res);
        xRes.flush(result);
    }
}
