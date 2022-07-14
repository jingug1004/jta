package anyfive.ipims.patent.systemmgt.basecode.rewardcode.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.grid.util.GridResponse;
import anyfive.ipims.patent.systemmgt.basecode.rewardcode.biz.RewardCodeMgtBiz;

/**
 * 보상금종류코드 목록 조회
 */
public class RetrieveRewardCodeMgtList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        RewardCodeMgtBiz biz = new RewardCodeMgtBiz(nsr);
        NSingleData result = biz.retrieveRewardCodeMgtList(xReq);
        nsr.closeConnection();

        GridResponse xRes = new GridResponse(req, res);
        xRes.flush(result);
    }
}
