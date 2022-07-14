package anyfive.ipims.patent.systemmgt.papermgt.paperwf.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.grid.util.GridResponse;
import anyfive.ipims.patent.systemmgt.papermgt.paperwf.biz.PaperWFMgtBiz;

/**
 * 진행서류 워크플로우관리 목록 조회
 */
public class RetrievePaperWFList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        PaperWFMgtBiz biz = new PaperWFMgtBiz(nsr);
        NSingleData result = biz.retrievePaperBizList(xReq);
        nsr.closeConnection();

        GridResponse xRes = new GridResponse(req, res);
        xRes.flush(result);
    }
}
