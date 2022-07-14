package anyfive.ipims.patent.systemmgt.configure.refresh.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.configure.refresh.biz.ConfigureBiz;

/**
 * 환경정보 Refresh
 */
public class RefreshConfigure implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        ConfigureBiz biz = new ConfigureBiz(nsr);
        biz.refreshConfigure(xReq);
    }
}
