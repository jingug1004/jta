package anyfive.ipims.patent.systemmgt.papermgt.paperevent.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.grid.util.GridResponse;
import anyfive.ipims.patent.systemmgt.papermgt.paperevent.biz.PaperEventMgtBiz;

/**
 * 진행서류 이벤트별 진행서류 목록 조회
 */
public class RetrievePaperEventPaperList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        PaperEventMgtBiz biz = new PaperEventMgtBiz(nsr);
        NSingleData result = biz.retrievePaperEventPaperList(xReq);
        nsr.closeConnection();

        GridResponse xRes = new GridResponse(req, res);
        xRes.flush(result);
    }
}
