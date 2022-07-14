package anyfive.ipims.patent.systemmgt.patteam.outinventor.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.patteam.outinventor.biz.OutInventorMgtBiz;

/**
 * 외부발명자 수정
 */
public class UpdateOutInventor implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        OutInventorMgtBiz biz = new OutInventorMgtBiz(nsr);
        biz.updateOutInventor(xReq);
        nsr.closeConnection();
    }
}
