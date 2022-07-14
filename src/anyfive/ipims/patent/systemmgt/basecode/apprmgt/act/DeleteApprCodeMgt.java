package anyfive.ipims.patent.systemmgt.basecode.apprmgt.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.basecode.apprmgt.biz.ApprCodeMgtBiz;

/**
 * 결재관리 삭제
 */
public class DeleteApprCodeMgt implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        ApprCodeMgtBiz biz = new ApprCodeMgtBiz(nsr);
        biz.deleteApprCodeMgt(xReq);
        nsr.closeConnection();
    }
}
