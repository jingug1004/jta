package anyfive.ipims.patent.costmgt.annual.current.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.grid.util.GridResponse;
import anyfive.ipims.patent.costmgt.annual.current.biz.AnnualCurrentBiz;

/**
 * 연차료 현황 목록 조회
 */
public class RetrieveAnnualCurrentList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        AnnualCurrentBiz biz = new AnnualCurrentBiz(nsr);
        NSingleData result = biz.retrieveAnnualCurrentList(xReq);
        nsr.closeConnection();

        GridResponse xRes = new GridResponse(req, res);
        xRes.flush(result);
    }
}
