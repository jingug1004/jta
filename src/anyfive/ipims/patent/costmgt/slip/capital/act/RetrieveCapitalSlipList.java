package anyfive.ipims.patent.costmgt.slip.capital.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.grid.util.GridResponse;
import anyfive.ipims.patent.costmgt.slip.capital.biz.CapitalSlipBiz;
/**
 * 출원비용 전표작성대상 목록 조회
 */
public class RetrieveCapitalSlipList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        CapitalSlipBiz biz = new CapitalSlipBiz(nsr);
        NSingleData result = biz.retrieveCapitalSlipList(xReq);
        nsr.closeConnection();

        GridResponse xRes = new GridResponse(req, res);
        xRes.flush(result);
    }
}
