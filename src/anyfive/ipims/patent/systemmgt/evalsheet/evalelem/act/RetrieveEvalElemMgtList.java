package anyfive.ipims.patent.systemmgt.evalsheet.evalelem.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.grid.util.GridResponse;
import anyfive.ipims.patent.systemmgt.evalsheet.evalelem.biz.EvalElemMgtBiz;

/**
 * 평가요소 관리 목록 조회
 */
public class RetrieveEvalElemMgtList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        EvalElemMgtBiz biz = new EvalElemMgtBiz(nsr);
        NSingleData result = biz.retrieveEvalElemMgtList(xReq);
        nsr.closeConnection();

        GridResponse xRes = new GridResponse(req, res);
        xRes.flush(result);
    }
}
