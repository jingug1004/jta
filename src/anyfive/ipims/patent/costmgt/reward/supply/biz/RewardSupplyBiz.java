package anyfive.ipims.patent.costmgt.reward.supply.biz;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.costmgt.reward.supply.dao.RewardSupplyDao;
import anyfive.ipims.share.common.util.SequenceUtil;

public class RewardSupplyBiz extends NAbstractServletBiz
{
    public RewardSupplyBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 보상금지급 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveRewardSupplyList(AjaxRequest xReq) throws NException
    {
        RewardSupplyDao dao = new RewardSupplyDao(this.nsr);

        return dao.retrieveRewardSupplyList(xReq);
    }

    /**
     * 보상금지급 지급확정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void createRewardSupplyConfirm(AjaxRequest xReq) throws NException
    {
        RewardSupplyDao dao = new RewardSupplyDao(this.nsr);
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);

        NMultiData rewardSupplyList = xReq.getMultiData("ds_rewardSupplyList");
        NMultiData createList = new NMultiData();

        for (int i = 0; i < rewardSupplyList.getRowSize(); i++) {
            rewardSupplyList.setString(i, "COST_SEQ", seqUtil.getCostSeq());
            createList.addSingleData(rewardSupplyList.getSingleData(i));
        }

        dao.createRewardSupplyConfirmMst(xReq, createList);
        dao.createRewardSupplyConfirmDtl(xReq, createList);
    }

    /**
     * 보상금지급 지급확정취소(삭제)
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteRewardSupplyConfirm(AjaxRequest xReq) throws NException
    {
        RewardSupplyDao dao = new RewardSupplyDao(this.nsr);

        NMultiData rewardSupplyList = xReq.getMultiData("ds_rewardSupplyList");

        dao.deleteRewardSupplyConfirmDtl(xReq, rewardSupplyList);
        dao.deleteRewardSupplyConfirmMst(xReq, rewardSupplyList);
    }
}
