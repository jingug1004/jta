package anyfive.ipims.patent.applymgt.priorjob.evaluation.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.ajax.AjaxResponse;
import anyfive.ipims.patent.applymgt.priorjob.evaluation.biz.EvaluationBiz;

public class RetrieveEvaluationE06 implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        EvaluationBiz biz = new EvaluationBiz(nsr);
        NSingleData result = biz.retrieveEvaluationE06(xReq);
        nsr.closeConnection();

        AjaxResponse xRes = new AjaxResponse(res);
        xRes.flushAll(result);
    }
}
