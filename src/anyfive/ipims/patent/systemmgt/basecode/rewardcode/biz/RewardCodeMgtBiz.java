package anyfive.ipims.patent.systemmgt.basecode.rewardcode.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.basecode.rewardcode.dao.RewardCodeMgtDao;

public class RewardCodeMgtBiz extends NAbstractServletBiz
{
    public RewardCodeMgtBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 보상금종류코드 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveRewardCodeMgtList(AjaxRequest xReq) throws NException
    {
        RewardCodeMgtDao dao = new RewardCodeMgtDao(this.nsr);

        return dao.retrieveRewardCodeMgtList(xReq);
    }

    /**
     * 보상금종류코드 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveRewardCodeMgt(AjaxRequest xReq) throws NException
    {
        RewardCodeMgtDao dao = new RewardCodeMgtDao(this.nsr);

        return dao.retrieveRewardCodeMgt(xReq);
    }

    /**
     * 보상금종류코드 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateRewardCodeMgt(AjaxRequest xReq) throws NException
    {
        RewardCodeMgtDao dao = new RewardCodeMgtDao(this.nsr);

        if (dao.updateRewardCodeMgt(xReq) == 0) {
            dao.createRewardCodeMgt(xReq);
        }
    }

    /**
     * 보상금종류코드 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteRewardCodeMgt(AjaxRequest xReq) throws NException
    {
        RewardCodeMgtDao dao = new RewardCodeMgtDao(this.nsr);

        dao.deleteRewardCodeMgt(xReq);
    }
}
