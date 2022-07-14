package anyfive.ipims.patent.common.evaluation.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NMultiData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.ajax.AjaxResponse;
import anyfive.ipims.patent.common.evaluation.biz.EvalCommonBiz;

/**
 * 평가서 항목 목록 조회
 */
public class RetrieveEvalSheetItemList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        EvalCommonBiz biz = new EvalCommonBiz(nsr);
        NMultiData result = biz.retrieveEvalSheetItemList(xReq);
        nsr.closeConnection();

        AjaxResponse xRes = new AjaxResponse(res);
        xRes.flush(result, xReq.getParam("_DS_ID_"));
    }
}
