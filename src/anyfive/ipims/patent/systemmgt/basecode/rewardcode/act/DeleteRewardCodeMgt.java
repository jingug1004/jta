package anyfive.ipims.patent.systemmgt.basecode.rewardcode.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.basecode.rewardcode.biz.RewardCodeMgtBiz;

/**
 * 보상급종류코드 삭제
 */
public class DeleteRewardCodeMgt implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        RewardCodeMgtBiz biz = new RewardCodeMgtBiz(nsr);
        biz.deleteRewardCodeMgt(xReq);
        nsr.closeConnection();
    }
}
