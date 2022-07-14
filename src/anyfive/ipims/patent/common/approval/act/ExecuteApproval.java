package anyfive.ipims.patent.common.approval.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.common.approval.biz.ApprovalBiz;

/**
 * 결재실행
 */
public class ExecuteApproval implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        ApprovalBiz biz = new ApprovalBiz(nsr);
        biz.executeApproval(xReq);
        nsr.closeConnection();
    }
}
