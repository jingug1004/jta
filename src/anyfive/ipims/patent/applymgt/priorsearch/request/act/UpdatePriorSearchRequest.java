package anyfive.ipims.patent.applymgt.priorsearch.request.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.priorsearch.request.biz.PriorSearchRequestBiz;

/**
 * 조사의뢰 수정
 */
public class UpdatePriorSearchRequest implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        PriorSearchRequestBiz biz = new PriorSearchRequestBiz(nsr);
        biz.updatePriorSearchRequest(xReq);
        nsr.closeConnection();
    }
}
