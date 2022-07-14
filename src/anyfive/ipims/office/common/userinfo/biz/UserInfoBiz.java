package anyfive.ipims.office.common.userinfo.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.office.common.userinfo.dao.UserInfoDao;

public class UserInfoBiz extends NAbstractServletBiz
{
    public UserInfoBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 사용자정보 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveUserInfo(AjaxRequest xReq) throws NException
    {
        UserInfoDao dao = new UserInfoDao(this.nsr);

        NSingleData result = new NSingleData();

        // 사용자정보 조회
        result.set("ds_mainInfo", dao.retrieveUserInfo(xReq));

        return result;
    }

    /**
     * 사용자정보 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateUserInfo(AjaxRequest xReq) throws NException
    {
        UserInfoDao dao = new UserInfoDao(this.nsr);

        dao.updateUserInfo(xReq);
    }
}
