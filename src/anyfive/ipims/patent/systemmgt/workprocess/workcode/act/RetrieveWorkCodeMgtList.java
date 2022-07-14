package anyfive.ipims.patent.systemmgt.workprocess.workcode.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.grid.util.GridResponse;
import anyfive.ipims.patent.systemmgt.workprocess.workcode.biz.WorkCodeMgtBiz;

/**
 * 업무코드 목록 조회
 */
public class RetrieveWorkCodeMgtList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        WorkCodeMgtBiz biz = new WorkCodeMgtBiz(nsr);
        NSingleData result = biz.retrieveWorkCodeMgtList(xReq);
        nsr.closeConnection();

        GridResponse xRes = new GridResponse(req, res);
        xRes.flush(result);
    }
}
