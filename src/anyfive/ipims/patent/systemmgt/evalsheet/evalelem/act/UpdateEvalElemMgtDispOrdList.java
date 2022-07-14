package anyfive.ipims.patent.systemmgt.evalsheet.evalelem.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.evalsheet.evalelem.biz.EvalElemMgtBiz;

/**
 * 평가요소 표시순서 수정
 */
public class UpdateEvalElemMgtDispOrdList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        EvalElemMgtBiz biz = new EvalElemMgtBiz(nsr);
        biz.updateEvalElemMgtDispOrdList(xReq);
        nsr.closeConnection();
    }
}
