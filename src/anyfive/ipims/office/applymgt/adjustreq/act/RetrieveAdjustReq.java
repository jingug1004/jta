package anyfive.ipims.office.applymgt.adjustreq.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.ajax.AjaxResponse;
import anyfive.ipims.office.applymgt.adjustreq.biz.AdjustReqBiz;

/**
 * 수정요청 조회
 */
public class RetrieveAdjustReq implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        AdjustReqBiz biz = new AdjustReqBiz(nsr);
        NSingleData result = biz.retrieveAdjustReq(xReq);
        nsr.closeConnection();

        AjaxResponse xRes = new AjaxResponse(res);
        xRes.flush(result, "ds_mainInfo");
    }
}
