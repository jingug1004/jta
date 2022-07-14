package anyfive.ipims.patent.applymgt.extpatent.eppct.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.extpatent.eppct.biz.ExtPatentEpPctBiz;

/**
 * EP/PCT OL 수정
 */
public class UpdateExtPatentEpPct implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        ExtPatentEpPctBiz biz = new ExtPatentEpPctBiz(nsr);
        biz.updateExtPatentEpPct(xReq);
        nsr.closeConnection();
    }
}
