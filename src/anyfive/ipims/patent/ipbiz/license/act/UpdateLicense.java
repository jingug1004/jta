package anyfive.ipims.patent.ipbiz.license.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.ipbiz.license.biz.LicenseBiz;

/**
 * 라이센스 수정
 */
public class UpdateLicense implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        LicenseBiz biz = new LicenseBiz(nsr);
        biz.updateLicense(xReq);
        nsr.closeConnection();
    }
}
