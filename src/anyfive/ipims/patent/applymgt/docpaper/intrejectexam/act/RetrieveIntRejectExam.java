package anyfive.ipims.patent.applymgt.docpaper.intrejectexam.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.ajax.AjaxResponse;
import anyfive.ipims.patent.applymgt.docpaper.intrejectexam.biz.IntRejectExamBiz;

/**
 * 거절검토서 조회
 */
public class RetrieveIntRejectExam implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        IntRejectExamBiz biz = new IntRejectExamBiz(nsr);
        NSingleData result = biz.retrieveIntRejectExam(xReq);
        nsr.closeConnection();

        AjaxResponse xRes = new AjaxResponse(res);
        xRes.flushAll(result);
    }
}
