package anyfive.ipims.patent.rivalpat.evalmaster.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.rivalpat.evalmaster.biz.EvalMasterBiz;

/**
 * 댓글 생성
 */
public class CreateRivalPatEvalReply implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        EvalMasterBiz biz = new EvalMasterBiz(nsr);
        biz.createRivalPatEvalReply(xReq);
        nsr.closeConnection();
    }
}
