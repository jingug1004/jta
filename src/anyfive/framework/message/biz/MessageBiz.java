package anyfive.framework.message.biz;

import any.core.exception.NException;
import any.core.message.NMessageMap;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.session.SessionUtil;

public class MessageBiz extends NAbstractServletBiz
{
    public MessageBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 메세지 조회
     *
     * @return
     * @throws NException
     */
    public String retrieveMessage()
    {
        return NMessageMap.toJSON(SessionUtil.getLangCode(this.nsr));
    }
}
