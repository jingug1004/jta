package anyfive.ipims.share.login.dao;

import any.core.config.NConfig;
import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class LoginDao extends NAbstractServletDao
{
    public LoginDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 로그인 사용자정보 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveLoginUserSearchList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/login/login", "/retrieveLoginUserSearchList");
        dao.bind(xReq);

        if (xReq.getParam("SYSTEM_TYPE").equals("") != true) {
            dao.addQuery("systemType");
        }

        if (xReq.getParam("SEARCH_TEXT").equals("") != true) {
            dao.addQuery("searchText");
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 로그인 정보 조회
     *
     * @param loginId
     * @return
     * @throws NException
     */
    public NSingleData retrieveLogin(String loginId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        String loginSystem = NConfig.getString("/config/login-system");

        dao.setQuery("/ipims/share/login/login", "/retrieveLogin");
        dao.bind("LOGIN_ID", loginId);
        dao.bind("LOGIN_SYSTEM", loginSystem);

        return dao.executeQueryForSingle();
    }

    /**
     * 로그인 사용자의 메뉴그룹 목록 조회
     *
     * @param userId
     * @return
     * @throws NException
     */
    public NMultiData retrieveLoginUserMenuGroupList(String userId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/login/login", "/retrieveLoginUserMenuGroupList");
        dao.bind("USER_ID", userId);

        return dao.executeQuery();
    }

    /**
     * 마지막 로그인 일시 저장
     *
     * @param userId
     * @return
     * @throws NException
     */
    public int updateLastLoginDatetime(String userId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/login/login", "/updateLastLoginDatetime");
        dao.bind("USER_ID", userId);

        return dao.executeUpdate();
    }
}
