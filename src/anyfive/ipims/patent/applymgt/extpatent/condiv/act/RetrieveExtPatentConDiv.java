package anyfive.ipims.patent.applymgt.extpatent.condiv.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.ajax.AjaxResponse;
import anyfive.ipims.patent.applymgt.extpatent.condiv.biz.ExtPatentConDivBiz;

/**
 * 계속/분할OL 조회
 */
public class RetrieveExtPatentConDiv implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        ExtPatentConDivBiz biz = new ExtPatentConDivBiz(nsr);
        NSingleData result = biz.retrieveExtPatentConDiv(xReq);
        nsr.closeConnection();

        AjaxResponse xRes = new AjaxResponse(res);
        xRes.flushAll(result);
    }
}
