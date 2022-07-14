package anyfive.ipims.patent.applymgt.extpatent.eppct.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.ajax.AjaxResponse;
import anyfive.ipims.patent.applymgt.extpatent.eppct.biz.ExtPatentEpPctBiz;

/**
 * EP/PCT OL 모출원 서지사항 조회
 */
public class RetrieveExtPatentEpPctPrior implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        ExtPatentEpPctBiz biz = new ExtPatentEpPctBiz(nsr);
        NSingleData result = biz.retrieveExtPatentEpPctPrior(xReq);
        nsr.closeConnection();

        AjaxResponse xRes = new AjaxResponse(res);
        xRes.flushAll(result);
    }
}
