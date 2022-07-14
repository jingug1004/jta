package anyfive.ipims.office.costmgt.extinvoice.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.grid.util.GridResponse;
import anyfive.ipims.office.costmgt.extinvoice.biz.ExtInvoiceBiz;

/**
 * 해외비용 INVOICE 목록 조회
 */
public class RetrieveExtInvoiceList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        ExtInvoiceBiz biz = new ExtInvoiceBiz(nsr);
        NSingleData result = biz.retrieveExtInvoiceList(xReq);
        nsr.closeConnection();

        GridResponse xRes = new GridResponse(req, res);
        xRes.flush(result);
    }
}
