package anyfive.ipims.patent.systemmgt.workprocess.workproc.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.workprocess.workproc.dao.WorkProcMgtDao;

public class WorkProcMgtBiz extends NAbstractServletBiz
{
    public WorkProcMgtBiz(NServiceResource nsr)
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
        WorkProcMgtDao dao = new WorkProcMgtDao(this.nsr);

        return dao.retrieveWorkProcMgtList(xReq);
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
        WorkProcMgtDao dao = new WorkProcMgtDao(this.nsr);

        return dao.retrieveWorkProcMgt(xReq);
    }

    /**
     * 업무프로세스 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void createWorkProcMgt(AjaxRequest xReq) throws NException
    {
        WorkProcMgtDao dao = new WorkProcMgtDao(this.nsr);

        NSingleData createInfo = dao.retrieveWorkProcMgtForCreate(xReq);

        xReq.setUserData("createInfo", createInfo);

        dao.createWorkProcMgt(xReq);
    }

    /**
     * 업무프로세스 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateWorkProcMgt(AjaxRequest xReq) throws NException
    {
        WorkProcMgtDao dao = new WorkProcMgtDao(this.nsr);

        dao.updateWorkProcMgt(xReq);
    }

    /**
     * 업무프로세스 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteWorkProcMgt(AjaxRequest xReq) throws NException
    {
        WorkProcMgtDao dao = new WorkProcMgtDao(this.nsr);

        dao.deleteWorkProcMgt(xReq);
    }

    /**
     * 업무프로세스 표시순서 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateWorkProcMgtDispOrdList(AjaxRequest xReq) throws NException
    {
        WorkProcMgtDao dao = new WorkProcMgtDao(this.nsr);

        dao.updateWorkProcMgtDispOrdList(xReq);
    }
}
