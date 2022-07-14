package anyfive.ipims.patent.costmgt.reward.supply.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.costmgt.reward.supply.biz.RewardSupplyBiz;

/**
 * 보상금지급 지급확정
 */
public class CreateRewardSupplyConfirm implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        RewardSupplyBiz biz = new RewardSupplyBiz(nsr);
        biz.createRewardSupplyConfirm(xReq);
        nsr.closeConnection();
    }
}
