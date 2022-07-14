package anyfive.ipims.office.common.userinfo.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class UserInfoDao extends NAbstractServletDao
{
    public UserInfoDao(NServiceResource nsr)
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/office/common/userinfo/userinfo", "/retrieveUserInfo");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 사용자정보 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateUserInfo(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/office/common/userinfo/userinfo", "/updateUserInfo");
        dao.bind(xReq);

        return dao.executeUpdate();
    }
}
