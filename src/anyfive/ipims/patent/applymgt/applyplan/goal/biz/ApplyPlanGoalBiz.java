package anyfive.ipims.patent.applymgt.applyplan.goal.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.applyplan.goal.dao.ApplyPlanGoalDao;

public class ApplyPlanGoalBiz extends NAbstractServletBiz
{
    public ApplyPlanGoalBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 출원목표수립 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveApplyPlanGoalList(AjaxRequest xReq) throws NException
    {
        ApplyPlanGoalDao dao = new ApplyPlanGoalDao(this.nsr);

        return dao.retrieveApplyPlanGoalList(xReq);
    }

    /**
     * 출원목표수립 목록 저장
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateApplyPlanGoalList(AjaxRequest xReq) throws NException
    {
        ApplyPlanGoalDao dao = new ApplyPlanGoalDao(this.nsr);

        dao.deleteApplyPlanGoalList(xReq);
        dao.createApplyPlanGoalList(xReq);
    }

    /**
     * 출원목표수립 코드 저장
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void addAppcode(AjaxRequest xReq) throws NException
    {
        ApplyPlanGoalDao dao = new ApplyPlanGoalDao(this.nsr);

        dao.deleteAppcode(xReq);
        dao.creatAppcode(xReq);
    }
}
