package anyfive.ipims.patent.systemmgt.log.user.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.log.user.dao.UserLogDao;

public class UserLogBiz extends NAbstractServletBiz
{
    public UserLogBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 사용자 로그 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveUserLogList(AjaxRequest xReq) throws NException
    {
        UserLogDao dao = new UserLogDao(this.nsr);

        return dao.retrieveUserLogList(xReq);
    }

    /**
     * 사용자 로그 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveUserLog(AjaxRequest xReq) throws NException
    {
        UserLogDao dao = new UserLogDao(this.nsr);

        return dao.retrieveUserLog(xReq);
    }
}
