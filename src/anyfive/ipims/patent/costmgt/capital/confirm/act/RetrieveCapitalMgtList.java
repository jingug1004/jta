package anyfive.ipims.patent.costmgt.capital.confirm.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.grid.util.GridResponse;
import anyfive.ipims.patent.costmgt.capital.confirm.biz.CapitalMgtBiz;
/**
 * 자본적 지출 확정 목록 조회
 */
public class RetrieveCapitalMgtList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        CapitalMgtBiz biz = new CapitalMgtBiz(nsr);
        NSingleData result = biz.retrieveCapitalMgtList(xReq);
        nsr.closeConnection();

        GridResponse xRes = new GridResponse(req, res);
        xRes.flush(result);
    }
}
