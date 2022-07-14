package anyfive.ipims.patent.applymgt.applyplan.invactual.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.grid.util.GridResponse;
import anyfive.ipims.patent.applymgt.applyplan.invactual.biz.ApplyPlanInvActualBiz;

/**
 * 출원실적 목록 조회 - 발명자별
 */
public class RetrieveApplyPlanInvActualList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        ApplyPlanInvActualBiz biz = new ApplyPlanInvActualBiz(nsr);
        NSingleData result = biz.retrieveApplyPlanInvActualList(xReq);
        nsr.closeConnection();

        GridResponse xRes = new GridResponse(req, res);
        xRes.flush(result);
    }
}
