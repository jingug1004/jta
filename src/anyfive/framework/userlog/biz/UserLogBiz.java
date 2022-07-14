package anyfive.framework.userlog.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.userlog.dao.UserLogDao;

public class UserLogBiz extends NAbstractServletBiz
{
    public UserLogBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 사용자 로그 생성
     *
     * @param data
     * @return
     * @throws NException
     */
    public void createUserLog(NSingleData data) throws NException
    {
        UserLogDao dao = new UserLogDao(this.nsr);

        dao.createUserLog(data);
    }
}
