package anyfive.ipims.office.costmgt.request.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.office.costmgt.request.dao.CostRequestDao;

public class CostRequestBiz extends NAbstractServletBiz
{
    public CostRequestBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 비용청구 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveCostRequestList(AjaxRequest xReq) throws NException
    {
        CostRequestDao dao = new CostRequestDao(this.nsr);

        return dao.retrieveCostRequestList(xReq);
    }
}
