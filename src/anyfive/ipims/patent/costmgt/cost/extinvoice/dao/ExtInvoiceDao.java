package anyfive.ipims.patent.costmgt.cost.extinvoice.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class ExtInvoiceDao extends NAbstractServletDao
{
    public ExtInvoiceDao(NServiceResource nsr)
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/cost/extinvoice", "/retrieveExtInvoiceList");
        dao.bind(xReq);

        // INVOICE 제목
        if (xReq.getParam("LETTER_SUBJECT").equals("") != true) {
            dao.addQuery("letterSubject");
        }

        // REF-NO
        if (xReq.getParam("REF_NO").equals("") != true) {
            dao.addQuery("refNo");
        }

        // 작성일
        if (xReq.getParam("DATE_START").equals("") != true) {
            dao.addQuery("dateStart");
        }
        if (xReq.getParam("DATE_END").equals("") != true) {
            dao.addQuery("dateEnd");
        }

        return dao.executeQueryForGrid(xReq);
    }
}
