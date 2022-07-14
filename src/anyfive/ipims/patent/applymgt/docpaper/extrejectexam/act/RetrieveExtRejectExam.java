package anyfive.ipims.patent.applymgt.docpaper.extrejectexam.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.ajax.AjaxResponse;
import anyfive.ipims.patent.applymgt.docpaper.extrejectexam.biz.ExtRejectExamBiz;

/**
 * 해외거절검토서 조회
 */
public class RetrieveExtRejectExam implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        ExtRejectExamBiz biz = new ExtRejectExamBiz(nsr);
        NSingleData result = biz.retrieveExtRejectExam(xReq);
        nsr.closeConnection();

        AjaxResponse xRes = new AjaxResponse(res);
        xRes.flushAll(result);
    }
}
