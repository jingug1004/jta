package anyfive.ipims.patent.rivalpat.evalmaster.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.grid.util.GridResponse;
import anyfive.ipims.patent.rivalpat.evalmaster.biz.EvalMasterBiz;

/**
 * 평가마스터 목록 조회
 */
public class RetrieveRivalPatEvalMasterList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        EvalMasterBiz biz = new EvalMasterBiz(nsr);
        NSingleData result = biz.retrieveRivalPatEvalMasterList(xReq);
        nsr.closeConnection();

        GridResponse xRes = new GridResponse(req, res);
        xRes.flush(result);
    }
}
