package anyfive.ipims.patent.systemmgt.log.mail.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.log.mail.biz.MailLogBiz;

/**
 * 메일 재발송 처리
 */
public class CreateMailSendLog implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        MailLogBiz biz = new MailLogBiz(nsr);
        biz.createMailSendLog(xReq);
        nsr.closeConnection();
    }
}
