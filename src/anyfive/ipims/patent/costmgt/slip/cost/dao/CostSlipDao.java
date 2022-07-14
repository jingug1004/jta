package anyfive.ipims.patent.costmgt.slip.cost.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class CostSlipDao extends NAbstractServletDao
{
    public CostSlipDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     *  출원비용 전표작성대상 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveCostSlipList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/slip/cost", "/retrieveCostSlipList");
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
     * 전표처리 비용 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveCostSlipDetailList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/slip/cost", "/retrieveCostSlipDetailList");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }
}
