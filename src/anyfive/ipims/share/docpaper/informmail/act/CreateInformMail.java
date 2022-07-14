package anyfive.ipims.share.docpaper.informmail.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.share.docpaper.informmail.biz.DocInformMailBiz;

/**
 * 진행서류 알림메일 생성
 */
public class CreateInformMail implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        DocInformMailBiz biz = new DocInformMailBiz(nsr);
        biz.createInformMailInfo(xReq);
        nsr.closeConnection();
    }
}
