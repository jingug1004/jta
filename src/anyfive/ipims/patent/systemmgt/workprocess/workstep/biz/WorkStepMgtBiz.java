package anyfive.ipims.patent.systemmgt.workprocess.workstep.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NBizException;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.workprocess.workstep.dao.WorkStepMgtDao;

public class WorkStepMgtBiz extends NAbstractServletBiz
{
    public WorkStepMgtBiz(NServiceResource nsr)
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
        WorkStepMgtDao dao = new WorkStepMgtDao(this.nsr);

        return dao.retrieveWorkStepMgtList(xReq);
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
        WorkStepMgtDao dao = new WorkStepMgtDao(this.nsr);

        return dao.retrieveWorkStepMgt(xReq);
    }

    /**
     * 업무단계 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void createWorkStepMgt(AjaxRequest xReq) throws NException
    {
        WorkStepMgtDao dao = new WorkStepMgtDao(this.nsr);

        dao.createWorkStepMgt(xReq);
    }

    /**
     * 업무단계 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateWorkStepMgt(AjaxRequest xReq) throws NException
    {
        WorkStepMgtDao dao = new WorkStepMgtDao(this.nsr);

        dao.updateWorkStepMgt(xReq);
    }

    /**
     * 업무단계 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteWorkStepMgt(AjaxRequest xReq) throws NException
    {
        WorkStepMgtDao dao = new WorkStepMgtDao(this.nsr);

        if (dao.deleteWorkStepMgt(xReq) == 0) {
            throw new NBizException("이미 사용중인 ID는 삭제할 수 없습니다.");
        }
    }
}
