package anyfive.ipims.patent.costmgt.slip.cost.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.costmgt.slip.cost.dao.CostSlipDao;

public class CostSlipBiz extends NAbstractServletBiz
{
    public CostSlipBiz(NServiceResource nsr)
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
    public NSingleData retrieveCostSlipList(AjaxRequest xReq) throws NException
    {
        CostSlipDao dao = new CostSlipDao(this.nsr);

        return dao.retrieveCostSlipList(xReq);
    }

    /**
     * 전표처리 비용 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveCostSlipDetailList(AjaxRequest xReq) throws NException
    {
        CostSlipDao dao = new CostSlipDao(this.nsr);

        return dao.retrieveCostSlipDetailList(xReq);
    }
}
