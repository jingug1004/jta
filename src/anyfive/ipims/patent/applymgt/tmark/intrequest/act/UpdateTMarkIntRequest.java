package anyfive.ipims.patent.applymgt.tmark.intrequest.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.tmark.intrequest.biz.TMarkIntRequestBiz;

/**
 * 상표국내출원의뢰 수정
 */
public class UpdateTMarkIntRequest implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        TMarkIntRequestBiz biz = new TMarkIntRequestBiz(nsr);
        biz.updateTMarkIntRequest(xReq);
        nsr.closeConnection();
    }
}
