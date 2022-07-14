package anyfive.ipims.patent.systemmgt.officemgt.user.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class OfficeMgtUserDao extends NAbstractServletDao
{
    public OfficeMgtUserDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 사무소 사용자 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveOfficeMgtUserList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/officemgt/user", "/retrieveOfficeMgtUserList");
        dao.bind(xReq);

        if (xReq.getParam("OFFICE_CODE").equals("") != true) {
            dao.addQuery("officeCode");
        }

        if (xReq.getParam("EMP_NAME").equals("") != true) {
            dao.addQuery("empName");
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 사무소 사용자 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveOfficeMgtUser(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/officemgt/user", "/retrieveOfficeMgtUser");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 사용자 마스터 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createUserMst(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/officemgt/user", "/createUserMst");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 사무소 사용자 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createOfficeMgtUser(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/officemgt/user", "/createOfficeMgtUser");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 사용자 마스터 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateUserMst(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/officemgt/user", "/updateUserMst");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 사무소 사용자 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateOfficeMgtUser(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/officemgt/user", "/updateOfficeMgtUser");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 사용자 마스터 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteUserMst(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/officemgt/user", "/deleteUserMst");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 사무소 사용자 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteOfficeMgtUser(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/officemgt/user", "/deleteOfficeMgtUser");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 비밀번호 오류횟수 초기화
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateUserMstPwErrCnt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/officemgt/user", "/updateUserMstPwErrCnt");
        dao.bind(xReq);

        return dao.executeUpdate();
    }
}
