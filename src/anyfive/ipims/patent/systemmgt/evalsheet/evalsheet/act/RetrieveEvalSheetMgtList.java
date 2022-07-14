package anyfive.ipims.patent.systemmgt.evalsheet.evalsheet.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.grid.util.GridResponse;
import anyfive.ipims.patent.systemmgt.evalsheet.evalsheet.biz.EvalSheetMgtBiz;

/**
 * 평가서 관리 목록 조회
 */
public class RetrieveEvalSheetMgtList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        EvalSheetMgtBiz biz = new EvalSheetMgtBiz(nsr);
        NSingleData result = biz.retrieveEvalSheetMgtList(xReq);
        nsr.closeConnection();

        GridResponse xRes = new GridResponse(req, res);
        xRes.flush(result);
    }
}
