package anyfive.ipims.patent.applymgt.priorsearch.consult.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.ajax.AjaxResponse;
import anyfive.ipims.patent.applymgt.priorsearch.consult.biz.PriorSearchConsultBiz;

/**
 * 조사의뢰품의 생성
 */
public class CreatePriorSearchConsult implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        PriorSearchConsultBiz biz = new PriorSearchConsultBiz(nsr);
        String result = biz.createPriorSearchConsult(xReq);
        nsr.closeConnection();

        AjaxResponse xRes = new AjaxResponse(res);
        xRes.flush(result);
    }
}
