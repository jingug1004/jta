package anyfive.ipims.patent.ipbiz.analy.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.ipbiz.analy.biz.AnalyBiz;

/**
 * 분석자료 삭제
 */
public class DeleteAnaly implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        AnalyBiz biz = new AnalyBiz(nsr);
        biz.deleteAnaly(xReq);
        nsr.closeConnection();
    }
}
