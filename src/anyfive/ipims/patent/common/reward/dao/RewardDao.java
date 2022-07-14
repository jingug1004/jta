package anyfive.ipims.patent.common.reward.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;

public class RewardDao extends NAbstractServletDao
{
    public RewardDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 보상금 지급내역 생성
     *
     * @param refId
     * @param rewardDiv
     * @param data
     * @return
     * @throws NException
     */
    public int createRewardInfo(String refId, String rewardDiv, NSingleData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/reward/reward", "/createRewardInfo");
        dao.bind("REF_ID", refId);
        dao.bind("REWARD_DIV", rewardDiv);
        dao.bind(data);

        return dao.executeUpdate();
    }

    /**
     * 보상금 지급내역 수정
     *
     * @param refId
     * @param rewardDiv
     * @param data
     * @return
     * @throws NException
     */
    public int updateRewardInfo(String refId, String rewardDiv, NSingleData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/reward/reward", "/updateRewardInfo");
        dao.bind("REF_ID", refId);
        dao.bind("REWARD_DIV", rewardDiv);
        dao.bind(data);

        for (int i = 0; i < data.getKeySize(); i++) {
            dao.addQuery("column");
            dao.replaceText("COLUMN_NAME", data.getKey(i));
            dao.replaceText("COLUMN_VALUE", "{@" + data.getKey(i) + "}");
        }

        return dao.executeUpdate();
    }
}
