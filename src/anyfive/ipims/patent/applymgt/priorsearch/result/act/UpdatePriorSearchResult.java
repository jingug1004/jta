package anyfive.ipims.patent.applymgt.priorsearch.result.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.priorsearch.result.biz.PriorSearchResultBiz;

/**
 * 선행기술조사 결과 수정
 */
public class UpdatePriorSearchResult implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        PriorSearchResultBiz biz = new PriorSearchResultBiz(nsr);
        biz.updatePriorSearchResult(xReq);
        nsr.closeConnection();
    }
}
