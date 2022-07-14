package anyfive.ipims.office.costmgt.extinvoice.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.office.costmgt.extinvoice.dao.ExtInvoiceDao;

public class ExtInvoiceBiz extends NAbstractServletBiz
{
    public ExtInvoiceBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 해외비용 INVOICE 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveExtInvoiceList(AjaxRequest xReq) throws NException
    {
        ExtInvoiceDao dao = new ExtInvoiceDao(this.nsr);

        return dao.retrieveExtInvoiceList(xReq);
    }
}
