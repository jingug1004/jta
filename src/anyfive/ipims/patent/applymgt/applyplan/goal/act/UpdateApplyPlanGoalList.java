package anyfive.ipims.patent.applymgt.applyplan.goal.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.applyplan.goal.biz.ApplyPlanGoalBiz;

/**
 * 출원목표수립 목록 저장
 */
public class UpdateApplyPlanGoalList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        ApplyPlanGoalBiz biz = new ApplyPlanGoalBiz(nsr);
        biz.updateApplyPlanGoalList(xReq);
        biz.addAppcode(xReq);
        nsr.closeConnection();
    }
}
