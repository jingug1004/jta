package anyfive.ipims.office.costmgt.costview.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.office.costmgt.costview.dao.CostViewDao;

public class CostViewBiz extends NAbstractServletBiz
{
    public CostViewBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 건별비용현황 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveCostViewList(AjaxRequest xReq) throws NException
    {
        CostViewDao dao = new CostViewDao(this.nsr);

        return dao.retrieveCostViewList(xReq);
    }

    /**
     * 건별비용현황 상세비용 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData RetrieveCostViewInputList(AjaxRequest xReq) throws NException
    {
        CostViewDao dao = new CostViewDao(this.nsr);

        return dao.RetrieveCostViewInputList(xReq);
    }
}
