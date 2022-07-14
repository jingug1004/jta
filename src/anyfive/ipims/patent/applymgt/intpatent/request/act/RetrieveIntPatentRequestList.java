package anyfive.ipims.patent.applymgt.intpatent.request.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.grid.util.GridResponse;
import anyfive.ipims.patent.applymgt.intpatent.request.biz.IntPatentRequestBiz;

/**
 * 국내특허 출원의뢰 목록 조회
 */
public class RetrieveIntPatentRequestList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        IntPatentRequestBiz biz = new IntPatentRequestBiz(nsr);
        NSingleData result = biz.retrieveIntPatentRequestList(xReq);
        nsr.closeConnection();

        GridResponse xRes = new GridResponse(req, res);
        xRes.flush(result);
    }
}
