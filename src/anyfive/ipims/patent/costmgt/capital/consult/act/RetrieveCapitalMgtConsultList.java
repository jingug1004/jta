package anyfive.ipims.patent.costmgt.capital.consult.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.grid.util.GridResponse;
import anyfive.ipims.patent.costmgt.capital.consult.biz.CapitalMgtConsultBiz;
/**
 * 자본적 지출 품의 목록 조회
 */
public class RetrieveCapitalMgtConsultList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        CapitalMgtConsultBiz biz = new CapitalMgtConsultBiz(nsr);
        NSingleData result = biz.retrieveCapitalMgtConsultList(xReq);
        nsr.closeConnection();

        GridResponse xRes = new GridResponse(req, res);
        xRes.flush(result);
    }
}
