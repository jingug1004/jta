package anyfive.ipims.patent.applymgt.intpatent.conveyprint.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.ajax.AjaxResponse;
import anyfive.ipims.patent.applymgt.intpatent.conveyprint.biz.IntPatentConveyPrintBiz;

/**
 * 양도증인쇄 조회
 */
public class RetrieveIntPatentConveyPrint implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        IntPatentConveyPrintBiz biz = new IntPatentConveyPrintBiz(nsr);
        NSingleData result = biz.retrieveIntPatentConveyPrint(xReq);
        nsr.closeConnection();

        AjaxResponse xRes = new AjaxResponse(res);
        xRes.flushAll(result);
    }
}
