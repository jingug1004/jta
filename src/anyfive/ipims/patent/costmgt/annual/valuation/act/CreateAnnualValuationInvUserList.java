package anyfive.ipims.patent.costmgt.annual.valuation.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NMultiData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.costmgt.annual.valuation.biz.AnnualValuationBiz;

/**
 * 발명부서 평가자 목록 지정
 */
public class CreateAnnualValuationInvUserList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        AnnualValuationBiz biz = new AnnualValuationBiz(nsr);
        NMultiData valuationList = xReq.getMultiData("ds_annualValuationList");
        for (int i = 0; i < valuationList.getRowSize(); i++) {
            biz.createAnnualValuationInvUser(valuationList.getSingleData(i));
        }
        nsr.closeConnection();
    }
}
