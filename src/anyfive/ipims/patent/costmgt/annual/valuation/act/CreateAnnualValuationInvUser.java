package anyfive.ipims.patent.costmgt.annual.valuation.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.costmgt.annual.valuation.biz.AnnualValuationBiz;

/**
 * 발명부서 평가자 지정
 */
public class CreateAnnualValuationInvUser implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        AnnualValuationBiz biz = new AnnualValuationBiz(nsr);
        biz.createAnnualValuationInvUser(xReq.getParamToSingleData());
        nsr.closeConnection();
    }
}
