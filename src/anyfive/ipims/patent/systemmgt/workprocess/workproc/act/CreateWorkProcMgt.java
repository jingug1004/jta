package anyfive.ipims.patent.systemmgt.workprocess.workproc.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.workprocess.workproc.biz.WorkProcMgtBiz;

/**
 * 업무프로세스 생성
 */
public class CreateWorkProcMgt implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        WorkProcMgtBiz biz = new WorkProcMgtBiz(nsr);
        biz.createWorkProcMgt(xReq);
        nsr.closeConnection();
    }
}
