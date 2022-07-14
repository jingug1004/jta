package anyfive.ipims.patent.applymgt.priorjob.officereq.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.ajax.AjaxResponse;
import anyfive.ipims.patent.applymgt.priorjob.officereq.biz.PriorJobOfficeReqBiz;

/**
 * 사무소요청사항 상세 조회
 */
public class RetrievePriorJobOfficeReq implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        PriorJobOfficeReqBiz biz = new PriorJobOfficeReqBiz(nsr);
        NSingleData result = biz.retrievePriorJobOfficeReq(xReq);
        nsr.closeConnection();

        AjaxResponse xRes = new AjaxResponse(res);
        xRes.flush(result, "ds_mainInfo");
    }
}
