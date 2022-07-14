package anyfive.ipims.patent.systemmgt.papermgt.paperwf.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.papermgt.paperwf.biz.PaperWFMgtBiz;

/**
 * 진행서류 워크플로우별 진행서류 생성
 */
public class CreatePaperWFPaper implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        PaperWFMgtBiz biz = new PaperWFMgtBiz(nsr);
        biz.createPaperWFPaper(xReq);
        nsr.closeConnection();
    }
}
