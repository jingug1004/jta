package anyfive.ipims.patent.applymgt.tmark.intrequest.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.grid.util.GridResponse;
import anyfive.ipims.patent.applymgt.tmark.intrequest.biz.TMarkIntRequestBiz;

/**
 * 상표 국내출원의뢰 조회
 */
public class RetrieveTMarkIntRequestList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        TMarkIntRequestBiz biz = new TMarkIntRequestBiz(nsr);
        NSingleData result = biz.retrieveTMarkIntRequestList(xReq);
        nsr.closeConnection();

        GridResponse xRes = new GridResponse(req, res);
        xRes.flush(result);
    }
}
