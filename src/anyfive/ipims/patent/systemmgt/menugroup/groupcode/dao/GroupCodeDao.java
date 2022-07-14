package anyfive.ipims.patent.systemmgt.menugroup.groupcode.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class GroupCodeDao extends NAbstractServletDao
{
    public GroupCodeDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 그룹관리 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveGroupCodeList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/menugroup/groupcode", "/retrieveGroupCodeList");
        dao.bind(xReq);

        if (xReq.getParam("SEARCH_TEXT").equals("") != true) {
            dao.addQuery("searchText");
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 그룹관리 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveGroupCode(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/menugroup/groupcode", "/retrieveGroupCode");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 그룹관리 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createGroupCode(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/menugroup/groupcode", "/createGroupCode");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 그룹관리 일반사용자 메뉴 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createGroupCommonMenu(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/menugroup/groupcode", "/createGroupCommonMenu");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 그룹관리 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateGroupCode(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/menugroup/groupcode", "/updateGroupCode");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 그룹관리 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteGroupCode(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/menugroup/groupcode", "/deleteGroupCode");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 그룹별 메뉴 목록 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteGroupMenuList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/menugroup/groupcode", "/deleteGroupMenuList");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 그룹별 사용자 목록 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteGroupUserList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/menugroup/groupcode", "/deleteGroupUserList");
        dao.bind(xReq);

        return dao.executeUpdate();
    }
}
