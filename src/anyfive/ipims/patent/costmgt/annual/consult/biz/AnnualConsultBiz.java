package anyfive.ipims.patent.costmgt.annual.consult.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.costmgt.annual.consult.dao.AnnualConsultDao;
import anyfive.ipims.share.common.util.SequenceUtil;

public class AnnualConsultBiz extends NAbstractServletBiz
{
    public AnnualConsultBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 연차료 품의서 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveAnnualConsultList(AjaxRequest xReq) throws NException
    {
        AnnualConsultDao dao = new AnnualConsultDao(this.nsr);

        return dao.retrieveAnnualConsultList(xReq);
    }

    /**
     * 연차료 품의서 상세 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveAnnualConsult(AjaxRequest xReq) throws NException
    {
        AnnualConsultDao dao = new AnnualConsultDao(this.nsr);

        return dao.retrieveAnnualConsult(xReq);
    }

    /**
     * 연차료 품의서 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveAnnualConsultInputList(AjaxRequest xReq) throws NException
    {
        AnnualConsultDao dao = new AnnualConsultDao(this.nsr);

        return dao.retrieveAnnualConsultInputList(xReq);
    }

    /**
     * 연차료 품의서 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String createAnnualConsult(AjaxRequest xReq) throws NException
    {
        AnnualConsultDao dao = new AnnualConsultDao(this.nsr);
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);

        String consultId = seqUtil.getBizId();

        xReq.setUserData("CONSULT_ID", consultId);

        // 연차료 품의서 생성
        dao.createAnnualConsult(xReq);

        // 비용마스터 수정(품의서ID 설정)
        dao.updateCostMasterToConsult(xReq);

        return consultId;
    }

    /**
     * 연차료 품의서 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateAnnualConsult(AjaxRequest xReq) throws NException
    {
        AnnualConsultDao dao = new AnnualConsultDao(this.nsr);

        dao.updateAnnualConsult(xReq);
    }

    /**
     * 연차료 품의서 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteAnnualConsult(AjaxRequest xReq) throws NException
    {
        AnnualConsultDao dao = new AnnualConsultDao(this.nsr);

        // 비용마스터 수정(품의서ID 삭제)
        dao.updateAnnualMasterConsultId(xReq);

        // 출원비용 품의서 삭제
        dao.deleteAnnualConsult(xReq);
    }
}
