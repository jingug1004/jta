package anyfive.ipims.patent.systemmgt.workprocess.workstep.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.grid.util.GridResponse;
import anyfive.ipims.patent.systemmgt.workprocess.workstep.biz.WorkStepMgtBiz;

/**
 * 업무단계 목록 조회
 */
public class RetrieveWorkStepMgtList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        WorkStepMgtBiz biz = new WorkStepMgtBiz(nsr);
        NSingleData result = biz.retrieveWorkStepMgtList(xReq);
        nsr.closeConnection();

        GridResponse xRes = new GridResponse(req, res);
        xRes.flush(result);
    }
}
