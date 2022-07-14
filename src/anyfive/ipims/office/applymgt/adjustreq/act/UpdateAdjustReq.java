package anyfive.ipims.office.applymgt.adjustreq.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.office.applymgt.adjustreq.biz.AdjustReqBiz;

/**
 * 수정요청 수정
 */
public class UpdateAdjustReq implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        AdjustReqBiz biz = new AdjustReqBiz(nsr);
        biz.updateAdjustReq(xReq);
        nsr.closeConnection();
    }
}
