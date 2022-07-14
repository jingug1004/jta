package anyfive.ipims.patent.costmgt.reward.consult.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.costmgt.reward.consult.dao.RewardConsultDao;
import anyfive.ipims.share.common.util.SequenceUtil;

public class RewardConsultBiz extends NAbstractServletBiz
{
    public RewardConsultBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 보상금품의 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveRewardConsultList(AjaxRequest xReq) throws NException
    {
        RewardConsultDao dao = new RewardConsultDao(this.nsr);
        return dao.retrieveRewardConsultList(xReq);
    }

    /**
     * 보상금품의 품의서 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String createRewardConsult(AjaxRequest xReq) throws NException
    {
        RewardConsultDao dao = new RewardConsultDao(this.nsr);
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);

        String consultId = seqUtil.getBizId();

        xReq.setUserData("CONSULT_ID", consultId);

        dao.createRewardConsult(xReq);

        dao.updateRewardSupply(xReq, xReq.getMultiData("ds_rewardSupplyList"));

        return consultId;
    }

    /**
     * 보상금품의 상세 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveRewardConsult(AjaxRequest xReq) throws NException
    {
        RewardConsultDao dao = new RewardConsultDao(this.nsr);
        return dao.retrieveRewardConsult(xReq);
    }

    /**
     * 보상금품의대상(상세-발명자별) 목록조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveRewardConsultByInv(AjaxRequest xReq) throws NException
    {
        RewardConsultDao dao = new RewardConsultDao(this.nsr);
        return dao.retrieveRewardConsultByInv(xReq);
    }

    /**
     * 보상금품의대상(상세-부서별) 목록조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveRewardConsultByDept(AjaxRequest xReq) throws NException
    {
        RewardConsultDao dao = new RewardConsultDao(this.nsr);
        return dao.retrieveRewardConsultByDept(xReq);
    }

    /**
     * 보상금품의 품의서 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateRewardConsult(AjaxRequest xReq) throws NException
    {
        RewardConsultDao dao = new RewardConsultDao(this.nsr);
        dao.updateRewardConsult(xReq);
    }

    /**
     * 보상금품의 품의서 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteRewardConsult(AjaxRequest xReq) throws NException
    {
        RewardConsultDao dao = new RewardConsultDao(this.nsr);

        dao.updateRewardSupplyConsultIdToNull(xReq);

        dao.deleteRewardConsult(xReq);
    }
}
