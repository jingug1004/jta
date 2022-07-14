package anyfive.ipims.patent.applymgt.tmark.intmasterrenew.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.ajax.AjaxResponse;
import anyfive.ipims.patent.applymgt.tmark.intmasterrenew.biz.TMarkIntMasterRenewBiz;

/**
 * 상표국내출원마스터 갱신
 */
public class CreateTMarkIntMasterRenew implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        TMarkIntMasterRenewBiz biz = new TMarkIntMasterRenewBiz(nsr);
        String result = biz.createTMarkIntMasterRenew(xReq);
        nsr.closeConnection();

        AjaxResponse xRes = new AjaxResponse(res);
        xRes.flush(result);
    }
}
