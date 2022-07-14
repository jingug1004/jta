package anyfive.ipims.patent.applymgt.intpatent.request.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.intpatent.request.biz.IntPatentRequestBiz;

/**
 * 국내특허 출원의뢰 수정
 */
public class UpdateIntPatentRequest implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        IntPatentRequestBiz biz = new IntPatentRequestBiz(nsr);
        biz.updateIntPatentRequest(xReq);
        nsr.closeConnection();
    }
}
