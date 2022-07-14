package anyfive.ipims.patent.costmgt.slip.reject.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class RejectSlipDao extends NAbstractServletDao
{
    public RejectSlipDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 거절 전표작성대상 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveRejectSlipList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/slip/reject", "/retrieveRejectSlipList");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 거절 전표 비용목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveRejectSlipCostList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/slip/reject", "/retrieveRejectSlipCostList");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }
}
