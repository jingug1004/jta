package anyfive.ipims.patent.systemmgt.menugroup.menucode.dao;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class MenuCodeDao extends NAbstractServletDao
{
    public MenuCodeDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 메뉴관리 트리 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveMenuCodeTree(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/menugroup/menucode", "/retrieveMenuCodeTree");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 메뉴관리 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveMenuCodeList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/menugroup/menucode", "/retrieveMenuCodeList");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 메뉴관리 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveMenuCode(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/menugroup/menucode", "/retrieveMenuCode");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 메뉴관리 언어별 메뉴명 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveMenuNameList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/menugroup/menucode", "/retrieveMenuNameList");
        dao.bind(xReq);

        return dao.executeQuery();
    }

    /**
     * 메뉴관리 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createMenuCode(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/menugroup/menucode", "/createMenuCode");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 메뉴관리 언어별 메뉴명 목록 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int[] createMenuNameList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/menugroup/menucode", "/createMenuNameList");
        dao.bind(xReq);

        return dao.executeBatch(xReq.getMultiDataWithoutDeleteRow("ds_menuNameList"));
    }

    /**
     * 메뉴관리 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateMenuCode(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/menugroup/menucode", "/updateMenuCode");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 메뉴관리 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteMenuCode(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/menugroup/menucode", "/deleteMenuCode");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 메뉴관리 언어별 메뉴명 목록 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteMenuNameList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/menugroup/menucode", "/deleteMenuNameList");
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

        dao.setQuery("/ipims/patent/systemmgt/menugroup/menucode", "/deleteGroupMenuList");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 메뉴순서 변경
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int[] updateMenuOrdList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/menugroup/menucode", "/updateMenuOrd");
        dao.bind(xReq);

        return dao.executeBatch(xReq.getMultiData("ds_menuCodeList"));
    }
}
