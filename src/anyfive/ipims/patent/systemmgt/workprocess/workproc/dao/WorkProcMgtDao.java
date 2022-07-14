package anyfive.ipims.patent.systemmgt.workprocess.workproc.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class WorkProcMgtDao extends NAbstractServletDao
{
    public WorkProcMgtDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 업무프로세스 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveWorkProcMgtList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/workprocess/workproc", "/retrieveWorkProcMgtList");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 업무프로세스 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveWorkProcMgt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/workprocess/workproc", "/retrieveWorkProcMgt");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 업무프로세스 시퀀스 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveWorkProcMgtForCreate(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/workprocess/workproc", "/retrieveWorkProcMgtForCreate");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 업무프로세스 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createWorkProcMgt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/workprocess/workproc", "/createWorkProcMgt");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 업무프로세스 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateWorkProcMgt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/workprocess/workproc", "/updateWorkProcMgt");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 업무프로세스 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteWorkProcMgt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/workprocess/workproc", "/deleteWorkProcMgt");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 업무프로세스 표시순서 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int[] updateWorkProcMgtDispOrdList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/workprocess/workproc", "/updateWorkProcMgtDispOrdList");
        dao.bind(xReq);

        return dao.executeBatch(xReq.getMultiData("ds_workProcMgtList"));
    }
}
