package anyfive.ipims.patent.systemmgt.patteam.applicant.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NBizException;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.patteam.applicant.dao.ApplicantListDao;
import anyfive.ipims.share.common.util.SequenceUtil;

public class ApplicantListBiz extends NAbstractServletBiz
{
    public ApplicantListBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 출원인 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveApplicantList(AjaxRequest xReq) throws NException
    {
        ApplicantListDao dao = new ApplicantListDao(this.nsr);

        return dao.retrieveApplicantList(xReq);
    }

    /**
     * 출원인 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveApplicant(AjaxRequest xReq) throws NException
    {
        ApplicantListDao dao = new ApplicantListDao(this.nsr);

        return dao.retrieveApplicant(xReq);
    }

    /**
     * 출원인  생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String createApplicant(AjaxRequest xReq) throws NException
    {
        ApplicantListDao dao = new ApplicantListDao(this.nsr);

        SequenceUtil seqUtil = new SequenceUtil(this.nsr);

        String appManCode = seqUtil.getAppManCode();

        xReq.setUserData("APP_MAN_CODE", appManCode);

        dao.createApplicant(xReq);

        return appManCode;
    }

    /**
     * 출원인  수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateApplicant(AjaxRequest xReq) throws NException
    {
        ApplicantListDao dao = new ApplicantListDao(this.nsr);

        dao.updateApplicant(xReq);
    }

    /**
     * 출원인  삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteApplicant(AjaxRequest xReq) throws NException
    {
        ApplicantListDao dao = new ApplicantListDao(this.nsr);

        if (dao.deleteApplicant(xReq) == 0) {
            throw new NBizException("사무소를 삭제할 수 없습니다.");
        }
    }
}
