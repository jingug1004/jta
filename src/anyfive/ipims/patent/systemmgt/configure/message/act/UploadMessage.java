package anyfive.ipims.patent.systemmgt.configure.message.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.configure.message.biz.MessageBiz;

/**
 * 메세지 업로드
 */
public class UploadMessage implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        MessageBiz biz = new MessageBiz(nsr);
        biz.uploadMessage(xReq);
        nsr.closeConnection();
    }
}
