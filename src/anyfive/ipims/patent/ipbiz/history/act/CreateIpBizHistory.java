package anyfive.ipims.patent.ipbiz.history.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.ipbiz.history.biz.IpBizHistoryBiz;

/**
 * History 생성
 */
public class CreateIpBizHistory implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        IpBizHistoryBiz biz = new IpBizHistoryBiz(nsr);
        biz.createIpBizHistory(xReq);
        nsr.closeConnection();
    }
}
