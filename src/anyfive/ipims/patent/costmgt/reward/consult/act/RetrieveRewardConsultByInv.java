package anyfive.ipims.patent.costmgt.reward.consult.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.grid.util.GridResponse;
import anyfive.ipims.patent.costmgt.reward.consult.biz.RewardConsultBiz;

/**
 * 보상금품의대상(상세-발명자별) 목록조회
 */
public class RetrieveRewardConsultByInv implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        RewardConsultBiz biz = new RewardConsultBiz(nsr);
        NSingleData result = biz.retrieveRewardConsultByInv(xReq);
        nsr.closeConnection();

        GridResponse xRes = new GridResponse(req, res);
        xRes.flush(result);
    }
}
