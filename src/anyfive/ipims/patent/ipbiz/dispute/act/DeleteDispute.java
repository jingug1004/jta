package anyfive.ipims.patent.ipbiz.dispute.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.ipbiz.dispute.biz.DisputeBiz;

/**
 * 분쟁(소송) 삭제
 */
public class DeleteDispute implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        DisputeBiz biz = new DisputeBiz(nsr);
        biz.deleteDispute(xReq);
        nsr.closeConnection();
    }
}
