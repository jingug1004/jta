package anyfive.ipims.patent.rivalpat.evalmaster.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NMultiData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.ajax.AjaxResponse;
import anyfive.ipims.patent.rivalpat.evalmaster.biz.EvalMasterBiz;

/**
 * 댓글 목록 조회
 */
public class RetrieveRivalPatEvalReplyList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        EvalMasterBiz biz = new EvalMasterBiz(nsr);
        NMultiData result = biz.retrieveRivalPatEvalReplyList(xReq);
        nsr.closeConnection();

        AjaxResponse xRes = new AjaxResponse(res);
        xRes.flush(result, "ds_replyList");
    }
}
