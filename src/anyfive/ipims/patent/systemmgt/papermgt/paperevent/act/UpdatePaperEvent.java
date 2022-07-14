package anyfive.ipims.patent.systemmgt.papermgt.paperevent.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.papermgt.paperevent.biz.PaperEventMgtBiz;

/**
 * 진행서류 이벤트 수정
 */
public class UpdatePaperEvent implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        PaperEventMgtBiz biz = new PaperEventMgtBiz(nsr);
        biz.updatePaperEvent(xReq);
        nsr.closeConnection();
    }
}
