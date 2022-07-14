package anyfive.ipims.patent.systemmgt.evalsheet.evalcode.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.ajax.AjaxResponse;
import anyfive.ipims.patent.systemmgt.evalsheet.evalcode.biz.EvalCodeMgtBiz;

/**
 * 평가코드 관리 조회
 */
public class RetrieveEvalCodeMgt implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        EvalCodeMgtBiz biz = new EvalCodeMgtBiz(nsr);
        NSingleData result = biz.retrieveEvalCodeMgt(xReq);
        nsr.closeConnection();

        AjaxResponse xRes = new AjaxResponse(res);
        xRes.flush(result, "ds_mainInfo");
    }
}
