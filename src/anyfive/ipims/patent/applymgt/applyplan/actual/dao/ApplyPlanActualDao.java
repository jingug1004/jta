package anyfive.ipims.patent.applymgt.applyplan.actual.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class ApplyPlanActualDao extends NAbstractServletDao
{
    public ApplyPlanActualDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 출원실적 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveApplyPlanActualList(AjaxRequest xReq , String year) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/applyplan/actual", "/retrieveApplyPlanActualList");
        dao.bind("PLAN_YEAR",year);
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }
}
