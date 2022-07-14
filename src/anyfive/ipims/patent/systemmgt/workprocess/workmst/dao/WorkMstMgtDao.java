package anyfive.ipims.patent.systemmgt.workprocess.workmst.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class WorkMstMgtDao extends NAbstractServletDao
{
    public WorkMstMgtDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 업무 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveWorkMstMgtList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/workprocess/workmst", "/retrieveWorkMstMgtList");
        dao.bind(xReq);

        if (xReq.getParam("BIZ_MGT_NAME").equals("") != true) {
            dao.addQuery("bizMgtName");
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 업무 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveWorkMstMgt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/workprocess/workmst", "/retrieveWorkMstMgt");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 업무 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createWorkMstMgt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/workprocess/workmst", "/createWorkMstMgt");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 업무 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateWorkMstMgt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/workprocess/workmst", "/updateWorkMstMgt");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 업무 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteWorkMstMgt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/workprocess/workmst", "/deleteWorkMstMgt");
        dao.bind(xReq);

        return dao.executeUpdate();
    }
}
