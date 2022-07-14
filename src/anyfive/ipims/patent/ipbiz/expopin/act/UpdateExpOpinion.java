package anyfive.ipims.patent.ipbiz.expopin.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.ipbiz.expopin.biz.ExpOpinionBiz;

/**
 * 감정서 수정
 */
public class UpdateExpOpinion implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        ExpOpinionBiz biz = new ExpOpinionBiz(nsr);
        biz.updateExpOpinion(xReq);
        nsr.closeConnection();
    }
}
