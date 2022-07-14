package anyfive.ipims.patent.applymgt.program.master.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.program.master.biz.ProgramMasterBiz;

/**
 * 프로그램마스터 수정
 */
public class UpdateProgramMaster implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        ProgramMasterBiz biz = new ProgramMasterBiz(nsr);
        biz.updateProgramMaster(xReq);
        nsr.closeConnection();
    }
}
