package anyfive.ipims.patent.common.reward.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.ipims.patent.common.reward.dao.RewardDao;

public class RewardBiz extends NAbstractServletBiz
{
    private String      refId      = null;
    private NSingleData rewardInfo = null;

    public RewardBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 초기화
     *
     * @param refId
     */
    public void init(String refId)
    {
        this.refId = refId;
        this.rewardInfo = new NSingleData();
    }

    /**
     * 값 설정
     *
     * @param key
     * @param value
     */
    public void setValue(String key, String value)
    {
        this.rewardInfo.setString(key, value);
    }

    /**
     * 저장
     *
     * @param rewardDiv
     * @throws NException
     */
    public void update(String rewardDiv) throws NException
    {
        RewardDao dao = new RewardDao(this.nsr);

        if (dao.updateRewardInfo(this.refId, rewardDiv, this.rewardInfo) == 0) {
            dao.createRewardInfo(this.refId, rewardDiv, this.rewardInfo);
        }
    }
}
