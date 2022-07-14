package anyfive.ipims.patent.applymgt.intpatent.conveyprint.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.grid.util.GridResponse;
import anyfive.ipims.patent.applymgt.intpatent.conveyprint.biz.IntPatentConveyPrintBiz;

/**
 * 양도증인쇄 목록 조회
 */
public class RetrieveIntPatentConveyPrintList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        IntPatentConveyPrintBiz biz = new IntPatentConveyPrintBiz(nsr);
        NSingleData result = biz.retrieveIntPatentConveyPrintList(xReq);
        nsr.closeConnection();

        GridResponse xRes = new GridResponse(req, res);
        xRes.flush(result);
    }
}
