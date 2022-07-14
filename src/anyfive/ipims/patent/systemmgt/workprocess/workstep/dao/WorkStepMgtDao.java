package anyfive.ipims.patent.systemmgt.workprocess.workstep.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class WorkStepMgtDao extends NAbstractServletDao
{
    public WorkStepMgtDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 업무단계 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveWorkStepMgtList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/workprocess/workstep", "/retrieveWorkStepMgtList");
        dao.bind(xReq);

        if (xReq.getParam("BIZ_MGT_ID").equals("") != true) {
            dao.addQuery("bizMgtId");
        }

        if (xReq.getParam("BIZ_STEP_NAME").equals("") != true) {
            dao.addQuery("bizStepName");
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 업무단계 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveWorkStepMgt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/workprocess/workstep", "/retrieveWorkStepMgt");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 업무단계 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createWorkStepMgt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/workprocess/workstep", "/createWorkStepMgt");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 업무단계 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateWorkStepMgt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/workprocess/workstep", "/updateWorkStepMgt");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 업무단계 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteWorkStepMgt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/workprocess/workstep", "/deleteWorkStepMgt");
        dao.bind(xReq);

        return dao.executeUpdate();
    }
}
