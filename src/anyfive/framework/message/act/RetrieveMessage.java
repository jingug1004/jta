package anyfive.framework.message.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxResponse;
import anyfive.framework.message.biz.MessageBiz;

/**
 * 메세지 조회
 */
public class RetrieveMessage implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        MessageBiz biz = new MessageBiz(nsr);
        String message = biz.retrieveMessage();

        AjaxResponse xRes = new AjaxResponse(res);
        xRes.flush(message);
    }
}
