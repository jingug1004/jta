package anyfive.ipims.patent.costmgt.slip.proc.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.costmgt.slip.proc.biz.SlipProcBiz;

/**
 * 전표처리 수정
 */
public class UpdateSlipProc implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        SlipProcBiz biz = new SlipProcBiz(nsr);
        biz.updateSlipProc(xReq);
        nsr.closeConnection();
    }
}