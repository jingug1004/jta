package anyfive.ipims.patent.applymgt.tmark.intconsult.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.tmark.intconsult.biz.TMarkIntConsultBiz;

/**
 * 상표국내출원품의 특허검토 작성
 */
public class UpdateTMarkIntConsult implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        TMarkIntConsultBiz biz = new TMarkIntConsultBiz(nsr);
        biz.updateTMarkIntConsult(xReq);
        nsr.closeConnection();
    }
}
