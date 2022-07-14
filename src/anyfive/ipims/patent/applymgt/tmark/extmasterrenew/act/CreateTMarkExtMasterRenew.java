package anyfive.ipims.patent.applymgt.tmark.extmasterrenew.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.ajax.AjaxResponse;
import anyfive.ipims.patent.applymgt.tmark.extmasterrenew.biz.TMarkExtMasterRenewBiz;

/**
 * 상표해외출원마스터 갱신
 */
public class CreateTMarkExtMasterRenew implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        TMarkExtMasterRenewBiz biz = new TMarkExtMasterRenewBiz(nsr);
        String result = biz.createTMarkExtMasterRenew(xReq);
        nsr.closeConnection();

        AjaxResponse xRes = new AjaxResponse(res);
        xRes.flush(result);
    }
}
