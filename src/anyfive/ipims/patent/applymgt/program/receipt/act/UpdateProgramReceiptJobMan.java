package anyfive.ipims.patent.applymgt.program.receipt.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.program.receipt.biz.ProgramReceiptBiz;

/**
 * 프로그램 접수 담당자지정
 */
public class UpdateProgramReceiptJobMan implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        ProgramReceiptBiz biz = new ProgramReceiptBiz(nsr);
        biz.updateProgramReceiptJobMan(xReq.getParam("REF_ID"), xReq.getParam("JOB_MAN"));
        nsr.closeConnection();
    }
}
