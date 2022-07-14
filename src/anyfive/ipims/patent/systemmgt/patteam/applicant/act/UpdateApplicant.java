package anyfive.ipims.patent.systemmgt.patteam.applicant.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.patteam.applicant.biz.ApplicantListBiz;

public class UpdateApplicant implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        ApplicantListBiz biz = new ApplicantListBiz(nsr);
        biz.updateApplicant(xReq);
        nsr.closeConnection();
    }
}
