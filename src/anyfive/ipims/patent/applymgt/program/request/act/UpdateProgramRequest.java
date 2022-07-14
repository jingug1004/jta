package anyfive.ipims.patent.applymgt.program.request.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.program.request.biz.ProgramRequestBiz;

/**
 * 프로그램 수정
 */
public class UpdateProgramRequest implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        ProgramRequestBiz biz = new ProgramRequestBiz(nsr);
        biz.updateProgramRequest(xReq);
        nsr.closeConnection();
    }
}
