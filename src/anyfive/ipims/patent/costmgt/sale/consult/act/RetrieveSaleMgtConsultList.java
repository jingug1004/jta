package anyfive.ipims.patent.costmgt.sale.consult.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.grid.util.GridResponse;
import anyfive.ipims.patent.costmgt.sale.consult.biz.SaleMgtConsultBiz;
/**
 * 매각 품의 목록 조회
 */
public class RetrieveSaleMgtConsultList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        SaleMgtConsultBiz biz = new SaleMgtConsultBiz(nsr);
        NSingleData result = biz.retrieveSaleMgtConsultList(xReq);
        nsr.closeConnection();

        GridResponse xRes = new GridResponse(req, res);
        xRes.flush(result);
    }
}
