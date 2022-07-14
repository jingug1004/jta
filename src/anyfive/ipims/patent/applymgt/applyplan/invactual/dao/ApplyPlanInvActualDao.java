package anyfive.ipims.patent.applymgt.applyplan.invactual.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.session.SessionUtil;

public class ApplyPlanInvActualDao extends NAbstractServletDao
{
    public ApplyPlanInvActualDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 출원실적 목록 조회 - 발명자별
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveApplyPlanInvActualList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/applyplan/invactual", "/retrieveApplyPlanInvActualList");
        dao.bind(xReq);

        dao.bind("DEPT_CODE", SessionUtil.getUserInfo(this.nsr).getDeptCode());

        return dao.executeQueryForGrid(xReq);
    }
}
