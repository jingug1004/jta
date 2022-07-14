package anyfive.ipims.patent.systemmgt.evalsheet.evalitem.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.evalsheet.evalitem.biz.EvalItemMgtBiz;

/**
 * 평가항목 관리 생성
 */
public class CreateEvalItemMgt implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        EvalItemMgtBiz biz = new EvalItemMgtBiz(nsr);
        biz.createEvalItemMgt(xReq);
        nsr.closeConnection();
    }
}
