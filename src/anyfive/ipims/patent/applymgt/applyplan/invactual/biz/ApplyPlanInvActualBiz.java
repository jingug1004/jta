package anyfive.ipims.patent.applymgt.applyplan.invactual.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.applyplan.invactual.dao.ApplyPlanInvActualDao;

public class ApplyPlanInvActualBiz extends NAbstractServletBiz
{
    public ApplyPlanInvActualBiz(NServiceResource nsr)
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
        ApplyPlanInvActualDao dao = new ApplyPlanInvActualDao(this.nsr);

        return dao.retrieveApplyPlanInvActualList(xReq);
    }
}
