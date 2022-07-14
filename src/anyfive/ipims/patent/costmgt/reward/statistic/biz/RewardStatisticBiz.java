package anyfive.ipims.patent.costmgt.reward.statistic.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.costmgt.reward.statistic.dao.RewardStatisticDao;

public class RewardStatisticBiz extends NAbstractServletBiz
{
    public RewardStatisticBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 보상금통계 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveRewardStatisticList(AjaxRequest xReq) throws NException
    {
        RewardStatisticDao dao = new RewardStatisticDao(this.nsr);
        NSingleData result = new NSingleData();

        if(xReq.getParam("STATUS").equals("1") == true){// 지급대상
            result = dao.retrieveRewardStatisticList1(xReq);
        } else { // 0: 품의중, 9:처리완료
            result = dao.retrieveRewardStatisticList2(xReq);
        }

        return result;
    }
}
