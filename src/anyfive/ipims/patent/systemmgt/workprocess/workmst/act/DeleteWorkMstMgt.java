package anyfive.ipims.patent.systemmgt.workprocess.workmst.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.workprocess.workmst.biz.WorkMstMgtBiz;

/**
 * 업무 삭제
 */
public class DeleteWorkMstMgt implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        WorkMstMgtBiz biz = new WorkMstMgtBiz(nsr);
        biz.deleteWorkMstMgt(xReq);
        nsr.closeConnection();
    }
}
