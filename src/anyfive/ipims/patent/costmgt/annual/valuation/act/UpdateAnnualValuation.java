package anyfive.ipims.patent.costmgt.annual.valuation.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.ajax.AjaxResponse;
import anyfive.ipims.patent.costmgt.annual.valuation.biz.AnnualValuationBiz;

/**
 * 등록유지평가 저장
 */
public class UpdateAnnualValuation implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        AnnualValuationBiz biz = new AnnualValuationBiz(nsr);
        String result = biz.updateAnnualValuation(xReq);
        nsr.closeConnection();

        AjaxResponse xRes = new AjaxResponse(res);
        xRes.flush(result);
    }
}
