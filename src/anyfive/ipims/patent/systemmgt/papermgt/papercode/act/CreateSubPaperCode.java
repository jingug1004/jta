package anyfive.ipims.patent.systemmgt.papermgt.papercode.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.ajax.AjaxResponse;
import anyfive.ipims.patent.systemmgt.papermgt.papercode.biz.PaperCodeMgtBiz;

/**
 * 세부서류 생성
 */
public class CreateSubPaperCode implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        PaperCodeMgtBiz biz = new PaperCodeMgtBiz(nsr);
        String paperSubcode = biz.createSubPaperCode(xReq);
        nsr.closeConnection();

        AjaxResponse xRes = new AjaxResponse(res);
        xRes.flush(paperSubcode);
    }
}
