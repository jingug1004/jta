package anyfive.ipims.patent.systemmgt.datahandle.jobmanchange.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.grid.util.GridResponse;
import anyfive.ipims.patent.systemmgt.datahandle.jobmanchange.biz.JobManChangeBiz;

/**
 * 건담당자 일괄변경 목록 조회
 */
public class RetrieveJobManChangeList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        JobManChangeBiz biz = new JobManChangeBiz(nsr);
        NSingleData result = biz.retrieveJobManChangeList(xReq);
        nsr.closeConnection();

        GridResponse xRes = new GridResponse(req, res);
        xRes.flush(result);
    }
}
