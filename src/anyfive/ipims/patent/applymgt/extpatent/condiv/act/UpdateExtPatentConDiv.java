package anyfive.ipims.patent.applymgt.extpatent.condiv.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.extpatent.condiv.biz.ExtPatentConDivBiz;

/**
 * 계속/분할OL 수정
 */
public class UpdateExtPatentConDiv implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        ExtPatentConDivBiz biz = new ExtPatentConDivBiz(nsr);
        biz.updateExtPatentConDiv(xReq);
        nsr.closeConnection();
    }
}
