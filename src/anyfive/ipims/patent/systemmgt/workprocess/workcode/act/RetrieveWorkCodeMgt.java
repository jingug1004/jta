package anyfive.ipims.patent.systemmgt.workprocess.workcode.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.ajax.AjaxResponse;
import anyfive.ipims.patent.systemmgt.workprocess.workcode.biz.WorkCodeMgtBiz;

/**
 * 업무코드 조회
 */
public class RetrieveWorkCodeMgt implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        WorkCodeMgtBiz biz = new WorkCodeMgtBiz(nsr);
        NSingleData result = biz.retrieveWorkCodeMgt(xReq);
        nsr.closeConnection();

        AjaxResponse xRes = new AjaxResponse(res);
        xRes.flushAll(result);
    }
}
