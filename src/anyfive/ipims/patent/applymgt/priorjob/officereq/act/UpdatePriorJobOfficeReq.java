package anyfive.ipims.patent.applymgt.priorjob.officereq.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.priorjob.officereq.biz.PriorJobOfficeReqBiz;

/**
 * 사무소요청사항 수정
 */
public class UpdatePriorJobOfficeReq implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        PriorJobOfficeReqBiz biz = new PriorJobOfficeReqBiz(nsr);
        biz.updatePriorJobOfficeReq(xReq);
        nsr.closeConnection();
    }
}
