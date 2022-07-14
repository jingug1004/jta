package anyfive.ipims.patent.costmgt.reward.consult.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.costmgt.reward.consult.biz.RewardConsultBiz;

/**
 * 보상금품의 품의서 삭제
 */
public class DeleteRewardConsult implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        RewardConsultBiz biz = new RewardConsultBiz(nsr);
        biz.deleteRewardConsult(xReq);
        nsr.closeConnection();
    }
}
