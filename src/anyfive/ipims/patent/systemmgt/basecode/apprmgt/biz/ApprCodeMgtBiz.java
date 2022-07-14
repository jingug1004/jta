package anyfive.ipims.patent.systemmgt.basecode.apprmgt.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NBizException;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.basecode.apprmgt.dao.ApprCodeMgtDao;

public class ApprCodeMgtBiz extends NAbstractServletBiz
{
    public ApprCodeMgtBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 결재관리 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveApprCodeMgtList(AjaxRequest xReq) throws NException
    {
        ApprCodeMgtDao dao = new ApprCodeMgtDao(this.nsr);

        return dao.retrieveApprCodeMgtList(xReq);
    }

    /**
     * 결재관리 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveApprCodeMgt(AjaxRequest xReq) throws NException
    {
        ApprCodeMgtDao dao = new ApprCodeMgtDao(this.nsr);

        return dao.retrieveApprCodeMgt(xReq);
    }

    /**
     * 결재관리 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void createApprCodeMgt(AjaxRequest xReq) throws NException
    {
        ApprCodeMgtDao dao = new ApprCodeMgtDao(this.nsr);

        if (dao.createApprCodeMgt(xReq) == 0) {
            throw new NBizException(this.nsr.message.get("msg.com.error.dup"));
        }
    }

    /**
     * 결재관리 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateApprCodeMgt(AjaxRequest xReq) throws NException
    {
        ApprCodeMgtDao dao = new ApprCodeMgtDao(this.nsr);

        dao.updateApprCodeMgt(xReq);
    }

    /**
     * 결재관리 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteApprCodeMgt(AjaxRequest xReq) throws NException
    {
        ApprCodeMgtDao dao = new ApprCodeMgtDao(this.nsr);

        if (dao.deleteApprCodeMgt(xReq) == 0) {
            throw new NBizException("이미 사용중이므로, 삭제할 수 없습니다.");
        }
    }
}
