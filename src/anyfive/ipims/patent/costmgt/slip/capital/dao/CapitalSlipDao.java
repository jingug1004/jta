package anyfive.ipims.patent.costmgt.slip.capital.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class CapitalSlipDao extends NAbstractServletDao
{
    public CapitalSlipDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     *  자본적 지출 전표작성대상 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveCapitalSlipList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/slip/capital", "/retrieveCapitalSlipList");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 전표처리 비용 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveCapitalSlipDetailList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/slip/capital", "/retrieveCapitalSlipDetailList");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }
}
