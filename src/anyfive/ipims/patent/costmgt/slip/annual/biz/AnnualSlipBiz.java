package anyfive.ipims.patent.costmgt.slip.annual.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.costmgt.slip.annual.dao.AnnualSlipDao;

public class AnnualSlipBiz extends NAbstractServletBiz
{
    public AnnualSlipBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 연차료 전표작성대상 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveAnnualSlipList(AjaxRequest xReq) throws NException
    {
        AnnualSlipDao dao = new AnnualSlipDao(this.nsr);

        return dao.retrieveAnnualSlipList(xReq);
    }

    /**
     * 연차료 전표처리 비용 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveAnnualSlipCostList(AjaxRequest xReq) throws NException
    {
        AnnualSlipDao dao = new AnnualSlipDao(this.nsr);

        return dao.retrieveAnnualSlipCostList(xReq);
    }
}
