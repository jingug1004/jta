package anyfive.ipims.patent.systemmgt.papermgt.papercode.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.papermgt.papercode.biz.PaperCodeMgtBiz;

/**
 * 진행서류 수정
 */
public class UpdatePaperCode implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        PaperCodeMgtBiz biz = new PaperCodeMgtBiz(nsr);
        biz.updatePaperCode(xReq);
        nsr.closeConnection();
    }
}
