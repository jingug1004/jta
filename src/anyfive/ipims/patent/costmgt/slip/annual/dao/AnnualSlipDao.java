package anyfive.ipims.patent.costmgt.slip.annual.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class AnnualSlipDao extends NAbstractServletDao
{
    public AnnualSlipDao(NServiceResource nsr)
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/slip/annual", "/retrieveAnnualSlipList");
        dao.bind(xReq);

        // 국내사무소
        if (xReq.getParam("OFFICE_CODE").equals("") != true) {
            dao.addQuery("officeCode");
        }
        // 국가구분
        if (xReq.getParam("INOUT_DIV").equals("") != true) {
            dao.addQuery("inoutDiv");
        }

        return dao.executeQueryForGrid(xReq);
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/slip/annual", "/retrieveAnnualSlipCostList");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }
}
