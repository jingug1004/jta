package anyfive.ipims.patent.systemmgt.evalsheet.evalcode.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.evalsheet.evalcode.biz.EvalCodeMgtBiz;

/**
 * 평가코드 관리 수정
 */
public class UpdateEvalCodeMgt implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        EvalCodeMgtBiz biz = new EvalCodeMgtBiz(nsr);
        biz.updateEvalCodeMgt(xReq);
        nsr.closeConnection();
    }
}
