package anyfive.ipims.patent.systemmgt.workprocess.workmst.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NBizException;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.workprocess.workmst.dao.WorkMstMgtDao;

public class WorkMstMgtBiz extends NAbstractServletBiz
{
    public WorkMstMgtBiz(NServiceResource nsr)
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
        WorkMstMgtDao dao = new WorkMstMgtDao(this.nsr);

        return dao.retrieveWorkMstMgtList(xReq);
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
        WorkMstMgtDao dao = new WorkMstMgtDao(this.nsr);

        return dao.retrieveWorkMstMgt(xReq);
    }

    /**
     * 업무 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void createWorkMstMgt(AjaxRequest xReq) throws NException
    {
        WorkMstMgtDao dao = new WorkMstMgtDao(this.nsr);

        dao.createWorkMstMgt(xReq);
    }

    /**
     * 업무 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateWorkMstMgt(AjaxRequest xReq) throws NException
    {
        WorkMstMgtDao dao = new WorkMstMgtDao(this.nsr);

        dao.updateWorkMstMgt(xReq);
    }

    /**
     * 업무 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteWorkMstMgt(AjaxRequest xReq) throws NException
    {
        WorkMstMgtDao dao = new WorkMstMgtDao(this.nsr);

        if (dao.deleteWorkMstMgt(xReq) == 0) {
            throw new NBizException("이미 사용중인 업무 ID는 삭제할 수 없습니다.");
        }
    }
}
