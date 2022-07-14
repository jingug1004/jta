package anyfive.ipims.patent.costmgt.slip.tax.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.costmgt.slip.tax.dao.TaxSlipDao;

public class TaxSlipBiz extends NAbstractServletBiz
{
    public TaxSlipBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 출원비용 전표작성대상 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveTaxSlipList(AjaxRequest xReq) throws NException
    {
        TaxSlipDao dao = new TaxSlipDao(this.nsr);

        return dao.retrieveTaxSlipList(xReq);
    }

    /**
     * 전표처리 비용 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveTaxSlipDetailList(AjaxRequest xReq) throws NException
    {
        TaxSlipDao dao = new TaxSlipDao(this.nsr);

        return dao.retrieveTaxSlipDetailList(xReq);
    }
}
