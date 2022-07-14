package anyfive.ipims.patent.costmgt.sale.confirm.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.costmgt.sale.confirm.biz.SaleMgtBiz;
/**
 * 매각 확정 생성
 */
public class CreateSaleMgt implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        SaleMgtBiz biz = new SaleMgtBiz(nsr);
        biz.createSaleMgt(xReq);
        nsr.closeConnection();
    }
}
