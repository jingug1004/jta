package anyfive.ipims.patent.applymgt.intpatent.consult.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.intpatent.consult.biz.IntPatentConsultBiz;

/**
 * 국내출원품의 수정
 */
public class UpdateIntPatentConsult implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        IntPatentConsultBiz biz = new IntPatentConsultBiz(nsr);
        biz.updateIntPatentConsult(xReq);
        nsr.closeConnection();
    }
}
