package anyfive.ipims.patent.rivalpat.analysis.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.rivalpat.analysis.biz.AnalysisDocBiz;

/**
 * 분석자료수정
 */
public class UpdateAnalysisDoc implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        AnalysisDocBiz biz = new AnalysisDocBiz(nsr);
        biz.updateAnalysisDoc(xReq);
        nsr.closeConnection();
    }
}
