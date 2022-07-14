package anyfive.ipims.patent.systemmgt.datahandle.jobmanchange.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.datahandle.jobmanchange.biz.JobManChangeBiz;

/**
 * 사용여부 변경
 */
public class UpdateJobManChangeList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        JobManChangeBiz biz = new JobManChangeBiz(nsr);
        biz.updateJobManChangeList(xReq);
        nsr.closeConnection();
    }
}
