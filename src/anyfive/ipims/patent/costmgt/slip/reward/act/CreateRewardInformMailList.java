package anyfive.ipims.patent.costmgt.slip.reward.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.costmgt.slip.reward.biz.RewardSlipBiz;

/**
 * 보상금 알림메일 발송목록 생성
 */
public class CreateRewardInformMailList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        RewardSlipBiz biz = new RewardSlipBiz(nsr);
        biz.createRewardInformMailList(xReq);
        nsr.closeConnection();
    }
}
