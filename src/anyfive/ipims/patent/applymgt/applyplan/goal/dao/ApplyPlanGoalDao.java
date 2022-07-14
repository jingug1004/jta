package anyfive.ipims.patent.applymgt.applyplan.goal.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class ApplyPlanGoalDao extends NAbstractServletDao
{
    public ApplyPlanGoalDao(NServiceResource nsr)
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/applyplan/goal", "/retrieveApplyPlanGoalList");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 출원목표수립 목록 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteApplyPlanGoalList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/applyplan/goal", "/deleteApplyPlanGoalList");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 출원목표수립 목록 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int[] createApplyPlanGoalList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/applyplan/goal", "/createApplyPlanGoal");
        dao.bind(xReq);

        return dao.executeBatch(xReq.getMultiData("ds_applyPlanGoalList"));
    }

    /**
     * 출원목표수립 코드 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteAppcode(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/applyplan/goal", "/deleteAppcode");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 출원목표수립 코드 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int creatAppcode(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/applyplan/goal", "/creatAppcode");
        dao.bind(xReq);

        return dao.executeUpdate();
    }
}
